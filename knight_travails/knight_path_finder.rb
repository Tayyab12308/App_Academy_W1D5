require "/Users/aa/Desktop/W1D5/skeleton/lib/00_tree_node.rb"
require 'byebug'
class KnightPathFinder
  
  attr_accessor :pos_considered

  def self.root_node(pos)
    x, y = pos
    PolyTreeNode.new([x, y])
  end

  def initialize(start_pos)
    # assumes start_pos is input as an array i.e. '[0, 1]'
    @start_node = KnightPathFinder.root_node(start_pos)
    @pos_considered = [ start_pos ]
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    valid_moves.select { |end_pos| !repeat_move?(end_pos) }

  end

  def self.valid_moves(pos)
    all_pos = self.all_moves(pos)
    all_pos.select { |move| valid_range?(move) }
  end

  def self.all_moves(pos)
    movements = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    movements.map { |move| [ move[0] + pos[0], move[1] + pos[1] ] }
  end

  def self.valid_range?(pos)
    x, y = pos
    return false if (x < 0 || x > 7) || (y < 0 || y > 7)
    true
  end

  def repeat_move?(pos)
    return true if @pos_considered.include?(pos)
    @pos_considered << pos
    false
  end

  def build_move_tree
    tree = []
    queue = [ @start_node ]
    until queue.empty?
      current_node = queue.pop
      branches = new_move_positions(current_node.value)
      branches.each do |pos|
        new_node = PolyTreeNode.new(pos)
        new_node.parent = current_node
        queue.unshift(new_node)
      end
      tree << current_node
    end
    tree
  end
end

 kpf = KnightPathFinder.new([0, 0])
#  p kpf.all_moves([2, 3])
var = kpf.build_move_tree
all = var.each { |val| p val }
p all.count