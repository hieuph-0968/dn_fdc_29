module UsersHelper
  def gravatar_for user
    image_tag("avatar.jpg", size: 60, alt: user.name, class: "gravatar")
  end
end
