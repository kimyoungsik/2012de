class RepliesController < ApplicationController
  before_filter :authenticate_user!
  def create
    @reply = current_user.replies.build(params[:reply])
    if @reply.save      
      @message_participant_ids = []
      @reply.message.message_participants.each do |message_participant|
        if message_participant != @reply.user
          @message_participant_ids << message_participant.id
        end
      end
      Notification.notify(@message_participant_ids, "reply_notification", @reply.id, "Reply", current_user.id)
      
      @reply.message.message_participations.each do |message_participation|
        if message_participation.user != current_user
          message_participation.read = false
          message_participation.save
        end
      end
    end      
    respond_to do |format|
      format.html { redirect_to message_path(@reply.message) }
      format.js
    end
  end
end