class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit]

  def index
    @prototype = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end;

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
  @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
    redirect_to root_path
    # if @prototype == prototype_user_id
    #  redirect_to prototype_path
    # else
    #   render :edit
    # 確認用
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user: current_user)
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end


end
