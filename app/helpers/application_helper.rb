module ApplicationHelper
  def project_list
    @projects = Project.list.sort_by(&:created_at).reverse
  end
end
