class AdminController < ApplicationController

  before_filter :login_required, :check_current_user_project

  def dashboard
    @browser_history = BrowserHistory.for_project(@project, {count: true})
    @browser_detail = BrowserDetail.for_project(@project, {count: true})
  end

  def explore
    @browser_history = BrowserHistory.for_project(@project, {count: true})
    @browser_detail = BrowserDetail.for_project(@project, {count: true})
  end

  def comparison_overview    
    date = query_for_date Time.now
    month = query_for_month Time.now
    @all_visitors = 11.downto(0).map {|date| BrowserDetail.search_by(project_id: @project.key, created_at:query_for_month(date.months.ago))}.map(&:size)
    @unique_visitors = 11.downto(0).map {|date| BrowserHistory.search_by(project_id: @project.key, created_at:query_for_month(date.months.ago))}.map(&:size)
    @month_range = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    respond_to do |format|
      format.js {render :json=> {visitors: {:total_frequency => @all_visitors, :unique_frequency => @unique_visitors}, :monthly_range => @month_range}}
    end 
  end

  def audience_overview
    date = query_for_date Time.now
    @search_by_date = 20.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, created_at: (query_for_date date.days.ago)}, {count: true})}    
   
    month = query_for_month Time.now
    @search_by_month = 11.downto(0).map {|date| BrowserDetail.search_by(project_id: @project.key, created_at:query_for_month(date.months.ago))}.map(&:size)
    
    @date_range = (20.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @month_range = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000

    respond_to do |format|
      format.js {render :json=> {:daily_frequency => @search_by_date, :monthly_frequency => @search_by_month, :daily_range => @date_range, :monthly_range => @month_range}}
    end 
  end

  def show_browsers
    @individual_browsers_count = BrowserDetail.search_by(project_id: @project.key, ret: "browser_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} 
    @total_browsers_count = BrowserDetail.for_project(@project)
    respond_to do |format|
      format.js {render :json=> {:browsers_frequency => @individual_browsers_count, :total_browsers => @total_browsers_count }}
    end
  end

  def show_operating_systems
    @individual_os_count = BrowserDetail.search_by(project_id: @project.key, ret: "os_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} 
    @total_os_count = BrowserDetail.for_project(@project)
    respond_to do |format|
      format.js {render :json=> {:os_frequency => @individual_os_count, :total_os => @total_os_count }}
    end
  end

  private

  def query_for_date(date)
    date.to_s.scan(/\d{4}-\d{2}-\d{2}/)[0] + "*"
  end

  def query_for_month(month)
    month.to_s.scan(/\d{4}-\d{2}/)[0] + "*"
  end

  def demographic
    
  end

  def desktop

  end

  def mobile

  end

end
