class AddLiturgicalFieldsToDailyReadings < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_readings, :usccb_link, :string
    add_column :daily_readings, :celebration_name, :string
    add_column :daily_readings, :celebration_description, :text
    add_column :daily_readings, :celebration_type, :string
    add_column :daily_readings, :celebration_quote, :text
    add_column :daily_readings, :rank, :string
  end
end
