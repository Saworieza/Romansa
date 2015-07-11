class Post < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :large => "350x350>", :medium => "200x200#", :thumb => "40x40>"}
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	cattr_accessor :current_user
	belongs_to :user
end
