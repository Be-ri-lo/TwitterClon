class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, class_name: "Tweet", optional: true
  validates :user_id, uniqueness: {scope: :tweet_id}  #con esta validacion hace que no se repita el like dos veces.
end
