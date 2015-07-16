class Activity < ActiveRecord::Base
=begin  
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  attr_accessor :action, :trackable
=end

  @activities = PublicActivity::Activity.all
end
