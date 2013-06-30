server 'zim.itasca.net', :app, :web, :db, :primary => true
set :deploy_to, "/home/cononrails/domains/dev.cononrails.itasca.net/apps/#{application}"
set :user, 'cononrails'
set :group, 'cononorails'