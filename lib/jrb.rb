require "tilt"
require "jrb/template"
require "jrb/rails" if defined?(Rails)

Tilt.register JRB::Template, "rb"
