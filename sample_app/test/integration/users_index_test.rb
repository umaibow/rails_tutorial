require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	
	def setup
		@admin = users(:sample)
		@non_admin = users(:sample2)
	end
	
	test "index including pagination" do
		
		#ログイン
		log_in_as(@admin)
		#ユーザ一覧ページを取得
		get users_path
		#フォームの確認
		assert_template 'users/index'
		#ページネーションの確認
		assert_select 'div.pagination'
		#最初のページのユーザを取得
		first_page_of_users = User.paginate(page:1)
		first_page_of_users.each do |user|
			
			#リンクとテキストを確認
			assert_select 'a[href=?]', user_path(user), text: user.name
			#管理者以外のユーザ
			unless user == @admin
				
				#削除ボタンの確認
				assert_select 'a[href=?]', user_path(user), text: 'delete'
				
			end
			
		end
		
		#ユーザ数が減ったのを確認
		assert_difference 'User.count', -1 do
			delete user_path(@non_admin)
		end
	end
	
	test "index as non-admin" do
		
		#ログイン
		log_in_as(@non_admin)
		#ユーザ一覧へ
		get users_path
		#デリートボタンが存在していない
		assert_select 'a', text: 'delete', count: 0
		
	end
	
end
