class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :post_counter, :email, :role
  has_many :posts
end
