json.results (render partial: 'show_single', object: @project_link).html_safe
json.error @project_link.errors.count != 0 ? @project_link.errors.full_messages : ''
json.model 'project_link'
