module Api
  class CoffeeController < ActionController::API
    def index
      render :plain => 'coffee'
    end
  end
end
