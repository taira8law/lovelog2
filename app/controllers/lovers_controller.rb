class LoversController < ApplicationController
  def index
    @lovers = current_user.lovers.order(id: :desc).page(params[:page])
  end

  def show
    @lover = Lover.find(params[:id])
    @activity = current_user.activities.build
    @activities = @lover.activities.order(activity_date: :desc).page(params[:page])
  end

  def new
    @lover = Lover.new
  end

  def create
    @lover = current_user.lovers.build(lover_params)

    if @lover.status=='交際中' && current_user.lovers.find_by(status: '交際中')
      flash.now[:danger] = '交際中の恋人は一人のみしか登録できません。'
      render :new
    else
      if @lover.save
        flash[:success] = '恋人を登録しました。'
        redirect_to @lover
      else
        flash.now[:danger] = '恋人の登録に失敗しました。'
        render :new
      end
    end
  end

  def update
    @lover = Lover.find(params[:id])
    
    if lover_params[:status]=='交際中' && current_user.lovers.find_by(status: '交際中')
      flash[:danger] = '交際中の恋人は一人のみしか登録できません。'
      redirect_to @lover
    else
      if @lover.update(lover_params)
        flash[:success] = '恋人は正常に更新されました。'
        redirect_to @lover
      else
        flash.now[:danger] = '恋人の更新に失敗しました。'
        render :new
      end
    end
  end

  def edit
    @lover = Lover.find(params[:id])
  end
  
  def destroy
    @lover = Lover.find(params[:id])
    @lover.destroy
    
    flash[:success] = '恋人は正常に削除されました'
    redirect_to lovers_path
  end
  
  private
    
  def lover_params
    params.require(:lover).permit(:name, :status)
  end
end