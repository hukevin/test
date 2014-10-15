class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :posts
  has_many :group_users
  has_many :participated_groups, :through => :group_users, :source => :group

  def join!(group)
  	participated_groups << group
  end

  def quit!(group)
  	participated_groups.delete(group)
  end
  
  def is_member_of?(group)
    participated_groups.include?(group)
  end
end
