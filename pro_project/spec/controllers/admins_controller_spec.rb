require "rails_helper"
require 'support/factory_girl'
require 'factory_girl'


RSpec.describe AdminsController, :type => :controller do

#
  describe "GET#login" do

      it "should get the login page" do

        get :login
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "should get the login page" do

        get :login

        expect(response).to render_template :login
      end

end

    describe "GET#verify_login" do

      # before :each do
      #   @user=User.create!(:name => "abdul",:email => "abdul@kreatio.com",:password => "abdul",:role => "Admin")
      # end

       it "should assign @user with params and redirected to admins path" do

         # user=User.create!(:name=>"abdul", :email=>"abdul@kreatio.com", :role=>"Admin" , :password=>"abdul")
         # get :verify_login, params: {}
         # expect(response).to have_http_status(200)
         # expect(assigns(@user)).to eq(user)

         #smith = create(:user,name: 'abdul', email: 'abdul@kreatio.com', role:'Admin' , password: 'abdul')
         get :verify_login, :user => {'email' => 'abdul@kreatio.com','password' => 'abdul'}
         #expect(assigns(:user)).to have_attributes(email: 'abdul@kreatio.com',password: 'abdul',role: 'Admin',name: 'abdul')
         #expect(assigns(:user))
         expect(assigns(:user).role).to eq('Admin')
         expect(response).to redirect_to admins_path

         #expect(@user.email).to eq(smith.email)
        # expect(:user["email"]).to eq(smith.email)


         # get :verify_login, :@user => { :name => "abdul",:email => "abdul@kreatio.com",:password => "abdul",:role => "Admin" }
         # assigns(:@user).should be_a_new(User).with(:name => "abdul",:email => "abdul@kreatio.com",:password => "abdul",:role => "Admin")
         # expect(@user.role).to eq("Admin")
         # expect(@user).to redirect_to :action => :index

       end
       it "should assign @user with params and redirected to users path" do

         get :verify_login, :user => {'email' => 'ajith@kreatio.com','password' => 'ajith'}
         #expect(assigns(:user)).to have_attributes(email: 'abdul@kreatio.com',password: 'abdul',role: 'Admin',name: 'abdul')
         #expect(assigns(:user))
         expect(assigns(:user).role).to eq('others')
         # expect(response).to redirect_to user_path
         expect(response).to redirect_to user_path(assigns[:user])
       end

       it "should assign @user without params and redirected to admins path" do

         get :verify_login, :user => {'email' => 'aji@kreatio.com','password' => 'ajith'}

         expect(flash[:notice]).to match(/user does not exist/i)
         expect(response).to redirect_to root_path


       end

         # it "should redirect to @user" do
       #
       #   expect(@user.role).not_to eq("Admin")
       #   expect(@user).to redirect_to user_path(@user)


         #expect(@user.email).not_to be_nil
         #expect(@user).to redirect_to :action => :index

       #it "should redirect_to admins_path"
       #it "should assign @user"



      #end

    end

    describe "GET#new" do
      #
      # before(:each) do
      #    FactoryGirl.create(:user)
      # end
      it "should get a new form" do
        get :new
       #expect(assigns(:user)).not_to be_a_new(User).with(email: 'abdul@kreatio.com',password: 'abdul',role: 'Admin',name: 'abdul')
        # expect(assigns(:user)).to be(nil)
        expect(assigns(:user)).to be_a_new(User)
        # assigns(:user).kind_of?(User).to be_false
      end
      #
      it "it should rendetr the new template" do
        get :new
        expect(subject).to render_template("admins/new")
        end

    end

    describe "GET#create" do
      it "should save the record" do

        post :create ,:user => FactoryGirl.attributes_for(:user)#using factory girl
        expect(assigns(:user)).not_to be_a_new(User)
       # expect(User.count).to eq(1)

      end

      it "should redirected to particular template" do

        #post :create ,:user => {id: nil, name: nil, password: nil, email: nil, role: nil, created_at: nil, updated_at: nil}#attributes_for(:user) #using factory girl
        post :create ,:user => FactoryGirl.attributes_for(:user) #using factory girl
        expect(flash[:notice]).to match(/New user succefully created/i)
        expect(response).to redirect_to admins_path
      end

      it "should render template if it's not save" do

        post :create ,:user => FactoryGirl.attributes_for(:user,email: nil)#using factory girl
        expect(response).to render_template ("admins/new")
        expect(flash[:notice]).to match(/something went wrong/i)

      end
    end


    describe "GET#edit" do
      before :each do
              @user = create(:user)
      end

      it "should assign instance variable it hold one record" do

        #@user = create(:user, name: 'abdul', email: 'abdul@kreatio.com',role: 'abdul',password: 'abdul')
        get :edit ,id: @user
        expect(assigns(:user)).to eq(@user)
      end
      it "should render the template" do

        #@user = create(:user, name: 'abdul', email: 'abdul@kreatio.com',role: 'abdul',password: 'abdul')
        get :edit ,id: @user
        expect(response).to render_template("edit")
      end

    end

  describe "PATCH#update" do
     before :each do
        @user=create(:user)
     end

    it "should assign a instanse variable" do

        patch :update ,id: @user ,:user => FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
    end

     it "should update a instanse variable attributes" do

        patch :update ,id: @user ,:user => FactoryGirl.attributes_for(:user,name: "arun")
        @user.reload
        expect(assigns(:user).name).to eq("arun")
     end

#      it "should redirected to admins path if update" do
#
#        patch :update ,id: @user ,:user => FactoryGirl.attributes_for(:user)
#        expect(response).to redirect_to(admins_path)
#      end
#
#      it "should render edit template if values are updated" do
#
#        patch :update ,id: @user ,:user => FactoryGirl.attributes_for(:user,email: nil)
# #       @user.reload
#        expect(@user.email).to eq(nil)
#
#      end

  end
  end
