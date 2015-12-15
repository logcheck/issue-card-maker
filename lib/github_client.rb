require 'netrc'
require 'octokit'

# TODO: print instructions if auth info is missing
def new_github_client
  Octokit::Client.new(:netrc => true)
end
