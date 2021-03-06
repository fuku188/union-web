class Notification < ApplicationRecord

  belongs_to :hold_user, class_name: "User"

  belongs_to :circle
  belongs_to :user
  belongs_to :blog

  validates :hold_user_id, presence: true
  enum notification_type: {followed: 0, new_user_blog: 1, favorited: 2, new_member: 3, contacted: 4}
end
