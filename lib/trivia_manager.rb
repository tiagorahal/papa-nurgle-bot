# lib/trivia_manager.rb
require 'json'

class TriviaManager
  def initialize
    @trivia_data = load_trivia_data
    @used_trivia = []
  end
  
  def get_trivia(user_level = 1)
    # Determinar dificuldade baseada no nível do usuário
    difficulty = determine_difficulty(user_level)
    
    # Filtrar trivias por dificuldade
    available_trivia = @trivia_data.select do |trivia|
      trivia['difficulty'] == difficulty && !@used_trivia.include?(trivia['id'])
    end
    
    # Se não houver trivias disponíveis, resetar e pegar qualquer uma
    if available_trivia.empty?
      @used_trivia = []
      available_trivia = @trivia_data.select { |t| t['difficulty'] == difficulty }
    end
    
    trivia = available_trivia.sample
    @used_trivia << trivia['id']
    
    {
      text: trivia['text'],
      difficulty: difficulty,
      category: trivia['category']
    }
  end
  
  private
  
  def determine_difficulty(level)
    case level
    when 1..3
      "Iniciante"
    when 4..7
      "Intermediário"
    when 8..11
      "Avançado"
    else
      "Mestre"
    end
  end
  
  def load_trivia_data
    # Se o arquivo JSON existir, carregar dele
    if File.exist?('lib/trivia_enhanced.json')
      JSON.parse(File.read('lib/trivia_enhanced.json'))
    else
      # Caso contrário, gerar dados de trivia
      generate_trivia_data
    end
  end
  
  def generate_trivia_data
    trivia = []
    id_counter = 1
    
    # Trivias para Iniciantes
    beginner_facts = [
      "Nurgle é conhecido como o Deus da Praga e da Decadência no universo Warhammer 40,000.",
      "O número sagrado de Nurgle é 7, representando os ciclos da vida e morte.",
      "Nurgle é paradoxalmente jovial e amoroso, vendo suas pragas como presentes.",
      "O símbolo de Nurgle é geralmente três círculos ou três chifres.",
      "Nurgle reside no Reino do Caos, em seu Jardim de pragas.",
      "Os seguidores de Nurgle são imunes à dor devido às suas bênçãos.",
      "Nurgle é um dos quatro Deuses do Caos principais.",
      "As cores sagradas de Nurgle são verde e marrom.",
      "Nurglings são pequenos daemons que servem Nurgle alegremente.",
      "Papa Nurgle é como é carinhosamente chamado por seus seguidores."
    ]
    
    beginner_facts.each do |fact|
      trivia << {
        'id' => id_counter,
        'text' => fact,
        'difficulty' => 'Iniciante',
        'category' => 'Conhecimento Básico'
      }
      id_counter += 1
    end
    
    # Trivias Intermediárias
    intermediate_facts = [
      "Typhus, o Arauto de Nurgle, comanda a companhia Terminus Est dos Death Guard.",
      "Mortarion, o Primarca dos Death Guard, é um Príncipe Daemon de Nurgle.",
      "A Death Guard é a principal Legião de Space Marines do Caos dedicada a Nurgle.",
      "O planeta Barbarus era o mundo natal de Mortarion antes de sua queda.",
      "Isha, a deusa Eldar, está aprisionada no jardim de Nurgle.",
      "Os Plague Marines são Space Marines do Caos abençoados com a resistência de Nurgle.",
      "A Peste Zumbi de Nurgle pode transformar populações inteiras em mortos-vivos.",
      "Ku'gath, o Plaguefather, é um dos maiores Great Unclean Ones de Nurgle.",
      "O Destroyer Hive é uma das armas mais temidas dos seguidores de Nurgle.",
      "A Mancha de Ferrugem é uma praga que corrói até mesmo a cerâmica."
    ]
    
    intermediate_facts.each do |fact|
      trivia << {
        'id' => id_counter,
        'text' => fact,
        'difficulty' => 'Intermediário',
        'category' => 'Lore Expandido'
      }
      id_counter += 1
    end
    
    # Trivias Avançadas
    advanced_facts = [
      "Durante a Heresia de Horus, Mortarion foi forçado a jurar lealdade a Nurgle para salvar sua legião do Destroyer Plague.",
      "O Codex: Daemon's menciona 7 grandes pragas de Nurgle, cada uma com 7 variações.",
      "Epidemius, o Tallyman de Nurgle, registra cada doença espalhada em nome do Deus da Praga.",
      "A Guerra da Ferrugem viu os Death Guard quase conquistar Ultramar no M42.",
      "O Thrice-Cursed Traitor Grulgor foi o primeiro Death Guard a se tornar um Plague Marine.",
      "As Plague Wars duraram aproximadamente 12 anos no Segmentum Ultramar.",
      "Rotigus Rainmaker é um Great Unclean One conhecido por suas 'chuvas generosas'.",
      "O Plague Planet no Eye of Terror é o principal domínio de Mortarion.",
      "A Creeping Death pode levar décadas para matar sua vítima completamente.",
      "Os Beasts of Nurgle são criaturas amigáveis que não entendem que seu toque é letal."
    ]
    
    advanced_facts.each do |fact|
      trivia << {
        'id' => id_counter,
        'text' => fact,
        'difficulty' => 'Avançado',
        'category' => 'Lore Profundo'
      }
      id_counter += 1
    end
    
    # Trivias Mestre
    master_facts = [
      "No Liber Chaotica, é revelado que Nurgle nasceu durante a Idade Média da Terra antiga.",
      "A tensão entre Nurgle e Tzeentch representa o conflito entre estagnação e mudança no universo.",
      "O Cauldron of Nurgle no Warp contém todas as doenças que já existiram ou existirão.",
      "Durante o Dark Founding, rumores dizem que capítulos inteiros foram corrompidos por Nurgle.",
      "A ligação entre Nurgle e Isha sugere uma natureza dualística de decadência e renovação.",
      "No manuscrito Rotted Annals, há menção a 49 avatares menores de Nurgle (7x7).",
      "A Godblight criada por Mortarion pode corromper até mesmo a essência de um Primarca.",
      "O Grandfather's Blessing pode transformar um mortal em daemon instantaneamente.",
      "Existem rumores de um pacto secreto entre Nurgle e Vashtorr, o Arkifane.",
      "A true name de Nurgle supostamente contém 7.777 sílabas."
    ]
    
    master_facts.each do |fact|
      trivia << {
        'id' => id_counter,
        'text' => fact,
        'difficulty' => 'Mestre',
        'category' => 'Conhecimento Oculto'
      }
      id_counter += 1
    end
    
    # Salvar os dados gerados
    File.write('lib/trivia_enhanced.json', JSON.pretty_generate(trivia))
    
    trivia
  end
end
