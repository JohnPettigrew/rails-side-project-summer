# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed-in user here.
    can :read, [User, Project]

    if user
      can :create, Project
      can :manage, Project, user_id: user.id
      can :manage, User, id: user.id

      if user.admin?
        can :manage, Project
        can :manage, User
      end
    end
  end
end
