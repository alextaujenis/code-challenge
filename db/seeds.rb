# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# generate the birds.csv file if it doesn't exist
birds_csv_file = "./data/birds.csv"
if !File.file?(birds_csv_file)
  CSV.open(birds_csv_file, "w") do |csv|
    # insert header row
    csv << [ "id", "name" ]
    # insert 50 birds
    50.times do |i|
      id = (i + 1).to_s
      name = Faker::Creature::Bird.plausible_common_name
      csv << [ id, name ]
    end
  end
end

# only seed the database if it's empty
if Node.count == 0 && Bird.count == 0
  # Nodes
  # don't insert the csv header row
  first_row = true
  CSV.foreach("./data/nodes.csv") do |row|
    if first_row
      first_row = false
    else
      Node.create!({
        id: row[0],
        parent_id: row[1]
      })
    end
  end

  # Birds
  # don't insert the csv header row
  first_row = true
  CSV.foreach("./data/birds.csv") do |row|
    if first_row
      first_row = false
    else
      Bird.create!({
        id: row[0],
        name: row[1]
      })
    end
  end

  # BirdsNodes
  # don't insert the csv header row
  first_row = true
  CSV.foreach("./data/birds_nodes.csv") do |row|
    if first_row
      first_row = false
    else
      bird = Bird.find(row[0])
      bird.nodes.push(Node.find(row[1]))
      bird.save!
    end
  end
end
