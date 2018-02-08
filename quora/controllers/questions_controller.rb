

get '/' do
  erb :"home"
end

#get a form to create a question
get '/questions/new' do
  erb :"new"
end

#get a question
get '/questions/:id' do

  @question = Question.find(params[:id])
  erb :"show"

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
	erb :"questions"
end



#show a form to edit an existing question
get "/questions/:id/edit" do 
  @id = params[:id]   
  @question = Question.find(params[:id])
  erb :"edit"
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

  erb :"delete"
end




delete "/questions/:id/delete" do 
  @id = params[:id]  # => 4 5 6 
  @question = Question.find(params[:id])

      if @question
      @question.destroy
       erb :"delete"
    else
    "Sorry, there was an error that question does not exist!"
  end


 
end





