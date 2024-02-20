# frozen_string_literal: true

class UsersController < ApplicationController
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
    @user = User.new(user_params)
    authorize @user
    raise(ExceptionHandler::UnprocessableEntity, Message.create_failed) unless @user.save

    serialized_response(@user)
  end

  def update
    return json_response({ message: Message.update_failed, status: :unprocessable_entity }) if user_params.blank?

    raise(ExceptionHandler::UnprocessableEntity, Message.update_failed) unless @user.update(user_params)

    serialized_response(@user) if @user.update(user_params)
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
