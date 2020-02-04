class ToppagesController < ApplicationController
  def index
    if logged_in?
      @lover = Lover.find_by(user_id: current_user.id, status: '交際中')
      @activities = current_user.activities.order(activity_date: :desc).page(params[:page])
    end
  end
end
