require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    children = root.children
    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end 
    children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
    end
    raise "shit, you are winning"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
