# lib/nurgle_responses.rb
class NurgleResponses
  def initialize
    @papa_responses = [
      "Papa Nurgle sorri para você com amor paternal! 💚",
      "O Avô abraça todos os seus filhos, especialmente você!",
      "Você chamou pelo Pai da Praga? Ele sempre está ouvindo...",
      "Papa Nurgle sussurra: 'Você é meu filho favorito!'",
      "O Grande Pai Pútrido abençoa sua devoção!"
    ]
    
    @whispers = [
      "🦠 *Você sente uma coceira estranha...*",
      "💚 *Um cheiro doce de decomposição paira no ar...*",
      "🍄 *Esporos dançam ao seu redor...*",
      "☠️ *Papa Nurgle sussurra algo incompreensível...*",
      "🌿 *Você sente algo crescendo dentro de você...*",
      "✨ *As bênçãos de Nurgle se manifestam sutilmente...*",
      "🦟 *Moscas zumbem uma melodia estranha...*",
      "💀 *A morte e o renascimento são um só...*"
    ]
    
    @special_blessings = [
      "Uma praga rara e bela se manifesta em você! As feridas cantam louvores a Nurgle!",
      "Pústulas douradas brotam em sua pele, cada uma um pequeno jardim de Nurgle!",
      "Você foi escolhido para carregar a Podridão Sagrada! Que honra!",
      "Fungos bioluminescentes crescem em suas extremidades, iluminando o caminho!",
      "A Grande Corrupção abraça sua alma! Você transcende a mortalidade!",
      "Nurgle pessoalmente abençoa você com a Necrose Jubilosa!",
      "Seu corpo se torna um templo vivo da decadência divina!",
      "A Pestilência Prismática dança em suas veias!"
    ]
    
    @garden_descriptions = [
      "Um paraíso de podridão onde flores de pus desabrocham eternamente. Árvores de carne apodrecida crescem em solo de ossos moídos. Rios de bile fluem preguiçosamente entre colinas de tecido necrosado.",
      
      "No coração do Reino do Caos, o jardim de Nurgle prospera. Cada doença é uma flor, cada praga uma árvore frondosa. Nurglings brincam entre poças de icor, enquanto Grandes Imundos Daemons tendem jardins de tumores.",
      
      "Um lugar onde a morte alimenta a vida em um ciclo eterno. Cogumelos do tamanho de casas crescem em cadáveres de deuses mortos. O ar é espesso com esporos que carregam mil doenças diferentes, cada uma mais bela que a anterior.",
      
      "O Jardim é amor manifesto em decomposição. Cada criatura aqui é abençoada com imortalidade através da podridão eterna. É o único lugar no universo onde o sofrimento se torna alegria pura."
    ]
    
    @conversion_messages = [
      "As sementes da corrupção foram plantadas em {target}! Em breve brotarão!",
      "{target} sente a primeira coceira... A infecção começou!",
      "Papa Nurgle volta seus olhos amorosos para {target}!",
      "A conversão de {target} está em andamento... 7 dias para a manifestação completa!",
      "{target} foi marcado! As bênçãos virão, queira ou não!",
      "Um esporo invisível pousou em {target}. A transformação é inevitável!"
    ]
  end
  
  def get_papa_response
    @papa_responses.sample
  end
  
  def get_random_whisper
    @whispers.sample
  end
  
  def get_special_blessing
    @special_blessings.sample
  end
  
  def get_garden_description
    @garden_descriptions.sample
  end
  
  def get_conversion_message(target_name)
    message = @conversion_messages.sample
    message.gsub("{target}", target_name)
  end
end
