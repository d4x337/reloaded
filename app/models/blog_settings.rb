class BlogSettings < ActiveRecord::Base
  attr_accessible :blog_id, :border_color, :text_color, :background_color, :allow_comments
end
