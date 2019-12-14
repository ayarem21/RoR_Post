class Like < ApplicationRecord
  belongs_to :comment, dependent: :destroy
  belongs_to :author, dependent: :destroy
end
