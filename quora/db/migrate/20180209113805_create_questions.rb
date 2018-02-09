class CreateQuestions < ActiveRecord::Migration[5.1]

  def change
    create_table :questions do |t|
      t.integer :user_id
      # t.belongs_to :user, foreign_key: true
      t.text :title
      t.text :description
      t.timestamps
   end

  end
  
end

