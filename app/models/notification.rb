#encoding:UTF-8
class NotificationType
  FRIENDSHIP_REQUESTED    = 1
  FRIENDSHIP_ACCEPTANCE   = 2
  COMMENT_NOTY_TO_OTHERS  = 3
  COMMENT_NOTY_TO_ONE     = 4
  KIT_ON_MOIM             = 5
  KIT_ON_USER             = 6
  KIT_ON_SEED             = 7
  REPLY                   = 8
  KIT_ON_NETWORK          = 9
  MESSAGE                 = 10
  SEED_PARTICIPATE        = 11
end
class Notification < ActiveRecord::Base
  attr_accessible :notification_type, :notifiable_id, :notifiable_type, :user_id, :subject, :message, :url, :sender_id, :created_at, :read

  belongs_to :user
  belongs_to :notifiable, :polymorphic => true
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  validates :user_id, :presence => true
  
  default_scope :order => 'notifications.created_at DESC'

  # with the notifiable_type and notifiable_id, you can easily get the Notification Type. in case it isn't clear, we use the notification_type
  def self.notify(targetuser_id, notification_type, notifiable_id, notifiable_type, sender_id)
    if targetuser_id == sender_id 
      return
    end
    case notifiable_type
    when "Friendship"
      obj = Friendship.find_by_id(notifiable_id)
      case notification_type
      when "friendship_acceptance_notification"
        type = NotificationType::FRIENDSHIP_ACCEPTANCE
      when "friendship_notification"
        type = NotificationType::FRIENDSHIP_REQUESTED
      end

    when "Comment"
      obj = Comment.find_by_id(notifiable_id)
      case notification_type
      when "other_comment_notification"
        type = NotificationType::COMMENT_NOTY_TO_OTHERS
      else
        type = NotificationType::COMMENT_NOTY_TO_ONE
      end

    when "Kit"
      obj = Kit.find_by_id(notifiable_id)
      case obj.kitable_type.downcase
      when "moim"
        type = NotificationType::KIT_ON_MOIM
      when "seed"
        type = NotificationType::KIT_ON_SEED
      when "user"
        type = NotificationType::KIT_ON_USER
      
      end

    when "Reply"
      obj = Reply.find_by_id(notifiable_id)
      type = NotificationType::REPLY

    when "Message"
      obj = Reply.find_by_id(notifiable_id)
      type = NotificationType::MESSAGE

    else
      # this must be a bug
    end

    body = create_body(obj, type)
    footer = create_footer(obj, type)
    url = create_url(obj, type)
    if targetuser_id.class.to_s != "Array"
      targetuser_id = [targetuser_id]
    end
    targetuser_id.each do |user_id|
      to_user = User.find(user_id)
      subject = create_subject(to_user, obj, type)
      @notification = Notification.new(:user_id => user_id, :notification_type=>notification_type, 
      :notifiable_id => notifiable_id, :notifiable_type => notifiable_type, :subject => subject, :message => body, :url => url, :sender_id => sender_id)
      @notification.save
      if can_send?(to_user, obj, type)
        UserMailer.delay.send_email(to_user, subject, body, footer, url)
      end
    end
  end

  private
  def self.can_send?(to_user, obj, type)
    unless to_user.notification_setting.nil?
      case type
      when NotificationType::FRIENDSHIP_REQUESTED
        return to_user.notification_setting.friendship_notify?
      when NotificationType::FRIENDSHIP_ACCEPTANCE
        return to_user.notification_setting.friendship_acceptance_notify?
      when NotificationType::COMMENT_NOTY_TO_OTHERS
        return (to_user != obj.user) && to_user.notification_setting.other_comment_notify?
      when NotificationType::COMMENT_NOTY_TO_ONE  
        return (to_user != obj.user) && to_user.notification_setting.comment_notify?      
      when NotificationType::KIT_ON_MOIM
        return (to_user != obj.user) && to_user.notification_setting.moim_kit_notify?
      when NotificationType::KIT_ON_USER
        return (to_user != obj.user) && to_user.notification_setting.kit_notify?
      when NotificationType::KIT_ON_SEED
        return (to_user != obj.user) && to_user.notification_setting.seed_kit_notify?
     
      when NotificationType::REPLY
        return (to_user != obj.user) && to_user.notification_setting.reply_notify?
      when NotificationType::KIT_ON_NETWORK
        return false        
      when NotificationType::MESSAGE
        return (to_user != obj.user) && to_user.notification_setting.reply_notify?
      when NotificationType::SEED_PARTICIPATE                
        return false
      end
    end
  end

  def self.create_subject(to_user, obj, type)

    case type
    when NotificationType::FRIENDSHIP_REQUESTED
      return "#{obj.user.name}님이 #{obj.friend.name}님을 친구로 초대하였습니다."

    when NotificationType::FRIENDSHIP_ACCEPTANCE
      return "#{obj.user.name}님이 #{obj.friend.name}님의 친구신청을 수락하였습니다."

    when NotificationType::COMMENT_NOTY_TO_OTHERS
      return "#{obj.user.name}님이 댓글을 남기셨습니다."

    when NotificationType::COMMENT_NOTY_TO_ONE
      return "#{obj.user.name}님이 #{obj.kit.user.name}님의 \"#{obj.kit.content.truncate(10)}\"킷에 댓글을 남기셨습니다."

    when NotificationType::KIT_ON_MOIM
      kitable = Moim.find(obj.kitable_id)
      return "#{obj.user.name}님이 '#{kitable.title}' 모임에 킷을 남기셨습니다."

    when NotificationType::KIT_ON_USER
      kitable = User.find(obj.kitable_id)
      return "#{obj.user.name}님이 #{kitable.name}님의 뜰에 다음과 같은 Kit을 남기셨습니다."

    when NotificationType::KIT_ON_SEED
      kitable = Seed.find(obj.kitable_id)
      return "#{obj.user.name}님이 '#{kitable.title}' 시드에 킷을 남기셨습니다."
  
 

    when NotificationType::REPLY, NotificationType::MESSAGE
      return "#{obj.user.name}님이 쪽지를 보내셨습니다."

    when NotificationType::KIT_ON_NETWORK

    when NotificationType::SEED_PARTICIPATE                

    end
  end

  def self.create_body(obj, type)
    if obj != nil
      case type
      when NotificationType::FRIENDSHIP_REQUESTED
        #return "#{obj.user.name}님이 #{obj.friend.name}님을 친구로 초대하였습니다."

      when NotificationType::FRIENDSHIP_ACCEPTANCE
        #return "#{obj.user.name}님이 #{obj.friend.name}님의 친구신청을 수락하였습니다."

      when NotificationType::COMMENT_NOTY_TO_OTHERS, NotificationType::COMMENT_NOTY_TO_ONE, NotificationType::KIT_ON_SEED, NotificationType::KIT_ON_USER, NotificationType::KIT_ON_MOIM
        return "\"#{obj.content}\""

      when NotificationType::REPLY, NotificationType::MESSAGE
        if obj.message.replies.count < 2
          return "제목: #{obj.message.title}<br/>\"#{obj.content}\""
        else
          return "\"#{obj.content}\"";
        end

      when NotificationType::KIT_ON_NETWORK

      when NotificationType::SEED_PARTICIPATE                

      end
    end
  end

  def self.create_footer(obj, type)
    case type
    when NotificationType::FRIENDSHIP_REQUESTED
      return "#{obj.user.name}님의 친구 요청을 확인하시려면 다음 링크를 클릭해주세요."

    when NotificationType::FRIENDSHIP_ACCEPTANCE
      return "#{obj.user.name}님의 페이지로 가시려면 다음 링크를 클릭해주세요."

    when NotificationType::COMMENT_NOTY_TO_OTHERS, NotificationType::COMMENT_NOTY_TO_ONE  
      return "#{obj.user.name}님의 댓글을 확인하시려면 다음 링크를 클릭해주세요."

    when NotificationType::KIT_ON_MOIM
      return "#{obj.user.name}님의 킷을 확인하시려면 다음 링크를 클릭해주세요"

    when NotificationType::KIT_ON_USER
      return "#{obj.user.name}님에게 답장하시려면 다음 링크를 클릭해주세요."

    when NotificationType::KIT_ON_SEED
      return "#{obj.user.name}님의 킷을 확인하시려면 다음 링크를 클릭해주세요"

    when NotificationType::REPLY, NotificationType::MESSAGE
      return "#{obj.user.name}님에게 답장하시려면 다음 링크를 클릭해주세요."

    when NotificationType::KIT_ON_NETWORK

    when NotificationType::SEED_PARTICIPATE                

    end

  end

  def self.create_url(obj, type)

    case type
    when NotificationType::FRIENDSHIP_REQUESTED, NotificationType::FRIENDSHIP_ACCEPTANCE
      return "http://www.dreamkit.net/users/#{obj.user.id}"

    when NotificationType::COMMENT_NOTY_TO_OTHERS
      case obj.kit.kitable_type.downcase
      when "user"
        return "http://www.dreamkit.net/users/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      when "seed"
        return "http://www.dreamkit.net/seeds/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      when "moim"
        return "http://www.dreamkit.net/moims/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      end

    when NotificationType::COMMENT_NOTY_TO_ONE  
      case obj.kit.kitable_type.downcase
      when "user"
        return "http://www.dreamkit.net/users/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      when "seed"
        return "http://www.dreamkit.net/seeds/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      when "moim"
        return "http://www.dreamkit.net/moims/#{obj.kit.kitable_id}#kit_#{obj.kit.id}"
      end   

    when NotificationType::KIT_ON_MOIM
      return "http://www.dreamkit.net/moims/#{obj.kitable_id}#kit_#{obj.id}"
    when NotificationType::KIT_ON_USER
      return "http://www.dreamkit.net/users/#{obj.kitable_id}#kit_#{obj.id}"
    when NotificationType::KIT_ON_SEED
      return "http://www.dreamkit.net/seeds/#{obj.kitable_id}#kit_#{obj.id}"
   
    when NotificationType::REPLY
      return "http://www.dreamkit.net/messages/#{obj.message_id}"
    when NotificationType::KIT_ON_NETWORK
    when NotificationType::MESSAGE  
      return "http://www.dreamkit.net/messages/#{obj.message_id}"
    when NotificationType::SEED_PARTICIPATE                
    end
  end

end
