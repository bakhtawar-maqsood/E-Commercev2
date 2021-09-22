# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user.id == record.user_id
  end

  def show_order_history?
    user.id == record.id
  end

  def show_my_products?
    user.id == record.id
  end
end
