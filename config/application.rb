require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Utage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_view.embed_authenticity_token_in_remote_forms = true
    I18n.config.available_locales = :ja # 使用できる言語を文字列もしくは配列で指定する
    I18n.config.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'
  end
end
