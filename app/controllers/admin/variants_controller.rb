module Admin
  class VariantsController < Admin::ApplicationController
    load_and_authorize_resource

    def index
      @q = Variant.accessible_by(current_ability, :index).ransack(params[:q])
      @variants = @q.result(distinct: true).page(page).per(per_page)

      respond_to do |format|
        format.html { render :index }
      end
    end

    private

    def variant_params
      params.require(:variant).permit(
        :product_id,
        :name,
        :description,
        :currency,
        :cents,
        option_value_variants_ids: []
      )
    end
  end
end
