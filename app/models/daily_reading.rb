class DailyReading < ApplicationRecord
  has_many :journal_entries

  validates :date, presence: true, uniqueness: true

  scope :for_date, ->(date) { find_by(date: date) }
  scope :today, -> { for_date(Date.current) }

  def liturgical_css_class
    case liturgical_color&.downcase
    when "green"  then "bg-green-500"
    when "purple" then "bg-purple-600"
    when "white"  then "bg-amber-100"
    when "red"    then "bg-red-600"
    when "rose"   then "bg-pink-400"
    else "bg-slate-400"
    end
  end
end