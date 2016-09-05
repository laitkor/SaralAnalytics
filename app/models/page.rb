class Page
  include Ripple::EmbeddedDocument
  class << self
    include CustomSearch
  end
  
  property :title, String
  property :url, String
end
