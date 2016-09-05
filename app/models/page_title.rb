class PageTitle
  include Ripple::Document  
  class << self
    include CustomSearch
  end
    property :project_id, String
    property :title, String
    property :page_url, String

end
