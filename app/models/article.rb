class Article < ApplicationRecord
    validates :title, presence: true, length:{minimum: 6, maximum: 50}
    validates :body, presence: true
    belongs_to :user
end
