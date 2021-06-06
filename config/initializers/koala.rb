# In Rails, you could put this in config/initializers/koala.rb
Koala.configure do |config|
    # config.access_token = MY_TOKEN
    # config.app_access_token = MY_APP_ACCESS_TOKEN
    config.app_id = '888738381709696'
    config.app_secret = '2454a517d8be45f272a8a42df8ea7b9e'
    # See Koala::Configuration for more options, including details on how to send requests through
    # your own proxy servers.
  end
  