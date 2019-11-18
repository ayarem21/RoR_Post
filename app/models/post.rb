class Post < ApplicationRecord

  validates :title, :content, presence:true, length: { minimum: 3}
  belongs_to :author
end
