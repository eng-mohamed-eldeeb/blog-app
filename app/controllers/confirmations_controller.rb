class ConfirmationsController < Devise::ConfirmationsController

# app/views/devise/mailer/confirmation_instructions.html.erb
# <%= link_to 'Confirm my account', confirmation_url(@resource, confirmation_token: @token) %>
private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end
