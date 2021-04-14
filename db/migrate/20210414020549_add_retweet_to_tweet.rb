class AddRetweetToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :retweet_id, :integer
  end
end
