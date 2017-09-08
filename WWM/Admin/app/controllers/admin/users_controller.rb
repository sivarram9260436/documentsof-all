class Admin::UsersController < AdminController
    def create
    @sites =Site.find(:all)
    @page_properties={:selected_menu=>'user_menu',:menu_title=>'New User'}
    @user = User.new(params[:user])
    @user.reset_password_code_until = 1.day.from_now
    @user.entity_type="Author"
    @user.reset_password_code =  Digest::SHA1.hexdigest( "#{@user.email}#{Time.sr_now.to_s.split(//).sort_by {random_api(10)}.join}" )
      link=(url_for :controller=>'/admin/login',:action=>'set_password',:id=>@user.reset_password_code,:only_path=>false)
    ( save_status = @user.save ) ? redirect_to( :action => 'list' ) : render( :action => 'new' )
    host = request.host.eql?('localhost') ? "#{request.host}:#{request.port}" : request.host
    if save_status
      author=Author.create(:firstname=>@user.firstname,:lastname=>@user.lastname,:email=>@user.email,:sites=>[@site])
      @user.update_attributes(:entity_id=>author.id)
    end
    WebMailer.user_registration(@user, 'new', host,link).deliver if save_status
  #  if @user.save
  #    host = request.host.eql?('localhost') ? "#{request.host}:#{request.port}" : request.host
  #    WebMailer.user_registration(@user, 'new', host,link).deliver if save_status
  #    redirect_to :action => 'list'
  #  else
  #    render :action => 'new' 
  #  end
   end
  
     def announcement_create        
    @announcement=SupportMessage.new(params[:anouncement])
    @announcement.user_id=session[:user_id]
    @announcement.status=true
    if @announcement.save
      render :text => 'Your Announcement Successfully Added'
    else
      render :text => 'Your Announcement not Added'
    end
  end
  
  
  
  
  end
  
