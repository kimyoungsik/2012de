# RailsAdmin config file. Generated on January 14, 2012 03:43
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_admin } # auto-generated
  
  # If you want to track changes on your models:
  # config.audit_with :history, Admin
  
  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, Admin
  
  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Dreamkit', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Admin, Attendance, Authentication, Comment, Ditto, Friendship, Interest, Invitation, Kit, Major, Message, MessageParticipation, Moim, Network, NetworkParticipation, Notification, NotificationSetting, Participation, PasswordReset, Reply, Seed, Support, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Admin, Attendance, Authentication, Comment, Ditto, Friendship, Interest, Invitation, Kit, Major, Message, MessageParticipation, Moim, Network, NetworkParticipation, Notification, NotificationSetting, Participation, PasswordReset, Reply, Seed, Support, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Admin do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :failed_attempts, :integer 
  #     configure :unlock_token, :string 
  #     configure :locked_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Attendance do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :attendee_id, :integer 
  #     configure :attended_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Authentication do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :provider, :string 
  #     configure :uid, :string 
  #     configure :token, :string 
  #     configure :nickname, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Comment do
  #   # Found associations:
  #     configure :kit, :belongs_to_association 
  #     configure :user, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :content, :text 
  #     configure :kit_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Ditto do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :dittoable_id, :integer 
  #     configure :dittoable_type, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Friendship do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :friend_id, :integer 
  #     configure :status, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Interest do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Invitation do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :invitee_email, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Kit do
  #   # Found associations:
  #     configure :comments, :has_many_association 
  #     configure :user, :belongs_to_association 
  #     configure :kitable, :polymorphic_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :content, :text 
  #     configure :kitable_id, :integer         # Hidden 
  #     configure :kitable_type, :string         # Hidden 
  #     configure :photo_file_name, :string 
  #     configure :photo_content_type, :string 
  #     configure :photo_file_size, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Major do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Message do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model MessageParticipation do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :message_id, :integer 
  #     configure :read, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Moim do
  #   # Found associations:
  #     configure :kits, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :user_id, :integer 
  #     configure :location, :string 
  #     configure :event_time, :datetime 
  #     configure :hasMap, :boolean 
  #     configure :mapCoordinates, :string 
  #     configure :mapAddress, :string 
  #     configure :moimable_id, :integer 
  #     configure :moimable_type, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Network do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :network_type, :string 
  #     configure :address, :string 
  #     configure :privacy, :boolean 
  #     configure :network_participations_count, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model NetworkParticipation do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :network_id, :integer 
  #     configure :approved, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Notification do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :notification_type, :string 
  #     configure :notifiable_id, :integer 
  #     configure :notifiable_type, :string 
  #     configure :read, :boolean 
  #     configure :message, :string 
  #     configure :subject, :string 
  #     configure :url, :string 
  #     configure :sender_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model NotificationSetting do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :kit_notify, :boolean 
  #     configure :seed_kit_notify, :boolean 
  #     configure :moim_kit_notify, :boolean 
  #     configure :comment_notify, :boolean 
  #     configure :other_comment_notify, :boolean 
  #     configure :reply_notify, :boolean 
  #     configure :friendship_notify, :boolean 
  #     configure :friendship_acceptance_notify, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Participation do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :seed_id, :integer 
  #     configure :status, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model PasswordReset do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :name, :string 
  #     configure :user_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Reply do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :message_id, :integer 
  #     configure :content, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Seed do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :kits, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Support do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :user_id, :integer 
  #     configure :seed_id, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :seeds, :has_many_association 
  #     configure :kits, :has_many_association 
  #     configure :authored_kits, :has_many_association 
  #     configure :comments, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :email, :string 
  #     configure :birthday, :datetime 
  #     configure :cellphone, :string 
  #     configure :avatar_file_name, :string         # Hidden 
  #     configure :avatar_content_type, :string         # Hidden 
  #     configure :avatar_file_size, :integer         # Hidden 
  #     configure :avatar, :paperclip 
  #     configure :admin, :boolean 
  #     configure :profile, :string 
  #     configure :remember_token, :string 
  #     configure :major_detail, :string 
  #     configure :major_id, :integer 
  #     configure :interest_id, :integer 
  #     configure :sex, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :password_salt, :string         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :remember_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
