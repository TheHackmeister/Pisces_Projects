require 'rails_helper'

# This assumes that we're using FactoryGirl
# That there is a :user factory
# and that there is a factory for <%= file_name %>. 

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, <%= type_metatag(:controller) %> do
	include_context 'application' # Sets up user, admin, and <%= controller_class_name %>
	
	it_behaves_like 'an index page'
	it_behaves_like 'a show page'
	it_behaves_like 'an edit page'
	it_behaves_like 'a new page'
	it_behaves_like 'a create page', {:text => nil}
	it_behaves_like 'an update page', {:text => nil}, {:text => "Example Text"}
	it_behaves_like 'a delete page' 

end
<% end -%>
