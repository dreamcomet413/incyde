# config valid only for current version of Capistrano
# lock '3.3.5'
lock '3.8.1'


set :application, 'incyde'
#set :repo_url, 'git@example.com:me/my_repo.git'
set :repo_url, 'https://github.com/vanurox/incyde.git'
#set :repo_url, 'https://leaniman@bitbucket.org/leaniman/incyde.git'

set :deploy_to, '/home/deploy/incyde'

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
#set :branch, "develop"

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/home/deploy/incyde"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/assets', 'public/system', 'public/uploads')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :passenger_roles, :app                  # this is default
set :passenger_restart_runner, :sequence    # this is default
set :passenger_restart_wait, 5              # this is default
set :passenger_restart_limit, 2             # this is default

#set :rvm_type, :user                     # Defaults to: :auto
#set :rvm_ruby_version, 'ruby-2.1.1'      # Defaults to: 'default'


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end

    on roles(fetch(:passenger_roles)), in: fetch(:passenger_restart_runner), wait: fetch(:passenger_restart_wait), limit: fetch(:passenger_restart_limit) do
      execute :touch, release_path.join('tmp/restart.txt')
    end

  end

end
