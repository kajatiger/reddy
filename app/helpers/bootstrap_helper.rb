module BootstrapHelper

  def bootstrap_errors_for(object)
    if object.errors.any?
      errors = object.errors.full_messages.inject("") do |result, msg|
        result += content_tag(:li, msg)
        result
      end
      content_tag :div, id: "error_explanation", class: "alert alert-block alert-danger" do
        content_tag(:h3, "#{pluralize(object.errors.count, "Fehler", "Fehler")} aufgetreten.") + content_tag(:ul, raw(errors))
      end
    end
  end

  # Bootstrap styled flash helper
  def bootstrap_flash_tag
    return if flash.blank?
    css_mapping = {notice: 'success', alert: 'danger', info: 'info'}
    [:notice, :alert, :info].select{|type| flash[type].present?}.inject("") do |result, type|
      inner_html = content_tag(:a, "x", class: "close", :'data-dismiss' => 'alert', href: "#") + flash[type]
      result += content_tag(:div, inner_html, class: "aaa-alert alert alert-#{css_mapping[type.to_sym]} fade in", :'data-alert' => 'alert')
      result.html_safe
    end
  end

  # Displays a Bootstrap label-tag in green or red, depending on what
  # +expression+ evaluates to. The default label content is 'Ja' or
  # 'Nein' respectively and can be over
  #
  # === Parameters
  # * +expression+: determines green (truey) or red (falsey) label colour
  # * +value+: Alternative conditional output. Expected to be an Array like ['truevalue', 'falsevalue']
  def boolean_label(expression, value = nil)
    value = Array(value).compact
    value = %w(Ja Nein) if value.empty?
    value = expression ? value.first : value.last
    content_tag :span, value, :class => "label label-#{expression ? 'success' : 'danger'}"
  end

  # iconized links helper
  # pass an icon into your typical link call like this: icon_link_to("Linktext", url, :class => "btn btn-default", :icon => :comment)
  def icon_link_to(name, options={}, html_options={})
    if html_options[:icon].present?
      link_to(options, html_options) do
        bootstrap_icon_tag(html_options[:icon], html_options[:color]) + " " + name
      end
    else
      link_to(name, options, html_options)
    end
  end

  def bootstrap_icon_tag(icon = nil, color = 'black')
    content_tag(:i, nil, class: "glyphicon glyphicon-#{icon.to_s} glyphicon-#{color}").html_safe
  end

  def link_to_delete(link, options = {})
    defaults = { method: :delete, data: { confirm: "Wirklich löschen?" }, title: "Löschen", icon: 'trash' }
    icon_link_to(nil, link, defaults.merge(options))
  end

  def link_to_edit(link, options = {})
    defaults = { title: "Bearbeiten", icon: 'pencil' }
    icon_link_to(nil, link, defaults.merge(options))
  end

  def link_to_show(link, options = {})
    defaults = { title: "Anzeigen", icon: 'eye-open' }
    icon_link_to(nil, link, defaults.merge(options))
  end

end
