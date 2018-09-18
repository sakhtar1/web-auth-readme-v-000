class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['HT3G4KSBLELSNJVBAT05D0ZR5IE11GOZ1HNFXJ1CM2I34SRY']
      req.params['client_secret'] = ENV['1F5XNMLEO4CSSNGSOYFDYILNZGQIJLKG415AU4W4IXWEZ4TL']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
