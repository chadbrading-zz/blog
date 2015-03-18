class ChangeTimeColumnToDatetimeOnPosts < ActiveRecord::Migration
  def up
    change_column :posts, :publish_time, :datetime
  end

  def down
    change_column :posts, :publish_time, :time
  end
end
