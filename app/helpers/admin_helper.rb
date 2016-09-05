module AdminHelper

  def desktop_users
    BrowserDetail.search_by(project_id: @project.key, device: "Desktop").length rescue nil 
  end

  def mobile_users
    BrowserDetail.search_by(project_id: @project.key, device: "Mobile").length rescue nil
  end

  def lang_count
    data = BrowserDetail.search_by(project_id: @project.key, ret: "language").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def country_count
    data = BrowserDetail.search_by(project_id: @project.key, ret: "country").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def city_count
    data = BrowserDetail.search_by(project_id: @project.key, ret: "city").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def browser_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Desktop", ret: "browser_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def platform_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Desktop", ret: "platform").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def operating_system_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Desktop", ret: "os_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def mobile_device_type_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Mobile", ret: "user_agent").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def mobile_browser_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Mobile", ret: "browser_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def mobile_platform_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Mobile", ret: "platform").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

  def mobile_operating_system_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Mobile", ret: "os_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
    if !(data.nil?)
      Hash[data.sort_by{|k, v| v}.reverse] 
    end
  end

end
