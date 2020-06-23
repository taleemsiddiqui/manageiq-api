module Api
  class ZongsController < BaseController

    URL = "http://cloudmanagement.me:9000"
    URL2 = "http://cloudmanagement.me:11000"
    #URL = "http://localhost:6000"
    
    def coffee

      is_valid = true

      is_valid = false if params[:provider].nil? || params[:provider].blank?
      is_valid = false if params[:entity].nil? || params[:entity].blank?
      is_valid = false if params[:endpoint].nil? || params[:endpoint].blank?

      unless is_valid
        render :json => {error: true, message: "Please provide the required params."}
      else
        path = "#{URL}/#{params[:provider]}/#{params[:entity]}/#{params[:endpoint]}"

        begin
      
          url = URI.parse(path)
              req = Net::HTTP::Get.new(url.to_s)
              res = Net::HTTP.start(url.host, url.port) {|http|
                http.request(req)
              }
              
          render :json => res.body
          
        rescue => exception
          render :json => exception
        end
        
      end
    end

    def icecream

      is_valid = true

      is_valid = false if params[:command].nil? || params[:command].blank?
      is_valid = false if params[:template].nil? || params[:template].blank?
      is_valid = false if params[:workspace].nil? || params[:workspace].blank?

      unless is_valid
        render :json => {error: true, message: "Please provide the required params."}
      else
        # path = "#{URL}:11000/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"
        path = "#{URL2}/#{params[:command]}/#{params[:template]}/#{params[:workspace]}"

        begin
          url = URI.parse(path)
          req = Net::HTTP::Get.new(url.to_s)
          res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
          }

          render :json => res.body
        rescue => exception
          render :json => exception
        end


      end

    end
  end
end


