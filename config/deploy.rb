# set to the name of git remote you intend to deploy to
set :remote, "dreamkit"
# specify the deployment branch
set :branch, "master"
# sudo will only be used to create the deployment directory
set :use_sudo, true
# the remote host is read automatically from your git remote specification
server remote_host, :app, :web, :db, :primary => true