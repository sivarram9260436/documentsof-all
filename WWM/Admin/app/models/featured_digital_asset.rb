class FeaturedDigitalAsset < ActiveRecord::Base
  belongs_to :entity,:polymorphic=>true
  belongs_to :featured_set
  def digital_asset
    self.entity
  end

  def external_source
    self.entity
  end
end
