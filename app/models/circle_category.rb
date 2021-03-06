class CircleCategory < ApplicationRecord
  belongs_to :circle
  belongs_to :category
  validates :circle_id, presence: true
  validates :category_id, presence: true
  default_scope -> {order("priority ASC")}
end
