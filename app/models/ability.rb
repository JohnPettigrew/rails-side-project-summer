class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # define user when not logged in

    if user.id # logged in
      can :manage, User
#      can :manage, User, :user_id => user.id
    end

    can [:read, :show], :all
  end

  def initialize(project)
    project ||= Project.new

    if project.id
      can :read, Project
      can :manage, Project, :project_id => project.id
    end

    can [:read, :show], :all
  end
end
