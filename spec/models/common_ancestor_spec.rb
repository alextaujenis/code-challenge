describe CommonAncestor, type: :model do
  it "can be created" do
    expect { described_class.new(node_a: nil, node_b: nil) }.to_not raise_error
  end

  describe "run" do
    let!(:node_130) { Node.create!(id: 130) }
    let!(:node_125) { Node.create!(id: 125, parent_id: 130) }
    let!(:node_2820230) { Node.create!(id: 2820230, parent_id: 125) }
    let!(:node_4430546) { Node.create!(id: 4430546, parent_id: 125) }
    let!(:node_5497637) { Node.create!(id: 5497637, parent_id: 4430546) }
    let(:common_ancestor) { CommonAncestor.new(node_a: node_a, node_b: node_b) }

    # /common_ancestor?a=5497637&b=2820230 should return
    # {root_id: 130, lowest_common_ancestor: 125, depth: 2}
    describe "with two nodes" do
      let(:node_a) { node_5497637 }
      let(:node_b) { node_2820230 }
      let(:expected_data) { { root_id: 130, lowest_common_ancestor: 125, depth: 2 } }

      it "returns the data" do
        expect(common_ancestor.data).to eq(expected_data)
      end
    end

    # /common_ancestor?a=5497637&b=130 should return
    # {root_id: 130, lowest_common_ancestor: 130, depth: 1}
    describe "with a node and the root node" do
      let(:node_a) { node_5497637 }
      let(:node_b) { node_130 }
      let(:expected_data) { { root_id: 130, lowest_common_ancestor: 130, depth: 1 } }

      it "returns the data" do
        expect(common_ancestor.data).to eq(expected_data)
      end
    end

    # /common_ancestor?a=5497637&b=4430546 should return
    # {root_id: 130, lowest_common_ancestor: 4430546, depth: 3}
    describe "with a parent node and leaf node" do
      let(:node_a) { node_5497637 }
      let(:node_b) { node_4430546 }
      let(:expected_data) { { root_id: 130, lowest_common_ancestor: 4430546, depth: 3 } }

      it "returns the data" do
        expect(common_ancestor.data).to eq(expected_data)
      end
    end

    # /common_ancestor?a=9&b=4430546 should return
    # {root_id: null, lowest_common_ancestor: null, depth: null}
    describe "with no common node match" do
      let(:node_a) { nil }
      let(:node_b) { node_4430546 }
      let(:expected_data) { { root_id: nil, lowest_common_ancestor: nil, depth: nil } }

      it "returns null for all fields" do
        expect(common_ancestor.data).to eq(expected_data)
      end
    end

    # /common_ancestor?a=4430546&b=4430546 should return
    # {root_id: 130, lowest_common_ancestor: 4430546, depth: 3}
    describe "when node_a is equal to node_b" do
      let(:node_a) { node_4430546 }
      let(:node_b) { node_4430546 }
      let(:expected_data) { { root_id: 130, lowest_common_ancestor: 4430546, depth: 3 } }

      it "returns itself" do
        expect(common_ancestor.data).to eq(expected_data)
      end
    end
  end
end
