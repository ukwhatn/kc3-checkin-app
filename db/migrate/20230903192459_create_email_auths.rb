class CreateEmailAuths < ActiveRecord::Migration[7.0]
  def change
    create_table :email_auths do |t|
      t.string :token, null: false
      t.string :email, null: false
      t.boolean :is_expired, null: false, default: false
      t.timestamps
    end
  end
end
