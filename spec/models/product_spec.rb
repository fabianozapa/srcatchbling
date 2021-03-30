require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:params) { {
    name: 'Product',
    slug: 'product',
    option_types_attributes: [
      {
        name: 'option_type',
        option_values_attributes: [
          { name: '1' },
          { name: '2' },
          { name: '3' }
        ]
      }
    ]
  } }

  context 'relationships' do
    it { is_expected.to have_many :option_types }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context '.create' do
    it 'accepts nested attributes' do
      product = described_class.create(params)
      expect(product.persisted?).to be_truthy

      expect(product.name).to eq 'Product'
      expect(product.slug).to eq 'product'

      expect(product.option_types.map(&:name)).to eq %w[option_type]
      expect(product.option_values.map(&:name)).to eq %w[3 2 1]
    end
  end
end
