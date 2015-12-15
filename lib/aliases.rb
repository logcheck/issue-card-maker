require 'psych'

class Aliases
  def initialize
    aliases = Psych.load_file('aliases.yml')
    @boards = aliases['boards'] || Hash.new
    @repos = aliases['repos'] || Hash.new
  rescue Errno::ENOENT
    @boards = Hash.new
    @repos = Hash.new
  end

  def resolve_board(token)
    @boards[token] || token
  end

  def resolve_repo(token)
    @repos[token] || token
  end
end
