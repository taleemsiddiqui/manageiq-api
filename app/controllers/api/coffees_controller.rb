module Api
  class CoffeesController < BaseController

    URL = "http://34.67.132.139:9000"
    
    def index
      render :json => "#{URL}/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"
    end
  end
end
