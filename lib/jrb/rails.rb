module JRB
  module Rails
    class TemplateHandler
      class << self
        def call(template)
          tilt_template = JRB::Template.new(template.identifier) { template.source }
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
