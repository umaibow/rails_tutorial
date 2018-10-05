class UsersController < ApplicationController
	
	#編集前にログインを確認
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	#ユーザを確認
	before_action :correct_user, only: [:edit, :update]
	#管理者を確認
	before_action :admin_user, only: :destroy
	
	def index
		@users = User.paginate(page: params[:page])
	end
	
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			#保存成功
			#ログイン
			log_in @user
			#成功時のメッセージ表示
			flash[:success] = "Welcome to the Sample App!"
			#ユーザーページへリダイレクト
			redirect_to @user
		else
			#保存失敗
			render 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			#成功のメッセージを表示
			flash[:success] = "Profile updated"
			#ユーザページにリダイレクト
			redirect_to @user
		else
			#更新に失敗
			render 'edit'
		end
	end
	
	def destroy
		
		#ユーザを削除
		User.find(params[:id]).destroy
		#メッセージを表示
		flash[:success] = "User deleted"
		#ユーザ一覧へリダイレクト
		redirect_to users_url
		
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
	
	#beforeアクション
	def logged_in_user
		#ログイン中か
		unless logged_in?
			
			#アクセスしたいURLを保存
			store_location
			#警告を表示
			flash[:danger] = "Please log in."
			#ログインページにリダイレクト
			redirect_to login_url
		end
	end
	
	#正しいユーザかどうか
	def correct_user
		
		#ユーザを取得
		@user = User.find(params[:id])
		#間違えていたらホーム画面へ戻る
		redirect_to(root_url) unless current_user?(@user)
		
	end
	
	#管理者かどうか
	def admin_user
		
		#違ったらホーム画面へ
		redirect_to(root_url) unless current_user.admin?
		
	end
	
end
