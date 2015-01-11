class Api::UsersController < Api::BaseController
  def show
    @user = User.find(params[:screen_name])
    render json: @user
  end
end