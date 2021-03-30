class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.references :product, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.string :currency, limit: 3, null: false
      t.integer :cents, null: false
      t.timestamps
    end
  end
end
