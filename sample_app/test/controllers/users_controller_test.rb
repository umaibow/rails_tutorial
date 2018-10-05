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
		
		#�ҏW�y�[�W���擾
		get edit_user_path(@user)
		#���b�Z�[�W���\������Ă���
		assert_not flash.empty?
		#���O�C���y�[�W�Ƀ��_�C���N�g
		assert_redirected_to login_url
		
	end
	
	test "should redirect update when not logged in" do
		#��������O�C���������
		patch user_path(@user), params: {user: {	name: @user.name,
													email: @user.email } }
		#���b�Z�[�W���\������Ă���
		assert_not flash.empty?
		#���O�C���y�[�W�Ƀ��_�C���N�g
		assert_redirected_to login_url
	end
	
	test "should redirect edit when logged in wrong user" do
		
		#�قȂ郆�[�U�Ń��O�C��
		log_in_as(@other_user)
		#�ʂ̃��[�U�̕ҏW�y�[�W���擾
		get edit_user_path(@user)
		#���b�Z�[�W���\������Ă��Ȃ�
		assert flash.empty?
		#�z�[����ʂ֖߂�
		assert_redirected_to root_url
		
	end
	
	test "should redirect update when logged in as wrong user" do
		
		#�قȂ郆�[�U�Ń��O�C��
		log_in_as(@other_user)
		#�ʂ̃��[�U���ɕύX�𑗐M
		patch user_path(@user), params: { user: {	name:	@user.name,
													email:	@user.email } }
		#���b�Z�[�W���\������Ă��Ȃ�
		assert flash.empty?
		#�z�[����ʂ֖߂�
		assert_redirected_to root_url
		
	end
	
	test "should redirect index when not logged in" do
		
		#���[�U�ꗗ
		get users_path
		#���O�C���y�[�W�ւ̃��_�C���N�g
		assert_redirected_to login_url
		
	end
	
	test "should redirect destroy when not logged in" do
		
		#���[�U�����ω����Ȃ���
		assert_no_difference 'User.count' do
			
			#���[�U���폜
			delete user_path(@user)
			
		end
		#���O�C����ʂ�
		assert_redirected_to login_url
		
	end
	
	test "should redirect destroy when logged in as a non-admin" do
		
		#�ʂ̃��[�U�Ƃ��ă��O�C��
		log_in_as(@other_user)
		#���[�U�����ω����Ȃ���
		assert_no_difference 'User.count' do
			
			#���[�U���폜
			delete user_path(@user)
			
		end
		#�z�[����ʂ�
		assert_redirected_to root_url
		
	end
	
end
