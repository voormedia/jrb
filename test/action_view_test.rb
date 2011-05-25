# encoding: UTF-8
require File.expand_path("test_helper", File.dirname(__FILE__))

class ActionViewTest < ActionController::TestCase
  tests TestController

  test "rendering .rb files" do
    get :index, :name => "John"
    assert_equal "<html><head></head><body>Hello John!</body></html>", response.body
  end

  test "escaping html characters" do
    get :index, :name => "<script>unsafe</script>"
    assert_equal "<html><head></head><body>Hello &lt;script&gt;unsafe&lt;/script&gt;!</body></html>", response.body
  end
  
  test "capturing content" do
    get :capture, :name => "John"
    assert_equal "<html><head></head><body>Hello John!</body></html>", response.body
  end
end
