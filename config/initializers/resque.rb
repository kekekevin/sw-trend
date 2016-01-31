Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load(ERB.new(IO.read(rails_root + '/config/resque.yml')).result)
Resque.redis = resque_config[rails_env]