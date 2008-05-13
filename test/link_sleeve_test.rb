require 'test/unit'
%w[ rubygems mocha link_sleeve ].each {|l| require l }

class LinkSleeveTest < Test::Unit::TestCase
  def test_that_spam_returns_true
    server = stub(:call => 0)
    XMLRPC::Client.stubs(:new).returns(server)

    assert LinkSleeve.spam?("This is spam.")
  end
  def test_that_non_spam_returns_false
    server = stub(:call => 1)
    XMLRPC::Client.stubs(:new).returns(server)

    deny LinkSleeve.spam?("Not spam.")
  end
  def test_that_correct_arguments_are_passed_to_xmlrpc_server
    server = stub()
    server.expects(:call).with("slv", "A string.")
    XMLRPC::Client.stubs(:new).returns(server)

    LinkSleeve.spam?("A string.")
  end
  def test_that_correct_xmlrpc_server_is_initialized
    server = stub_everything()
    XMLRPC::Client.expects(:new).with("www.linksleeve.org","/slv.php").returns(server)

    LinkSleeve.spam?("A string.")
  end
  def test_that_link_sleeve_errors_dont_stop_posting
    server = stub()
    server.stubs(:call).raises(RuntimeError)
    XMLRPC::Client.stubs(:new).returns(server)

    deny LinkSleeve.spam?("A string")
  end

  private

  def deny(boolean, message = nil)
    message = build_message message, '<?> is not false or nil.', boolean
    assert_block message do
      not boolean
    end
  end
end
