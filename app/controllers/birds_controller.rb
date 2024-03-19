class BirdsController < ApplicationController
  def search
    render json: { bird_ids: [ 2, 3, 4, 5 ] }
  end
end
