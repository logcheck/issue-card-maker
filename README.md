# Issue Card Maker for GitHub & Trello

## The Basic Idea

It's a command line tool that asks for:

1. a GitHub repository and issue number
2. a Trello board and list

In return it:

1. Creates a Trello card in the specified list, copying the title and
   description from GitHub, and attaching a link back to the GitHub
   issue.
2. Adds a comment to the GitHub Issue with a link back to the Trello card.

https://github.com/octokit/octokit.rb
https://github.com/jeremytregunna/ruby-trello

## TODO

- Detect github repo from working directory?
- Reimplement as a Chrome Extension in Javascript

## Setup

### GitHub Authentication

Go to https://github.com/settings/tokens and generate a new token. It needs
either "repo", "public_repo", or both.

Copy the token into ~/.netrc like this:

    machine api.github.com
      login $USERNAME
      password $TOKEN

### Trello Authorization

Go to https://trello.com/app-key and get your API key.

Add it to ~/.netrc like so:

    machine trello.com
      login $APIKEY

Run make-card, it will print an URL for you to visit. Copy the token back
to the ~/.netrc as the password.
