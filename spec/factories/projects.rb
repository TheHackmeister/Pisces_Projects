require 'faker'
FactoryGirl.define do
  factory :project do |f|
    transient do
      #Sort by step?
      step_due '10/10/2010'
      step_action 'Action'
      multiple_projects false
    end


    sequence :title do |n| 'Title ' + n.to_s end
		sequence :goal do |n| 'Project Goal ' + n.to_s end
		sequence :notes do |n| 'Notes' + n.to_s end
		sequence :customer_notes do |n| 'Customer Notes' + n.to_s end
		sequence :stumbling_blocks do |n| 'Stumbling Blocks' + n.to_s end
		sequence :soft_deadline do |n| Date.today() + n.days end
		sequence :started do |n| Date.today() - n.days end
		sequence :customer_id do |n| (100) + (n%100)  end # 381 # Should be Pisces Molecular

		project_type_id do (create :project_type).id end
		priority_id do |n| (create :priority, text: 'Pri' + n.to_s, val: n).id end
    status_id do |n| (create :status).id end

    factory :project_with_step do 
      after(:create) do |project, eval|
        FactoryGirl.create(:step, project: project, due: eval.step_due, action: eval.step_action)
        project.reload
      end
    end
  end
end
