#encoding:UTF-8
class MessagesController < ApplicationController
  before_filter :load_messages, :authenticate_user!
  
  def index
    @title = "쪽지"
    @message = Message.new
  end
  
  def show
    @message = Message.find(params[:id])
    @title ="쪽지 | #{@message.title}"
    @replies = @message.replies
    @message_participation = @message.message_participations.find_by_user_id(current_user.id)
    @message_participation.read = true
    @message_participation.save    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  # def new
  #     @message = Message.new
  #   end
  
  def create
    @message = Message.new(params[:message])
    if !@message.participant_ids.empty? and @message.save
      @reply = current_user.replies.create!(:message_id => @message.id, :content => @message.content)
      current_user.message_participations.create!(:message_id => @message.id)
      @message.participant_ids.each do |id|
        User.find(id).message_participations.create!(:message_id => @message.id)
      end
      Notification.notify(@message.participant_ids, "message_send", @reply, "Message", current_user.id)
      redirect_to @message
    else
      flash.now[:error] = "받는 사람이 잘못 입력되었습니다. 이름을 확인해주세요."
      render :index
      # redirect_to (root_path)
    end      
  end
  
  def load_messages
    if user_signed_in?
      @messages = current_user.messages
    else
      redirect_to (root_path)
    end
    
  end
end
