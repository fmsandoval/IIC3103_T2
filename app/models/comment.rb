class Comment < ApplicationRecord
  belongs_to :post
  validates :commenter,
            presence: true,
            length: { minimum: 5 }
  validates :body,
            presence: true,
            length: { minimum: 5 }

  def as_json options={}
    {
        id: self.id,
        author: self.commenter,
        comment: self.body,
        created_at: self.created_at
    }
  end

end
