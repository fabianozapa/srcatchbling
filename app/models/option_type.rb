class OptionType < ApplicationRecord
  belongs_to :product
  has_many :option_values, dependent: :destroy

  validates_presence_of :name, :option_values
  validates_uniqueness_of :name, scope: :product_id, case_sensitive: false

  accepts_nested_attributes_for :option_values
end
