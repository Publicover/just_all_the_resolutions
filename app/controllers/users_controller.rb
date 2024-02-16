# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, except: [:index, :create]

  def index
    @users = User.all
    authorize @users
    serialized_response(@users)
  end

  def show
    serialized_response(@user)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    @user.update(user_params)
    serialized_response(@user)
  end

  def destroy
    @user.destroy
    UserSerializer.new(@user).serializable_hash.to_json
    serialized_response(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    def user_params
      params.require(:user).permit(policy(User).permitted_attributes)
    end
end
