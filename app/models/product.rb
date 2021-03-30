class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :option_types, dependent: :destroy
  has_many :option_values, through: :option_types

  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug

  accepts_nested_attributes_for :option_types

  def slug=(value)
    write_attribute(:slug, I18n.transliterate(value).gsub(/[^0-9A-z]/, '-'))
  end
end
