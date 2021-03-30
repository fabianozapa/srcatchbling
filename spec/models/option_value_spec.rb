require 'rails_helper'

RSpec.describe OptionValue, type: :model do
  fixtures :products, :option_types

  let(:params) { {
    option_type_id: option_types.first.id,
    name: '1'
  } }

  context 'relationships' do
    it { is_expected.to belong_to :option_type }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:option_type_id).case_insensitive }
  end

  context '.create' do
    it 'creates the record' do
      option_value = described_class.create(params)
      expect(option_value.persisted?).to be_truthy
    end
  end
end
