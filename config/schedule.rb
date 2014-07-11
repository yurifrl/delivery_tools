# Use this file to easily define all of your cron jobs.
#

# Example:
#
set :output, 'config/cron_log.log'
#
every 2.minutes do
  rake 'shipping_watcher:status_change'
end