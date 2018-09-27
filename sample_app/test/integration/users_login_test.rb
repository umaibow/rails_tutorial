require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	
	def setup
		#�e�X�g�p���[�U���擾
		@user = users(:sample)
	end
	
	#���O�C���G���[���b�Z�[�W�̃e�X�g
	test "login with invalid infomation" do
		#���O�C���̃p�X���J��
		get login_path
		#new�y�[�W�̃t�H�[�����\������Ă��邩
		assert_template 'sessions/new'
		#�����ȃp�����[�^�𑗐M
		post login_path, params:{session: {email: "", password: "" } }
		#new�y�[�W�ɃG���[���b�Z�[�W���\������Ă��邩
		assert_not flash.empty?
		#Home�y�[�W�Ɉړ�
		get root_path
		#�G���[���b�Z�[�W�������Ă��邩
		assert flash.empty?
	end
	
	#���C�A�E�g�ύX�̃e�X�g
	test "changed layout with login" do
		#���O�C���̃p�X���J��
		get login_path
		#���O�C������
		post login_path, params:{session: {email:@user.email, password: 'password' } }
		#���O�C�����m�F
		assert is_logged_in?
		#���[�U�y�[�W���Ƀ��_�C���N�g���Ă���
		assert_redirected_to @user
		follow_redirect!
		#���[�U���j���[���\������Ă���
		assert_template 'users/show'
		#���O�C���̃����N�����݂��Ă��Ȃ�
		assert_select "a[href=?]", login_path, count: 0
		#���O�A�E�g�̃����N�����݂��Ă���
		assert_select "a[href=?]", logout_path
		#���[�U�����N�����݂��Ă���
		assert_select "a[href=?]", user_path(@user)
		#���O�A�E�g����
		delete logout_path
		#���O�A�E�g���m�F
		assert_not is_logged_in?
		#�z�[����ʂւ̑J�ڂ��m�F
		assert_redirected_to root_url
		follow_redirect!
		#���O�C���̃����N�����݂��Ă���
		assert_select "a[href=?]", login_path
		#���O�A�E�g�̃����N�����݂��Ă��Ȃ�
		assert_select "a[href=?]", logout_path, count:0
		#���[�U�����N�����݂��Ă��Ȃ�
		assert_select "a[href=?]", user_path(@user), count:0
	end
end
