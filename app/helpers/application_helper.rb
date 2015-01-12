module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "nNote nInformation hideit"
    when :success then "nNote nSuccess hideit"
    when :error then "nNote nFailure hideit"
    when :alert then "nNote nWarning hideit"
    end
  end

  def user_flash_class(level)
    case level
    when :notice then "notice"
    when :success then "success"
    when :error then "error"
    when :alert then "info"
    end
  end

  def messages!
    return "" if @notification_message.blank?

    html = <<-HTML
      <div class="#{flash_class(@key)}">
        <p><strong>#{@notification_message}</strong></p>
      </div>
    HTML

    html.html_safe
  end

  def notification_messages!
    [:notice, :success, :alert, :error].each do |key|
      if flash[key]
        @key = key
        @notification_message = flash[key]
      end
    end

    user_messages!
  end

  def user_messages!
    return "" if @notification_message.blank?

    html = <<-HTML
      <div id = "div4" class="#{user_flash_class(@key)}">
        <div class="message-box-wrap">
          <strong>#{@notification_message}</strong>
        </div>
      </div>
    HTML

    html.html_safe
  end
end
