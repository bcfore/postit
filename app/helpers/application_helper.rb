module ApplicationHelper
  def fix_url(str)
    str.start_with?('http://') ? str : "http://#{str}"
  end

  def print_datetime(datetime)
    if datetime.nil?
      return
    else
      datetime.strftime('%m/%d/%Y %l:%M%P %Z').squeeze(' ')
    end
  end
end
