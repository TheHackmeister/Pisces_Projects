module FormHelper
  def setup_project(project, steps: true) 
    project.customer ||= Customer.new
    project.priority ||= Priority.new
    if project.steps.length == 0 && steps
      project.steps.build
    end
   # project.communications.each do |comm|
    #  comm.contact ||= Contact.new  
    #end
    project
  end
  
  def setup_communication(comm)
    comm
  end
  
  def add_dropdown()


  end

end