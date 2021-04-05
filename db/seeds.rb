user = User.new(
  role: 'admin',
  name: 'Admin',
  email: 'admin1@admin.com',
  password: 'sekhmet123456',
  password_confirmation: 'sekhmet123456'
)
user.save!

product = Product.new(
  name: 'Back Scratchers',
  slug: 'backscratchers',
  option_types_attributes: [
    {
      product_id: 1,
      name: 'size',
      option_values_attributes: [
        {
          option_type_id: 1,
          name: 'XS'
        },
        {
          option_type_id: 1,
          name: 'S'
        },
        {
          option_type_id: 1,
          name: 'M'
        },
        {
          option_type_id: 1,
          name: 'L'
        },
        {
          option_type_id: 1,
          name: 'XL'
        }
      ]
    }
  ]
)
product.save!

variant = Variant.new(
  product_id: Product.last.id,
  name: 'The Itcher',
  description: 'Scratch any itch',
  currency: 'USD',
  cents: 2700,
  option_value_variants_attributes: [
    {
      option_value_id: 5,
      quantity: 1
    }
  ]
)
variant.save!

variant = Variant.new(
  product_id: Product.last.id,
  name: 'The Blinger',
  description: 'Diamonds',
  currency: 'USD',
  cents: 34300,
  option_value_variants_attributes: [
    {
      option_value_id: 4,
      quantity: 1
    }
  ]
)
variant.save!

variant = Variant.new(
  product_id: Product.last.id,
  name: 'Glitz and Gold',
  description: 'Gold handle and fancy emeralds',
  currency: 'USD',
  cents: 434300,
  option_value_variants_attributes: [
    {
      option_value_id: 5,
      quantity: 1
    },
    {
      option_value_id: 4,
      quantity: 1
    },
    {
      option_value_id: 3,
      quantity: 1
    },
    {
      option_value_id: 2,
      quantity: 1
    }
  ]
)
variant.save!
