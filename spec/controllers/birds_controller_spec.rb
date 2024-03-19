# not ready for factories...
def bird_name
  Faker::Creature::Bird.implausible_common_name
end

describe BirdsController, type: :request do
  describe "POST /birds" do
    subject { post "/birds", params: params }
    let(:response_data) { JSON.parse(response.body).symbolize_keys }
    before(:each) do
      node1 = Node.create(id: 1) # root node
      node2 = Node.create(id: 2, parent_id: 1)
      node3 = Node.create(id: 3, parent_id: 2)
      node4 = Node.create(id: 4, parent_id: 3)
      node5 = Node.create(id: 5, parent_id: 2)
      node6 = Node.create(id: 6, parent_id: 1)
      Bird.create(id: 1, nodes: [ node1 ], name: bird_name)
      Bird.create(id: 2, nodes: [ node2 ], name: bird_name)
      Bird.create(id: 3, nodes: [ node3 ], name: bird_name)
      Bird.create(id: 4, nodes: [ node4 ], name: bird_name)
      Bird.create(id: 5, nodes: [ node5 ], name: bird_name)
      Bird.create(id: 6, nodes: [ node6 ], name: bird_name)
      Bird.create(id: 7, nodes: [ node1 ], name: bird_name)
    end

    describe "with an array of node ids" do
      let(:params) { { node_ids: [ 2, 3 ] } }
      let(:expected_data) { [ 2, 3, 4, 5 ] }

      it "returns the ids of the birds that belong to one of those nodes or any descendant nodes" do
        subject
        expect(response_data[:bird_ids]).to match_array(expected_data)
      end
    end

    describe "with all node ids" do
      let(:params) { { node_ids: [ 1, 2, 3, 4, 5, 6 ] } }
      let(:expected_data) { [ 1, 2, 3, 4, 5, 6, 7 ] }

      it "returns all bird ids" do
        subject
        expect(response_data[:bird_ids]).to match_array(expected_data)
      end
    end

    describe "without node ids" do
      let(:params) { { node_ids: [ ] } }
      let(:expected_data) { [ ] }

      it "returns no bird ids" do
        subject
        expect(response_data[:bird_ids]).to match_array(expected_data)
      end
    end
  end
end