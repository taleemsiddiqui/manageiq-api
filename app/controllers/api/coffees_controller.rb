module Api
  class CoffeesController < ActionController::API

    URL = "http://35.224.44.23:9000"
    
    def index

      path = "#{URL}/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"
      url = URI.parse(path)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
              http.request(req)
            }      
            
      render :json => res.body
    end

    def test_resource(type, id = nil, _data = nil)
      render :plain => 'test'
    end
  end
end
