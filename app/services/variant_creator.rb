class VariantCreator
  attr_reader :product, :variant_json, :record, :errors

  def self.call(*args)
    obj = new(*args)
    obj.call
    obj
  end

  def initialize(product, variant_json)
    @product = product
    @variant_json = variant_json.with_indifferent_access
  end

  def call
    return unless product.persisted?
    return unless variant_json.present?

    variant = build_variant
    variant = build_option_values_variants(variant)

    return false if errors.present?

    @record = Variant.create(variant)

    if record.errors.present?
      @errors = record.errors
      return false
    end

    @record.reload
  end

private

  def build_variant
    {
      product_id: product.id,
      name: @variant_json.delete(:name),
      description: @variant_json.delete(:description),
      price: @variant_json.delete(:price)
    }
  end

  def build_option_values_variants(variant)
    variant[:option_value_variants_attributes] = []

    variant_json.each do |_, values_names|
      next unless values_names.is_a?(Array)
      values_names.each do |value_name|
        option_value = product.option_values.find_by(name: value_name)
        if option_value.blank?
          add_errors(:option_value, "#{value_name} not found")
        else
          variant[:option_value_variants_attributes] << {
            option_value_id: option_value.id,
            quantity: 1
          }
        end
      end
    end

    variant
  end

  def add_errors(key, error)
    @errors = ActiveModel::Errors.new(self) if errors.blank?
    @errors.add(key.to_sym, error)
  end
end
