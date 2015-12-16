require 'trello_client'

class CardLister
  attr_accessor :trello_board_id
  attr_accessor :trello_list_name
  attr_accessor :trello_list_number
  attr_accessor :column_specifiers

  attr_reader :trello_client

  def initialize
    @trello_client = new_trello_client
  end

  def valid?
    if trello_board_id.nil?
      $stderr.puts "No Trello board ID set!"
      return false
    end
    if trello_list_name && trello_list_number
      $stderr.puts "Can't specify a list name AND a list number!"
      return false
    end
    if column_specifiers.empty?
      $stderr.puts "No column specifiers!"
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

  def print(out)
    trello_list.cards.each do |card|
      columns = column_specifiers.map { |spec| column_for_card(spec, card) }
      out.puts columns.join("\t")
    end
  end

  private

  def column_for_card(specifier, card)
    card.send(specifier.to_sym)
  end
end
