class SessionsController < ApplicationController
  def create
    user = User.find_by(email: auth_params[:email])

    if !!user && user.authenticate(auth_params[:password])
      jwt = Auth.issue({user_id: user.id})
      render json: {jwt: jwt, user_id: user.id, user_email: user.email, user_first_name: user.first_name}
    else
      render json: {error: 'Invalid login'}
    end
  end


   private
    def auth_params
      params.require(:user).permit(:email, :password)
    end

end
