module SluggableNolly
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    # slug_base = to_slug self.slug_input
    slug_base = to_slug self.send(self.slug_column)
    the_slug = ''
    count = 1

    loop do # find a unique slug
      the_slug = append_suffix(slug_base, count)
      slugable = self.class.find_by slug: the_slug
      break if slugable.nil? || slugable == self
      count += 1
    end

    self.slug = the_slug
  end

  def append_suffix(slug_base, count)
    slug_base + (count > 1 ? "-#{count}" : "")
  end

  def to_slug(str)
    # self.slug = self.title.gsub(' ', '-').downcase
    # self.slug = CGI::escape(self.slug_input.gsub(' ', '-').downcase)
    # str.downcase.gsub(/\s*[^a-z0-9]\s*/, '-').gsub(/-+/, '-').gsub(/^-|-$/, '')
    str.downcase.gsub(/\W+/, '-').gsub(/^-|-$/, '')
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end

