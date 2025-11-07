class Admin < ActiveRecord::Base # Sequel::Model
  include Rodauth::Rails.model(:admin)
end