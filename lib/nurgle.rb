require 'json'

class Nurgle
  def initialize
    file = File.read(File.join(__dir__, 'nurgle.json'))
    @data = JSON.parse(file)
  end
  def select_random
    @data.sample
  end
end