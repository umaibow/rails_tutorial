class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			#�ۑ�����
			#���O�C��
			login_@user
			#�������̃��b�Z�[�W�\��
			flash[:success] = "Welcome to the Sample App!"
			#���[�U�[�y�[�W�փ��_�C���N�g
			redirect_to @user
		else
			#�ۑ����s
			render 'new'
		end
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
