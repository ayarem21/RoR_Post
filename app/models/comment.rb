class Comment < ApplicationRecord
  has_ancestry

  belongs_to :post
  belongs_to :author
  has_many :likes, dependent: :destroy
end
