require 'telegram/bot'
require_relative 'greeting.rb'


class Bot
  def initialize
    token = '6768420107:AAE_lFrx_sLSJl2_LlvhdztnqRlVdClMpGw'

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
      when '/start'

        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to Papa Nurgle chat bot created by Tiago. Use  /start to start the bot,  /stop to end the bot, /motivate to get a diffrent motivational quote everytime you request for it.")

      when '/stop'

        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        
      when  '/hello'
      greeting = Greeting.new
      value = greeting.select_random
      bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, you need to use  /start,  /stop , /motivate or /joke")
      end
    end
  end
  end
end