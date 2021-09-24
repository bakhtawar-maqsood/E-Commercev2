# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.id != record.order_item.product.user_id
  end

  def order_history?
    user.id == record.first.user_id
  end
end
