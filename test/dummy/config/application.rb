require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"

Bundler.require
require "jrb"

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.active_support.deprecation = :stderr
  end
end

