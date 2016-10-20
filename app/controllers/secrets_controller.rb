class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
    @secret = Secret.all
  end

  def new
  end

  def create

    @secret = Secret.create(content: params[:New_Secret], user_id: params[:user_id])
    redirect_to "/users/#{ @secret.user_id }"
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end
end
