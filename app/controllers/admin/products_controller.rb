module Admin
  class ProductsController < Admin::ApplicationController
    load_and_authorize_resource

    def index
      @q = Product.accessible_by(current_ability, :index).ransack(params[:q])
      @products = @q.result(distinct: true).page(page).per(per_page)

      respond_to do |format|
        format.html { render :index }
      end
    end

    private

    def product_params
      params.require(:product).permit(
        :product_id,
        :name,
        :description,
        :currency,
        :cents,
        option_types_attributes: [
          :name,
          option_values_attributes: [
            :name
          ]
        ]
      )
    end
  end
end
