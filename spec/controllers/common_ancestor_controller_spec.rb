describe CommonAncestorController, type: :request do
  describe "GET #index" do
    let (:expected_data) do
      {
        root_id: 1045177,
        lowest_common_ancestor: 2138651,
        depth: 4
      }
    end

    it "responds with the expected_data" do
      get "/common_ancestor?a=2138692&b=2138651"
      expect(response.body).to eq(expected_data.to_json)
    end
  end
end
