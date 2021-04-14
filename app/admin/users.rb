ActiveAdmin.register User do
  permit_params :name, :email
  actions :all  


  filter :name

  index do 
    column :name
    column :email
    column :tweets do |user|
      user.tweets.count
    end

    column :likes do |user|
      user.tweets.size
    end

    column :retweet do |user|
      user.tweets.size
    end
    actions 
  end

  
  
end
