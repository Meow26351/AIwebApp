require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)
ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "C:/Users/tomi2/Documents/diplomna/aiweb/credentials/steam-outlet-377121-0bbd15f48537.json"
module Aiweb
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_storage.service = :amazon
    config.assets.enabled = true
    config.active_job.queue_adapter = :sidekiq
    config.redis_url = 'redis://localhost:6379/0'
    config.autoload_paths += %W(#{config.root}/app/jobs)
    config.net_http_read_timeout = 30
  end
end
