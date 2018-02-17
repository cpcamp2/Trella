class Task < ApplicationRecord
  validates :content, presence: true, length: {minimum: 3, maximum: 250}

  belongs_to :user
end