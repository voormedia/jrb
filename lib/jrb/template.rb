require "tilt/template"

module JRB
  class Template < Tilt::Template
    self.default_mime_type = "text/html"

    def prepare
      @buffer_variable = "@output_buffer" # Rails compatibility with capture()
      @new_buffer = options.delete(:escape_html) == false ? "''" : "ActiveSupport::SafeBuffer.new"
    end

    def precompiled_preamble(locals)
      <<-RUBY
        #{super}
        __output_buffer = #{@new_buffer}
        __old_output_buffer, #{@buffer_variable} = #{@buffer_variable}, __output_buffer
        instance_eval do
          def <<(data)
            #{@buffer_variable} << data
          end
          alias write <<
        end
        __result = begin
      RUBY
    end

    def precompiled_postamble(locals)
      <<-RUBY
        ensure
          #{@buffer_variable} = __old_output_buffer
        end
        __output_buffer << __result unless __result == __output_buffer
        __output_buffer
      RUBY
    end

    def precompiled_template(locals)
      data.to_str
    end
  end
end
