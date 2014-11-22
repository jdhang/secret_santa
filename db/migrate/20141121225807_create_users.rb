class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :last_name, :username, :password_digest, :role
      t.boolean :matched, default: false
      t.integer :matched_id
      t.timestamps
    end
  end
end
