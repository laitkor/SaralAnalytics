class SegmentationsController < ApplicationController
include SegmentationsHelper
  
  before_filter :login_required

  def filter
    @browser_detail = BrowserDetail.for_project(@project, {count: true})
    @weekly_data = (6.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @quarterly_data = (20.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @monthly_data = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    page = params[:page]
    date = query_for_date Time.now
    month = query_for_month Time.now
    browsers = {}
    browsers_per_week = {}
    browsers_per_month = {}
    unique_browsers.each do |unique_browser|
      browsers[unique_browser] = 20.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, browser_name: unique_browser, created_at: (query_for_date date.days.ago)}, {count: true})}
      browsers_per_week[unique_browser] = 6.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, browser_name: unique_browser, created_at: (query_for_date date.days.ago)}, {count: true})}
      browsers_per_month[unique_browser] = 11.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, browser_name: unique_browser, created_at: (query_for_month date.months.ago)}, {count: true})}
    end   
    respond_to do |format|
      format.js {render :json=> {result: browsers, monthly_result: browsers_per_month, weekly_result: browsers_per_week, weekly_range: @weekly_data, quarterly_range: @quarterly_data, monthly_range: @monthly_data}}
      format.html {}
      #format.csv { send_data @a.to_csv }
      #format.csv do
      #  response.headers['Content-Type'] = 'text/csv'
      #  response.headers['Content-Disposition'] = "attachment; filename=general_segmentation_day_#{6.months.ago}_to_#{Date.current}.csv"    
      #  render :text => CSVGenerator.generate(browsers) 
      #end
    end
 
  end

  def city
    @weekly_data = (6.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @quarterly_data = (20.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @monthly_data = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    page = params[:page]
    date = query_for_date Time.now
    month = query_for_month Time.now
    cities = {}
    cities_per_week = {}
    cities_per_month = {}
    unique_cities.each do |unique_city|
      cities[unique_city] = 20.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, city: unique_city, created_at: (query_for_date date.days.ago)}, {count: true})}
      cities_per_week[unique_city] = 6.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, city: unique_city, created_at: (query_for_date date.days.ago)}, {count: true})}
      cities_per_month[unique_city] = 11.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, city: unique_city, created_at: (query_for_month date.months.ago)}, {count: true})}
    end   
    respond_to do |format|
      format.js {render :json=> {result: cities, monthly_result: cities_per_month, weekly_result: cities_per_week, weekly_range: @weekly_data, quarterly_range: @quarterly_data, monthly_range: @monthly_data}}
      format.html {}
    end 
  end

  def country
    @weekly_data = (6.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @quarterly_data = (20.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @monthly_data = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    page = params[:page]
    date = query_for_date Time.now
    month = query_for_month Time.now
    countries = {}
    countries_per_week = {}
    countries_per_month = {}
    unique_countries.each do |unique_country|
      countries[unique_country] = 20.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, country: unique_country, created_at: (query_for_date date.days.ago)}, {count: true})}
      countries_per_week[unique_country] = 6.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, country: unique_country, created_at: (query_for_date date.days.ago)}, {count: true})}
      countries_per_month[unique_country] = 11.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, country: unique_country, created_at: (query_for_month date.months.ago)}, {count: true})}
    end   
    respond_to do |format|
      format.js {render :json=> {result: countries, monthly_result: countries_per_month, weekly_result: countries_per_week, weekly_range: @weekly_data, quarterly_range: @quarterly_data, monthly_range: @monthly_data}}
      format.html {}
    end 
  end

  def operating_system
    @weekly_data = (6.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @quarterly_data = (20.days.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    @monthly_data = (11.months.ago.at_midnight + Time.zone.now.utc_offset).to_i * 1000
    page = params[:page]
    date = query_for_date Time.now
    month = query_for_month Time.now
    operating_systems = {}
    os_per_week = {}
    os_per_month = {}
    unique_operating_systems.each do |unique_operating_system|
      operating_systems[unique_operating_system] = 20.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, os_name: unique_operating_system, created_at: (query_for_date date.days.ago)}, {count: true})}
      os_per_week[unique_operating_system] = 6.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, os_name: unique_operating_system, created_at: (query_for_date date.days.ago)}, {count: true})}
      os_per_month[unique_operating_system] = 11.downto(0).map {|date| BrowserDetail.search_by({project_id: @project.key, domain: page, os_name: unique_operating_system, created_at: (query_for_month date.months.ago)}, {count: true})}
    end   
    respond_to do |format|
      format.js {render :json=> {result: operating_systems, monthly_result: os_per_month, weekly_result: os_per_week, weekly_range: @weekly_data, quarterly_range: @quarterly_data, monthly_range: @monthly_data}}
      format.html {}
    end 
  end

  private

  def query_for_date(date)
    date.to_s.scan(/\d{4}-\d{2}-\d{2}/)[0] + "*"
  end

  def query_for_month(month)
    month.to_s.scan(/\d{4}-\d{2}/)[0] + "*"
  end
end