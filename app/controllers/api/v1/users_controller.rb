class Api::V1::UsersController < Api::V1::BaseController

  def show
    @user = User.find(params[:id])

    @envelop = Hash.new
    @envelop[:meta] = { :code => 200 }
    @envelop[:data] = @user;
    @envelop[:pagination] = Hash.new
    @envelop[:pagination][:next_url] = nil
  end

end