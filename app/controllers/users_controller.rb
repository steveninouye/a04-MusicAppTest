class UsersController < ApplicationController
  def show
    render :show
  end

  def new
    return redirect_to bands_url if current_user
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = ['Successfully created your account']
      session[:session_token] = @user.session_token
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
