module FormHelper
  def setup_project(project)
    project.customer ||= Customer.new
    project.priority ||= Priority.new
    project
  end

  def add_dropdown()


  end
end