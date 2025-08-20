#!/usr/bin/env ruby
# bin/main.rb

require 'bundler/setup'
require_relative '../lib/bot'

# Criar diretórios necessários
['logs', 'data'].each do |dir|
  Dir.mkdir(dir) unless Dir.exist?(dir)
end

# Mensagem de início
puts "🦠 =============================================== 🦠"
puts "     PAPA NURGLE'S TELEGRAM BOT v2.0"
puts "     Espalhando amor e pestilência desde 2024"
puts "🦠 =============================================== 🦠"
puts ""
puts "📊 Iniciando sistemas..."
puts "✅ Módulo de Infecção: Carregado"
puts "✅ Gerador de Saudações: Ativo"
puts "✅ Sistema de Trivia: Pronto"
puts "✅ Motor de Respostas: Operacional"
puts ""

# Verificar token
if ENV['NURGLE_BOT_TOKEN'].nil?
  puts "⚠️  AVISO: Token não encontrado em variável de ambiente!"
  puts "   Usando token padrão (não recomendado para produção)"
  puts "   Configure: export NURGLE_BOT_TOKEN='seu_token_aqui'"
  puts ""
end

# Iniciar bot
begin
  puts "🚀 Conectando ao Telegram..."
  bot = Bot.new
  
  # Trap para shutdown gracioso
  ['INT', 'TERM'].each do |signal|
    trap(signal) do
      puts "\n\n💀 Recebido sinal de término..."
      puts "   Papa Nurgle se despede... por enquanto."
      puts "   As infecções foram salvas."
      puts "🦠 =============================================== 🦠"
      exit
    end
  end
  
  # Executar bot
  bot.run
  
rescue => e
  puts "\n❌ ERRO FATAL: #{e.message}"
  puts "   Stacktrace: #{e.backtrace.first(5).join("\n   ")}"
  puts "\n   Por favor, verifique:"
  puts "   1. Seu token está correto"
  puts "   2. Você tem conexão com a internet"
  puts "   3. As dependências estão instaladas (bundle install)"
  exit(1)
end
