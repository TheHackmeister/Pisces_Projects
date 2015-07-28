<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  load_and_authorize_resource
  <%= controller_before_filter %> :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  respond_to :html

<% unless options[:singleton] -%>
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with(@<%= plural_table_name %>)
  end
<% end -%>

  def show
    respond_with(@<%= singular_table_name %>)
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= singular_table_name %>)
  end

  def edit
    respond_with(@<%= singular_table_name %>)
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, attributes_params) %>
    if not @<%= orm_instance.save %>
      flash[:alert] = <%= singular_table_name %>.errors.full_messages
    end
    respond_with(@<%= singular_table_name %>)
  end

  def update
    if not @<%= orm_instance_update(attributes_params) %>
      flash[:alert] = <%= singular_table_name %>.errors.full_messages
    end
    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    if not @<%= orm_instance.destroy %>
      flash[:alert] = <%= singular_table_name %>.errors.full_messages
    end
    respond_with(@<%= singular_table_name %>)
  end

  private
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end
    <%- if strong_parameters_defined? -%>

    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
    <%- end -%>
end
<% end -%>
