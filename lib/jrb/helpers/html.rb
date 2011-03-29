module JRB
  module HTML
    ELEMENTS = %w{a abbr address article aside audio b bdi bdo
      blockquote body canvas caption cite code colgroup command
      datalist dd del details dfn div dl dt em embed fieldset figcaption
      figure footer form h1 h2 h3 h4 h5 h6 head header hgroup html i iframe
      ins kbd keygen legend li map mark menu meter 
      nav noscript ol optgroup option output p pre progress q rp
      rt ruby s samp script section select small source span strong style sub
      summary sup table tbody td textarea tfoot th thead time title tr track
      ul var video wbr} #label object button
    
    SELF_CLOSING = %w{area base br col hr img link meta param} # input

    ELEMENTS.each do |element|
      module_eval <<-RUBY
        def #{element}(attrs = nil)
          "<#{element}\#{format_attrs(attrs)}>".html_safe + 
            (yield if block_given?) +
            "</#{element}>".html_safe
        end
      RUBY
    end
    
    SELF_CLOSING.each do |element|
      module_eval <<-RUBY
        def #{element}(attrs = nil)
          "<#{element}\#{format_attrs(attrs)}/>".html_safe
        end
      RUBY
    end

    private

    def format_attrs(attrs)
      return if attrs.nil?
      attrs.each_with_object("") do |(name, value), str|
        str << %Q{ #{name}="#{value}"}
      end
    end
  end
end
