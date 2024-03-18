describe Bst, type: :model do
  it "can be created" do
    expect { described_class.new }.to_not raise_error
  end

  describe "with an input array" do
    let(:input_array) { [ 5, 7, 2, 3, 9, 4, 1 ] }
    let(:bst) { Bst.new(input_array) }

    describe "include?" do
      describe "with an included value" do
        let(:value) { 3 }

        it "returns true" do
          expect(bst.include?(value)).to eq(true)
        end
      end

      describe "with an excluded value" do
        let(:value) { 6 }

        it "returns false" do
          expect(bst.include?(value)).to eq(false)
        end
      end
    end
  end
end
