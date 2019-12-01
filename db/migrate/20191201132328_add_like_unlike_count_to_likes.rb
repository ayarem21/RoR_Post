class AddLikeUnlikeCountToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :likes_count, :integer
    add_column :likes, :unlikes_count, :integer
  end
end
