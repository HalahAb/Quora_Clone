#show all answers for a specific question
get '/questions/:id/answers' do
  @id = params[:id] 
  @answers = Answer.where("question_id = ?", params[:id])
  @question = Question.find(params[:id])

  # Question.destroy_all
  erb :"answers/answers"

end



#get a form to answer a specific question
get '/questions/:id/answer' do
  @id = params[:id]   
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = ?", params[:id])
  erb :"answers/new"
end


#submit an answer
post '/questions/:id/answers' do

@question = Question.find(params[:id])
@answer = Answer.new(description: params[:description], question_id: params[:id])
@answer.save

# params[:description].to_s + " ID"+ params[:id].to_s

  if @answer.save
    redirect '/questions/'+ @question.id.to_s+'/answers'
  else
    "Sorry, there was an error!"
  end 

end



#delete an answer to a specific question

delete "/questions/:id/answers/:answerid/delete" do 
  
  @question = Question.find(params[:id]) 
  @answers = Answer.where("question_id = ?", params[:id])
  @findanswer = Answer.find(params[:answerid])

 if @findanswer
      @findanswer.destroy
      erb :"answers/answers"
    else
    "Sorry, there was an error that question does not exist!"
  end


  # redirect '/questions/'+ @question.id.to_s+'/answers'
end


