require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, '8f6facc3c8724b42b361675473c555b7', 'f127b9fda8fc4927bcf14272e2746677',
           scope: 'playlist-read-private user-read-birthdate playlist-read-collaborative user-library-read user-library-modify user-read-private user-read-email playlist-modify-public user-library-read user-library-modify'
end