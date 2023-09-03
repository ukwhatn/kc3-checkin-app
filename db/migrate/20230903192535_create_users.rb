class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.references :univ, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :grade, null: false
      t.string :qr_token, null: false
      t.timestamps
    end
  end
end
