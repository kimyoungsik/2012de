#encoding:UTF-8

Factory.define :user do |user|
  user.name                  "김영식"
  user.email                 "doly11@headflow.net"
  user.password              "dudtlr"
  user.password_confirmation "dudtlr"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :seed do |seed|
  seed.title "Foo bar"
  seed.description "Foo barbar bar"
  seed.association :user
end

Factory.sequence :name do |n|
  "#{n}번째 네트워크"
end

Factory.define :network do |network|
  network.name "foobar"
  network.network_type "company"
  network.address "foobar@foobar.com"
end

Factory.define :comment do |comment|
  comment.content "i like this content"
  comment.association :user
  comment.association :kit
end

Factory.define :network_participation do |network_participation|
  network_participation.association :user
  network_participation.association :network
end

Factory.define :notification_setting do |notification_setting|
  notification_setting.association :user
end

Factory.define :message do |message|
  message.association :user
  message.association :message
end

