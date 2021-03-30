module Admin
  class UsersController < Admin::ApplicationController
    load_and_authorize_resource

    def index
      @users = @users.page(page).per(per_page)
      respond_to do |format|
        format.html { render :index }
        format.json { render json: {users: @users.as_json} }
      end
    end

    def edit
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { user: @user.as_json } }
      end
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, flash: default_flash_success_message(:update) }
          format.json { render json: { user: @user.as_json } }
        else
          format.html { render :edit, flash: default_flash_error_message(:update) }
          format.json { render json: { user: @user.as_json, errors: @user.errors.messages.as_json } }
        end
      end
    end

    private

    def user_params
      p = params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
      p = p.except(:password, :password_confirmation) if p[:password].blank?
      return p
    end
  end
end
