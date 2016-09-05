module CSVGenerator
  def self.to_csv(model)
    CSV.generate do |csv|
      csv << ['Date', ]
      model.find_each do |item|
        csv << item.attributes.values_at(*model.column_names)
      end
    end
  end
end

#def self.to_csv(options = {})
#  CSV.generate(options) do |csv|
#    csv << column_names
#    all.each do |product|
#      csv << product.attributes.values_at(*column_names)
#    end
#  end
#end