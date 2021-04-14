class CreateTagsTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tags_tweets, :id => false do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
