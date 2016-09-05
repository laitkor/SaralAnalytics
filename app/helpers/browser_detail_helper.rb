module BrowserDetailHelper 


  def ip_address   
    request.remote_ip    
  end

  def browser_name
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.browser
  end

  def browser_version
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.version
  end

  def time_zone
    Time.zone
  end

  def browser_language
    request.env['HTTP_ACCEPT_LANGUAGE'].match(/\w{2}(-\w{2})?/)[0]
  end

  def device
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
    user_agent.mobile? ? 'Mobile' : 'Desktop'
  end

  def user_agent_os
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.os
  end

  def device_type 
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
    if (user_agent.mobile?)  
      @iphone = request.env['HTTP_USER_AGENT'] =~ /iPhone/i
      @android = request.env['HTTP_USER_AGENT'] =~ /Android/i
      @palmpre = request.env['HTTP_USER_AGENT'] =~ /webOS/i
      @berry = request.env['HTTP_USER_AGENT'] =~ /BlackBerry/i
      @ipod = request.env['HTTP_USER_AGENT'] =~ /iPod/i
      @ipad = request.env['HTTP_USER_AGENT'] =~ /iPad/i
      @windows = request.env['HTTP_USER_AGENT'] =~ /windows/i
      if (@iphone || @android || @palmpre || @berry || @ipod || @ipad || @windows)        
        if(@iphone && @iphone>0)
          @device_type = "iphone"    
        elsif(@android && @android>0)
          @device_type = "android"             
        elsif(@palmpre && @palmpre>0)
          @device_type = "webOS" 
        elsif(@berry && @berry>0)
          @device_type = "BlackBerry"         
        elsif(@ipod && @ipod>0)
          @device_type = "ipod"   
        elsif(@ipad && @ipad>0)
          @device_type = "ipad" 
        elsif(@windows && @windows>0)
          @device_type = "windows"
        end
      end
    else
      "Desktop"
    end
  end

  def mobile_os 
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
    if (user_agent.mobile?)  
      @iphone = request.env['HTTP_USER_AGENT'] =~ /iPhone/i
      @android = request.env['HTTP_USER_AGENT'] =~ /Android/i
      @palmpre = request.env['HTTP_USER_AGENT'] =~ /webOS/i
      @berry = request.env['HTTP_USER_AGENT'] =~ /BlackBerry/i
      @ipod = request.env['HTTP_USER_AGENT'] =~ /iPod/i
      @ipad = request.env['HTTP_USER_AGENT'] =~ /iPad/i
      @windows = request.env['HTTP_USER_AGENT'] =~ /windows/i
      if (@iphone || @android || @palmpre || @berry || @ipod || @ipad || @windows)        
        if(@iphone && @iphone>0)
          @mobile_os = "iOS"    
        elsif(@android && @android>0)
          @mobile_os = "Android"             
        elsif(@palmpre && @palmpre>0)
          @mobile_os = "WebOS" 
        elsif(@berry && @berry>0)
          @mobile_os = "BlackBerry OS"         
        elsif(@ipod && @ipod>0)
          @mobile_os = "iOS"   
        elsif(@ipad && @ipad>0)
          @mobile_os = "iOS" 
        elsif(@windows && @windows>0)
          @mobile_os = "Windows"
        end
      end
    else
      "Other"
    end
  end

  def accept_headers
    request.env["HTTP_ACCEPT"] ? request.env["HTTP_ACCEPT"].match(/([^,]+)/) : ''
  end

  def latitude
    get_address=Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
    get_address.lat
  end

  def longitude
    get_address=Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
    get_address.lng
  end

  def region
    get_address=Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
    (get_address.state).capitalize rescue nil
  end

  def city
    get_address=Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
    if get_address.city.present?
      (get_address.city).capitalize rescue nil
    else
      "Other"
    end
  end


  def country
    get_address=Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
    if get_address.country.present?
      (get_address.country).capitalize rescue nil
    else
      "Other"
    end
  end

  def server
    request.env["SERVER_SOFTWARE"].match(/([^()]+)/)
  end

  def platform
    if (request.env['HTTP_USER_AGENT'].match(/linux/i))
      platform = 'linux'
    elsif (request.env['HTTP_USER_AGENT'].match(/macintosh|mac os x/i))
      platform = 'mac'
    elsif (request.env['HTTP_USER_AGENT'].match(/windows|win32/i))
      platform = 'windows'
    else
      platform = 'other'    
    end  
  end


  def accept_encoding
    request.env["HTTP_ACCEPT_ENCODING"].match(/([^,]+)/)
  end

  def content_type
    request.env["HTTP_ACCEPT"] ? request.env["HTTP_ACCEPT"].match(/([^,]+)/) : ''
  end

  def http_referer    
    unless session['main_referer']
      session['main_referer'] = request.host_with_port
    else
      session['main_referer']
    end    
  end  

  def full_domain     
    session['referer'] = request.env["REQUEST_URI"]     
  end


end