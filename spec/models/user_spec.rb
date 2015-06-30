require 'rails_helper'

RSpec.describe User do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}
  
  it 'has a factory' do
    expect(user.has_role?(:user)).to eq(true)
  end
  
  describe '#has_role?' do
    context 'user is an admin' do
      it 'thus has_role?(:admin) returns true' do
        expect(admin.has_role?(:admin)).to eq(true)
      end
      
      it 'thus has_role?(:user) returns false' do
        expect(admin.has_role?(:user)).to eq(false)
      end
    end  
    context 'user is a user' do
      it 'thus has_role?(:admin) returns false' do  
        expect(user.has_role?(:admin)).to eq(false)
      end
      it 'thus has_role?(:user) returns true' do  
        expect(user.has_role?(:user)).to eq(true)
      end
    end
  end
  
  it 'requires a first name.' do
    user.first = ""
    expect(user.valid?).to eq(false)
  end
  
  it 'requires a last name.' do
    user.last = ""
    expect(user.valid?).to eq(false)
  end
  
  #This could be improved by targetting :assign_default_role more specifically. 
  it 'assign_default_role function assigns the user role' do
    FactoryGirl.create(:role, title: 'admin', val: 2)
    FactoryGirl.create(:role, title: 'test', val: 1)
    FactoryGirl.create(:role, title: 'User', val: 3)
    user
    expect(user.roles.first.title).to eq("User")
  end

	it 'when created, generates a token' do
		new_user = FactoryGirl.build :user
		expect(new_user.token).to eq ""
		new_user.save
		expect(new_user.token).to_not eq ""
	end
end
