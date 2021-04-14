class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: 'Tweet', foreign_key: :retweet_id, dependent: :destroy
  belongs_to :tweet, class_name: 'Tweet', optional: true    
  scope :tweets_for_me, ->(friends) {where(user_id: friends)}

  has_and_belongs_to_many :tags

  validates :content, presence: :true, length: { maximum: 140}

  after_create do
      tweet = Tweet.find_by(id: self.id)
      hashtags = self.content.scan(/#\w+/)
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
      end
    end
  
      before_update do
      self.tags.clear
      hashtags = self.content.scan(/#\w+/)
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
        self.tags << tag
      end
    end  

  def to_s
      content
  end
  
  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def retweet?(user) 
    self.retweets.find{|retweet| retweet.user_id == user.id}
  end


    #paginate_per  25  
end
