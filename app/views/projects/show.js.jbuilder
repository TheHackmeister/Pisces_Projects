json.results @project.send(@show).to_s
json.error @project.errors.count != 0 ? @project.errors.full_messages : ''
