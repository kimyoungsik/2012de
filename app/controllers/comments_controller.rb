class CommentsController < ApplicationController
before_filter :authenticate_user!
before_filter :authorized_user, :only => :destroy

  def create
    @comment = current_user.comments.build(params[:comment])
    # render :text => @comment.to_yaml
    if @comment.save
      @kit = @comment.kit
      @kit.updated_at = Time.now
      @kit.save    

      if @kit.kitable_type == "Seed" 
        @seed = @kit.kitable
        @seed.updated_at = Time.now
        @seed.save
      end

      commenters = []
      commenters << @comment.kit.user # notification to kit.user
      @kit.comments.each do |othercomment|
          commenters << othercomment.user
      end

      commenters.uniq.each do |commenter|
        if commenter != current_user
          Notification.notify(commenter.id, "", @comment.id, "Comment", current_user.id)
        end
      end
    end    
    respond_to do |format|
      format.js
    end
  end
  
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back_or kits_path }
      format.js
    end    
  end
  
  private
  
   def authorized_user
     @comment = Comment.find(params[:id])
     redirect_to kits_path unless current_user == @comment.user
   end
   
   def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
   end

   def clear_return_to
       session[:return_to] = nil
   end
  
end
