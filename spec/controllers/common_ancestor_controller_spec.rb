describe CommonAncestorController, type: :request do
  describe "GET #index" do
    let (:expected_data) do
      { hello: "world" }
    end

    it "responds with json" do
      get "/common_ancestor"
      expect(response.body).to eq(expected_data.to_json)
    end
  end
end
