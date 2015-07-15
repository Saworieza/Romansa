class Post < ActiveRecord::Base
	belongs_to :user
	has_many :votes, dependent: :destroy
	has_many :comments

	cattr_accessor :current_user
end
