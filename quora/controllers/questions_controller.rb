

get '/' do
  erb :"home"
end

#get a form to create a question
get '/questions/new' do

  if cookies[:user_id].present?
     
     erb :"questions/new"
  else
    @display_sign_in_error =  true
    erb :"home"
  end
end

#get a question (Has a delete feature used after a user posts a question he can delete it)
get '/questions/:id' do

  @question = Question.find(params[:id])
  erb :"questions/show"

end


#store a question
post '/submit' do
  if cookies[:user_id].present?
  	@question = Question.new(description: params[:description], title: params[:title], user_id: cookies[:user_id] )
    	if @question.save

        # redirects to questions with the delete feature
    		redirect '/questions/'+ @question.id.to_s
    	else
    		"Sorry, there was an error!"
    	end 
  else
    @display_sign_in_error =  true
    erb :"home"
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
    
  @question = Question.find_by(id: params[:id], user_id: cookies[:user_id])
  if @question
    erb :"questions/edit"
  else
    @display_sign_in_error =  true
    erb :"home"
  end

end


# store an updated question
post "/questions/:id" do 
  @question = Question.find_by(id: params[:id], user_id: cookies[:user_id])
    if @question
      @question.title = params[:title]
      @question.description = params[:description]

      if @question.save
        redirect '/questions/'+ @question.id.to_s #redirects to questions view with delete button
      else
        "Sorry, there was an error!"
      end 
    else
      @display_sign_in_error =  true
      erb :"home"
    end
end

# This isn't doing anything #
get "/questions/:id/delete" do 
 
  @question = Question.find_by(id: params[:id], user_id: cookies[:user_id])
  
  if @question 
    erb :"questions/delete"
  else
    @display_sign_in_error =  true
    erb :"home"
  end

end




delete "/questions/:id/delete" do 
  @question = Question.find(params[:id])
  @answers = Answer.where("question_id = ?", params[:id])
  

  if @question
    if (@question.user_id == cookies[:user_id].to_i)
      @question.destroy
      @answers.destroy_all
       erb :"questions/delete"
       # redirect '/questions/'+@question.id.to_s+'/delete'
    else 
      "Sorry, you must be logged in to delete this question!"
    end 
  else
    "Sorry, there was an error that question does not exist!"
  end

end





