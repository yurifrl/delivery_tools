# Use this file to easily define all of your cron jobs.
#

# Example:
#
if Rails.env == 'development'
  set :output, 'cron_log.log'
end
#
every 2.minutes do
  rake 'shipping_watcher:status_change'
end