class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :name, null: false
      t.string :introduction_url, null: false
      t.references :timetable, null: false, foreign_key: true
      t.timestamps
    end
  end
end
