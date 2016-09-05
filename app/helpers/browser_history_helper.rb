module BrowserHistoryHelper

  def ip_address   
    request.remote_ip    
  end

  def user_agent_os
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.os
  end

  def browser
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.browser
  end

  def main_domain 
    request.env["HTTP_HOST"]    
  end

  def full_domain 
    "#{request.env['HTTP_HOST']}/#{request.env['REQUEST_PATH']}"   
  end

  def device
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"]) 
    user_agent.mobile? ? 'Mobile' : 'Desktop'
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
end
