

get '/' do
  erb :"home"
end

#get a form to create a question
get '/questions/new' do
  erb :"questions/new"
end

#get a question
get '/questions/:id' do

  @question = Question.find(params[:id])
  erb :"questions/show"

end


#store a question
post '/submit' do
	@question = Question.new(description: params[:description], title: params[:title] )


	if @question.save
		redirect '/questions/'+ @question.id.to_s
	else
		"Sorry, there was an error!"
	end 
end


#show all questions
get '/questions' do
	@questions = Question.all
  # Question.destroy_all
  #Answer.destroy_all
	erb :"questions/questions"
end



#show a form to edit an existing question
get "/questions/:id/edit" do 
  @id = params[:id]   
  @question = Question.find(params[:id])
  erb :"questions/edit"
end


# store an updated question
post "/questions/:id" do 
  @question = Question.find(params[:id])

  @question.title = params[:title]
  @question.description = params[:description]

  if @question.save
    redirect '/questions/'+ @question.id.to_s
  else
    "Sorry, there was an error!"
  end 

end


get "/questions/:id/delete" do 
  @id = params[:id]   
  @question = Question.find(params[:id])

  erb :"questions/delete"
end




delete "/questions/:id/delete" do 
  @id = params[:id]
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = ?", params[:id])

      if @question
      @question.destroy
      @answers.destroy
       erb :"questions/delete"
    else
    "Sorry, there was an error that question does not exist!"
  end


 
end





