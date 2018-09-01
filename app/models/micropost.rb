class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader #CarrierWave
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size # custom validatos, build-in Rails validator

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      error.add(:picture, "should be less than 5MB")
    end
  end
end
