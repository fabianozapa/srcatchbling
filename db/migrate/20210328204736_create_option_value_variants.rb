class CreateOptionValueVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :option_value_variants do |t|
      t.references :option_value, foreign_key: true
      t.references :variant, foreign_key: true
      t.integer :quantity, default: 0, null: false
      t.timestamps
    end
  end
end
