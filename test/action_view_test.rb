# encoding: UTF-8
require File.expand_path("test_helper", File.dirname(__FILE__))

class ActionViewTest < ActionController::TestCase
  tests TestController

  test "rendering .rb files" do
    get :index, :name => "John"
    assert_equal "<html><head></head><body>Hello John!</body></html>", response.body
  end

  test "escaping html characters in html templates" do
    get :index, :name => "<script>unsafe</script>"
    assert_equal "<html><head></head><body>Hello &lt;script&gt;unsafe&lt;/script&gt;!</body></html>", response.body
  end

  test "not escaping html characters in xml templates" do
    get :index, :name => "<script>unsafe</script>", :format => :xml
    assert_equal "<greeting>Hello &lt;script&gt;unsafe&lt;/script&gt;!</greeting>", response.body
  end

  test "not escaping html characters in json templates" do
    get :index, :name => "<script>safe</script>", :format => :json
    assert_equal '{"greeting":"Hello \\u003Cscript\\u003Esafe\\u003C/script\\u003E!"}', response.body
  end

  test "capturing content" do
    get :capture, :name => "John"
    assert_equal "<html><head></head><body>Hello John!</body></html>", response.body
  end
end
