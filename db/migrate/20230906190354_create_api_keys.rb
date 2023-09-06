class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :key_string, null: false
      t.timestamps
    end
  end
end
