class Post < ActiveRecord::Base
  validates_presence_of :author_id, :content
  belongs_to :author
  has_attached_file :photo, styles: {medium: "300x300>", thumb: "100x100>" }, default_url: "missing"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
