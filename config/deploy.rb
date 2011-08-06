require 'bundler/capistrano'

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

after "deploy",            "deploy:notify_hoptoad"
after "deploy:migrations", "deploy:notify_hoptoad"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Notify Hoptoad of the deployment"
  task :notify_hoptoad, :except => { :no_release => true } do
    rails_env = fetch(:hoptoad_env, fetch(:rails_env, "production"))
    local_user = ENV['USER'] || ENV['USERNAME']
    executable = RUBY_PLATFORM.downcase.include?('mswin') ? fetch(:rake, 'rake.bat') : fetch(:rake, 'rake')
    notify_command = "#{executable} hoptoad:deploy TO=#{rails_env} REVISION=#{current_revision} REPO=#{repository} USER=#{local_user}"
    notify_command << " DRY_RUN=true" if dry_run
    notify_command << " API_KEY=#{ENV['API_KEY']}" if ENV['API_KEY']
    puts "Notifying Hoptoad of Deploy (#{notify_command})"
    `#{notify_command}`
    puts "Hoptoad Notification Complete."
  end
end
