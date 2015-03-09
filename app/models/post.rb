class Post < ActiveRecord::Base
  validates_presence_of :author_id, :content
  belongs_to :author
end
