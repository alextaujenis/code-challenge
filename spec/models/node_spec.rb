describe Node, type: :model do
  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end

  describe "with many birds" do
    let!(:bird1) { Bird.create(name: Faker::Creature::Bird.implausible_common_name) }
    let!(:bird2) { Bird.create(name: Faker::Creature::Bird.implausible_common_name) }
    let!(:node) { Node.create(id: 1, birds: birds) }
    let(:birds) { [ bird1, bird2 ] }

    it "has many birds" do
      expect(node.birds).to eq(birds)
    end

    it "belongs to many birds" do
      expect(bird1.nodes).to include(node)
      expect(bird2.nodes).to include(node)
    end
  end
end
