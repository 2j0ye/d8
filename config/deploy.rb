### This file contains project-specific settings ###

require "lns-deploy-d8"

# The project name.

# logger.level = Capistrano::Logger::MAX_LEVEL

set :application, "d8"
# Multistage support - see stages/[STAGE].rb for specific configs
set :stage_dir, "config/stages/" # Configure your stage directory !
set :default_stage, "dev"
set :stages, %w(dev)
set :use_sound,true

set :use_composer, false
set :use_makefile, true
set :makefile, "d8.make"


# Slack
# Add an incomming webHook and configure the channel (optional bot icon/name)
# If both null, don't send notifications
# set :slack_subdomain, "lns"
# set :slack_token, "3KPBguwEn6Wfqow2AybKtP2c"
# set :slack_channel, "projet-rothschild-not"

####################################################
# Set the repository type and location to deploy from.
set :lab_deploy_url, "http://deploys.dashboard.dev.scoua.de/api/v1/deploys"

# GITHUB
set :scm, :git
set :repository, "git@github.com:Jjoye/d8.git"
set(:branch_prompt) {
  (stage == :dev) ? (set :default_branch, 'dev') : (set :default_branch, 'dev')
  Capistrano::CLI.ui.ask("Branche ou tag à déployer [#{default_branch}]: ")
}
set(:branch) { (branch_prompt == "") ? "#{default_branch}" : "#{branch_prompt}" }
set :repository_cache, "git_cache"
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache
####################################################

# Bower
set :use_bower,       false
set :bower_mode,      'local' # local or server
set :bower_directory, 'libraries'

# List the Drupal multi-site folders.  Use "default" if no multi-sites are installed.
set :domains, ["default"]

# Servers uris
set(:domain) { "#{domain}" }
role(:web) { domain }
role(:app) { domain }
role(:db, :primary => true) { domain }

# Generally don't need sudo for this deploy setup
set :use_sudo, false
# Keep the last 3 releases
set :keep_releases, 3

default_run_options[:pty] = true

# Drush configuration (could be overrided on stages.rb)
set :local_drush, "drush"

# Drush remote path
set :remote_drush, "/usr/bin/drush"

# Run drush make before creating symlink
before 'deploy:create_symlink' do
    run "cd #{latest_release} && drush make makefile.make -y"
end
