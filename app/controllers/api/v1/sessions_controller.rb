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

      render status: 201 # Created
    else
      @envelop = Hash.new
      @envelop[:meta] = { :code => 400,
                          :error_message => 'Invalid email/password combination.',
                          :error_type => 'AuthException' }
      @envelop[:data] = nil
      @envelop[:pagination] = Hash.new
      @envelop[:pagination][:next_url] = nil

      render status: 400 # Bad Request
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end