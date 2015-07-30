require 'csv'
require 'pry'


def parse_csv(filename)
  keys = nil
  data = []
  CSV.foreach(filename) do |row|
    # set keys as the first row
    if keys.nil?
     keys = row.map{|k|
      k = "" if k.nil?
      k.downcase.strip.gsub(" ", '_')
      }
     next
    end

    item = {}
    row.each_with_index{|e, i|
      item[keys[i]] = e
    }
    data << item
  end
  data
end

# # name, email, JAN-DEC total sales
# "5-2015 Innovation Sales.xlsx"

# # name, total
# "2014 Kanata Sales.csv"

# # customer name, jan-dec 2014 (part 1 and 2)
# "2014 Richardson Sales 1 of 2.csv"
# "2014 Richardson Sales 2 of 2.csv"

# # customer name, 2014
# "2014 Tomax Sales.csv"

# # name, 2014
# "Perry Ellis 2014 Sales.xlsx"


# {
#   distributor: "Boundless Network LLC",
#   supplier: "Kanata",
#   total: "100"
# }


# {
#   distributor: "Boundless Network LLC",
#   suppliers: {
#     "Kanata" => 100,
#     "Tomax" => 0
#   }
# }



distributors = {}
filenames = %w(innovation.csv kanata.csv perry.csv richardson.csv tomax.csv)
supplier_names = filenames.map{|s| s.sub('.csv', '')}
filenames.each{|filename|
  path = File.join('/Users/cgenco/Downloads/AgeeSW', filename)
  data = parse_csv(path)
  # binding.pry
  data.each{|transaction|
    next unless transaction["name"]
    name = transaction["name"].strip
    distributors[name] ||= {}

    distributors[name][filename.sub('.csv', '')] = (transaction["total"] || '').gsub(/[\$\,]/, '').to_f
  }
}

puts (["distributor"] + supplier_names).to_csv
distributors.keys.sort.each{|distributor|
  suppliers = distributors[distributor]
  puts ([distributor] + supplier_names.map{|n| suppliers[n]}).to_csv
}
