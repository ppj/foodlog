class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]
  before_action :require_user

  def create
    commentable_type = params[:comment][:class_name]
    commentable_class = commentable_type.constantize
    commentable = commentable_class.find_by slug: params[commentable_type.downcase+'_id']
    @comment = commentable.comments.new(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:success] = "New comment added"
      redirect_to :back
    else
      controller = commentable_type.downcase.pluralize
      render(controller+'/show')
    end
  end

  def vote
    @vote    = Vote.create(vote: params[:vote], creator: current_user, voteable: @comment)
    respond_to do |format|
      format.html {
        if @vote.valid?
          flash[:notice] = 'Your vote was cast.'
        else
          flash[:error]  = 'You can vote only once on this comment.'
        end
        redirect_to :back
      }
      format.js {
        template = 'vote_'+@comment.commentable_type.downcase
        render template
      }
    end
  end

  def vote_destroy
    @vote = Vote.find_by(creator: current_user, voteable: @comment)
    @vote.destroy if @vote

    respond_to do |format|
      format.html {
        flash[:notice] = 'Your vote on that comment was cancelled'
        redirect_to :back
      }
      format.js {
        template = 'vote_'+@comment.commentable_type.downcase
        render template
      }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
