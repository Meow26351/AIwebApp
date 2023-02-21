require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "C:/Users/tomi2/Documents/diplomna/aiweb/credentials/steam-outlet-377121-0bbd15f48537.json"
module Aiweb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.service = :amazon
    config.assets.enabled = true
    config.active_job.queue_adapter = :sidekiq
    config.redis_url = 'redis://localhost:6379/0'
    config.autoload_paths += %W(#{config.root}/app/jobs)
    config.net_http_read_timeout = 30
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
