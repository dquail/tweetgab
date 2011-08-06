set :application, "tweetgab"
set :repository,  "git://github.com/dquail/tweetgab.git"

set :scm, :git

set :user, :ubuntu

set :deploy_to, '/webapps/tweetgab.com'
set :deploy_via, :remote_cache
set :keep_releases, 4 

role :web, "www.tweetgab.com"                          # Your HTTP server, Apache/etc
role :app, "www.tweetgab.com"                          # This may be the same as your `Web` server
role :db,  "www.tweetgab.com", :primary => true        # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end