module Api
    class AwsController < ActionController::API
        def index
          render :plain => 'AWS'
        end
      end
  end 