class ActivitiesController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_activity, only:[:destroy, :edit, :update, :show]
  before_action :correct_user, only: [:edit, :update, :show, :destroy]
  
  def create
#    @activity = Activity.new(activity_params)
#    @activity.user_id = current_user.id
#    @lover=Lover.find(@activity.lover_id)
    @activity = current_user.activities.build(activity_params)

    if @activity.save
      flash[:success] = '活動を登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '活動の登録に失敗しました。'
      redirect_back(fallback_location: root_path) 
    end
  end

  def new
    @activity = Activity.new
  end

  def index
  end

  def destroy
    @activity.destroy
    @lover = Lover.find(@activity.lover_id)
    
    flash[:success] = '活動は正常に削除されました'
    redirect_to @lover
  end

  def edit
    @lover=Lover.find(@activity.lover_id)
  end

  def update
    @lover=Lover.find(@activity.lover_id)
    
    if @activity.update(activity_params)
      flash[:success] = '活動を登録しました。'
      redirect_to @lover
    else
      flash.now[:danger] = '活動の登録に失敗しました。'
      redirect_back(fallback_location: root_path) 
    end
  end

  def show
    @lover = Lover.find(@activity.lover_id)
  end
  
  private

  def set_activity
      @activity = Activity.find(params[:id])
  end
  
  def activity_params
    puts params
    params.require(:activity).permit(:id, :content, :activity_date, :lover_id)
  end
  
  def correct_user
    @activity = current_user.activities.find_by(id: params[:id])
    unless @activity
      redirect_to root_url
    end
  end
end
