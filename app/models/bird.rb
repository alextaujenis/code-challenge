class Bird < ApplicationRecord
  has_and_belongs_to_many :nodes
  validates :name, presence: true, uniqueness: true
end
