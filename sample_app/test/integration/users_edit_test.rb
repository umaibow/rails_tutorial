require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:sample)
	end
	
	test "unsuccessful edit" do
		
		#ログインする
		log_in_as(@user)
		#編集ページを取得
		get edit_user_path(@user)
		#テンプレートを確認
		assert_template 'users/edit'
		#無効なデータで編集
		patch user_path(@user), params: { user: {	name:					"",
													email:					"foo@invalid",
													password:				"foo",
													password_confirmation:	"bar" } }
		#編集ページに留まっている
		assert_template 'users/edit'
	end
	
	test "successful edit" do
		
		#ログインする
		log_in_as(@user)
		#編集ページを取得
		get edit_user_path(@user)
		#テンプレートを確認
		assert_template 'users/edit'
		#ダミーデータ
		name	= "Foo Bar"
		email	= "foo@bar.com"
		#有効なデータで編集
		patch user_path(@user), params: { user: {	name:					name,
													email:					email,
													password:				"",
													password_confirmation:	"" } }
		#完了メッセージが表示されている
		assert_not flash.empty?
		#ユーザページへのリダイレクトを確認
		assert_redirected_to @user
		#再読み込み
		@user.reload
		#情報の更新を確認
		assert_equal name,	@user.name
		assert_equal email,	@user.email
		
	end
	
	test "successful edit with friendly forwarding" do
		
		#編集ページを取得
		get edit_user_path(@user)
		#ログイン
		log_in_as(@user)
		#編集ページにリダイレクトしている
		assert_redirected_to edit_user_url(@user)
		#ダミーデータ
		name	= "Foo Bar"
		email	= "foo@bar.com"
		#有効なデータで編集
		patch user_path(@user), params: { user: {	name:					name,
													email:					email,
													password:				"",
													password_confirmation:	"" } }
		#完了メッセージが表示されている
		assert_not flash.empty?
		#ユーザページへのリダイレクトを確認
		assert_redirected_to @user
		#再読み込み
		@user.reload
		#情報の更新を確認
		assert_equal name,	@user.name
		assert_equal email,	@user.email
		
	end
	
end
