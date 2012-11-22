set :application,       'CamanJS-Site'
set :use_sudo,          false
set :host,              'camanjs.com'
set :user,              "camanjs_com"

set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

role :web,  host
role :app,  host
role :db,   host, :primary => true

set :group,   user

set :deploy_via, :copy
set :repository, "_site"
set :scm, :none
set :copy_compression, :gzip

before 'deploy:update',       'deploy:update_jekyll'
after  'deploy:update_code',  'deploy:create_symlink'

namespace :deploy do

  desc <<-DESC
  A macro-task that updates the code and fixes the symlink.
  DESC
  task :default do
    transaction do
      compile
      update_code
    end
  end

  task :update_code, :except => { :no_release => true } do
    on_rollback { run "rm -rf #{release_path}; true" }
    strategy.deploy!
  end

  desc "Compile the site and CSS. "
  task :compile do
    system "rake dev:off"
    system "rake jekyll:compile"
  end

end