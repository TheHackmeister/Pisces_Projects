module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def search_html form, label, label_text, sub_label, path, value
    haml_tag(:div, :class => "search") do
      haml_concat (form.label label, label_text)
      haml_concat (form.hidden_field label, :class => 'search_id')
      haml_concat (form.fields_for sub_label do |t|
        form.text_field sub_label, :class => 'search_field', :data => {:path => path}, :value => value
      end)
      haml_tag(:div, :class => "search_results") do
      end
    end
  end

  def format_text_field text
    #May need to research red carpet markdown
    if text == ""
      return "None"
    end
    simple_format text
  end
end
