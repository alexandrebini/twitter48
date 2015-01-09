class Api::TimelinesController < Api::BaseController
  def show
    @timeline = Timeline.find(params[:screen_name])
    render json: @timeline
  end
end