
class RodauthAdmin < Rodauth::Rails::Auth
  configure do
    # ... enable features ...
    prefix "/admin"
    session_key_prefix "admin_"

    # search views in `app/views/admin/rodauth` directory
    rails_controller { Admin::RodauthController }
  end
end