class UsersController < ApplicationController
	
	#�ҏW�O�Ƀ��O�C�����m�F
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	#���[�U���m�F
	before_action :correct_user, only: [:edit, :update]
	#�Ǘ��҂��m�F
	before_action :admin_user, only: :destroy
	
	def index
		@users = User.paginate(page: params[:page])
	end
	
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
			log_in @user
			#�������̃��b�Z�[�W�\��
			flash[:success] = "Welcome to the Sample App!"
			#���[�U�[�y�[�W�փ��_�C���N�g
			redirect_to @user
		else
			#�ۑ����s
			render 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			#�����̃��b�Z�[�W��\��
			flash[:success] = "Profile updated"
			#���[�U�y�[�W�Ƀ��_�C���N�g
			redirect_to @user
		else
			#�X�V�Ɏ��s
			render 'edit'
		end
	end
	
	def destroy
		
		#���[�U���폜
		User.find(params[:id]).destroy
		#���b�Z�[�W��\��
		flash[:success] = "User deleted"
		#���[�U�ꗗ�փ��_�C���N�g
		redirect_to users_url
		
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
	
	#before�A�N�V����
	def logged_in_user
		#���O�C������
		unless logged_in?
			
			#�A�N�Z�X������URL��ۑ�
			store_location
			#�x����\��
			flash[:danger] = "Please log in."
			#���O�C���y�[�W�Ƀ��_�C���N�g
			redirect_to login_url
		end
	end
	
	#���������[�U���ǂ���
	def correct_user
		
		#���[�U���擾
		@user = User.find(params[:id])
		#�ԈႦ�Ă�����z�[����ʂ֖߂�
		redirect_to(root_url) unless current_user?(@user)
		
	end
	
	#�Ǘ��҂��ǂ���
	def admin_user
		
		#�������z�[����ʂ�
		redirect_to(root_url) unless current_user.admin?
		
	end
	
end
