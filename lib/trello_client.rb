require 'netrc'
require 'trello'

# TODO: print instructions if auth info is missing
def new_trello_client
  n2 = Netrc.read
  trello_api_key, trello_member_token = n2['trello.com']

  if trello_member_token.nil?
    puts "Go to this URL, generate a token, save it in ~/.netrc"
    puts "https://trello.com/1/authorize?key=#{trello_api_key}&response_type=token&expiration=never&scope=read,write"
    exit
  end

  Trello::Client.new(
    developer_public_key: trello_api_key,
    member_token: trello_member_token
  )
end
