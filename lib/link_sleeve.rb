# LinkSleeve
require 'xmlrpc/client'

class LinkSleeve
  def self.spam?(text)
    server.call("slv", text) == 0
  end

  def self.server
    XMLRPC::Client.new("www.linksleeve.org", "slv.php")
  end
end
