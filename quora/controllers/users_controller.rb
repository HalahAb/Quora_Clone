get '/user/register' do
  @user = User.new
  erb :"users/new"
end

post '/user/register' do

  @user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation] )


  if @user.save
    # redirect '/questions/'+ @question.id.to_s
  else
    erb :"users/new"
  end 
end


post '/user/sign_in' do
  @user = User.find_by(username: params[:username], password: params[:password])

  if @user
    # cookies[:username] = params["username"]
    cookies[:user_id]= @user.id
    redirect "/"
  else
    "Could not find your username and or password try again or register."
  end

end