require 'resque'

root = ENV['RAILS_ROOT'] || (defined?(RAILS_ROOT) && RAILS_ROOT)
env  = ENV['RAILS_ENV']  || (defined?(RAILS_ENV) && RAILS_ENV)

if root
  require 'yaml'
  config = YAML.load_file File.join(root, 'config', 'resque.yml')
  Resque.redis = config[env]

  if toad = config['hoptoad']
    require 'resque/failure/hoptoad'
    Resque::Failure::Hoptoad.configure do |config|
      config.api_key   = toad['api_key']
      config.secure    = toad['secure']
      config.subdomain = toad['subdomain']
    end
  end
end