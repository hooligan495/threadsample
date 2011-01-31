module CommentsHelper
  def display_time(time)
    case time
    when time.day == Time.now.day
      time.strftime("%H:%M")
    else
      time.strftime("%b-%d")
    end    
  end
end
