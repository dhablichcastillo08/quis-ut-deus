class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :daily_reading

  validates :date, presence: true
  validates :content, presence: true
  validates :mood, inclusion: {
    in: %w[peaceful grateful joyful reflective struggling],
    allow_blank: true
  }
end
