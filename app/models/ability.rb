class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user
      if current_user.admin
        admin
      end
    else
      guest
    end
  end

  private

  def admin
    can :manage, :all
  end

  def employee
  end

  def guest
    can :read, :all
  end
end
