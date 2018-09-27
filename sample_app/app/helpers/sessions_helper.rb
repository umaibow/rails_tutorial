module SessionsHelper
	#���[�U�[�Ń��O�C��
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#���݃��O�C�����̃��[�U�[
	def current_user
		#ID���烆�[�U�[������
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end
	
	#���O�C�������ǂ���
	def logged_in?
		!current_user.nil?
	end
	
	#���O�A�E�g
	def log_out
		#�Z�b�V��������폜
		session.delete(:user_id)
		#���݂̃��[�U�͋�
		@current_user = nil
	end
end
