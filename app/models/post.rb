class Post < ApplicationRecord
  validates :title, :content, presence:true, length: { minimum: 3}
  belongs_to :author, :foreign_key => :author_id

end
