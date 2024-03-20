describe Bird, type: :model do
  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end

  describe "valid?" do
    let(:name) { Faker::Creature::Bird.plausible_common_name }
    let(:bird) { Bird.new(name: name) }
    subject { bird.valid? }

    describe "with a valid bird" do
      it "returns true" do
        expect(subject).to eq(true)
      end
    end

    describe "with a missing name" do
      let(:name) { nil }

      it "returns false" do
        expect(subject).to eq(false)
      end
    end

    describe "with a duplicate name" do
      before(:each) { Bird.create(name: name) }

      it "returns false" do
        expect(subject).to eq(false)
      end
    end
  end

  describe "with many nodes" do
    let!(:node1) { Node.create(id: 1) }
    let!(:node2) { Node.create(id: 2, parent_id: 1) }
    let!(:bird) { Bird.create(name: Faker::Creature::Bird.plausible_common_name, nodes: nodes) }
    let(:nodes) { [ node1, node2 ] }

    it "has many nodes" do
      expect(bird.nodes).to eq(nodes)
    end

    it "belongs to many nodes" do
      expect(node1.birds).to include(bird)
      expect(node2.birds).to include(bird)
    end
  end
end
