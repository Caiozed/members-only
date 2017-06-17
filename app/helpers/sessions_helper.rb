module SessionsHelper

	def log_in(user)
		user.remember_token = User.new_token
  	cookies.permanent.signed[:remember_token] = user.remember_token
  	cookies.permanent.signed[:user_id] = user.id
  	user.update_attribute(:remember_digest, User.digest(user.remember_token))
  	current_user
	end

	def log_out
		current_user.update_attribute(:remember_digest, nil)
  	cookies.delete :remember_token
  	cookies.delete :user_id
  	redirect_to root_path
  end

  def is_logged_in?
		!current_user.nil?
	end

	def current_user
		current_user ||= User.find_by(id: cookies.signed[:user_id])
			if current_user && current_user.authenticated?(:remember, cookies.signed[:remember_token])
				current_user 
			end
	end
end
