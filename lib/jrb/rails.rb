module JRB
  module Rails
    class TemplateHandler
      HTML_MIME_TYPES = ["text/html", "application/xhtml+xml"]

      class << self
        def call(template)
          auto_escape = HTML_MIME_TYPES.include? template.type
          tilt_template = JRB::Template.new(template.identifier, 1, :escape_html => auto_escape) { template.source }
          tilt_template.send(:precompiled, {}).first
        end
      end
    end

    class Railtie < ::Rails::Railtie
      initializer "jrb.register_handler" do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler "rb", TemplateHandler
        end
      end
    end
  end
end
