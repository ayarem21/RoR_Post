class AddColumnCounter < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :visit_count, :integer, default: 0
  end
end
