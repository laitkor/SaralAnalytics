class BrowserDetail
  include Ripple::Document
  class << self
    include CustomSearch
  end
  property :project_id, String
  property :ip_address, String
  property :browser_name, String
  property :browser_version, String
  property :time_zone, String
  property :language, String
  property :height, String
  property :width, String
  property :user_agent, String
  property :screen_color, String
  property :screen_resolution, String
  property :accept_headers, String
  property :server, String
  property :cookie_enabled, String
  property :platform, String
  property :os_name, String
  property :fonts_installed, String
  property :java_enabled, String
  property :latitude, String
  property :longitude, String
  property :accept_encoding, String
  property :content_type, String
  property :device, String
  property :major_version, String
  property :session_storage, String
  property :browser_vendor, String
  property :finger_print, String
  property :http_referer, String
  property :country, String
  property :city, String
  property :region, String
  property :flash_installed, String
  property :plugins_installed, String
  property :js_version, String
  property :product_sub, String
  property :html_audio_support, String
  property :html_video_support, String
  property :canvas_support, String
  property :powered_by, String
  property :iframe_name, String
  property :config_set_id, String
  property :last_updated, String
  property :domain, String
  timestamps!

  def key    
    @key ||= "#{created_at}"
  end
  
end
