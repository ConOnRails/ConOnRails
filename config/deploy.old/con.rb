set :deploy_to, "/home/cvgops/apps/#{application}"
set :user, 'cvgops'
set :group, 'cvgops'
set :rvm_type, :system
server '192.168.15.2', :app, :web, :db, :primary => true
