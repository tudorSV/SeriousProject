class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user
    elsif current_user.admin
      admin(current_user)
    elsif
      employee(current_user)
    else
      guest(current_user)
    end
  end

  private

  def admin(current_user)
    can :manage, :all
  end

  def employee(current_user)
    can :manage, User, id: current_user.id
    can :manage, Company, employees: { user_id: current_user.id }
    can :manage, Shop, employees: { user_id: current_user.id }
    can :manage, Employee, user_id: current_user.id
  end

  def guest(current_user)
    can :create, User
  end
end
