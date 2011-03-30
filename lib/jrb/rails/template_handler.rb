module JRB
  module Rails
    class TemplateHandler
      class << self
        def call(template)
          helper = JRB.const_get(template.mime_type.to_sym.to_s.upcase)

          [ "class_eval { def <<(out); @output_buffer << out; end; alias_method :write, :<< }",
            "@output_buffer = ActiveSupport::SafeBuffer.new",
            template.source,
            "@output_buffer.to_s" ].join(";")
        end
      end
    end
  end
end
