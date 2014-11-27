require 'csv'

def read_csv(file)
  CSV.foreach(file) do |row|
    puts row.inspect
  end
end

read_csv('commandfx_2014.csv')
