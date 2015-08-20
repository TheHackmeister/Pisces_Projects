FactoryGirl.define do
  factory :cdb_batch_project do
    cdb_batch_id do (create :cdb_batch).id end
    project_id do (create :project).id end
  end

end
