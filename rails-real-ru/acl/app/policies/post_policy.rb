# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def create?
    user
  end

  def update?
    admin? || author?
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user&.admin?
  end

  def author?
    record.author == user
  end
  # END
end
