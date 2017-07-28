module Slugable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug
  end

  def to_param
    self.slug
  end

  def generate_slug
    # self.slug = self.title.gsub(' ', '-').downcase
    self.slug = CGI::escape(self.slug_input.gsub(' ', '-').downcase)
  end
end

