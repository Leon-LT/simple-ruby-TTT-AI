require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :children, :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end

  def losing_node?(evaluator)
    if @board.over?
      return false if @board.tied?
      winning_eval = @board.winner
      return true if winning_eval != evaluator
      return false if winning_eval.nil? || winning_eval == evaluator
    end

    if @next_mover_mark != evaluator
        return children.any? { |child| child.losing_node?(evaluator)}
      else
        return children.all? { |child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return false if @board.tied?
      winning_eval = @board.winner
      return true if winning_eval == evaluator
      return false if winning_eval.nil? || winning_eval != evaluator
    end

    if @next_mover_mark != evaluator
      return children.any? { |child| child.winning_node?(evaluator)}
    else
      return children.all? { |child| child.winning_node?(evaluator)}
    end
  end

  def next_mark(curr_mark)
    (@next_mover_mark == :x) ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_mark = next_mark(@next_mover_mark)
    @board.rows.each_with_index do |row, x|
      row.each_with_index do |col, y|
        pos = [x,y]
        if @board.empty?(pos)
          duped_board = @board.dup
          duped_board[pos] = next_mover_mark
          @children << TicTacToeNode.new(duped_board, next_mark, pos)
        end
      end
    end
    @children
  end
end
