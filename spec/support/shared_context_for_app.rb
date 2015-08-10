RSpec.shared_context "application", a: :b do
	let(:user) {FactoryGirl.create(:user)}
	let(:admin) {FactoryGirl.create(:user, role_title: 'admin', role_val: '2')}
	let(:object) { FactoryGirl.create(class_name.to_sym) }

	let(:new_class_path) {send("new_" + class_single + "_path")}
	#let(:class_path) {|model| send(class_single + "_path", model)}

	def class_path model=nil
		if model 
			send(class_single + '_path', model)
		else
			send(class_plural + '_path')
		end
	end

	def edit_class_path model
		send('edit_' + class_single + '_path', model)
	end

	def class_single
		class_name
	end

	def class_plural
		class_name.pluralize
	end

	def class_model
		class_name.classify.constantize
	end

	def picture name='screen'
		page.driver.render('./log/' + name + '.png', :full => true)	
	end
end
