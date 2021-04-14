class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :name, presence: true

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy
  
  def to_s
    email
    avatar  
  end 

  def friend?(user)
    !!self.friends.find{|friend| friend.id == user.id}
  end

  #paginates_per  10
end
