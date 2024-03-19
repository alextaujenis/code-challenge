class Bird < ActiveRecord::Base
  has_and_belongs_to_many :nodes
end
