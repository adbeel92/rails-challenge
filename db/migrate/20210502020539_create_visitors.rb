class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.references :link, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.string :os
      t.integer :counter, null: false, default: 0

      t.timestamps
    end
  end
end
