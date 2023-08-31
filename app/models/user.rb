class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0 }

  def is?(requested_role)
    role == requested_role.to_s
  end

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  before_create :default_post_counter
  def default_post_counter
    post_counter || 0
  end
end
