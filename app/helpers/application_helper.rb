module ApplicationHelper

  def full_url(str)
    if (str.starts_with?('http://') || str.starts_with?('https://')) && str.include?(".com")
      str
    elsif !str.include?(".com")
      "http://#{str}.com"
    else
      "http://#{str}"
    end
  end
end
