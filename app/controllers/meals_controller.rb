class MealsController < ApplicationController

  before_action :set_meal,     except: [:index, :new, :create]
  before_action :set_time,     only: [:create, :udpate]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only:   [:edit, :update, :destroy]

  def index
    @meals = Meal.all.sort_by{|x| x.time}.reverse
    respond_to do |format|
      format.html
      format.json {render json: @meals}
      format.xml  {render xml:  @meals}
    end

  end

  def show
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json {render json: @meal}
      format.xml  {render xml:  @meal}
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.creator = current_user
    fill_plates!

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
    fill_plates!
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
      redirect_to meals_path
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @meal)

    respond_to do |format|
      format.html {
        if @vote.valid?
          flash[:success] = 'Your vote was cast.'
        else
          flash[:danger]  = 'You can vote only once on this meal.'
        end
        redirect_to :back
      }
      format.js # by default renders the vote.js.erb template in the views/meals folder
    end

  end

  def vote_destroy
    @vote = Vote.find_by(creator: current_user, voteable: @meal)
    @vote.destroy if @vote

    respond_to do |format|
      format.html {
        flash[:success] = 'Your vote on that meal was cancelled'
        redirect_to :back
      }
      format.js { render 'vote' }
    end

  end

  private

  def meal_params
    params.require(:meal).permit(:name, :category, :time, :description)
  end

  def set_meal
    @meal = Meal.find_by(slug: params[:id])
  end

  def set_time
    meal_params[:time] = DateTime.strptime(meal_params[:time], '%b %d, %Y (%H:%M %p)')
  end

  def require_creator_or_admin
    access_denied "You cannot make changes to this meal!" unless logged_in? and (current_user == @meal.creator or current_user.admin?)
  end

  def fill_plates!
    plate_index = 0
    params[:food_ids].each do |food_id|
      plate = @meal.plates[plate_index] || Plate.new
      plate.food_id = food_id
      plate.servings = params[:food_servings][plate_index]
      if plate.new_record?
        @meal.plates << plate
      else
        plate.save
      end
      plate_index += 1
    end
    (plate_index..(@meal.plates.size-1)).each do |extra_plate_index|
      plate = @meal.plates[extra_plate_index]
      @meal.plates.destroy(plate)
    end
  end

end
