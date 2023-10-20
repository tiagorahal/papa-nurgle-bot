require 'json'

class Greeting
  def initialize
    file = File.read(File.join(__dir__, 'greetings.json'))
    @data = JSON.parse(file)
  end
  def select_random
    @data.sample
  end
end