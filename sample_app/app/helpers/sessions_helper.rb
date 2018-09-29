module SessionsHelper
	#ユーザーでログイン
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#ユーザのセッションを保存
	def remember(user)
		#トークンを発行
		user.remember
		#クッキーにトークンを保存
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	
	#現在ログイン中のユーザー
	def current_user
		#IDからユーザーを検索
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
			
		end
	end
	
	#ログイン中かどうか
	def logged_in?
		!current_user.nil?
	end
	
	#クッキーから削除
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	
	#ログアウト
	def log_out
		#クッキーに保存された情報を破棄する
		forget(current_user)
		#セッションから削除
		session.delete(:user_id)
		#現在のユーザは空
		@current_user = nil
	end
end
