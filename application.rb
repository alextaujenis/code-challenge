Dir["./app/models/**/*.rb"].each {|file| require file }

nodes = Nodes.new(file_path: "./data/nodes.csv")

print nodes.all.keys.length
print nodes.all
