class FoodsController < ApplicationController

  before_action :set_food, except: [:index, :new, :create]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only:   [:edit, :update, :destroy]

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.creator = current_user

    if @food.save
      flash[:success] = 'New food item added'
      redirect_to foods_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      flash[:success] = 'Food updated'
      redirect_to foods_path
    else
      render :edit
    end
  end

  def index
    @foods = Food.all
  end

  def show
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json {render json: @food}
      format.xml  {render xml:  @food}
    end
  end

  def destroy
    if @food.destroy
      flash[:info] = "Food was deleted"
      redirect_to foods_path
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @food)

    respond_to do |format|
      format.html {
        if @vote.valid?
          flash[:success] = 'Your vote was cast.'
        else
          flash[:danger]  = 'You can vote only once on this food.'
        end
        redirect_to :back
      }
      format.js # by default renders the vote.js.erb template in the views/foods folder
    end

  end

  def vote_destroy
    @vote = Vote.find_by(creator: current_user, voteable: @food)
    @vote.destroy if @vote

    respond_to do |format|
      format.html {
        flash[:success] = 'Your vote on that food was cancelled'
        redirect_to :back
      }
      format.js { render 'vote' }
    end

  end

  private

  def food_params
    params.require(:food).permit(:name, :energy, :fat, :protein, :notes)
  end

  def set_food
    @food = Food.find_by slug: params[:id]
  end

  def require_creator_or_admin
    access_denied "You cannot make changes to this food!" unless logged_in? and (current_user == @food.creator or current_user.admin?)
  end

end
