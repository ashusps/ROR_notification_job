module NotificationsHelper
	def users_list
		([['All', 'all']] + User.all.map{|u| [u.email, u.id]}).flatten(0)
	end

	def importances_list
		Notification.importances.map { |k, v| [k, v]}
	end
end
