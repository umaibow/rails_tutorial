require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:sample)
	end
	
	test "unsuccessful edit" do
		
		#���O�C������
		log_in_as(@user)
		#�ҏW�y�[�W���擾
		get edit_user_path(@user)
		#�e���v���[�g���m�F
		assert_template 'users/edit'
		#�����ȃf�[�^�ŕҏW
		patch user_path(@user), params: { user: {	name:					"",
													email:					"foo@invalid",
													password:				"foo",
													password_confirmation:	"bar" } }
		#�ҏW�y�[�W�ɗ��܂��Ă���
		assert_template 'users/edit'
	end
	
	test "successful edit" do
		
		#���O�C������
		log_in_as(@user)
		#�ҏW�y�[�W���擾
		get edit_user_path(@user)
		#�e���v���[�g���m�F
		assert_template 'users/edit'
		#�_�~�[�f�[�^
		name	= "Foo Bar"
		email	= "foo@bar.com"
		#�L���ȃf�[�^�ŕҏW
		patch user_path(@user), params: { user: {	name:					name,
													email:					email,
													password:				"",
													password_confirmation:	"" } }
		#�������b�Z�[�W���\������Ă���
		assert_not flash.empty?
		#���[�U�y�[�W�ւ̃��_�C���N�g���m�F
		assert_redirected_to @user
		#�ēǂݍ���
		@user.reload
		#���̍X�V���m�F
		assert_equal name,	@user.name
		assert_equal email,	@user.email
		
	end
	
	test "successful edit with friendly forwarding" do
		
		#�ҏW�y�[�W���擾
		get edit_user_path(@user)
		#���O�C��
		log_in_as(@user)
		#�ҏW�y�[�W�Ƀ��_�C���N�g���Ă���
		assert_redirected_to edit_user_url(@user)
		#�_�~�[�f�[�^
		name	= "Foo Bar"
		email	= "foo@bar.com"
		#�L���ȃf�[�^�ŕҏW
		patch user_path(@user), params: { user: {	name:					name,
													email:					email,
													password:				"",
													password_confirmation:	"" } }
		#�������b�Z�[�W���\������Ă���
		assert_not flash.empty?
		#���[�U�y�[�W�ւ̃��_�C���N�g���m�F
		assert_redirected_to @user
		#�ēǂݍ���
		@user.reload
		#���̍X�V���m�F
		assert_equal name,	@user.name
		assert_equal email,	@user.email
		
	end
	
end
