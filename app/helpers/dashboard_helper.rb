module DashboardHelper
  def time_greeting
    hour = Time.current.hour
    case hour
    when 0..11 then "morning"
    when 12..16 then "afternoon"
    else "evening"
    end
  end
end