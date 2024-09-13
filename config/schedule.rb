# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/var/log/cron.log"

# Set the path for rbenv
env :PATH, ENV['PATH'] + ':/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin'
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 1.minutes do
  runner "Switch.turn_off"
end

# Learn more: http://github.com/javan/whenever
