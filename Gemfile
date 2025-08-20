# Gemfile
source 'https://rubygems.org'

ruby '~> 3.0'

# Bot do Telegram
gem 'telegram-bot-ruby', '~> 1.0'

# JSON para parsing de dados
gem 'json', '~> 2.6'

# Requisições HTTP persistentes
gem 'net-http-persistent', '~> 4.0'

# Logger colorido para melhor visualização (opcional)
gem 'colorize', '~> 0.8'

# Dotenv para carregar variáveis de ambiente de arquivo .env (desenvolvimento)
group :development do
  gem 'dotenv', '~> 2.8'
  gem 'pry', '~> 0.14'  # Para debug
end

# Para testes (opcional)
group :test do
  gem 'rspec', '~> 3.12'
  gem 'vcr', '~> 6.1'
  gem 'webmock', '~> 3.18'
end
