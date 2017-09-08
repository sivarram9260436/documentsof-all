class UsersController < ApplicationController


def edit
  @user=User.find(params[:id])
end

def update
  @user=User.find(params[:id])
  if @user.update(user_params)
    flash[:notice] = "user can be succesfully updated"
    redirect_to user_path(@user)
  else render 'edit'
  end
end

def show 
@user=User.find(params[:id])
if flash[:notice]
  end
end

def password
@user=User.find(params[:id])
end

def new_password

  
  @old=params[:old_password]
  @new=params[:new_password]
  @user=User.find(params[:id])

  if @old==@user.password
     @user.password=@new
     if @user.save
       flash[:notice] = "password can be succesfully updated"
       render :template => '/users/edit'
     end

  else
    flash[:notice] = "you can't update your password"
    #render :template => '/users/edit'
    #flash[:notice] = "Post successfully created"
    redirect_to edit_user_path(@user)
  end
end




private

def user_params
  params.require(:user).permit(:name,:password,:email,:role)
end

end
