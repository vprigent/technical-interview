require 'uri'

class ShortenedUrl < ApplicationRecord
  ACTIVE_DURATION = 30.days

  validate :origin_is_url_format?

  validates_presence_of :origin

  # don't generate this short unless origin is already valid
  # drawback, this is the only place we know we are setting the short value, so no extra validation beyond this point. Could use a db check though.
  after_validation :generate_short

  scope :active, -> { where("created_at > ?", ACTIVE_DURATION.ago) }

  private

  def generate_short
    random = SecureRandom.base64(10)
    # avoids collision, if any short url is already used, regen the random number.
    while ShortenedUrl.find_by(short: random).present?
      random = SecureRandom.base64(10)
    end

    self.short = random
  end

  def origin_is_url_format?
    URI.parse(origin)&.host.present?
  rescue URI::InvalidURIError
    self.errors.add(:origin, "URL is not the right format")
    false
  end
end
