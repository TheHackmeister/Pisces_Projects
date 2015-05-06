class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first, :last, :presence => true
  
  
  
  has_many :role_assignments
  has_many :roles, through: :role_assignments
  #accepts_nested_attributes_for :role_assignments
  #has_many :roles, through: :role_assigment, source: :role
  
  def has_role?(role_sym)
    roles.any? { |r| r.title.underscore.downcase.to_sym == role_sym }
  end
  
   before_save :assign_default_role

  protected
  
  def assign_default_role
    if self.roles.size == 0
      self.role_assignments.new :role =>Role.find_by_title('User')
    end
  end
end
