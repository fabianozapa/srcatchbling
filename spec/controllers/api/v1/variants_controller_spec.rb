require 'rails_helper'

RSpec.describe Api::V1::VariantsController, type: :controller do
  fixtures :users, :products, :option_types, :option_values, :variants, :option_value_variants

  before do
    allow_any_instance_of(Api::V1::ApplicationController).to receive(:token).and_return(User.find_by_role(:admin).api_token)
  end

  describe '#index' do
    it 'lists variant with option_value_variants' do
      get :index, params: { product_slug: :backscratchers }, :format => :json
      expect(JSON.parse(response.body)).to match_array([
        {
          'name' => 'The Itcher',
          'description' => 'Scratch any itch',
          'price' => '$27.00',
          'sizes' => match_array(%w[XL])
        },
        {
          'name' => 'The Blinger',
          'description' => 'Diamonds',
          'price' => '$343.00',
          'sizes' => match_array(%w[L])
        },
        {
          'name' => 'Glitz and Gold',
          'description' => 'Gold handle and fancy emeralds',
          'price' => '$4343.00',
          'sizes' => match_array(%w[S M L XL])
        }
      ])
    end
  end

  describe '#create' do
    let(:params) { {
      name: 'The Itcher Up',
      description: 'Scratch any itch Up',
      price: '$50.0',
      sizes: %w[S M]
    } }

    it 'creates variant and option_value_variants' do
      post :create, params: { product_slug: :backscratchers }.merge(params), :format => :json
      expect(JSON.parse(response.body)).to match(
        'name' => 'The Itcher Up',
        'description' => 'Scratch any itch Up',
        'price' => '$50.00',
        'sizes' => match_array(%w[S M])
      )
    end
  end

  describe '#update' do
    let(:params) { {
      name: 'The Itcher',
      description: 'Scratch any itch Up',
      price: '$30.0',
      sizes: %w[S L]
    } }

    it 'updates variant and option_value_variants' do
      put :update, params: { product_slug: :backscratchers, id: variants.first.id }.merge(params), :format => :json
      expect(JSON.parse(response.body)).to match(
        'name' => 'The Itcher',
        'description' => 'Scratch any itch Up',
        'price' => '$30.00',
        'sizes' => match_array(%w[S L])
      )
    end
  end

  describe '#destroy' do
    it 'lists the back scratchers' do
      variant_id = variants.first.id
      delete :destroy, params: { product_slug: :backscratchers, id: variant_id }, :format => :json
      expect(Variant.find_by(id: variant_id)).to be_nil
    end
  end
end
