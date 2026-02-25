class PrayerLog < ApplicationRecord
  belongs_to :user
  belongs_to :prayer_habit

  validates :completed_at, presence: true
end
