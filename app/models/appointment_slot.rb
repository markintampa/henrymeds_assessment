class AppointmentSlot < ApplicationRecord
  belongs_to :provider
  belongs_to :client, optional: true
end
