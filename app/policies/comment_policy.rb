class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.id != record.product.user_id
  end

  def edit?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end
end
