class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title,
            presence: true,
            length: { minimum: 5 }
  validates :lead,
            presence: true,
            length: { minimum: 5, maximum: 200 }
  validates :body,
            presence: true,
            length: { minimum: 5 }
end
