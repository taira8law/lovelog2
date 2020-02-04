class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :lover
  
  validates :content, presence: true, length: {maximum: 32768}
  validates :activity_date, presence: true
end
