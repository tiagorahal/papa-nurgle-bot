require 'telegram/bot'
require 'logger'
require_relative 'greeting_generator'
require_relative 'trivia_manager'
require_relative 'infection_system'
require_relative 'nurgle_responses'
require_relative 'config'

class Bot
  attr_reader :logger, :infection_system, :greeting_generator, :trivia_manager, :responses

  def initialize
    @logger = Logger.new('logs/bot.log', 'daily')
    @infection_system = InfectionSystem.new
    @greeting_generator = GreetingGenerator.new
    @trivia_manager = TriviaManager.new
    @responses = NurgleResponses.new
    @command_count = Hash.new(0)
    
    logger.info "Papa Nurgle's Bot iniciando..."
  end

  def run
    token = Config::BOT_TOKEN
    
    Telegram::Bot::Client.run(token) do |bot|
      logger.info "Bot conectado e ouvindo..."
      
      bot.listen do |message|
        begin
          handle_message(bot, message)
        rescue => e
          logger.error "Erro ao processar mensagem: #{e.message}"
          bot.api.send_message(
            chat_id: message.chat.id, 
            text: "💀 As bênçãos de Nurgle foram temporariamente interrompidas... Tente novamente."
          )
        end
      end
    end
  end

  private

  def handle_message(bot, message)
    return unless message.text
    
    user_id = message.from.id
    user_name = message.from.first_name
    chat_id = message.chat.id
    
    # Sistema de infecção sempre ativo
    infection_system.update_infection(user_id)
    
    # Log do comando
    logger.info "Comando recebido: #{message.text} de #{user_name} (#{user_id})"
    @command_count[message.text] += 1
    
    case message.text
    when '/start'
      send_welcome(bot, chat_id, user_name, user_id)
      
    when '/stop'
      send_farewell(bot, chat_id, user_name)
      
    when '/greet', '/hello'
      send_greeting(bot, chat_id, user_id)
      
    when '/trivia'
      send_trivia(bot, chat_id, user_id)
      
    when '/infection', '/status'
      send_infection_status(bot, chat_id, user_id, user_name)
      
    when '/blessing'
      send_special_blessing(bot, chat_id, user_id)
      
    when '/plague'
      send_plague_name(bot, chat_id, user_id)
      
    when '/garden'
      send_garden_description(bot, chat_id)
      
    when '/devotion'
      send_devotion_level(bot, chat_id, user_id, user_name)
      
    when '/convert'
      attempt_conversion(bot, chat_id, message)
      
    when '/help'
      send_help(bot, chat_id)
      
    when '/stats'
      send_stats(bot, chat_id) if user_id == Config::ADMIN_ID
      
    # Easter eggs
    when '7', 'seven', 'sete'
      bot.api.send_message(
        chat_id: chat_id,
        text: "🎯 O número sagrado de Nurgle! Suas bênçãos se multiplicam por sete!"
      )
      infection_system.bonus_infection(user_id, 7)
      
    when /nurgle|papa|grandfather|vovô/i
      bot.api.send_message(
        chat_id: chat_id,
        text: responses.get_papa_response
      )
      
    when /khorne|tzeentch|slaanesh/i
      bot.api.send_message(
        chat_id: chat_id,
        text: "😤 Falsos deuses! Apenas Nurgle oferece verdadeiro amor e aceitação!"
      )
      
    else
      # Respostas contextuais para mensagens não reconhecidas
      if message.text.start_with?('/')
        bot.api.send_message(
          chat_id: chat_id,
          text: "🦠 Comando desconhecido. Use /help para ver os comandos disponíveis."
        )
      elsif rand < 0.1 # 10% de chance de resposta aleatória
        bot.api.send_message(
          chat_id: chat_id,
          text: responses.get_random_whisper
        )
      end
    end
  end

  def send_welcome(bot, chat_id, user_name, user_id)
    infection_system.register_user(user_id)
    welcome_text = <<~TEXT
      🦠 Bem-vindo ao jardim de Papa Nurgle, #{user_name}!
      
      Você foi abençoado com sua primeira infecção sagrada.
      Cada interação aumenta sua devoção ao Senhor da Decadência.
      
      📜 Comandos principais:
      /greet - Receba uma saudação pestilenta
      /trivia - Aprenda sobre o Pai da Praga
      /infection - Veja seu nível de infecção
      /blessing - Receba uma bênção especial
      /help - Lista completa de comandos
      
      Que a podridão esteja com você! 💚
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: welcome_text)
  end

  def send_farewell(bot, chat_id, user_name)
    farewell_text = <<~TEXT
      💀 #{user_name}, você pode tentar fugir do abraço de Nurgle...
      Mas a podridão sempre encontra um caminho de volta.
      
      Suas infecções permanecerão dormentes até seu retorno.
      Papa Nurgle é paciente e amoroso. 💚
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: farewell_text)
  end

  def send_greeting(bot, chat_id, user_id)
    level = infection_system.get_level(user_id)
    greeting = greeting_generator.generate(level)
    
    bot.api.send_message(
      chat_id: chat_id,
      text: "🦠 #{greeting}",
      parse_mode: 'HTML'
    )
    
    infection_system.add_infection(user_id, 1)
  end

  def send_trivia(bot, chat_id, user_id)
    trivia = trivia_manager.get_trivia(infection_system.get_level(user_id))
    
    bot.api.send_message(
      chat_id: chat_id,
      text: "📚 #{trivia[:text]}\n\n<i>Dificuldade: #{trivia[:difficulty]}</i>",
      parse_mode: 'HTML'
    )
    
    infection_system.add_infection(user_id, 2)
  end

  def send_infection_status(bot, chat_id, user_id, user_name)
    status = infection_system.get_status(user_id)
    level_name = infection_system.get_level_name(user_id)
    progress_bar = create_progress_bar(status[:progress_percent])
    
    status_text = <<~TEXT
      🧪 <b>Status de Infecção - #{user_name}</b>
      
      📊 Nível: <b>#{level_name}</b> (Nível #{status[:level]})
      🦠 Infecção Total: #{status[:total_infection]}
      📈 Progresso: #{progress_bar} #{status[:progress_percent]}%
      ⏰ Última Bênção: #{status[:last_blessing]}
      🏆 Ranking: ##{status[:rank]} entre os devotos
      
      <i>#{get_level_description(status[:level])}</i>
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: status_text, parse_mode: 'HTML')
  end

  def send_special_blessing(bot, chat_id, user_id)
    blessing = infection_system.daily_blessing(user_id)
    
    if blessing[:available]
      blessing_text = <<~TEXT
        ✨ <b>BÊNÇÃO ESPECIAL DE NURGLE!</b> ✨
        
        #{responses.get_special_blessing}
        
        🎁 Você recebeu <b>+#{blessing[:amount]}</b> pontos de infecção!
        🔄 Próxima bênção disponível em 24 horas.
      TEXT
    else
      blessing_text = <<~TEXT
        ⏳ Sua bênção diária já foi concedida.
        Próxima bênção em: <b>#{blessing[:time_remaining]}</b>
        
        <i>Papa Nurgle aprecia a paciência...</i>
      TEXT
    end
    
    bot.api.send_message(chat_id: chat_id, text: blessing_text, parse_mode: 'HTML')
  end

  def send_plague_name(bot, chat_id, user_id)
    plagues = [
      "Podridão Gloriosa", "Pústula Sagrada", "Ferrugem Carmesim",
      "Necrose Jubilosa", "Gangrena Verdejante", "Lepra Risonha",
      "Pestilência Púrpura", "Decomposição Dourada", "Míldio Mental",
      "Corrupção Cósmica", "Entropia Efervescente", "Decadência Divina"
    ]
    
    # Usa o ID do usuário como seed para sempre ter a mesma praga
    srand(user_id)
    your_plague = plagues.sample
    srand
    
    bot.api.send_message(
      chat_id: chat_id,
      text: "🧫 Sua praga pessoal é: <b>#{your_plague}</b>\n\nCarregue-a com orgulho!",
      parse_mode: 'HTML'
    )
    
    infection_system.add_infection(user_id, 1)
  end

  def send_garden_description(bot, chat_id)
    description = responses.get_garden_description
    
    bot.api.send_message(
      chat_id: chat_id,
      text: "🌺 <b>O Jardim de Nurgle</b>\n\n#{description}",
      parse_mode: 'HTML'
    )
  end

  def send_devotion_level(bot, chat_id, user_id, user_name)
    level = infection_system.get_level(user_id)
    devotion = calculate_devotion(level)
    
    devotion_text = <<~TEXT
      🙏 <b>Nível de Devoção - #{user_name}</b>
      
      #{devotion[:icon]} #{devotion[:title]}
      
      #{devotion[:description]}
      
      <i>Continue sua jornada de decadência...</i>
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: devotion_text, parse_mode: 'HTML')
  end

  def attempt_conversion(bot, chat_id, message)
    if message.reply_to_message
      target_name = message.reply_to_message.from.first_name
      
      conversion_text = <<~TEXT
        🦠 <b>TENTATIVA DE CONVERSÃO!</b>
        
        #{message.from.first_name} tenta converter #{target_name} para os caminhos de Nurgle!
        
        #{responses.get_conversion_message(target_name)}
      TEXT
      
      bot.api.send_message(chat_id: chat_id, text: conversion_text, parse_mode: 'HTML')
    else
      bot.api.send_message(
        chat_id: chat_id,
        text: "💬 Responda a mensagem de alguém com /convert para tentar convertê-lo!"
      )
    end
  end

  def send_help(bot, chat_id)
    help_text = <<~TEXT
      📜 <b>Comandos do Bot de Papa Nurgle</b>
      
      <b>Básicos:</b>
      /start - Iniciar o bot
      /stop - Parar o bot
      /help - Esta mensagem
      
      <b>Interações:</b>
      /greet - Saudação pestilenta
      /trivia - Fatos sobre Nurgle
      /blessing - Bênção diária especial
      
      <b>Status:</b>
      /infection - Seu nível de infecção
      /devotion - Seu nível de devoção
      /plague - Sua praga pessoal
      
      <b>Especiais:</b>
      /garden - Descrição do Jardim de Nurgle
      /convert - Converter outros (responda uma mensagem)
      
      <b>Easter Eggs:</b>
      Digite "7" para uma surpresa
      Mencione outros deuses do Caos...
      
      💚 <i>Espalhe a podridão!</i>
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: help_text, parse_mode: 'HTML')
  end

  def send_stats(bot, chat_id)
    stats_text = <<~TEXT
      📊 <b>Estatísticas do Bot</b>
      
      Comandos mais usados:
      #{@command_count.sort_by{|k,v| -v}.first(10).map{|k,v| "#{k}: #{v}"}.join("\n")}
      
      Total de usuários: #{infection_system.total_users}
      Infecção total distribuída: #{infection_system.total_infection}
    TEXT
    
    bot.api.send_message(chat_id: chat_id, text: stats_text, parse_mode: 'HTML')
  end

  def create_progress_bar(percent)
    filled = (percent / 10).to_i
    empty = 10 - filled
    "🟩" * filled + "⬜" * empty
  end

  def get_level_description(level)
    descriptions = [
      "Você acabou de entrar no jardim...",
      "As primeiras pústulas começam a aparecer.",
      "A podridão abraça sua alma.",
      "Você ouve os sussurros de Papa Nurgle.",
      "Sua devoção cresce como fungos na escuridão.",
      "O cheiro doce da decadência te envolve.",
      "Você é um verdadeiro filho da pestilência.",
      "As bênçãos de Nurgle fluem através de você.",
      "Você transcendeu a mortalidade comum.",
      "Você é um arauto da entropia divina!"
    ]
    
    descriptions[level - 1] || descriptions.last
  end

  def calculate_devotion(level)
    devotions = [
      { icon: "🌱", title: "Semente da Corrupção", description: "Você apenas começou sua jornada." },
      { icon: "🍄", title: "Esporo Crescente", description: "A infecção se espalha lentamente." },
      { icon: "🦠", title: "Portador da Praga", description: "Você carrega as bênçãos com orgulho." },
      { icon: "☠️", title: "Arauto da Decadência", description: "Sua presença traz podridão." },
      { icon: "💀", title: "Campeão de Nurgle", description: "Papa Nurgle sorri para você." },
      { icon: "👑", title: "Príncipe Daemon", description: "Você ascendeu além da mortalidade!" }
    ]
    
    index = [(level / 2).to_i, devotions.length - 1].min
    devotions[index]
  end
end
