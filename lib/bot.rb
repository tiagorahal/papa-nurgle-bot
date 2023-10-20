require 'telegram/bot'
require_relative 'greeting.rb'
require_relative 'trivia.rb'


class Bot
  def initialize
    token = '6768420107:AAE_lFrx_sLSJl2_LlvhdztnqRlVdClMpGw'

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
      when '/start'

        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to Papa Nurgle chat bot created by Tiago. Use  /start to start the bot,  /stop to end the bot, /hello to get a greeting from Nurgle, /trivia to know a random fact about Papa Nurgle.")

      when '/stop'

        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        
      when  '/hello'
      greeting = Greeting.new
      value = greeting.select_random
      bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)

      when  '/trivia'
      trivia = Trivia.new
      value = trivia.select_random
      bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)

      else
        bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, you need to use  /start,  /stop , /hello, /trivia")
      end
    end
  end
  end
end