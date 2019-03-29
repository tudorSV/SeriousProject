class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user
      if current_user.admin
        admin
      else
        employee
      end
    else
      guest
    end
  end

  private

  def admin
    can :manage, User
    can :manage, Company
    can :manage, Shop
  end

  def employee
    can :read, User
    can :read, Shop   #, employees: { user_id: current_user.id }
    can :read, Company
  end

  def guest
  end
end
