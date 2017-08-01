module ApplicationHelper
  def fix_url(str)
    str.start_with?('http://') ? str : "http://#{str}"
  end

  def print_datetime(datetime)
    return if datetime.nil?

    if logged_in? && !current_user.time_zone.blank?
      datetime = datetime.in_time_zone(current_user.time_zone)
    end

    datetime.strftime('%m/%d/%Y %l:%M%P %Z').squeeze(' ')
  end

  def voteable_id_str(voteable)
    # voteable_id = voteable.respond_to?(:slug, true) ? voteable.slug : voteable.id
    # "#{voteable.class.to_s.downcase}_#{voteable_id}_votes"
    "#{voteable.class.to_s.downcase}_#{voteable.to_param}_votes"
  end
end
