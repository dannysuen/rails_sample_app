module UsersHelper

  def gravatar_for(user, options = { size: 80 })
    gravatar_url = gravatar_url_for(user, options)
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def gravatar_url_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

end
