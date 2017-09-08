class AdminsController < ApplicationController

  #before_filter :check_admin, :only => [:index,:new,:create]


 def new

    @user=User.new

 end

 def create
   @user=User.new(user_params)
   if @user.save
     flash[:notice] = " New user succefully created"
     redirect_to admins_path

   else 
     render 'admins/new'
     flash[:notice] = "something went wrong"
    end
 end

 def update
  @user=User.find(params[:id])
  if @user.update!(user_params)
      flash[:notice] = "user succefully updated"
        redirect_to admins_path
  else
    render 'edit'
  end
 end

 def edit

 @user=User.find(params[:id])
 end


def index
@users=User.all
end


 def login

 @user=User.new
 
 end

 def verify_login
   

    @user=User.where("email=? AND password=?",params[:user][:email] , params[:user][:password]).first
     
  if @user
     reset_session
     session[:user_id]=@user.id
      if @user.role=="Admin"
       session[:role]=@user.role
       redirect_to  admins_path

      else
        redirect_to user_path(@user)

       end
    
   else

     flash[:notice] = "user does not exist"

     redirect_to root_url
   end

  end

private
  
  def user_params
  	params.require(:user).permit(:name,:password,:email,:role)
  end
 
end
