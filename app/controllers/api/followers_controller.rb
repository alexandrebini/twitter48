class Api::FollowersController < Api::BaseController
  def in_common
    @followers = Followers.in_common(params[:screen_names])
    render json: @followers
  end
end