require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    # @empty_board_node = TicTacToeNode.new(Board.new(), next_mover_mark)
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.won? && (@board.winner != evaluator)
      return false
    end
    
    children = self.children
    if evaluator == @next_mover_mark
      children.all? { |kid| kid.losing_node?(evaluator) }
    else
      children.any? { |kid| kid.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator && @board.won?
      return false
    end

    children = self.children
    if evaluator == @next_mover_mark #if our turn
      children.any? { |kid| kid.winning_node?(evaluator)}
    else
      children.all? { |kid| kid.winning_node?(evaluator)}
    end
  end

  require "byebug"
  # This method generates an array of all moves that can be made after
  # the current move.
  def children

    boards = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |square, i2|
        if square == nil
          new_mark = ((@next_mover_mark == :x) ? :o : :x)
          new_board = TicTacToeNode.new( @board.dup, new_mark, [i, i2])
          new_board.board[[i,i2]] = new_mark
          boards << new_board
        end
      end
    end
    boards
  end
end
