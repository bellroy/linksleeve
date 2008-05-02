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

    assert !LinkSleeve.spam?("Not spam.")
  end
  def test_that_correct_arguments_are_passed_to_xmlrpc_server
    server = stub()
    server.expects(:call).with("slv", "A string.")
    XMLRPC::Client.stubs(:new).returns(server)

    LinkSleeve.spam?("A string.")
  end
  def test_that_correct_xmlrpc_server_is_initialized
    server = stub_everything()
    XMLRPC::Client.expects(:new).with("www.linksleeve.org","slv.php").returns(server)

    LinkSleeve.spam?("A string.")
  end
end
