namespace :shipping_watcher do
  desc "Generate Cron"
  task :generate_cron, [:sys_user] => :environment do |t, sys_user|
    path     = File.join(File.expand_path('.'))
    sys_user = 'yuri'
    sh "val=\"* * * * * source #{path}/verify_status_change/lib/tasks/cron.sh \";  (crontab -u #{sys_user} -l; echo \"$val\") | crontab -u #{sys_user} -"
    #sh "cd #{yebo_path} && rvm cron command \"* * * * *\" rake abandoned_cart:send_emails[\"#{sys_user}\"] && rvm cron setup"
  end

  desc "Verify change of status"
  task :verify_status_change, [:sys_user] => :environment do |t, args|
    Apartment::Database.switch(args[:sys_user])
    Spree::Order.email_eligible_abandoned_email_orders
  end
end