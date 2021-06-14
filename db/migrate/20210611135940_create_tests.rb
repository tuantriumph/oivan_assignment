class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :name, null: false
      t.text :desc, null: false

      t.timestamps
    end
  end
end
