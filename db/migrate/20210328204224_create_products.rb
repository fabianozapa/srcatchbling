class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
