class Api::V1::MicropostsController < Api::V1::BaseController

  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: params[:per_page])

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @microposts
    @envelop[:pagination] = Hash.new

    current_page = params[:page].nil? ? 1 : params[:page].to_i

    # debugger

    # 是否是最后一页
    if @microposts.size == Micropost.per_page && current_page * Micropost.per_page < @user.microposts.count
      @envelop[:pagination][:next_url] = api_v1_users_url(:user_id => params[:user_id], :page => current_page + 1)
    else
      @envelop[:pagination][:next_url] = nil
    end
  end

end