module SessionsHelper
	#ユーザーでログイン
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#現在ログイン中のユーザー
	def current_user
		#IDからユーザーを検索
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end
	
	#ログイン中かどうか
	def logged_in?
		!current_user.nil?
	end
	
	#ログアウト
	def log_out
		#セッションから削除
		session.delete(:user_id)
		#現在のユーザは空
		@current_user = nil
	end
end
