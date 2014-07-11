require 'httparty'

class Notifier
  include HTTParty
  default_params :output => 'json'
  format :json

  def self.request(tracker)
    tracker.url = "http://store1.lvh.me:3000/api/order_tracker"
    base_uri(tracker.url)
    post("#{tracker.url}?token=#{tracker.api_key}", :body => {tracking_code: tracker.code, status_name: tracker.status.name, status_id: tracker.status_id})
  end
end