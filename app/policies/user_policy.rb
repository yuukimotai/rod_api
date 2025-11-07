class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    return true if user.is_a?(Admin)
    false
  end
end