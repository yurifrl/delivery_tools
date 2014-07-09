ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/app'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Shipping Watcher' do
  #'should receive new entrance by post'
  # entrance accepts parameters ->
  # * url return
  # * type of service
  # * service attributes
  #'should create new entrance by post'
  #'should have a entrance'
  #'should send post to url return of entrance'
end