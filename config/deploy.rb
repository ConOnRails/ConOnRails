set :stages, %w(production development)
set :default_stage, :development
require 'capistrano/ext/multistage'

set :application, "ConOnRails"
set :repository, "git@github.com:ConOnRails/ConOnRails.git"
set :user, 'cononrails'
set :group, 'cononrails'
set :use_sudo, false

set :deploy_via, :remote_cache
set :rails_env, :production

server 'zim.itasca.net', :app, :web, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    ;
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end