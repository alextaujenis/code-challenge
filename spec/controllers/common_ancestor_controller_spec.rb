describe CommonAncestorController, type: :request do
  describe "GET #index" do
    let!(:node_130) { Node.create!(id: 130) }
    let!(:node_125) { Node.create!(id: 125, parent_id: 130) }
    let!(:node_2820230) { Node.create!(id: 2820230, parent_id: 125) }
    let!(:node_4430546) { Node.create!(id: 4430546, parent_id: 125) }
    let!(:node_5497637) { Node.create!(id: 5497637, parent_id: 4430546) }

    let (:expected_data) do
      {
        root_id: 130,
        lowest_common_ancestor: 125,
        depth: 2
      }
    end

    it "responds with the expected_data" do
      get "/common_ancestor?a=5497637&b=2820230"
      expect(response.body).to eq(expected_data.to_json)
    end
  end
end
