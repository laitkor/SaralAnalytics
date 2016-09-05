class Project
  include Ripple::Document
  class << self
    include CustomSearch
  end
  
  property :name, String
  property :user_id, String
  property :company_id, String
  property :created_at, String
  property :updated_at, String
  timestamps!

  before_save :record_creation
  before_update :record_updation


  validate :verify_unique_project

  def verify_unique_project
    if !(Project.search_by(name: name).empty?)
      if !(self.name==Project.find(key).name rescue nil)
        errors.add :name, "This name has already been taken"
      end
    end
  end

  def self.for_user(key_or_user)
    key = key_or_user.respond_to?(:key) ? key_or_user.key : key_or_user
    if new_key = Company.search_by(user_id: key).first
      return Project.find Project.search_by(company_id: new_key)
    else
      return Employee.find(Employee.search_by(user_id: key)[0]).projects rescue []
    end
  end

  def funnels
    Funnel.search_by(project_id: self.key)
  end


  private
    def record_creation
      self.created_at = Time.now
      self.updated_at = Time.now
    end

    def record_updation
      self.updated_at = Time.now
    end

end
