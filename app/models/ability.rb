class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.feeder?
      can :manage, User, id: user.id
      can :manage, Variant
      can :manage, OptionValueVariant
    elsif user.consumer?
      can :manage, User, id: user.id
      can :read, Product
      can :read, OptionType
      can :read, OptionValue
      can :read, Variant
      can :read, OptionValueVariant
    end
  end
end
