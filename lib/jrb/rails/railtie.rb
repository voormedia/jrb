require "jrb/rails/template_handler"

module JRB
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "jrb.register_handler" do |app|
        app.paths["app/views"].eager_load!
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler "rb", JRB::Rails::TemplateHandler
        end
      end
    end
  end
end
