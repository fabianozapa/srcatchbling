class OptionValueVariant < ApplicationRecord
  belongs_to :variant
  belongs_to :option_value

  validates_presence_of :option_value
  validates_presence_of :variant
  validates_uniqueness_of :option_value_id, scope: :variant_id
end
