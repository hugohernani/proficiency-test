module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "School System"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def gravatar_for(student, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(student.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: student.name, class: "gravatar")
  end


end
