module JRB
  module HTML
    ELEMENTS = %w{a abbr address area article aside audio b base bdi bdo
      blockquote body br button canvas caption cite code col colgroup command
      datalist dd del details dfn div dl dt em embed fieldset figcaption
      figure footer form h1 h2 h3 h4 h5 h6 head header hgroup hr html i iframe
      img input ins kbd keygen label legend li link map mark menu meta meter
      nav noscript object ol optgroup option output p param pre progress q rp
      rt ruby s samp script section select small source span strong style sub
      summary sup table tbody td textarea tfoot th thead time title tr track
      ul var video wbr}

    ELEMENTS.each do |element|
      module_eval <<-RUBY
        def #{element}(attrs = nil)
          self << "<#{element}\#{format_attrs(attrs)}>".html_safe
          self << yield if block_given?
          self << "</#{element}>".html_safe
        end
      RUBY
    end

    private

    def format_attrs(attrs)
      return if attrs.nil?
      attrs.each_with_object("") do |name, value, str|
        str << %Q{ #{name}="#{value}"}
      end
    end
  end
end
