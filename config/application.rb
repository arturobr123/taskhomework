require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GamificationFaurecia
  class Application < Rails::Application
  	#config.time_zone = 'Central Time (US & Canada)'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    #QUE SIDEKIQ SE OCUPE DE LOS JOBS EN 2DO PLANO
    config.active_job.queue_adapter = :sidekiq
  end
end
