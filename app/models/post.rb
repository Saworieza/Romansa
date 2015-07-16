class Post < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: ->(controller, model) {controller && controller.current_user}

	#as_attached_file :avatar, :styles => { :large => "580x360#", :medium => "420x420>", :thumb => "150x150>" }
  	#validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	
	cattr_accessor :current_user

	belongs_to :user
	has_many :votes, dependent: :destroy
	has_many :comments

end
