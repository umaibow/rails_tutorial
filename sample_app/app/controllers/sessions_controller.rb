class SessionsController < ApplicationController
	def new
	end
	
	def create
		#email���烆�[�U�[������
		user = User.find_by(email: params[:session][:email].downcase)
		#�p�X���[�h���r
		if user && user.authenticate(params[:session][:password])
			#���O�C��
			log_in user
			#�����L�����邩�ǂ���
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			#���O�C����ۑ�
			remember user
			#���[�U�[�y�[�W�Ƀ��_�C���N�g
			redirect_to user
		else
			#�G���[���b�Z�[�W���ꎞ�����\��
			flash.now[:danger] = 'Invalid email/password combination'
			#new�y�[�W��
			render 'new'
		end
	end
	
	def destroy
		#���O�A�E�g
		log_out if logged_in?
		#�z�[����ʂֈړ�
		redirect_to root_url
	end
end
