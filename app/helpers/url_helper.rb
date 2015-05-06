module UrlHelper  
  	def with_subdomain(subdomain)  
	  	subdomain = (subdomain || "")  
	  	subdomain += "." unless subdomain.empty?  
	  	[subdomain, request.domain(2), request.port_string].join  
	end

  	def url_for(options = nil)  
	  	if options.kind_of?(Hash) && options.has_key?(:subdomain)  
	  		raise options.inspect
	    	options[:host] = with_subdomain(options.delete(:subdomain))  
	  	end  
  		super  
    end    
end  



