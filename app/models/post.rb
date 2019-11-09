class Post < ApplicationRecord
  validates :title, :name, :content, presence:true, length: { minimum: 3}
end
