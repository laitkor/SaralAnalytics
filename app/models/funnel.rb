class Funnel
  include Ripple::Document 
  class << self
    include CustomSearch
  end
  
  property :project_id, String
  property :name, String
  timestamps!
  
  many :pages, :dependent => :destroy
  accepts_nested_attributes_for :pages, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  def update_attributes(attr)
    self.name = attr['name']
    self.pages = attr["pages_attributes"].map { |x| x[1] }
    self.save
  end

  validates_presence_of :name

end
