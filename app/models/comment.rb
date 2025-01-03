class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true  # se for nil, será “comentário anônimo”

  validates :content, presence: true
end
