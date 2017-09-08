class  AllRedirect < ActiveRecord::Base
  validates_presence_of :host, :destination, :redirect_type, :record_type ,:orig_uri
  # validates_inclusion_of :redirect_type, :in => %w(permanent redirect)
  # validates_inclusion_of :record_type, :in => %w(host uri)
  validates_format_of :orig_uri, :with => /^\//, :message => "must start with /", :if => "record_type == 'uri'"
  validates_presence_of :orig_uri, :if => "record_type == 'uri'"
end
