module Api
  class CoffeesController < ActionController::API

    #URL = "http://cloudmanagement.me"
    URL = "http://localhost"
    
    def index

      #path = "#{URL}:9000/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"
      path = "#{URL}:6000/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"
      url = URI.parse(path)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
              http.request(req)
            }      
            
      render :json => res.body
    end
  end
end
