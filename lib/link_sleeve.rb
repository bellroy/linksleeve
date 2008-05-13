# LinkSleeve
require 'xmlrpc/client'

class LinkSleeve
  def self.spam?(text)
    begin
      server.call("slv", text) == 0
    rescue RuntimeError => e
      if defined?(RAILS_DEFAULT_LOGGER)
        RAILS_DEFAULT_LOGGER.warn "LinkSleeve down?: '#{e.message}'. Allowing post anyway.\n<<COMMENT\n#{text}\nCOMMENT"
      end
      return false
    end
  end

  def self.server
    XMLRPC::Client.new("www.linksleeve.org", "/slv.php")
  end
end
