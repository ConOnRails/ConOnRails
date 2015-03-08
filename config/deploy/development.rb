server 'dev.cononrails.itasca.net', user: 'dev-cononrails', roles: [:app, :web, :db]
set :rvm_type, :user
set :rvm_custom_path, nil
set :rvm_ruby_version, 'ruby-2.2.0'
set :rails_env, 'development'
set :log_level, :debug
set :deploy_to, '/home/dev-cononrails/apps'
