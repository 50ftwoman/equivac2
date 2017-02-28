class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.string :contact
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
