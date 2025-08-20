# lib/config.rb
module Config
  # Token do bot - MOVA PARA VARIÁVEL DE AMBIENTE EM PRODUÇÃO!
  BOT_TOKEN = ENV['NURGLE_BOT_TOKEN'] || '6768420107:AAE_lFrx_sLSJl2_LlvhdztnqRlVdClMpGw'
  
  # ID do administrador (seu user ID do Telegram)
  ADMIN_ID = ENV['ADMIN_TELEGRAM_ID']&.to_i || 123456789 # Substitua pelo seu ID
  
  # Configurações do sistema de infecção
  INFECTION_CONFIG = {
    daily_blessing_cooldown: 86400,  # 24 horas em segundos
    level_up_notification: true,
    achievement_notifications: true,
    passive_infection_rate: 0.1,     # Chance de infecção passiva
    max_level: 15,
    streak_bonus_multiplier: 1.5
  }
  
  # Configurações de logging
  LOG_CONFIG = {
    level: ENV['LOG_LEVEL'] || 'INFO',
    file: 'logs/bot.log',
    max_size: 10_485_760,  # 10 MB
    keep: 5                 # Manter 5 arquivos de log
  }
  
  # Configurações de rate limiting
  RATE_LIMIT = {
    commands_per_minute: 20,
    blessing_cooldown: 86400,
    trivia_cooldown: 30
  }
  
  # Webhooks (se usar no futuro)
  WEBHOOK_CONFIG = {
    enabled: false,
    url: ENV['WEBHOOK_URL'],
    port: ENV['PORT'] || 8443
  }
end
