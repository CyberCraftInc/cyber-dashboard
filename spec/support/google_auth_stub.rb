OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
  provider: 'google',
  uid: '123545',
  info: {
    first_name: 'Dulla',
    last_name: 'Ilppa',
    email: 'test@google.com'
  },
  credentials: {
    token: '123456'
  }
)
