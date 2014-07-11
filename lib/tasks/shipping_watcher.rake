namespace :shipping_watcher do
  desc "Verify change of status"
  task :status_change => :environment do
    require File.expand_path('../../shipping_watcher/tracker', __FILE__)
    require File.expand_path('../../shipping_watcher/notifier', __FILE__)
    Tracker.all.each do |tracker|
      tracker.load_shipper
      Notifier.request(tracker) if tracker.status_changed?
    end
  end
end