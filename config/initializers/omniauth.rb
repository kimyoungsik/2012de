Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '181566241883873', 'b1d48ecdec1256fa93580ed33895d353', :scope => "email, user_birthday, offline_access, publish_stream, user_groups, friends_groups"
  # provider :facebook, "310390195663416", "711cdf0b422451c746c47b6459583f33", :scope => "email, user_birthday, offline_access, publish_stream, user_groups, friends_groups"
 
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end