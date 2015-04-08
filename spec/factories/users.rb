FactoryGirl.define do
    # Define a basic devise user.
    factory :user do
      transient do      
        role_title 'User'
        role_val '1'
      end
        email "example@example.com"
        password "example123"
        password_confirmation "example123"
        first "first"
        last "last"
        after(:build) do |userObj, eval|
          if !Role.find_by_title(eval.role_title) then
            userObj.roles << FactoryGirl.create(:role, title: eval.role_title, val: eval.role_val)
          end
        end
          
    #    after(:create) do |userObj|
    #      userObj.reload
    #    end
    end
end