class OptionValue < ApplicationRecord
  belongs_to :option_type

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :option_type_id, case_sensitive: false
end
