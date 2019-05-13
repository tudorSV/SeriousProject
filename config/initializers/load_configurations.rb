CONFIGURATION = YAML.load_file("#{Rails.root}/config/configuration.yml")[ENV['RAILS_ENV']]
