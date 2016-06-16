class Api::V1::UsersController < Api::V1::BaseController

  def show
    @user = User.find(params[:id])

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @user
    @user.gravatar_url = gravatar_url_for(@user)
  end

  def index
    @users = User.paginate(page: params[:page])

    @users.each do |user|
      user.gravatar_url = gravatar_url_for(user, size: 200)
    end

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @users
    @envelop[:pagination] = Hash.new
    @envelop[:pagination][:next_url] = nil
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # redirect_to 'localhost:3000/api/v1/users/show'
      @envelop = Hash.new
      @envelop[:meta] = { :code => 200 }
      @envelop[:data] = @user
      @user.gravatar_url = gravatar_url_for(@user)
    else
      @envelop = Hash.new
      @envelop[:meta] = { :code => 400 }
      @envelop[:data] = @user
      @user.gravatar_url = gravatar_url_for(@user)
    end
  end

  # update方法的错误处理做得很好，其它方法应该参照一下
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      @envelop = Hash.new
      @envelop[:meta] = { :code => 200 }
      @envelop[:data] = @user
      @user.gravatar_url = gravatar_url_for(@user)
      render 'show'
    else
      @envelop = Hash.new
      @envelop[:meta] = {
          :code => 400,
          :error_type => 'ParamsInvalidException',
          :error_message => @user.errors.full_messages.first
      }
      render 'show', status: 400
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end