class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attr_accessor :tag_names

  after_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).join(", ")
  end

  private

  def assign_tags
    if @tag_names.present?
      self.tags = @tag_names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
      end
    end
  end
end