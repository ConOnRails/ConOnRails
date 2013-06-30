set :deploy_to, "/home/ops/apps/#{application}"
set :user, 'ops'
set :group, 'ops'
set :rvm_type, :user
server '192.168.92.136', :app, :web, :db, :primary => true
