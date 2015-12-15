require 'github_client'
require 'trello_client'

class CardMaker
  CARD_URL_PATTERN = %r{https://trello.com/c/(\w+)}

  def self.card_url_for_issue(issue)
    CARD_URL_PATTERN.match(issue.body) { |m| m[0] }
  end

  attr_accessor :github_repository_name
  attr_accessor :trello_board_id
  attr_accessor :trello_list_name
  attr_accessor :trello_list_number

  attr_reader :github_client
  attr_reader :trello_client

  def initialize
    @github_client = new_github_client
    @trello_client = new_trello_client
  end

  def valid?
    if github_repository_name.nil?
      puts "No GitHub repository name set!"
      return false
    end
    if trello_board_id.nil?
      puts "No Trello board ID set!"
      return false
    end
    if trello_list_name && trello_list_number
      puts "Can't specify a list name AND a list number!"
      return false
    end
    return true
  end

  def trello_board
    @trello_board ||= trello_client.find(:board, trello_board_id)
  end

  # If no list name is specified, defaults to the first list.
  def trello_list
    @trello_list ||= begin
      if trello_list_number
        trello_board.lists[trello_list_number - 1]
      elsif trello_list_name
        trello_board.lists.find { |l| l.name == trello_list_name }
      else
        trello_board.lists.first
      end
    end
  end

  def find_issue(number)
    github_client.issue(github_repository_name, number)
  end

  def make_card_for_issue(issue)
    puts "making card for ##{issue.number}: #{issue.title}"

    # TODO: fork ruby-trello, fix client.create(:card, ...)
    card = Trello::Card.new
    card.client = trello_client
    card.list_id = trello_list.id
    card.name = issue.title
    card.desc = issue.body
    card.pos = 'bottom'
    card.save

    card.add_attachment(issue.html_url)

    puts "=> card created: #{card.short_url}"

    new_body = issue.body + "\n\nCard: #{card.short_url}"
    github_client.update_issue(github_repository_name, issue.number, body: new_body)
    puts "=> issue description updated"
  end
end
