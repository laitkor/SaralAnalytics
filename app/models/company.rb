class Company
  include Ripple::Document
  class << self
    include CustomSearch
  end
  
  property :user_id, String
  property :company_code, String
  property :name, String
  property :address1, String
  property :address2, String
  property :city, String
  property :state, String
  property :pincode, String
  property :contact_phone, String

  validates_presence_of :name, message: "Name can't be blank"

  validates_presence_of :address1, message: "Address can't be blank"

  validates :contact_phone,
            :presence => {:message => "Phone number can't be blank" },
            :format => { :with => /^[\(\)0-9\- \+\.]{5,20} *[extension\.]{0,9} *[0-9]{0,5}$/i, :message =>"Please enter a proper phone number"}
end

