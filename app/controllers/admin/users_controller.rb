class Admin::UsersController < Admin::DashboardController
  

  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  before_filter :get_updated_by, :only => [:create, :update]

  def index
    authorize! :read, user
    @q = User.search(params[:q])
    users = @q.result(:distinct => true).page params[:page]  
  end

  def show
    authorize! :read, user
  end

  def new
    authorize! :create, user
    user.build_profile
    user.build_tariff
    user.staffs.build
  end

  def create
    authorize! :create, user

    if user.save
      flash[:success] = t(:'admin.users.flash.user_created')
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end

  def edit
    authorize! :edit, user
    user.build_profile unless user.profile.present?
    user.build_tariff unless user.tariff.present?
    user.staffs.build unless user.staffs.exists?
    user.skip_confirmation!
  end

  def update
    
    authorize! :edit, user

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if user.update_attributes(params[:user])
      flash[:success] = t(:'admin.users.flash.user_updated')
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    authorize! :destroy, user

    if user.destroy
      flash[:success] = t(:'admin.users.flash.user_destroyed')
      redirect_to admin_users_path
    end
  end

  def users
    @users ||= if params[:id]
      			    else
                    @q = User.search(params[:q])
                    @users = @q.result(:distinct => true).page params[:page]
			          end
  end
  helper_method :users

  def user
    @user ||= if params[:id]
      User.find(params[:id])
    else
      User.new(params[:user])
    end
  end
  helper_method :user


  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end

  def search
    index
    render :index
  end

  def get_updated_by
    user.updated_by = current_user.id
  end

  def confirm
    if user.confirm!
      flash[:success] = t(:'admin.users.flash.user_confirmed')
      redirect_to admin_users_path
    else
      flash[:error] = 'Confirmation error.'
      redirect_to admin_users_path
    end
  end

end