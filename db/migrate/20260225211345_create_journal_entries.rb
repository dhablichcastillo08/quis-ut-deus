class CreateJournalEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :journal_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_reading, null: false, foreign_key: true
      t.date :date
      t.text :content
      t.string :mood

      t.timestamps
    end
  end
end
