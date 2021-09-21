class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end

  def add?
    user.id != record.user_id
  end

  def index
    byebug
    record&.first&.user_id == user.id || nil
  end
end
