require 'json'

class Trivia
  def initialize
    file = File.read(File.join(__dir__, 'trivia.json'))
    @data = JSON.parse(file)
  end
  def select_random
    @data.sample
  end
end