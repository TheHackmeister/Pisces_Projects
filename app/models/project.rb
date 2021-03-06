class Project < ActiveRecord::Base
  belongs_to :customer
  belongs_to :priority
  belongs_to :status
	belongs_to :project_type
  has_many :contacts, :dependent => :destroy
  has_many :project_links, :dependent => :destroy
  has_many :steps, :dependent => :destroy
  has_many :communications, :dependent => :destroy

	has_many :cdb_batch_projects
	has_many :cd_batches, through: :cdb_batch_projects, class_name: :CdbBatch

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :project_links
  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :communications
  

  validates :title, :customer, :priority, :status, :project_type, :presence => true
  validates_associated :customer, :priority, :status, :project_links, :steps, :contacts, :communications
  
  delegate :text, :val, :to => :priority, :prefix => true
  delegate :customer_name, :to => :customer
  delegate :text, :val, :to => :status, :prefix => true
	delegate :text, :sort, :to => :project_type, :prefix => true
  #delegate :action, :note, :to => :step, :allow_nil => true, :prefix => true
  #delegate :name, :url, :notes, :to => :project_links, :allow_nil => true, :prefix => true
  #delegate :summary, :notes, :to => :communications, :allow_nil => true, :prefix => true
  
	include HasFormattedFields
	formattable_text_fields :notes, :customer_notes, :stumbling_blocks, :results_notes

  def get_first_step_action
    if self.steps.length == 0
        return ""
    else 
        return self.steps.first.action
    end
  end
  
  def get_first_step_date
    if self.steps.length == 0
      return ""
    else 
      return self.steps.first.due
    end
  end

	
  def customer_name
    if self.customer.blank?
      return ""
    else 
      return self.customer.customer_name
    end
  end

	def links
		project_links.where(is_results: false)
	end

	def results_links
		project_links.where(is_results: true)
	end

  #text :customer
  #text :communications
  #text :contacts
  #text :project_links
  #text :steps
  searchable do
    text :goal
    text :title
    text :notes
    text :customer_notes
    text :stumbling_blocks
    text :priority_text
    text :status_text
    text :customer_name
    text :steps do
      steps.map(&:action)
      steps.map(&:note)
    end
    text :contacts do
      contacts.map{|contact|
				contact.contact_name
				contact.email}
    end
    text :project_links do
      project_links.map(&:url)
      project_links.map(&:name)
      project_links.map(&:notes)
    end
    text :communications do
      communications.map(&:summary)
      communications.map(&:notes)
    end
    
    string(:title) { title.downcase.sub(/^(a|an|the)\b/, '')}
    integer :priority_val
    string(:goal) { goal.downcase.sub(/^(a|an|the)\b/, '')}
  end
  
  before_save{ |project| project.notes = project.notes.gsub("%28", "(").gsub("%29", ")").gsub("%20", " ")}  
end
