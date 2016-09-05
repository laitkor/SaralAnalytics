class BrowserHistoryController < ApplicationController
include BrowserHistoryHelper

  protect_from_forgery
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
  end

  def histories
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    if !(BrowserHistory.search_by(ip_address: ip_address, project_id: params[:project_id]).empty?)
      respond_to do |format|
        format.js {render :json => @browser_history}
      end
    else
      @browser_history = BrowserHistory.new(
      :project_id=>params[:project_id],
      :ip_address=>ip_address, 
      :main_domain=>params[:main_domain],
      :domain=>params[:domain], 
      :os_name=>user_agent_os, 
      :browser=>browser, 
      :device=>device, 
      :device_type=>device_type, 
      :client=>ip_address 
      )
      respond_to do |format|
        format.js {render :json => @browser_history}
        @browser_history.save
      end
    end
  end
end
