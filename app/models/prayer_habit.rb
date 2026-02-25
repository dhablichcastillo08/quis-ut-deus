class PrayerHabit < ApplicationRecord
  belongs_to :user
  has_many :prayer_logs, dependent: :destroy

  validates :name, presence: true
  validates :frequency, inclusion: { in: %w[daily weekly] }

  def completed_today?
    prayer_logs.where("completed_at >= ?", Date.current.beginning_of_day).exists?
  end

  def current_streak
    streak = 0
    date = Date.current

    loop do
      break unless prayer_logs.where(completed_at: date.all_day).exists?
      streak += 1
      date -= 1.day
    end

    streak
  end
end