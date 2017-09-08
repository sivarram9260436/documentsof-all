# Copyright (c) 2008 [Sur http://expressica.com]

module SimpleCaptcha #:nodoc 
  module ControllerHelpers #:nodoc

#    include ConfigTasks

    # This method is to validate the simple captcha in controller.
    # It means when the captcha is controller based i.e. :object has not been passed to the method show_simple_captcha.
    #
    # *Example*
    #
    # If you want to save an object say @user only if the captcha is validated then do like this in action...
    #
    #  if simple_captcha_valid?
    #   @user.save
    #  else
    #   flash[:notice] = "captcha did not match"
    #   redirect_to :action => "myaction"
    #  end
    def simple_captcha_valid?
      return true if Rails.env == 'test'
      if params[:captcha]
        data = simple_captcha_value
        result = data == params[:captcha].delete(" ").upcase
        simple_captcha_passed! if result
        return result
      else
        return false
      end
    end

  end
end

# Copyright (c) 2008 [Sur http://expressica.com]

  module ModelHelpers #:nodoc

    # To implement model based simple captcha use this method in the model as...
    #
    #  class User < ActiveRecord::Base
    #
    #    apply_simple_captcha :message => "my customized message"
    #
    #  end
    #
    # Customize the error message by using :message, the default message is "Captcha did not match". 
    # As in the applications captcha is needed with a very few cases like signing up the new user, but
    # not every time you need to authenticate the captcha with @user.save. So as to maintain simplicity
    # here we have the explicit method to save the instace with captcha validation as...
    #
    # * to validate the instance
    #  
    #  @user.valid_with_captcha?  # whene captcha validation is required.
    #
    #  @user.valid?               # when captcha validation is not required.
    #
    # * to save the instance
    #
    #  @user.save_with_captcha   # whene captcha validation is required.
    #
    #  @user.save                # when captcha validation is not required.
    module ClassMethods
      def apply_simple_captcha(options = {})
        instance_variable_set(:@add_to_base, options[:add_to_base])
        instance_variable_set(:@captcha_invalid_message, options[:message] || "Secret Code did not match with the Image")
        module_eval do
          #include SimpleCaptcha::ConfigTasks
          attr_accessor :captcha, :captcha_key, :authenticate_with_captcha
          alias_method :valid_without_captcha?, :valid?
          alias_method :save_without_captcha, :save
          #include SimpleCaptcha::ModelHelpers::InstanceMethods
        end
      end
    end

    module InstanceMethods
      def valid?(options={})
        return valid_without_captcha? if Rails.env == 'test'
        if authenticate_with_captcha
          ret = valid_without_captcha?
          if captcha && captcha.upcase.delete(" ") == simple_captcha_value(captcha_key)
            ret = ret && true
          else
            ret = false
            self.class.instance_variable_get(:@add_to_base) == true ?
            self.errors.add_to_base(self.class.instance_variable_get(:@captcha_invalid_message)) :
            self.errors.add(:captcha, self.class.instance_variable_get(:@captcha_invalid_message))
          end
          simple_captcha_passed!(captcha_key) if ret
          return ret
        else
          return valid_without_captcha?
        end
      end

      def valid_with_captcha?
        return valid_without_captcha? if Rails.env == 'test'
        self.authenticate_with_captcha = true
        ret = self.valid?
        self.authenticate_with_captcha = false
        ret
      end

      def save_with_captcha
        self.authenticate_with_captcha = true
        ret = self.save_without_captcha
        self.authenticate_with_captcha = false
        ret
      end

      def save(check_validations={:validate => true})
        self.authenticate_with_captcha = false
        self.save_without_captcha({:validate =>check_validations[:validate]})
      end
    end
  end

ActiveRecord::Base.module_eval do
  extend SimpleCaptcha::ModelHelpers::ClassMethods
end

