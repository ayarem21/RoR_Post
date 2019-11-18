class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :author, :author_id
  end
end
