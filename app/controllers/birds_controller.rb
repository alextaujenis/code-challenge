class BirdsController < ApplicationController
  def search
    all_node_ids = Node.all_children_ids(Set.new, Set.new(params.require(:node_ids)))
    all_bird_ids = Bird.includes(:nodes).where(nodes: { id: all_node_ids }).distinct.pluck(:id)
    render json: { bird_ids: all_bird_ids }
  end
end
