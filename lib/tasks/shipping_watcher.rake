namespace :shipping_watcher do
  desc "Verify change of status"
  task :status_change do
    require File.expand_path('../../shipping_watcher/tracker', __FILE__)
    Tracker.verify_status_change
  end
end