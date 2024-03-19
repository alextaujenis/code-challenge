class BirdsController < ApplicationController
  def search
    all_node_ids = Node.all_children_ids(Bst.new(), params.require(:node_ids))
    all_bird_ids = Bird.includes(:nodes).where(nodes: { id: all_node_ids }).pluck(:id).uniq
    render json: { bird_ids: all_bird_ids }
  end
end
