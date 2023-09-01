class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can %i[index show], User
    can %i[index new create show], Post
    can %i[new create], Comment
    can %i[update destroy], Post, { author_id: user.id }
    can %i[update destroy], Comment, { author_id: user.id }
    can :manage, :all if user.is? :admin
  end
end
