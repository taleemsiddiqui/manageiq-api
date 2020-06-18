module Api
    class IcecreamsController < ActionController::API
  
        #URL = "http://cloudmanagement.me"
        URL = "http://localhost:10000"
      
      def index

        is_valid = true

        is_valid = false if params[:command].nil? || params[:command].blank?
        is_valid = false if params[:template].nil? || params[:template].blank?
        is_valid = false if params[:workspace].nil? || params[:workspace].blank?

        unless is_valid
          render :json => {error: true, message: "Please provide the required params."}
        else 
          # path = "#{URL}:11000/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"
          path = "#{URL}/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"
          url = URI.parse(path)
                req = Net::HTTP::Get.new(url.to_s)
                res = Net::HTTP.start(url.host, url.port) {|http|
                  http.request(req)
                }
                
          render :json => res.body
        end
        
      end
    end
  end
  