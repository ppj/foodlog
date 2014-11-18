class MealsController < ApplicationController

  before_action :set_meal,     except: [:index, :new, :create]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only:   [:edit, :update, :destroy]

  def index
    @meals = Meal.all.sort_by{|x| x.time}.reverse
    respond_to do |format|
      format.html
      format.json {render json: @posts}
      format.xml  {render xml:  @posts}
    end

  end

  def show
    respond_to do |format|
      format.html
      format.json {render json: @post}
      format.xml  {render xml:  @post}
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.creator = current_user

    if @meal.save
      flash[:success] = "Meal added successfully!"
      redirect_to meals_path
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @meal.update(meal_params)
      flash[:success] = "Meal changed successfully!"
      redirect_to meals_path
    else
      render :new
    end

  end

  def destroy
    if @meal.destroy
      flash[:info] = "Meal was deleted"
      redirect_to root_path
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:title, :category, :description, :time)
  end

  def set_meal
    @meal = Meal.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied "You cannot make changes to this meal!" unless logged_in? and (current_user == @meal.creator or current_user.admin?)
  end

end
