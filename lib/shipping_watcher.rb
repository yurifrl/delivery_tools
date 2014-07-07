require 'sinatra'
require 'sinatra/activerecord'
require 'foreigner'
require 'json'
require_relative '../config/database.rb'
require_relative 'shipping_watcher/tracker'
require_relative 'shipping_watcher/calculator'

# /noinspection RubyJumpError
# /noinspection ALL
class ShippingWatcher < Sinatra::Base
  post '/' do
    content_type :json
    obj = Tracker.where(code: params[:tracking_code]).first

    if params[:action] == '1' && !obj.nil?
      # noinspection ALL
      return {status: 'consult', object: obj.logs, details: 'last consult'}.to_json
    end

    if obj
      obj.log!
      # noinspection ALL
      return {status: 'consult', object: obj.get_status, details: 'last consult'}.to_json
    end

    obj = Tracker.new do |tracker|
      tracker.code        = params[:tracking_code]
      tracker.shipper_id  = params[:shipper_id]
      tracker.login_id    = params[:login_id]
      tracker.login_pass  = params[:login_pass]
      tracker.login_token = params[:login_token]
      tracker.url         = params[:url]
    end

    if obj.try(:save)
      obj.log!
      {status: 'success', object: obj.get_status, details: 'actual state of object'}.to_json
    else
      {status: 'failed', object: obj.get_status, details: obj.get_errors}.to_json
    end
  end

  post '/zip' do
    content_type :json
    Calculator.compute.to_json
  end
end