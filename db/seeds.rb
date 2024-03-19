# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# only seed the database if it's empty
if Node.count == 0
  # don't insert the csv header row
  first_row = true
  CSV.foreach("./data/nodes.csv") do |row|
    if first_row
      first_row = false
    else
      Node.create({
        id: row[0],
        parent_id: row[1]
      })
    end
  end
end
