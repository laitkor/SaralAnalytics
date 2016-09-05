class Role
  include Ripple::Document
  class << self
    include CustomSearch
  end
  
  property :name, String
end
