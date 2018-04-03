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

  def as_json options={}
    {
        id: self.id,
        title: self.title,
        subtitle: self.lead,
        body: self.body,
        created_at: self.created_at
    }
  end

  def short_body
    if self.body.length <= 500
      return self.body
    end
    short = self.body[0..499]
    short << '...'
    return short
  end

end
