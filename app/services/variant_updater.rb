class VariantUpdater
  attr_reader :product, :variant, :variant_json, :errors

  def self.call(*args)
    obj = new(*args)
    obj.call
    obj
  end

  def initialize(product, variant, variant_json)
    @product = product
    @variant = variant
    @variant_json = variant_json.with_indifferent_access
  end

  def call
    return unless product.persisted? && variant.persisted?
    return unless variant_json.present?

    ActiveRecord::Base.connection.transaction do
      update_variant
      destroy_option_value_variants
      create_option_value_variants
    end

    @variant.reload

    return false if errors.present?

    variant
  end

  private

  def update_variant
    variant_params = {
      name: @variant_json.delete(:name),
      description: @variant_json.delete(:description),
      price: @variant_json.delete(:price)
    }.compact

    unless @variant.update(variant_params)
      @errors = @variant.errors
      ActiveRecord::Rollback
    end
  end

  def destroy_option_value_variants
    variant.option_value_variants.each do |option_value_variant|
      unless option_value_variant.destroy
        add_errors(:option_value_variant, "#{type_name} can not be destroyed")
      end
    end
    raise ActiveRecord::Rollback if errors.present?
  end

  def create_option_value_variants
    variant_json.each do |type_name, values_names|
      next unless values_names.is_a?(Array)

      option_type = product.option_types.find_by(name: type_name.singularize)
      if option_type.blank?
        add_errors(:option_type, "#{type_name} not found")
        next
      end

      values_names.each do |value_name|
        option_value = option_type.option_values.find_by(name: value_name)
        if option_value.blank?
          add_errors(:option_value, "#{value_name} not found")
          next
        end

        OptionValueVariant.create(
          variant_id: @variant.id,
          option_value_id: option_value.id
        )
      end
    end

    raise ActiveRecord::Rollback if errors.present?
  end

  def add_errors(key, error)
    @errors = ActiveModel::Errors.new(self) if errors.blank?
    @errors.add(key.to_sym, error)
  end
end
