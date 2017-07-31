class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :mobile_no
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
