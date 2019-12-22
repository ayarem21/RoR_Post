class Post < ApplicationRecord
  validates :title, :content, presence: true, length: { minimum: 3}
  validates :file, presence: true

  belongs_to :author
  has_many :comments, dependent: :destroy

  has_one_attached :file

  is_impressionable counter_cache: true

  def self.search(search)
    where("title LIKE ? OR content LIKE ?", "%#{search}%","%#{search}%")
  end
end
