module JRB
  autoload :HTML, "jrb/helpers/html"

  require "jrb/rails/railtie" if defined?(Rails)
end
