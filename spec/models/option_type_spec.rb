require 'rails_helper'

RSpec.describe OptionType, type: :model do
  fixtures :products

  let(:params) { {
    product_id: products.first.id,
    name: 'option_type',
    option_values_attributes: [
      { name: '1' },
      { name: '2' }
    ]
  } }

  context 'relationships' do
    it { is_expected.to belong_to :product }
    it { is_expected.to have_many :option_values }
  end

  context 'validations' do
    it { should validate_presence_of(:option_values) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:product_id).case_insensitive }
  end

  context '.create' do
    it 'requires nested attributes' do
      option_type = described_class.create(params.without(:option_values_attributes))
      expect(option_type.persisted?).to be_falsey
    end

    it 'creates with nested attributes' do
      option_type = described_class.create(params)
      expect(option_type.persisted?).to be_truthy
      expect(option_type.name).to eq 'option_type'
      expect(option_type.option_values.map(&:name)).to match_array %w[1 2]
    end
  end
end
