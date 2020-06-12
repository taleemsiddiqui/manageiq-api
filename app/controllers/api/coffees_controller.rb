module Api
  class CoffeesController < BaseController

    URL = "http://34.67.132.139:9000/"
    
    def index

      path = "#{URL}/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"
      url = URI.parse(path)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
              http.request(req)
            }
            
      render :json => res.body
    end
  end
end
