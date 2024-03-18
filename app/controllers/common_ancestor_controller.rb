class CommonAncestorController < ApplicationController
  def search
    common_ancestor = CommonAncestor.new({
      nodes: CodeChallenge::Application.config.nodes,
      node_a: params.require(:a),
      node_b: params.require(:b)
    })
    common_ancestor.run

    render json: common_ancestor.data
  end
end
