require 'grape'
require 'rack/cors'

require_relative 'shipping_watcher/tracker'
require_relative 'shipping_watcher/calculator'

# All support for cross-domain
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

# /noinspection RubyJumpError
# /noinspection ALL
module ShippingWatcher
  class API < Grape::API
    format :json
    get do
      {status: 'show'}
    end

    post do
      obj = Tracker.where(code: params[:tracking_code]).first

      if params[:action] == '1' && !obj.nil?
        # noinspection ALL
        return {status: 'consult', object: obj.logs, details: 'last consult'}
      end

      if obj
        obj.log!
        # noinspection ALL
        return {status: 'consult', object: obj.get_status, details: 'last consult'}
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
        {status: 'success', object: obj.get_status, details: 'actual state of object'}
      else
        {status: 'failed', object: obj.get_status, details: obj.get_errors}
      end
    end

    params do
      requires :zip, type: Hash do
        requires :cep_origem, type: String
        requires :cep_destino, type: String
        requires :items, type: Array do
          requires :peso, type: Float
          requires :comprimento, type: Float
          requires :largura, type: Float
          requires :altura, type: Float
        end
      end
    end
    post '/zip' do
      calc             = Calculator.new
      calc.cep_origem  = params[:zip][:cep_origem]
      calc.cep_destino = params[:zip][:cep_destino]
      calc.items       = params[:zip][:items]
      calc.compute
    end
  end
end
