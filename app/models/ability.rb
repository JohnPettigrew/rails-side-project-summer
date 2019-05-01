# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [User, Project]

    if user
      can :manage, User, id: user.id
      can :create, Project
      can :manage, Project, user_id: user.id
      cannot :admin, User
      cannot :admin, Project

      if user.admin?
        can :manage, Project
        can :manage, User
      end
    end
  end
end
