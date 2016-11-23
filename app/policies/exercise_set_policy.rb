class ExerciseSetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end

  def edit? 
    user.admin? || record.user == user
  end

  def update? 
    user.admin? || record.user == user
  end

  def destroy? 
    user.admin? || record.user == user
  end
end
