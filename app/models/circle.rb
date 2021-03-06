class Circle < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :picture, presence: true
  validates :header_picture, presence: true

  has_many :members, through: :memberships, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :blogs
  has_many :events
  has_many :contacts, foreign_key: "receive_circle_id", dependent: :destroy

  # カテゴリー関連
  has_many :categories, through: :circle_categories
  has_many :circle_categories, dependent: :destroy

  # メンバー申請関連
  has_many :entrying_users, through: :entries, source: :user
  has_many :entries, dependent: :destroy

  # 気になる関連
  has_many :favorited_users, through: :favorites, source: :user
  has_many :favorites, dependent: :destroy

  # 新歓日程
  has_many :welcome_event_schedules

  # 画像関連
  mount_uploader :picture, PictureUploader
  validate  :picture_size
  mount_uploader :header_picture, PictureUploader
  validate  :header_picture_size

  scope :ascend, -> { order(:id) }

  acts_as_taggable_on :joining_colleges

  def display_categories
    response = ""
    self.categories.each do |c|
      response += "/" if !response.blank?
      response += c.name
    end
    response
  end

  def be_member?(user)
    self.members.ids.include?(user.id)
  end
  def find_membership(user)
    self.memberships.find_by(member_id: user.id)
  end

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    def header_picture_size
      if header_picture.size > 5.megabytes
        errors.add(:header_picture, "should be less than 5MB")
      end
    end
end
