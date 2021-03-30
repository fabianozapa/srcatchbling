require 'rails_helper'

RSpec.describe Variant, type: :model do
  fixtures :products

  let(:params) { {
    product_id: products.first.id,
    name: 'size',
    description: 'size',
    price: '$27.00',
    option_value_variants_attributes: [
      { option_value_id: 4 },
      { option_value_id: 3 }
    ]
  } }

  context 'relationships' do
    it { is_expected.to belong_to :product }
    it { is_expected.to have_many :option_value_variants }
    it { is_expected.to have_many :option_values }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:cents) }
  end

  context '.create' do
    it 'creates with nested attributes' do
      option_type = described_class.create(params)
      expect(option_type.persisted?).to be_truthy
      expect(option_type.name).to eq params[:name]
      expect(option_type.option_values.map(&:name)).to match_array %w[L M]
    end
  end
end
