module Notifications
  class Create
  	attr_accessor :params, :receiver_id

  	def initialize params, receiver_id
  		@params, @receiver_id = params, receiver_id
  	end

  	def call
  	end

  end
end
