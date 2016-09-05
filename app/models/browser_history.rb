require 'ripple'

class BrowserHistory
  include Ripple::Document
  class << self
    include CustomSearch
  end
  property :project_id, String
  property :ip_address, String
  property :os_name, String
  property :browser, String
  property :main_domain, String
  property :domain, String
  property :item_type, String
  property :device, String
  property :device_type, String
  property :client, String
  timestamps!

  many :browser_details

  def key    
    @key ||= "#{created_at}"
  end
  

end
