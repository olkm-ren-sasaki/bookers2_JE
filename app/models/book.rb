class Book < ApplicationRecord
  # タグ機能用のgemとのアソシエーション
  acts_as_taggable
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  # 検索機能
  def self.ransackable_attributes(auth_object = nil)
    # ["body", "created_at", "id", "title", "updated_at", "user_id", "range", "search"]
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    # ["base_tags", "book_comments", "favorites", "tag_taggings", "taggings", "tags", "user"]
    %w[user tags]
  end

end
