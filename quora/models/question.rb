class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :foreign_key => :answer_id
  
end