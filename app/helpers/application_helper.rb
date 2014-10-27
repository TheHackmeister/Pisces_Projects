module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def search_html form, label, label_text, sub_label, path, value, display
    haml_tag(:div, :class => "search") do
      haml_concat(form.label label, label_text)
      haml_concat(form.hidden_field label, :class => 'search_id')
      haml_concat((form.fields_for sub_label do |t|
        form.text_field sub_label, :class => 'search_field', :data => {:path => path, 'display-field' => display }, :value => value
      end))
      haml_tag(:div, :class => "search_results") do
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
    text = simple_format text
    
    text.html_safe
  end

  def sub_tag string, find, tag, options=""

    while string.include?(find) == true
      string = string.sub(find, '<' + tag + ' ' + options + ' >').sub(find, '</' + tag + '>')
    end
    puts string
    string
  end
end
