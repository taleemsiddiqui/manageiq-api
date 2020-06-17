module Api
    class IcecreamsController < ActionController::API
  
        #URL = "http://cloudmanagement.me"
        URL = "http://localhost"
      
      def index
  
        # path = "#{URL}:11000/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"
        path = "#{URL}:10000/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"
        url = URI.parse(path)
              req = Net::HTTP::Get.new(url.to_s)
              res = Net::HTTP.start(url.host, url.port) {|http|
                http.request(req)
              }
              
        render :json => res.body
      end
    end
  end
  