#!/bin/sh
export RAILS_ENV=production
bundle exec rake shipping_watcher:verify_status_change

# this task has to ben runned, the parameter is the user tenant:
# rake abandoned_cart:send_emails[PARAM]