require_relative 'tic_tac_toe_node'

require "byebug"
class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    children.any? do |kid|
      return kid.prev_move_pos if kid.winning_node?(mark)
    end

    children.each do |kid|
      return kid.prev_move_pos if kid.losing_node?(mark) == false
    end

    raise "Unable to find winning or draw move!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
