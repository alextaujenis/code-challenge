class CommonAncestorController < ApplicationController
  def search
    if a.present? && a > 0 && b.present? && b > 0
      common_ancestor = CommonAncestor.new({
        node_a: Node.find(a),
        node_b: Node.find(b)
      })
      common_ancestor.run
      render json: common_ancestor.data
    else
      render json: { error: "Required parameter(s) missing: ?a=1&b=2" }
    end
  end

  private

  def a
    @_a ||= params[:a].try(:to_i)
  end

  def b
    @_b ||= params[:b].try(:to_i)
  end
end
