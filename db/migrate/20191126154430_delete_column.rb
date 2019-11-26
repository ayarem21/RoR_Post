class DeleteColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :author_id
  end
end
