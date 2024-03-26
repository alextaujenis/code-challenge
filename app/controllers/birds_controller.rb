class BirdsController < ApplicationController
  def search
    if node_ids.present? && node_ids.kind_of?(Array)
      all_node_ids = Node.all_children_ids(node_ids) + node_ids
      all_bird_ids = Bird.includes(:nodes).where(nodes: { id: all_node_ids }).distinct.pluck(:id)
      render json: { bird_ids: all_bird_ids }
    else
      render json: { error: "Required parameter missing: { node_ids: [ ] }" }
    end
  end

  private

  def node_ids
    params[:node_ids]
  end
end
