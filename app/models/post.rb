class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  def self.search_by_content(word)
      @posts = Post.where("content LIKE?","%#{word}%")
  end
  def self.search_by_username(word)
      #@posts = Post.where("username LIKE?","%#{word}%")
      @posts = Post.joins(:user).where('users.username LIKE ?', "%#{word}%")
  end
end
