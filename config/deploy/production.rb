server 'cononrails.itasca.net', user: 'cononrails', roles: %w{web app db}
set :rails_env, :production
set :log_level, :debug
set :deploy_to, "/home/cononrails/apps/" + fetch(:application)
