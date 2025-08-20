# lib/infection_system.rb
require 'json'
require 'time'

class InfectionSystem
  attr_reader :users_data
  
  def initialize(data_file = 'data/infections.json')
    @data_file = data_file
    @users_data = load_data
    @level_thresholds = [0, 10, 25, 50, 100, 175, 275, 400, 550, 750, 1000, 1500, 2000, 3000, 5000]
    @level_names = [
      "Não Infectado",
      "Recém Tocado",
      "Esporo Inicial", 
      "Portador Menor",
      "Hospedeiro Ativo",
      "Vetor Pestilento",
      "Praga Ambulante",
      "Arauto da Decadência",
      "Campeão Pútrido",
      "Escolhido de Nurgle",
      "Avatar da Pestilência",
      "Daemon Menor",
      "Príncipe Daemon",
      "Favorito de Papa Nurgle",
      "Encarnação da Entropia"
    ]
  end
  
  def register_user(user_id)
    user_id = user_id.to_s
    unless @users_data[user_id]
      @users_data[user_id] = {
        'total_infection' => 0,
        'level' => 1,
        'first_infection' => Time.now.to_s,
        'last_interaction' => Time.now.to_s,
        'last_blessing' => nil,
        'achievements' => [],
        'streak_days' => 0,
        'total_interactions' => 0
      }
      save_data
    end
  end
  
  def add_infection(user_id, amount)
    user_id = user_id.to_s
    register_user(user_id) unless @users_data[user_id]
    
    old_level = @users_data[user_id]['level']
    @users_data[user_id]['total_infection'] += amount
    @users_data[user_id]['total_interactions'] += 1
    
    # Atualizar nível
    new_level = calculate_level(@users_data[user_id]['total_infection'])
    @users_data[user_id]['level'] = new_level
    
    # Verificar conquistas
    if new_level > old_level
      add_achievement(user_id, "level_#{new_level}")
    end
    
    update_streak(user_id)
    save_data
    
    new_level > old_level
  end
  
  def bonus_infection(user_id, multiplier)
    user_id = user_id.to_s
    register_user(user_id) unless @users_data[user_id]
    
    bonus = rand(5..15) * multiplier
    add_infection(user_id, bonus)
    bonus
  end
  
  def get_level(user_id)
    user_id = user_id.to_s
    return 1 unless @users_data[user_id]
    @users_data[user_id]['level']
  end
  
  def get_level_name(user_id)
    level = get_level(user_id)
    @level_names[level - 1] || @level_names.last
  end
  
  def get_status(user_id)
    user_id = user_id.to_s
    register_user(user_id) unless @users_data[user_id]
    
    user = @users_data[user_id]
    current_level = user['level']
    total = user['total_infection']
    
    # Calcular progresso para próximo nível
    current_threshold = @level_thresholds[current_level - 1] || 0
    next_threshold = @level_thresholds[current_level] || @level_thresholds.last
    progress = total - current_threshold
    needed = next_threshold - current_threshold
    progress_percent = ((progress.to_f / needed) * 100).round(1)
    
    # Calcular ranking
    rank = calculate_rank(user_id)
    
    {
      level: current_level,
      total_infection: total,
      progress_percent: progress_percent,
      next_level_at: next_threshold,
      last_blessing: user['last_blessing'] || "Nunca recebida",
      achievements: user['achievements'].size,
      streak_days: user['streak_days'],
      rank: rank
    }
  end
  
  def daily_blessing(user_id)
    user_id = user_id.to_s
    register_user(user_id) unless @users_data[user_id]
    
    last_blessing = @users_data[user_id]['last_blessing']
    
    if last_blessing.nil? || (Time.now - Time.parse(last_blessing)) >= 86400
      blessing_amount = rand(20..50) + (@users_data[user_id]['level'] * 2)
      add_infection(user_id, blessing_amount)
      @users_data[user_id]['last_blessing'] = Time.now.to_s
      save_data
      
      {available: true, amount: blessing_amount}
    else
      time_remaining = format_time_remaining(Time.parse(last_blessing) + 86400 - Time.now)
      {available: false, time_remaining: time_remaining}
    end
  end
  
  def update_infection(user_id)
    user_id = user_id.to_s
    register_user(user_id) unless @users_data[user_id]
    
    @users_data[user_id]['last_interaction'] = Time.now.to_s
    update_streak(user_id)
    save_data
  end
  
  def total_users
    @users_data.size
  end
  
  def total_infection
    @users_data.values.sum { |user| user['total_infection'] }
  end
  
  private
  
  def load_data
    return {} unless File.exist?(@data_file)
    JSON.parse(File.read(@data_file))
  rescue
    {}
  end
  
  def save_data
    Dir.mkdir('data') unless Dir.exist?('data')
    File.write(@data_file, JSON.pretty_generate(@users_data))
  end
  
  def calculate_level(total_infection)
    level = 1
    @level_thresholds.each_with_index do |threshold, index|
      if total_infection >= threshold
        level = index + 1
      else
        break
      end
    end
    [level, @level_thresholds.size].min
  end
  
  def calculate_rank(user_id)
    sorted_users = @users_data.sort_by { |_, data| -data['total_infection'] }
    sorted_users.find_index { |id, _| id == user_id } + 1
  end
  
  def update_streak(user_id)
    user = @users_data[user_id]
    last_interaction = Time.parse(user['last_interaction'])
    
    if user['last_interaction'] && (Time.now - last_interaction) < 86400
      user['streak_days'] = (user['streak_days'] || 0) + 1
    elsif (Time.now - last_interaction) > 172800  # Mais de 2 dias
      user['streak_days'] = 0
    end
  end
  
  def add_achievement(user_id, achievement)
    @users_data[user_id]['achievements'] ||= []
    unless @users_data[user_id]['achievements'].include?(achievement)
      @users_data[user_id]['achievements'] << achievement
    end
  end
  
  def format_time_remaining(seconds)
    hours = (seconds / 3600).to_i
    minutes = ((seconds % 3600) / 60).to_i
    "#{hours}h #{minutes}min"
  end
end
