class AddPublishTimeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish_time, :TimeWithZone
  end
end
