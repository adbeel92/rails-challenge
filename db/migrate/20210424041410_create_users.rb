class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
    add_column :users, :uuid, :uuid, default: 'uuid_generate_v4()', null: false
    add_index :users, :uuid
  end
end
