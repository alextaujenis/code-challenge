class CommonAncestorController < ApplicationController
  def search
    common_ancestor = CommonAncestor.new({
      node_a: Node.find(params.require(:a).to_i),
      node_b: Node.find(params.require(:b).to_i)
    })
    common_ancestor.run

    render json: common_ancestor.data
  end
end
