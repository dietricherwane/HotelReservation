module RoomTypeAdditionalBedsHelper

  def room_type_additional_bed_messages!
    [:error, :alert, :success, :notice].each do |key|
      if flash[key]
        @key = key
        @notification_message = flash[key]
      end
    end

    return "" if @notification_message.blank?

    messages!
  end

end
