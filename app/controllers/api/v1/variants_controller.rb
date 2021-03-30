module Api
  module V1
    class VariantsController < Api::V1::ApplicationController
      before_action :load_product

      def show
        render json: @product.as_json
      end

      def index
        @q = Variant.where(product_id: @product.id).accessible_by(current_ability, :index).ransack(params[:q])
        @variants = @q.result(distinct: true).page(page).per(per_page)

        render json: @variants.map { |v| Api::V1::VariantPresenter.as_json(v) }
      end

      def create
        variant_creator = VariantCreator.call(@product, product_params.to_h)
        if variant_creator.errors.blank?
          render json: Api::V1::VariantPresenter.as_json(variant_creator.record)
        else
          render status: 400, json: variant_creator.errors.messages.as_json
        end
      end

      def update
        variant = @product.variants.find(params[:id])
        variant_updater = VariantUpdater.call(@product, variant, product_params.to_h)
        if variant_updater.errors.blank?
          render json: Api::V1::VariantPresenter.as_json(variant_updater.variant)
        else
          render status: 400, json: variant_updater.errors.messages.as_json
        end
      end

      def destroy
        variant = @product.variants.find(params[:id])
        presenter = Api::V1::VariantPresenter.as_json(variant)
        if variant.destroy
          render status: 200, json: presenter
        else
          render status: 400, json: variant.errors.messages.as_json
        end
      end

    private

      def load_product
        @product = Product.find_by!(slug: params[:product_slug])
      end

      def product_params
        params.permit(:name, :description, :price, sizes: [])
      end
    end
  end
end
