class CreatePrayerHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :prayer_habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :frequency
      t.boolean :active

      t.timestamps
    end
  end
end
