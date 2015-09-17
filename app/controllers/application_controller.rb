require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

	# Needed for API. If a user doesn't have a valid token, the authentication strategy will NOT roll over into the usual html auth.
	skip_before_action :verify_authenticity_token, if: :json_request? 
 
	# Fix for CanCan 
  resource = controller_name.singularize.to_sym
  method = "#{resource}_params"
  params[resource] &&= send(method) if respond_to?(method, true)

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    render :edit
  end
  
	private 
	
	def json_request?
		request.format.symbol == :json
	end

	def dynamic_field_edit instance, field_name
		if field_name =~ /_id$/i

		#if instance.send(field_name).is_a? ActiveRecord::Base
			field_name = field_name.gsub(/_id$/i, '')
			if field_name.classify.constantize.reference_type_is_search?
				type = :search_reference
			else
				type = :reference
			end
		else 
			type = instance.class.column_for_attribute(field_name).type
		end 

		case type
		when :text
			dynamic_text_area instance, field_name, true
		when :string
			dynamic_text_field instance, field_name, true
		when :date
			dynamic_date_select instance, field_name, true
		when :search_reference
			dynamic_search_html instance, field_name, true
		when :reference
			dynamic_collection_select instance, field_name, true
		else
		end
	end

	def dynamic_text_field instance, field_name, ajax=false
		view = get_view ajax
		view.render partial: 'text_field', locals: {
			field_name: field_name, 
			text: instance.send(field_name), 
			model_name: instance.class.table_name.singularize, 
			ajax_class: ajax ? 'edit_field' : ''
		}
	end

	def dynamic_text_area instance, field_name, ajax=false
		view = get_view ajax
		view.render partial: 'text_area',formats: [:html], locals: { field_name: field_name, 
			text: instance.send(field_name), 
			model_name: instance.class.table_name.singularize, 
			ajax_class: ajax ? 'edit_field' : ''}
	end

	def dynamic_collection_select instance, field_name, ajax=false, drop_down_text='text'
		view = get_view ajax
		view.render partial: 'collection_select', locals: {
			field_name: field_name, 
			model_name: instance.class.table_name.singularize, 
			drop_down_text: drop_down_text, 
			ajax_class: ajax ? 'edit_field' : ''
		}
	end

	def dynamic_date_select instance, field_name, ajax=false
		view = get_view ajax
		view.render partial: 'date_select', locals: {
			field_name: field_name, 
			model_name: instance.class.table_name.singularize, 
			ajax_class: ajax ? 'edit_field' : ''
		}
	end

	def dynamic_search_html instance, field_name, ajax=false
		view = get_view ajax
		view.render partial: 'search_html', locals: { 
			ajax_class: ajax ? 'edit_field' : '',
			field_name: field_name, 
			model: instance
		}
	end

	def get_view ajax
		if ajax
			self
		else 
			view_context
		end
	end

	helper_method :dynamic_text_field, :dynamic_text_area, :dynamic_collection_select,
		:dynamic_date_select, :dynamic_search_html
end
