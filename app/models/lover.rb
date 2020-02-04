class Lover < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: {maximum: 255}
  has_many :activities, dependent: :destroy
end