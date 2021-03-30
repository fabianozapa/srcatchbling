require 'rails_helper'

RSpec.describe OptionValueVariant, type: :model do
  fixtures :products, :option_types, :option_values, :variants, :option_value_variants

  context 'relationships' do
    it { is_expected.to belong_to :variant }
    it { is_expected.to belong_to :option_value }
  end

  context 'validations' do
    it { should validate_presence_of(:option_value) }
    it { should validate_presence_of(:variant) }
  end
end
