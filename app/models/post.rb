class Post < ApplicationRecord
    has_one_attached :image ,dependent: :destroy
    has_many :likes , dependent: :destroy

end

