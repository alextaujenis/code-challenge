class CommonAncestorController < ApplicationController
  def search
    common_ancestor = CommonAncestor.new(
      Node.find(params.require(:a)),
      Node.find(params.require(:b))
    })
    common_ancestor.run

    render json: common_ancestor.data
  end
end
