class SessionsController < ApplicationController
	def new
	end
	
	def create
		#emailからユーザーを検索
		user = User.find_by(email: params[:session][:email].downcase)
		#パスワードを比較
		if user && user.authenticate(params[:session][:password])
			#ログイン
			log_in user
			#情報を記憶するかどうか
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			#ログインを保存
			remember user
			#ユーザーページにリダイレクト
			redirect_to user
		else
			#エラーメッセージを一時だけ表示
			flash.now[:danger] = 'Invalid email/password combination'
			#newページへ
			render 'new'
		end
	end
	
	def destroy
		#ログアウト
		log_out if logged_in?
		#ホーム画面へ移動
		redirect_to root_url
	end
end
