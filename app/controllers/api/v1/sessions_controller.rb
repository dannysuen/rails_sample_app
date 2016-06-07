class Api::V1::SessionsController < Api::V1::BaseController

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      @envelop = Hash.new
      @envelop[:meta] = { :code => 200 }
      @envelop[:data] = @user
      @user.gravatar_url = gravatar_url_for(@user)
      @envelop[:pagination] = Hash.new
      @envelop[:pagination][:next_url] = nil
    else
      @envelop = Hash.new
      @envelop[:meta] = { :code => 400 }
      @envelop[:data] = @user
      @user.gravatar_url = gravatar_url_for(@user)
      @envelop[:pagination] = Hash.new
      @envelop[:pagination][:next_url] = nil
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end