class ActivitiesController < ApplicationController
  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    @lover=Lover.find(@activity.lover_id)

    if @activity.save
      flash[:success] = '活動を登録しました。'
      redirect_to @lover
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
    @activity = Activity.find(params[:id])
    @activity.destroy
    @lover = Lover.find(@activity.lover_id)
    
    flash[:success] = '活動は正常に削除されました'
    redirect_to @lover
  end

  def edit
    @activity = Activity.find(params[:id])
    @lover=Lover.find(@activity.lover_id)
  end

  def update
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    @lover=Lover.find(@activity.lover_id)
    
    if @activity.save
      flash[:success] = '活動を登録しました。'
      redirect_to @lover
    else
      flash.now[:danger] = '活動の登録に失敗しました。'
      redirect_back(fallback_location: root_path) 
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @lover = Lover.find(@activity.lover_id)
  end
  
  private
  
  def activity_params
    puts params
    params.require(:activity).permit(:content, :activity_date, :lover_id)
  end
end
