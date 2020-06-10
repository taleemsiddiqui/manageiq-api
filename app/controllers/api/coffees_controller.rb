module Api
    class CoffeesController < ActionController::API
        def index
          render :plain => 'Coffee'
        end
      end
  end 