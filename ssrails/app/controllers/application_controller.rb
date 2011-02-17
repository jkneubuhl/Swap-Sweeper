require 'net/http'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init
  attr_accessor :access_token

  def check_for_access_token

    logger.debug "calling authorize before processing #{request.url}"

    if session.key?('token_id')
      token = data_cache( session['token_id'] ) { nil }
      if token 
        client = OAuth2::Client.new( config['app_id'], config['secret'], :site => 'https://graph.facebook.com', :parse_json => true )
        @access_token = OAuth2::AccessToken.new( client, token )
      end
    end
    

    # if this is the first time we've seen this user
    # hang on to the url that we are trying to go to
    # so we can come back after we log into facebook

    unless @access_token
      session['redirect'] = request.url
      redirect_to url_for( :controller => 'account', :action => 'authorize' )
    end
  end

  def user
    
    logger.debug "TOKEN #{ @access_token }"
    response = @access_token.get('/me')
    logger.debug "USER #{response}"
    response
  end

  def init
    @access_token = nil
  end

  def data_cache( key )
    unless output = CACHE.get( key )
      logger.debug "CACHE MISS #{key}"
      output = yield
      CACHE.set( key, output, 1.hour )
    end
    logger.debug "CACHE #{key} #{output}"
    output
  end



end