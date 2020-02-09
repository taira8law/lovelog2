class ToppagesController < ApplicationController
  def index
    if logged_in?
      @lover = Lover.find_by(user_id: current_user.id, status: '交際中')
      @activity = Activity.new
      @activities = current_user.activities.order(activity_date: :desc).page(params[:page])
      @lovers = Lover.where(user_id: current_user.id)
    end
  end
end
