module Api
    class CoffeesController < BaseController 
        def index
            render :json => {message: "Test"}
        end
    end 
  end 