# encoding: UTF-8
require File.expand_path("test_helper", File.dirname(__FILE__))
require "tempfile"

class TiltTemplateTest < ActiveSupport::TestCase
  test "registered for .rb files" do
    assert Tilt.mappings["rb"].include?(JRB::Template)
  end

  test "loading and evaluating templates on #render" do
    template = JRB::Template.new { "'Hello World!'" }
    assert_equal "Hello World!", template.render
  end

  test "can be rendered more than once" do
    template = JRB::Template.new { "'Hello World!'" }
    3.times { assert_equal "Hello World!", template.render }
  end

  test "passing locals" do
    template = JRB::Template.new { '"Hey " + name + "!"' }
    assert_equal "Hey Joe!", template.render(Object.new, :name => 'Joe')
  end

  test "evaluating in an object scope" do
    template = JRB::Template.new { '"Hey #{@name}!"' }
    scope = Object.new
    scope.instance_variable_set :@name, 'Joe'
    assert_equal "Hey Joe!", template.render(scope)
  end

  test "automatic output escaping" do
    template = JRB::Template.new { '"Hey #{@name}!"' }
    scope = Object.new
    scope.instance_variable_set :@name, '<script>Joe</script>'
    assert_equal "Hey &lt;script&gt;Joe&lt;/script&gt;!", template.render(scope)
  end

  test "disabled automatic output escaping" do
    template = JRB::Template.new(:escape_html => false) { '"Hey #{@name}!"' }
    scope = Object.new
    scope.instance_variable_set :@name, '<script>Joe</script>'
    assert_equal "Hey <script>Joe</script>!", template.render(scope)
  end
  
  test "value equals output buffer" do
    template = JRB::Template.new { '__output_buffer << "Hey #{name}!"; __output_buffer' }
    assert_equal "Hey Joe!", template.render(Object.new, :name => 'Joe')
  end

  test "write method" do
    template = JRB::Template.new { 'write "Hey "; write name; write "!"' }
    assert_equal "Hey Joe!", template.render(Object.new, :name => 'Joe')
    assert_equal "Hey Jane!", template.render(Object.new, :name => 'Jane')
  end
  test "passing a block for yield" do
    template = JRB::Template.new { '"Hey #{yield}!"' }
    assert_equal "Hey Joe!", template.render { 'Joe' }
  end

  test "backtrace file and line reporting without locals" do
    data = '"Hey #{name}!" + fail'
    template = JRB::Template.new('test.rb', 11) { data }
    begin
      template.render
      fail 'should have raised an exception'
    rescue => boom
      assert_kind_of NameError, boom
      line = boom.backtrace.grep(/^test\.rb:/).first
      assert line, "Backtrace didn't contain test.rb"
      file, line, meth = line.split(":")
      assert_equal '11', line
    end
  end

  test "backtrace file and line reporting with locals" do
    data = '"Hey #{name}!" + fail'
    template = JRB::Template.new('test.rb', 1) { data }
    begin
      template.render(Object.new, :name => 'Joe', :foo => 'bar')
      fail 'should have raised an exception'
    rescue => boom
      assert_kind_of RuntimeError, boom
      line = boom.backtrace.first
      file, line, meth = line.split(":")
      assert_equal 'test.rb', file
      assert_equal '1', line
    end
  end
end

class CompiledTiltTemplateTest < ActiveSupport::TestCase
  class Scope
  end

  test "compiling template source to a method" do
    template = JRB::Template.new { "'Hello World!'" }
    template.render(Scope.new)
    method = template.send(:compiled_method, [])
    assert_kind_of UnboundMethod, method
  end

  test "loading and evaluating templates on #render" do
    template = JRB::Template.new { "'Hello World!'" }
    assert_equal "Hello World!", template.render(Scope.new)
    assert_equal "Hello World!", template.render(Scope.new)
  end

  test "passing locals" do
    template = JRB::Template.new { '"Hey " + name + "!"' }
    assert_equal "Hey Joe!", template.render(Scope.new, :name => 'Joe')
  end

  test "evaluating in an object scope" do
    template = JRB::Template.new { '"Hey #{@name}!"' }
    scope = Scope.new
    scope.instance_variable_set :@name, 'Joe'
    assert_equal "Hey Joe!", template.render(scope)
    scope.instance_variable_set :@name, 'Jane'
    assert_equal "Hey Jane!", template.render(scope)
  end
  
  test "automatic output escaping" do
    template = JRB::Template.new { '"Hey #{@name}!"' }
    scope = Scope.new
    scope.instance_variable_set :@name, '<script>Joe</script>'
    assert_equal "Hey &lt;script&gt;Joe&lt;/script&gt;!", template.render(scope)
  end

  test "disabled automatic output escaping" do
    template = JRB::Template.new(:escape_html => false) { '"Hey #{@name}!"' }
    scope = Scope.new
    scope.instance_variable_set :@name, '<script>Joe</script>'
    assert_equal "Hey <script>Joe</script>!", template.render(scope)
  end
  
  test "value equals output buffer" do
    template = JRB::Template.new { '__output_buffer << "Hey #{name}!"; __output_buffer' }
    assert_equal "Hey Joe!", template.render(Scope.new, :name => 'Joe')
  end

  test "write method" do
    template = JRB::Template.new { 'write "Hey "; write name; write "!"' }
    assert_equal "Hey Joe!", template.render(Scope.new, :name => 'Joe')
    assert_equal "Hey Jane!", template.render(Scope.new, :name => 'Jane')
  end

  test "passing a block for yield" do
    template = JRB::Template.new { '"Hey #{yield}!"' }
    assert_equal "Hey Joe!", template.render(Scope.new) { 'Joe' }
    assert_equal "Hey Jane!", template.render(Scope.new) { 'Jane' }
  end

  test "backtrace file and line reporting without locals" do
    data = '"Hey #{name}!" + fail'
    template = JRB::Template.new('test.erb', 11) { data }
    begin
      template.render(Scope.new)
      fail 'should have raised an exception'
    rescue => boom
      assert_kind_of NameError, boom
      line = boom.backtrace.grep(/^test\.erb:/).first
      assert line, "Backtrace didn't contain test.erb"
      file, line, meth = line.split(":")
      assert_equal '11', line
    end
  end

  test "backtrace file and line reporting with locals" do
    data = '"Hey #{name}!" + fail'
    template = JRB::Template.new('test.erb') { data }
    begin
      template.render(Scope.new, :name => 'Joe', :foo => 'bar')
      fail 'should have raised an exception'
    rescue => boom
      assert_kind_of RuntimeError, boom
      line = boom.backtrace.first
      file, line, meth = line.split(":")
      assert_equal 'test.erb', file
      assert_equal '1', line
    end
  end

  test "encoding with magic comment" do
    f = Tempfile.open("template")
    f.puts('# coding: UTF-8')
    f.puts('"ふが #{@hoge}"')
    f.close()
    @hoge = "ほげ"
    jrb = JRB::Template.new(f.path)
    3.times { jrb.render(self) }
    f.delete
  end

  test "encoding with :default_encoding" do
    f = Tempfile.open("template")
    f.puts('"ふが #{@hoge}"')
    f.close()
    @hoge = "ほげ"
    jrb = JRB::Template.new(f.path, :default_encoding => 'UTF-8')
    3.times { jrb.render(self) }
    f.delete
  end
end
