class Employee
  include Ripple::Document
  class << self
    include CustomSearch
  end

  property :user_id, String  
  property :company_id, String
  property :employee_code, String
  property :name, String

  validates :name, 
            :presence => {:message => "Employee name can't be blank" }

  def projects
    emp_pr_ids = EmployeesProjects.search_by(employee_id: key)
    emp_pr_ids.map { |emp_pr_id| Project.find EmployeesProjects.find(emp_pr_id).project_id }
  end
end
