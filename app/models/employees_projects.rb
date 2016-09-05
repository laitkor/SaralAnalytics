class EmployeesProjects
  include Ripple::Document
  class << self
    include CustomSearch
  end
  
  
  property :company_name, String
  property :user_id, String
  property :company_id, String
  property :employee_id, String
  property :project_id, String
  timestamps!

  def self.create_all(attr)
    attr[:project_id].reject(&:blank?).each do |pr_id|
      EmployeesProjects.create({
        employee_id: attr[:employee_id],
        project_id: pr_id,
        user_id: attr[:user_id],
        company_id: attr[:company_id],
        company_name: attr[:company_name]
      })
    end
  end

  def self.delete_all(employee_id)
    employee_projects = EmployeesProjects.find EmployeesProjects.search_by(employee_id: employee_id)
    employee_projects.map &:destroy
  end


  def self.update_all(attr)
    employee = Employee.find attr[:id]
    company = Company.find employee.company_id
    user_id = User.search_by(email: attr[:user][:email])[0]

    self.delete_all employee.key

    self.create_all(project_id: attr[:employees_projects][:project_id], employee_id: employee.key, user_id: user_id, company_id: company.key, company_name: company.name)
  end

end
