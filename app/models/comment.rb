# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post
end
