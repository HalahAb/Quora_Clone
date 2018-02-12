class User < ActiveRecord::Base
  has_many :questions, :foreign_key => :question_id
  has_many :answers, :foreign_key => :answer_id

  validates :username, :password, presence: true
  validates :username, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :password, format: { with: /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/,
    message: "invalid format: Minimum eight characters, at least one letter and one number" }
  

end