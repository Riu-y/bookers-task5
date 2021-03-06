class Book < ApplicationRecord
  belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy

def self.search(search)
      return Post.all unless search
      Post.where(['content LIKE ?', "%#{search}%"])
    end

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
