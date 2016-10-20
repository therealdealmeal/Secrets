class UsersController < ApplicationController
  skip_before_filter :require_login, except: [:new, :create]
  skip_before_filter :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end
  def new
    render "/users/new"
  end
  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      # session[:user_id] = @user.id
      redirect_to "/users/#{ @user.id }"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end
  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{ user.id }"
    else
      flash[:error] = "Invalid"
      redirect_to "/sessions/new"
    end
  end
  def show
    @user = User.find(params[:id])
    @secret = Secret.all.where(user_id: @user.id)
  end
  def logout
    redirect_to sessions_new_path
  end
  def edit
    @user = User.find(params[:id])
    session[:user_id] = nil
  end
  def update
    @user = User.find(params[:id]).update(name: params["name"], email: params["email"], password: params["password"], password_confirmation: params["password_confirmation"])
    session[:user_id] = nil
    redirect_to "/users/#{ params[:id] }"
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to "/sessions/new"
  end
end
