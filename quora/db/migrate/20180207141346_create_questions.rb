class CreateQuestions < ActiveRecord::Migration[5.1]

  def change
    create_table :questions do |t|
      t.string :user_id
      t.text :title
      t.text :description
      t.timestamps
   end

  end
  
end