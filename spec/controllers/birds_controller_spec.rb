# not ready for factories...
def bird_name
  Faker::Creature::Bird.implausible_common_name
end

describe BirdsController, type: :request do
  describe "POST /birds" do
    subject { post "/birds", params: params }
    before(:all) do
      node1 = Node.create(id: 1) # root node: not selected
      node2 = Node.create(id: 2, parent_id: 1) # selected
      node3 = Node.create(id: 3, parent_id: 2) # selected
      node4 = Node.create(id: 4, parent_id: 3) # child
      node5 = Node.create(id: 5, parent_id: 2) # child
      node6 = Node.create(id: 6, parent_id: 1) # not selected
      Bird.create(id: 1, nodes: [ node1 ], name: bird_name)
      Bird.create(id: 2, nodes: [ node2 ], name: bird_name)
      Bird.create(id: 3, nodes: [ node3 ], name: bird_name)
      Bird.create(id: 4, nodes: [ node4 ], name: bird_name)
      Bird.create(id: 5, nodes: [ node5 ], name: bird_name)
      Bird.create(id: 6, nodes: [ node6 ], name: bird_name)
    end

    describe "with an array of node ids" do
      let(:params) { { node_ids: [ 2, 3 ] } }
      let(:expected_data) { { bird_ids: [ 2, 3, 4, 5 ] } }

      it "return the ids of the birds that belong to one of those nodes or any descendant nodes" do
        subject
        expect(response.body).to eq(expected_data.to_json)
      end
    end
  end
end