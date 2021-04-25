class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_column :users, :uuid, :uuid, default: 'uuid_generate_v4()'
    add_index :users, :uuid
  end
end
