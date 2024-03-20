describe Node, type: :model do
  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end

  describe "parent_node" do
    let!(:parent_node) { Node.create(id: 1) }
    let(:node) { Node.create(id: 2, parent_id: 1) }

    it "returns the parent node" do
      expect(node.parent_node).to eq(parent_node)
    end
  end

  describe "with many birds" do
    let!(:bird1) { Bird.create(name: Faker::Creature::Bird.plausible_common_name) }
    let!(:bird2) { Bird.create(name: Faker::Creature::Bird.plausible_common_name) }
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

  describe "with existing nodes" do
    let!(:node1) { Node.create(id: 1) }
    let!(:node2) { Node.create(id: 2, parent_id: 1) }
    let!(:node3) { Node.create(id: 3, parent_id: 2) }
    let!(:node4) { Node.create(id: 4, parent_id: 3) }
    let!(:node5) { Node.create(id: 5, parent_id: 4) }
    let!(:node6) { Node.create(id: 6, parent_id: 5) }
    let!(:node7) { Node.create(id: 7, parent_id: 3) }
    let!(:node8) { Node.create(id: 8, parent_id: 7) }

    describe "all_parents" do
      let(:expected_data) { [ node4, node3, node2, node1 ] }

      it "returns all parents" do
        expect(node5.all_parents).to match_array(expected_data)
      end
    end

    describe "self.all_children_ids" do
      let(:expected_data) { [ 4, 5, 6, 7, 8 ] }

      it "returns all children ids" do
        expect(Node.all_children_ids(Set.new, Set[ 4, 7 ])).to match_array(expected_data)
      end
    end
  end
end
