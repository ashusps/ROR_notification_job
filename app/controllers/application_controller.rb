class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	add_flash_types :errors, :notice, :alert

	def error_message! obj
	    arry = []
	    obj.errors.each { |e| arry.push(e.full_message)}
	    return arry.join(", ")
	end
end
