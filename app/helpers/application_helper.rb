module ApplicationHelper
  def display_time(time)
    case time
    when time.day == Time.now.day
      time.strftime("%I:%M%p")
    else
      time.strftime("%b-%d %I:%M%p")
    end    
  end
end
