class CreateAnswers < ActiveRecord::Migration[5.1]

  def change
    create_table :answers do |t|
      

      t.integer :user_id
      t.integer :question_id
      # t.belongs_to :user, foreign_key: true
      # t.belongs_to :question, foreign_key: true
     

      t.text :description
      t.integer :number_up_votes
      t.integer :number_down_votes
      t.timestamps

   end

  end
  
end