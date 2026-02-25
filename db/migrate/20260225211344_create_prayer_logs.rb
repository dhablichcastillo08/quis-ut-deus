class CreatePrayerLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :prayer_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prayer_habit, null: false, foreign_key: true
      t.datetime :completed_at
      t.text :notes

      t.timestamps
    end
  end
end
