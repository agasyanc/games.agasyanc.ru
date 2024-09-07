# config/deploy/production.rb

server '94.228.122.160', user: 'deploy', roles: %w{app db web}

# Define the deployment directory
set :deploy_to, '/home/deploy/games.agasyanc.ru'

# Use the following if you have a different branch to deploy
# set :branch, 'main'

# Specify the Ruby version if needed
set :rbenv_type, :user # or :system if rbenv is installed system-wide
set :rbenv_ruby, '3.3.0' # Replace with the installed Ruby version
# Use Passenger


# Optionally set linked files and directories
set :linked_files, %w{config/database.yml db/production.sqlite3 config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
