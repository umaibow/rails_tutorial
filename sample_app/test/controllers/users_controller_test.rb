require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	
	def setup
		
		@user = users(:sample)
		@other_user = users(:sample2)
		
	end
	
	test "should get new" do
		get signup_path
		assert_response :success
	end
	
	test "should redirect edit when not logged in" do
		
		#編集ページを取得
		get edit_user_path(@user)
		#メッセージが表示されている
		assert_not flash.empty?
		#ログインページにリダイレクト
		assert_redirected_to login_url
		
	end
	
	test "should redirect update when not logged in" do
		#誤ったログイン情報を入力
		patch user_path(@user), params: {user: {	name: @user.name,
													email: @user.email } }
		#メッセージが表示されている
		assert_not flash.empty?
		#ログインページにリダイレクト
		assert_redirected_to login_url
	end
	
	test "should redirect edit when logged in wrong user" do
		
		#異なるユーザでログイン
		log_in_as(@other_user)
		#別のユーザの編集ページを取得
		get edit_user_path(@user)
		#メッセージが表示されていない
		assert flash.empty?
		#ホーム画面へ戻る
		assert_redirected_to root_url
		
	end
	
	test "should redirect update when logged in as wrong user" do
		
		#異なるユーザでログイン
		log_in_as(@other_user)
		#別のユーザ情報に変更を送信
		patch user_path(@user), params: { user: {	name:	@user.name,
													email:	@user.email } }
		#メッセージが表示されていない
		assert flash.empty?
		#ホーム画面へ戻る
		assert_redirected_to root_url
		
	end
	
	test "should redirect index when not logged in" do
		
		#ユーザ一覧
		get users_path
		#ログインページへのリダイレクト
		assert_redirected_to login_url
		
	end
	
	test "should redirect destroy when not logged in" do
		
		#ユーザ数が変化しないか
		assert_no_difference 'User.count' do
			
			#ユーザを削除
			delete user_path(@user)
			
		end
		#ログイン画面へ
		assert_redirected_to login_url
		
	end
	
	test "should redirect destroy when logged in as a non-admin" do
		
		#別のユーザとしてログイン
		log_in_as(@other_user)
		#ユーザ数が変化しないか
		assert_no_difference 'User.count' do
			
			#ユーザを削除
			delete user_path(@user)
			
		end
		#ホーム画面へ
		assert_redirected_to root_url
		
	end
	
end
