# /usr/bin/bash

search-cmd install browser_details
search-cmd install page_titles
search-cmd install browser_histories
search-cmd install projects
search-cmd install companies
search-cmd install employees
search-cmd install pages
search-cmd install users
search-cmd install funnels


  def search_by(query)
    q = []
    ret = query.delete(:ret) || "id"
    query.each_pair do |index, val|
      val = val.blank? ? 0 : val
      q.push [index, val].join(':')
    end
    q = q.join(', ')
    search = Ripple.client.search("#{self.to_s.tableize}",q)
    (search["response"]["docs"] || []).map { |doc| doc["fields"][ret] }
  end