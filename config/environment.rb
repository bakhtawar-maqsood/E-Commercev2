# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'
# Initialize the Rails application.

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: 'bakhtawar.maqsood@devsinc.com',
    password: 'dcbjugyqvyliuwvz',
    authentication: 'plain',
    enable_starttls_auto: true
  }
end

Rails.application.initialize!

PUBLISHABLE_KEY = 'pk_test_51JZWMuEVSKB0mGfOY5sTEpVGMlvmxq6LuOkWzaGZEzrDTkCatKblEo4ZogeVlR5S5iHku4USfSgMn3jw7Tmi4Kl700dUvrravD'
SECRET_KEY = 'sk_test_51JZWMuEVSKB0mGfOILroTaaY9Vu5wmtfxxSEAIqkzt65XvhhILv7ebRCW41VJxm4yL2lzbJiy5KBH3NpaGc7T1fX00DDmXFSy0'
CLOUDINARY_URL = 'CLOUDINARY_URL=cloudinary://439618615248476:rABWqdhCjMjvipZJFTqbwEoI8AM@dpxupa9zn'
