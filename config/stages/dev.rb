### This file contains stage-specific settings ###

# Set the deployment directory on the target hosts.
set :deploy_to, "/var/www/html/#{application}"

# The hostnames to deploy to.
set :domain, "www.julien.scoua.de"

# The username on the target system, if different from your local username
ssh_options[:user] = 'julien'
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :deploy_via, :checkout
