module CustomSearch

  def search_by(query, options= {})
    q = []
    ret = query.delete(:ret) || "id"
    query.each_pair do |index, val|
      val = val.blank? ? 0 : val
      value = val.to_s.gsub(/([^a-z,A-Z,0-9,_,-,\*])/, '\\\\\1')
      q.push [index, value].join(':')
    end
    q = q.join(' AND ')
    search = Ripple.client.search("#{self.to_s.tableize}",q, options.merge({rows: 1000}))
    return search["response"]["numFound"] if options[:count]
    (search["response"]["docs"] || []).map { |doc| doc[ret] || doc["fields"][ret] }
  end


  def for_project(key_or_project, options = {})
    key = key_or_project.respond_to?(:key) ? key_or_project.key : key_or_project
    result = self.search_by({project_id: key}, options) 
    return result if options[:count]
    self.find result
  end
end


