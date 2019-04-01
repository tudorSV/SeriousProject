class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user
      if current_user.admin
        admin(current_user)
      else
        employee(current_user)
      end
    else
      guest(current_user)
    end
  end

  private

  def admin(current_user)
    can :manage, :all
  end

  def employee(current_user)
    cannot :manage, User
    can :manage, Company, employees: { user_id: current_user.id }
    can :manage, Shop, employees: { user_id: current_user.id }
    can :manage, Employee, user_id: current_user.id
  end

  def guest(current_user)
    can :create, User
    cannot :manage, Company
    cannot :manage, Shop
    cannot :manage, Employee
  end
end
