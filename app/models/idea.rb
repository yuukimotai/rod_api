class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments

  def self.search_by_content(word)
      @ideas = Idea.where('content LIKE ?',"%#{word}%")
  end
  def self.search_by_username(word)
      #@ideas = Idea.where("username LIKE?","%#{word}%")
      @ideas = Idea.joins(:user).where('users.username LIKE ?', "%#{word}%")
  end
end
