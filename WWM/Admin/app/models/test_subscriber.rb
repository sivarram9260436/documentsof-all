class TestSubscriber < ActiveRecord::Base
  belongs_to :newsletter
  validate :test_subscriber__validation


def test_subscriber__validation
     errors[:base] << ("Email should not be blank") if self.email_id.blank?
     errors[:base] << ("Email has already been taken") if not TestSubscriber.where("UPPER(email_id) = UPPER(?)", self.email_id.upcase.strip).blank? and  not self.email_id.blank?
     errors[:base] << ("Email is invalid") if /^([a-zA-Z0-9_.'-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/.match(self.email_id.strip.to_s).blank? and not self.email_id.blank?
  end

end
