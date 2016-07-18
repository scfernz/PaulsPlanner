class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      # if no user logged in, use a dummy user, see later
      user = User.new
    end
    if user.has_role? :teacher
      can :manage, Task
      can :manage, Cohort
      can :index, Meeting
      can :show, Meeting, id: user.meetings.pluck(:id)
      can :map_markers, Meeting, id: user.meetings.pluck(:id)

    elsif user.has_role? :student
      can :manage, Task, user_id: user.id
      can :create, Meeting
      can :manage, Meeting, id: user.meetings.pluck(:id)
      cannot :index, Meeting
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
