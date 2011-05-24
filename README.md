JRB - Plain Ruby templates
==========================

JRB is a simple template handler that allows you to use plain Ruby files as
templates. Use it when you're experimenting with your views. Use it if you
have templates that don't have much markup. Or use it if you prefer to use
HTML generators such as [Crafty](https://github.com/voormedia/crafty).


Synopsis
--------

Add `jrb` to your `Gemfile`:

    gem "jrb"

Now you can write Ruby templates whenever you like. JRB renders the last
return value of your Ruby template.

    # app/views/examples/hello.html.rb
    "Hello world!"

For more complex scenarios, JRB exposes the method `<<`, aliased as `write`.
It allows you to write directly to the output stream.

    # app/views/examples/greeting.html.rb
    write "Hello "
    write @name
    write "!"

JRB escapes HTML output by default.

    # app/views/examples/escaping.html.rb
    write "<html>".html_safe
    write @unsafe_content
    write "</html>".html_safe

JRB really shines when used in combination with HTML helpers such as those
provided by [Crafty](https://github.com/voormedia/crafty).

    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      helper Crafty::HTML::Basic
    end

    # app/views/examples/builder.html.rb
    html do
      head do
        title "Hello"
      end
      body do
        div class: ["main", "content"] do
          p "Hello #{@name}!"
        end
      end
    end


About JRB
---------

JRB was created by Rolf Timmermans (r.timmermans *at* voormedia.com)

Copyright 2010-2011 Voormedia - [www.voormedia.com](http://www.voormedia.com/)


License
-------

JRB is released under the MIT license.
