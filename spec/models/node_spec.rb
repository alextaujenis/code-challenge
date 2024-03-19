describe Node, type: :model do
  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end
end
