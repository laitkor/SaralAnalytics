class BrowserDetailController < ApplicationController
include BrowserDetailHelper

  protect_from_forgery
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
  end

  def details
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    @browser_detail = BrowserDetail.new(
    :project_id=>params[:project_id],
    :ip_address=>ip_address,    
    :browser_name=>browser_name,    
    :browser_version=>browser_version, 
    :time_zone=>time_zone, 
    :language=>browser_language, 
    :height =>params[:height],
    :width=>params[:width],
    :device=>device,
    :user_agent=>device_type,
    :screen_color=>params[:screen_color], 
    :screen_resolution=>params[:screen_resolution],
    :accept_headers=>accept_headers, 
    :server=>server, 
    :cookie_enabled=>params[:cookie_enabled],
    :platform=>platform, 
    :os_name=> if user_agent_os.present?
        user_agent_os
      else
        mobile_os
      end,
    :java_enabled=>params[:java_enabled],
    :accept_encoding=>accept_encoding,
    :content_type=>content_type, 
    :latitude=>latitude,
    :longitude=>longitude,   
    :city=>city, 
    :country=>country,
    :region=>region,
    :http_referer=>http_referer,  
    :plugins_installed=>params[:plugins_installed],
    :html_audio_support=>params[:html_audio_support],
    :html_video_support=>params[:html_video_support],
    :canvas_support=>params[:canvas_support],
    :domain=>params[:domain]
     )
    respond_to do |format|
      format.js {render :json => @browser_detail}
      @browser_detail.save
    end
  end

end
