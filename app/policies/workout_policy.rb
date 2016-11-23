class WorkoutPolicy < ApplicationPolicy 

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end
  
  def show? 
    admin_or_mine
  end

  def edit?
    admin_or_mine
  end

  def update?
    admin_or_mine
  end

  def destroy? 
    admin_or_mine
  end

  private

  def admin_or_mine 
    user.admin? || record.user == user
  end
end