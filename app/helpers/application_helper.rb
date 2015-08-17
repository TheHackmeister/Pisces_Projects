module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

	ActionView::Helpers::FormBuilder.class_eval do
		def search_html associated
			base = @object.class.reflect_on_association(associated).foreign_key
			path = Rails.application.routes.path_for controller: associated.to_s.pluralize, action: :index 

			@template.content_tag :div, class: 'search' do 
				hidden = self.hidden_field base, class: 'search_id'
				input =	self.fields_for associated.to_s.classify.constantize do |t|
					t.text_field associated, 
						class: 'search_field', 
						data: {:path => {path: path, input: :search}.as_json, 'display-field' => 'to_s'}, 
						value: @object.send(associated).to_s
				end
				results =	@template.content_tag :div, class: 'search_results' do end
				(hidden + input + results)
			end
		end
	end

  def format_text_field text
    if text == ""
      return "None"
    end

    text = sub_tag text, '***', 'b'
    text = sub_tag text, '*r*', 'font', 'color="red"'
    text = sub_tag text, '\n', 'br'
    text = simple_format text,{} ,:sanitize => false
    
    text.html_safe
  end

  def sub_tag string, find, tag, options=""
		if(options != "") 
			options = " " + options 
		end

    while string.include?(find) == true
      string = string.sub(find, '<' + tag + options + '>').sub(find, '</' + tag + '>')
    end
    #puts string # I don't think I need this.
    string
  end
  
  def display_alert alert
    if(alert.kind_of?(Array)) then
      s = "" 
      alert.each do |message|
        s += message + "\n"
      end
      return s
    else 
      return alert
    end
  end
  alias_method :display_notice, :display_alert

	def show_attribute_text_or_link attribute
		if attribute.is_a?(ActiveRecord::Base) 
			link_to attribute, polymorphic_path([attribute])
		else
			capture_haml() {
				attribute.to_s
			}
		end
	end
	alias_method :show_attribute_link_or_text, :show_attribute_text_or_link

	def create_index_text_or_link object, attribute
		if attribute.is_a? Numeric
			capture_haml() {
				attribute.to_s
			}
		elsif attribute.is_a? ActiveRecord::Base
			link_to attribute.to_s, attribute
		else
			link_to attribute.to_s, object
		end
	end
	alias_method :create_index_link_or_text, :create_index_text_or_link
end
