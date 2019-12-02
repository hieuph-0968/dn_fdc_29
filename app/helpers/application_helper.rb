module ApplicationHelper
  def full_title page_title = ""
    page_title
  end

  def load_count_post topic_id
    Post.count_post_by_topic topic_id
  end
end
