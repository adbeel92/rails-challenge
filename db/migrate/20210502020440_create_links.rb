class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :original_url, null: false
      t.string :short_url

      t.timestamps
    end
  end
end
