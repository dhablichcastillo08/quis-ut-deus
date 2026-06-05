module ApplicationHelper
  def liturgical_bar_class(color)
    case color&.downcase
    when "green"  then "bg-green-500"
    when "purple" then "bg-purple-600"
    when "white"  then "bg-amber-100"
    when "red"    then "bg-red-600"
    when "rose"   then "bg-pink-400"
    else "bg-slate-600"
    end
  end

  def liturgical_dot_class(color)
    case color&.downcase
    when "green"  then "bg-green-500"
    when "purple" then "bg-purple-500"
    when "white"  then "bg-amber-100"
    when "red"    then "bg-red-500"
    when "rose"   then "bg-pink-400"
    else "bg-slate-500"
    end
  end

  def liturgical_badge_class(color)
    case color&.downcase
    when "green"  then "bg-green-900 text-green-300"
    when "purple" then "bg-purple-900 text-purple-300"
    when "white"  then "bg-amber-900 text-amber-300"
    when "red"    then "bg-red-900 text-red-300"
    when "rose"   then "bg-pink-900 text-pink-300"
    else "bg-slate-700 text-slate-300"
    end
  end
end
