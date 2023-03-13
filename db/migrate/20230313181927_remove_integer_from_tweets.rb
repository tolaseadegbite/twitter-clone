class RemoveIntegerFromTweets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tweets, :integer, :string
  end
end
