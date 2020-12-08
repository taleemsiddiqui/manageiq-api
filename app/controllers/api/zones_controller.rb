module Api
  class ZonesController < BaseController
    INVALID_ZONES_ATTRS = ID_ATTRS + %w[created_on updated_on].freeze

    # URL = "http://cloudmanagement.me:9000"
    # URL = "https://localhost:6000"
      URL = "https://cloudmanagement.me:9000"
    # URL2 = "http://cloudmanagement.me:11000"
    URL2 = "http://localhost:10000"
    URL3 = "https://cloudmanagement.me:1888"

    def cloudapi
      profile = request.headers["profile"]
      log_request("Profile", profile)
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
  	  http =Net::HTTP.start(url.host, url.port,:use_ssl => url.scheme == 'https')
   	  req = Net::HTTP::Get.new(url.to_s, {'profile' => profile,'Content-Type' =>'application/json'})

	  #req.body = data.to_json
    	  res = http.request(req)
          #url = URI.parse(path)
          #req = Net::HTTP::Get.new(url.to_s)
          #res = Net::HTTP.start(url.host, url.port) {|http|
          #  http.request(req)
          #}

          render :json => res.body

        rescue => exception
          render :json => exception
        end

      end
    end

    def orchestration

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

    def automation

      data = {}

      params.each {|key, val| data[key] = val if key != 'endpoint'}
              
      uri = URI("#{URL3}/#{params[:endpoint]}")
      http =Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') 
      #http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
  
      req.body = data.to_json
      res = http.request(req)
  
      render :json => res.body
  
    end
    # def coffee
    #   log_request("", "Coffee method called")
    #   render :plain => "ping pong"
    # end

    # def display_resource(type, id, data)
    #   log_request("", "display method called")
    #   log_request("", "display_resource method called data => type:#{type}, id: #{id},data:#{data}")
    # end

    # Edit an existing zone. Certain fields are meant for internal use only
    # and may not be edited. Attempting to edit one of the forbidden fields
    # will result in a bad request error.
    #
    def edit_resource(type, id, data)
      bad_attrs = data_includes_invalid_attrs(data)

      if bad_attrs.present?
        msg = "Attribute(s) '#{bad_attrs}' should not be specified for updating a zone resource"
        raise BadRequestError, msg
      end

      super
    end

    private

    # Check to see if any of the data attributes contain an invalid field.
    # Returns a list of invalid fields as a comma separated string that you
    # can use for error messages, or nil if the data argument is blank.
    #
    def data_includes_invalid_attrs(data)
      return nil unless data

      data.keys.select { |key| INVALID_ZONES_ATTRS.include?(key) }.compact.join(", ")
    end
  end
end
