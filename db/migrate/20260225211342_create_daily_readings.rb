class CreateDailyReadings < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_readings do |t|
      t.date :date
      t.string :title
      t.text :first_reading
      t.text :psalm
      t.text :second_reading
      t.text :gospel
      t.string :saint_of_the_day
      t.string :feast_day
      t.string :liturgical_color
      t.string :season

      t.timestamps
    end
  end
end
