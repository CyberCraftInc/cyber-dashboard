OmniAuth.config.test_mode = true

def google_oauth2_mock
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    provider: 'google_oauth2',
    uid: '12345678910',
    info: {
      email: 'fakeemail@gmail-fake.com',
      first_name: 'David',
      last_name: 'McDonald'
    },
    credentials: {
      token: 'abcdefgh12345',
      refresh_token: '12345abcdefgh'
    }
  )
end

def google_oauth2_invalid_mock
  OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
end
