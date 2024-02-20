# frozen_string_literal: true

class FoodsController < ApplicationController
  before_action :set_food, except: [:index, :create]

  def index
    @foods = Food.all
    authorize @foods
    serialized_response(@foods)
  end

  def show
    serialized_response(@food)
  end

  def create
    @food = Food.new(food_params)
    authorize @food
    raise(ExceptionHandler::UnprocessableEntity, Message.create_failed) unless @food.save

    serialized_response(@food, :created)
  end

  def update
    raise(ExceptionHandler::UnprocessableEntity, Message.update_failed) unless @food.update(food_params)

    serialized_response(@food)
  end

  def destroy
    @food.destroy
    serialized_response(@food)
  end

  private

    def set_food
      @food = Food.find(params[:id])
      authorize @food
    end

    def food_params
      params.require(:food).permit(policy(Food).permitted_attributes)
    end
end
