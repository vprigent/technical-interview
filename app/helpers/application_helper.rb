module ApplicationHelper

  def generate_from_short shortened_url
    "http://localhost:3000/#{shortened_url.short}"
  end
end
