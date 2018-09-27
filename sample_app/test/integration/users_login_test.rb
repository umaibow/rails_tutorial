require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	
	def setup
		#テスト用ユーザを取得
		@user = users(:sample)
	end
	
	#ログインエラーメッセージのテスト
	test "login with invalid infomation" do
		#ログインのパスを開く
		get login_path
		#newページのフォームが表示されているか
		assert_template 'sessions/new'
		#無効なパラメータを送信
		post login_path, params:{session: {email: "", password: "" } }
		#newページにエラーメッセージが表示されているか
		assert_not flash.empty?
		#Homeページに移動
		get root_path
		#エラーメッセージが消えているか
		assert flash.empty?
	end
	
	#レイアウト変更のテスト
	test "changed layout with login" do
		#ログインのパスを開く
		get login_path
		#ログインする
		post login_path, params:{session: {email:@user.email, password: 'password' } }
		#ログインを確認
		assert is_logged_in?
		#ユーザページがにリダイレクトしている
		assert_redirected_to @user
		follow_redirect!
		#ユーザメニューが表示されている
		assert_template 'users/show'
		#ログインのリンクが存在していない
		assert_select "a[href=?]", login_path, count: 0
		#ログアウトのリンクが存在している
		assert_select "a[href=?]", logout_path
		#ユーザリンクが存在している
		assert_select "a[href=?]", user_path(@user)
		#ログアウトする
		delete logout_path
		#ログアウトを確認
		assert_not is_logged_in?
		#ホーム画面への遷移を確認
		assert_redirected_to root_url
		follow_redirect!
		#ログインのリンクが存在している
		assert_select "a[href=?]", login_path
		#ログアウトのリンクが存在していない
		assert_select "a[href=?]", logout_path, count:0
		#ユーザリンクが存在していない
		assert_select "a[href=?]", user_path(@user), count:0
	end
end
