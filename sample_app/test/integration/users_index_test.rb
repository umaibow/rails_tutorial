require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
	
	def setup
		@admin = users(:sample)
		@non_admin = users(:sample2)
	end
	
	test "index including pagination" do
		
		#���O�C��
		log_in_as(@admin)
		#���[�U�ꗗ�y�[�W���擾
		get users_path
		#�t�H�[���̊m�F
		assert_template 'users/index'
		#�y�[�W�l�[�V�����̊m�F
		assert_select 'div.pagination'
		#�ŏ��̃y�[�W�̃��[�U���擾
		first_page_of_users = User.paginate(page:1)
		first_page_of_users.each do |user|
			
			#�����N�ƃe�L�X�g���m�F
			assert_select 'a[href=?]', user_path(user), text: user.name
			#�Ǘ��҈ȊO�̃��[�U
			unless user == @admin
				
				#�폜�{�^���̊m�F
				assert_select 'a[href=?]', user_path(user), text: 'delete'
				
			end
			
		end
		
		#���[�U�����������̂��m�F
		assert_difference 'User.count', -1 do
			delete user_path(@non_admin)
		end
	end
	
	test "index as non-admin" do
		
		#���O�C��
		log_in_as(@non_admin)
		#���[�U�ꗗ��
		get users_path
		#�f���[�g�{�^�������݂��Ă��Ȃ�
		assert_select 'a', text: 'delete', count: 0
		
	end
	
end
