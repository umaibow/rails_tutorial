module SessionsHelper
	#���[�U�[�Ń��O�C��
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#���[�U�̃Z�b�V������ۑ�
	def remember(user)
		#�g�[�N���𔭍s
		user.remember
		#�N�b�L�[�Ƀg�[�N����ۑ�
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	
	#���݃��O�C�����̃��[�U�[
	def current_user
		#ID���烆�[�U�[������
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
			
		end
	end
	
	#���O�C�������ǂ���
	def logged_in?
		!current_user.nil?
	end
	
	#�N�b�L�[����폜
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	
	#���O�A�E�g
	def log_out
		#�N�b�L�[�ɕۑ����ꂽ����j������
		forget(current_user)
		#�Z�b�V��������폜
		session.delete(:user_id)
		#���݂̃��[�U�͋�
		@current_user = nil
	end
end
