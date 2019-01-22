class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content_max_length}
  validate  :picture_size

  private

  def picture_size
    return unless picture.size > Settings.micropost.max_size_image.megabytes
    errors.add :picture, t("should_be_less")
  end
end
