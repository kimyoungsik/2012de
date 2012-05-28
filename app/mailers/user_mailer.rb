#encoding:UTF-8
class UserMailer < ActionMailer::Base
  default :from => "\"DreamKit\" <dreamkit@dreamkit.net>"

  def send_email(to_user, subject, body, footer, url)
    @m_subject = subject
    @m_body = body
    @footer = footer
    @url = url
    mail(:to => to_user.email, :subject => @m_subject)  do |format|
       format.html
    end
  end 
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "#{@user.name}님, 드림킷에 오신 것을 진심으로 환영합니다.")
  end
  
  def kit_notification(kit)
    @page_owner = User.find(kit.kitable_id)
    @kit = kit
    @kit_author = kit.user
    if @page_owner.notification_setting.kit_notify?
      mail(:to => @page_owner.email, :subject => "#{@kit_author.name}님이 #{@page_owner.name}님의 뜰에 Kit을 남기셨습니다.")
    end
  end
  
  def seed_kit_notification(kit)
    @seed = Seed.find(kit.kitable_id)
    @kit = kit
    if @seed.user != @kit.user and @seed.user.notification_setting.seed_kit_notify?
      mail(:to => @seed.user.email, :subject => "#{@kit.user.name}님이 '#{@seed.title}' 시드에 Kit을 남기셨습니다.")
    end
  end

  def moim_kit_notification(kit)
    @moim = Moim.find(kit.kitable_id)
    @kit = kit
    if @moim.user != @kit.user and @moim.user.notification_setting.moim_kit_notify?
      mail(:to => @moim.user.email, :subject => "#{@kit.user.name}님이 '#{@moim.title}' 모임에 Kit을 남기셨습니다.")
    end
    @moim.attendees.each do |attendee|
      if attendee != @kit.user and attendee.notification_setting.moim_kit_notify?
        mail(:to => attendee.email, :subject => "#{@kit.user.name}님이 '#{@moim.title}' 모임에 Kit을 남기셨습니다.")
      end
    end      
  end

  def comment_notification(comment)
    @comment = comment
    @kit = comment.kit
    if @kit.user.notification_setting.comment_notify?
      mail(:to => @kit.user.email, :subject => "#{@comment.user.name}님이 #{@kit.user.name}님의 Kit에 댓글을 남기셨습니다.")
    end
  end
  
  def other_comment_notification(comment, recipient)
     @comment = comment
     if recipient.notification_setting.other_comment_notify?
       mail(:to => recipient.email, :subject => "#{@comment.user.name}님이 댓글을 남기셨습니다.")
     end
  end

  def reply_notification(reply, message_participant)
    @reply = reply
    mail(:to => message_participant.email, :subject => "#{@reply.user.name}님이 쪽지를 보내셨습니다.")
  end

  def friendship_notification(friendship)
    @friendship = friendship
    @user = User.find(@friendship.user_id)
    @friend = User.find(@friendship.friend_id)
    if @friend.notification_setting.friendship_notify?
      mail(:to => @friend.email, :subject => "#{@user.name}님이 #{@friend.name}님을 친구로 초대하였습니다.")
    end
  end
  
  def friendship_acceptance_notification(friendship)
    @friendship = friendship
    @user = User.find(@friendship.user_id)
    @friend = User.find(@friendship.friend_id)
    if @friend.notification_setting.friendship_acceptance_notify?
      mail(:to => @friend.email, :subject => "#{@user.name}님이 #{@friend.name}님의 친구신청을 수락하였습니다.")
    end
  end
  
  def invitation(user, email)
     @user = user
     @email = email
     mail(:to => email, :subject => "#{@user.name}님이 당신을 DreamKit으로 초대합니다.")     
  end
  
  def password_reset(user, new_password)
     @user = user
     @email = @user.email
     @new_password = new_password
     mail(:to => @email, :subject => "#{@user.name}님의 DreamKit 비밀번호가 재발급되었습니다.")          
  end
  
  
  def feedback_notification(feedback)
    @feedback = feedback
    @user = @feedback.user
    @email = "dreamkit@headflow.net"
    mail(:to => @email, :subject => "#{@user.name}님으로부터 피드백이 도착했습니다.")
  end

end