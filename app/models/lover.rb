class Lover < ApplicationRecord
#  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :name, presence: true, length: {maximum: 255}
  has_many :activities, dependent: :destroy
end