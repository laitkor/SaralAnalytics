class PageTitleController < ApplicationController

  protect_from_forgery
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
  end

  def page_details    
    if !(PageTitle.search_by(title: params[:title], project_id: params[:project_id]).empty?)
      respond_to do |format|
        format.js {render :json => @new_page_title}
      end
    else
      @page_title = PageTitle.new(
        :project_id=>params[:project_id],
        :title=>params[:title],
        :page_url=>params[:page_url]
      )
      respond_to do |format|
        format.js {render :json => @page_title}
        @page_title.save
      end
    end
  end
end
