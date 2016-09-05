module SegmentationsHelper
  
  def unique_browsers
    BrowserDetail.search_by(project_id: @project.key, ret: "browser_name").inject([]) { |result,h| result << h unless result.include?(h); result } rescue nil
  end

  def unique_cities   
    BrowserDetail.search_by(project_id: @project.key, ret: "city").inject([]) { |result,h| result << h unless result.include?(h); result } rescue nil
  end

  def unique_countries   
    BrowserDetail.search_by(project_id: @project.key, ret: "country").inject([]) { |result,h| result << h unless result.include?(h); result } rescue nil
  end

  def unique_operating_systems   
    BrowserDetail.search_by(project_id: @project.key, ret: "os_name").inject([]) { |result,h| result << h unless result.include?(h); result } rescue nil
  end

  def seg_browser_count
    data = BrowserDetail.search_by(project_id: @project.key, ret: "browser_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil   
  end

  def seg_operating_system_count
    data = BrowserDetail.search_by(project_id: @project.key, device: "Desktop", ret: "os_name").inject(Hash.new(0)) { |total, e| total[e] += 1 ;total} rescue nil    
  end

end
