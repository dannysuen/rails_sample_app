class Api::V1::UsersController < Api::V1::BaseController

  def show
    @user = User.find(params[:id])

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @user
    @user.gravatar_url = gravatar_url_for(@user)
  end

  def index

    @users = User.paginate(page: params[:page], per_page: params[:per_page])
    # debugger
    @users.each do |user|
      user.gravatar_url = gravatar_url_for(user, size: 200)
    end

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @users
    @envelop[:pagination] = Hash.new

    current_page = params[:page].nil? ? 1 : params[:page].to_i

    # 是否是最后一页
    if @users.size == User.per_page && current_page * User.per_page < User.count
      @envelop[:pagination][:next_url] = api_v1_users_url(:page => current_page + 1)
    else
      @envelop[:pagination][:next_url] = nil
    end
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