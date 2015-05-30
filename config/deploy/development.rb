server 'dev.cononrails.itasca.net', user: 'dev-cononrails', roles: [:app, :web, :db]
set :rails_env, 'development'
set :log_level, :debug
set :deploy_to, '/home/dev-cononrails/apps'
