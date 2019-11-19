class Post < ApplicationRecord
  validates :title, :content, presence:true, length: { minimum: 3}
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_one_attached :file
  is_impressionable counter_cache: true
end
