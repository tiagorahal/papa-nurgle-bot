# lib/greeting_generator.rb
class GreetingGenerator
  def initialize
    @subjects = [
      "decadência", "podridão", "pestilência", "imundície", "doença", "praga",
      "bênçãos", "jardim", "lama", "pus", "solo", "ciclo",
      "morte", "renascimento", "corrupção", "sofrimento", "renovação",
      "Pai Nurgle", "Senhor da Praga", "Avô Nurgle", "entropia",
      "feridas", "chagas", "fungos", "esporos", "necrose", "gangrena",
      "putrefação", "decomposição", "miasma", "contágio", "infecção"
    ]
    
    @templates = [
      "Que {subj} seja seu eterno companheiro.",
      "Regozije-se na {subj} de Nurgle.",
      "Na {subj}, encontre consolo.",
      "Deixe a {subj} de Nurgle guiar seu caminho.",
      "Banhe-se na {subj} concedida por Nurgle.",
      "Que a {subj} lhe traga alegria.",
      "Na {subj}, encontre renovação.",
      "Deleite-se na {subj} do Pai da Praga.",
      "Deixe a {subj} consumir seus medos.",
      "Que a {subj} floresça dentro de você.",
      "Abrace a doce {subj} com gratidão.",
      "A {subj} é a maior dádiva de Papa Nurgle.",
      "Através da {subj}, alcance a iluminação.",
      "Permita que a {subj} transforme sua existência.",
      "Na {subj}, descubra o verdadeiro significado da vida."
    ]
    
    @advanced_templates = [
      "Quando a {subj1} encontra a {subj2}, nasce a verdadeira bênção.",
      "Entre a {subj1} e a {subj2}, Papa Nurgle sorri.",
      "A {subj1} abraça a {subj2} no jardim eterno.",
      "Onde a {subj1} prospera, a {subj2} floresce.",
      "A união da {subj1} com a {subj2} é o amor de Nurgle."
    ]
    
    @prefixes = [
      "", "Ah! ", "Oh, devoto! ", "Filho da pestilência, ",
      "Querido infectado, ", "Abençoado seja! ", "Irmão na podridão, "
    ]
    
    @suffixes = [
      "", " Glória a Nurgle!", " Sete bênçãos sobre você!",
      " Papa Nurgle te ama!", " Espalhe a alegria da decadência!",
      " Que a entropia te guie!", " Apodreça em paz!"
    ]
  end
  
  def generate(level = 1)
    # Quanto maior o nível, mais complexa a saudação
    prefix = level > 3 ? @prefixes.sample : ""
    suffix = level > 5 ? @suffixes.sample : ""
    
    if level > 7 && rand < 0.5
      # Saudações avançadas para níveis altos
      template = @advanced_templates.sample
      subj1 = @subjects.sample
      subj2 = (@subjects - [subj1]).sample
      greeting = template.gsub("{subj1}", subj1).gsub("{subj2}", subj2)
    else
      template = @templates.sample
      subj = @subjects.sample
      greeting = template.gsub("{subj}", subj)
    end
    
    # Capitalizar primeira letra
    greeting = greeting[0].upcase + greeting[1..-1]
    
    "#{prefix}#{greeting}#{suffix}"
  end
  
  def generate_batch(count = 10, level = 1)
    greetings = []
    count.times do
      greetings << generate(level)
    end
    greetings.uniq
  end
end
