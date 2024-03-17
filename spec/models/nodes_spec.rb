describe Nodes, type: :model do
  let(:nodes) { Nodes.new(file_path: "./spec/data/nodes.csv") }

  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end

  describe "all" do
    let(:expected_data) do
      {
        'id' => 'parent_id',
        '125' => '130',
        '130' => nil,
        '2820230' => '125',
        '4430546' => '125',
        '5497637' => '4430546'
      }
    end

    it "returns the nodes" do
      expect(nodes.all).to eq(expected_data)
    end
  end

  describe "find_parent" do
    let(:child_id) { "4430546" }
    let(:parent_id) { "125" }

    it "returns the parent_id" do
      expect(nodes.find_parent(child_id)).to eq(parent_id)
    end
  end

  describe "all_parents" do
    describe "with a leaf node" do
      let(:child_id) { "5497637" }
      let(:expected_data) { [ '4430546', '125', '130' ] }

      it "returns all parents" do
        expect(nodes.all_parents(child_id)).to eq(expected_data)
      end
    end

    describe "with a root node" do
      let(:child_id) { "130" }
      let(:expected_data) { [ ] }

      it "returns no parents" do
        expect(nodes.all_parents(child_id)).to eq(expected_data)
      end
    end
  end
end
