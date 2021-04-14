class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: 'Tweet', foreign_key: :retweet_id, dependent: :destroy
  belongs_to :tweet, class_name: 'Tweet', optional: true    
  
  validates :content, presence: :true, length: { maximum: 140}

  def to_s
      content
  end
  
  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def retweet?(user) 
    self.retweets.find{|retweet| retweet.user_id == user.id}
  end

  def content_with_hashtags #pendiente
      new_array = [] #contenido en un array
      self.content.split(" ").each do |word| #donde el espacio elemento de separacion o #. Iterar este array, y revisar si en cada palabra existe un #
        if word.start_with?("#") #si empieza con # y existe, se crea un link
          word_parsed = word.sub '#'
          word = link_to(word, Rails.application.routes.url_helpers.root_path+"?search="+word_parsed)
        end
        new_array.push(word) #y este link se retorna a su array vacio.
      end
      self.content = new_array.join(" ")
    end

    #paginate_per  25  
end
