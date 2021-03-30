class Variant < ApplicationRecord
  attr_accessor :price

  belongs_to :product
  has_many :option_value_variants, dependent: :destroy
  has_many :option_values, through: :option_value_variants

  validates_presence_of :name, :description, :currency, :cents
  validates_numericality_of :cents, greater_than_or_equal_to: 0

  accepts_nested_attributes_for :option_value_variants

  def price
    money = Money.new(cents, currency)
    "#{money.symbol}#{money.to_s}"
  end

  def price=(value)
    money = Monetize.parse(value)
    write_attribute(:currency, money.currency.iso_code)
    write_attribute(:cents, money.cents)
  end
end
