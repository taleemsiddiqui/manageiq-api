module Api
    class CoffeesController < ActionController::API
        def index
          #render :plain => 'Coffee'
          url = URI.parse('http://34.67.132.139:9000/aws/resources/regions')
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
            }
            
            render :json => {message: res.body}
        end
      end
  end 