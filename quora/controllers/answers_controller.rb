#show all answers for a specific question
get '/questions/:id/answers' do
  @answers = Answer.where("question_id = ?", params[:id])
  @question = Question.find(params[:id])

  # Question.destroy_all
  erb :"answers/answers"

end



#get a form to answer a specific question
get '/questions/:id/answer' do
  if cookies[:user_id].present? 
    @question = Question.find(params[:id])
    @answers = Answer.where("question_id = ?", params[:id])
    erb :"answers/new"

  else
    @display_sign_in_error =  true
    erb :"home"
  end

end


#submit an answer
post '/questions/:id/answers' do

if cookies[:user_id].present?
    @question = Question.find(params[:id])
    @answer = Answer.new(description: params[:description], question_id: params[:id], user_id: cookies[:user_id])
    @answer.save

    # params[:description].to_s + " ID"+ params[:id].to_s

      if @answer.save
        redirect '/questions/'+ @question.id.to_s+'/answers'
      else
        "Sorry, there was an error!"
      end 
else
  @display_sign_in_error =  true
  erb :"home"
end

end



#delete an answer to a specific question

delete "/questions/:id/answers/:answerid/delete" do 
  if cookies[:user_id].present?
        
        @question = Question.find(params[:id]) 
        @answers = Answer.where("question_id = ?", params[:id])
        @findanswer = Answer.find(params[:answerid])
      
    if @findanswer
        if (@findanswer.user_id == cookies[:user_id].to_i)
          @findanswer.destroy
          erb :"answers/answers"
        else 
          "Sorry, you must be logged in to delete this answer!"
        end 
    else
      "Sorry, there was an error that answer does not exist!"
    end


  else
    @display_sign_in_error =  true
    erb :"home"
  end
  # redirect '/questions/'+ @question.id.to_s+'/answers'
end


