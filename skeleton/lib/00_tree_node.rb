require "byebug"
# MAX_STACK_SIZE = 20
# tracer = proc do |event|
#   if event == 'call' && caller_locations.length > MAX_STACK_SIZE
#     fail "Probable Stack Overflow"
#   end
# end
# set_trace_func(tracer)


class PolyTreeNode
  attr_reader :value, :children, :parent
  # attr_accessor :parent
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
    # debugger
  end

  def parent=(parent_node)
    if !@parent.nil?
      @parent.children.delete(self)
    end
    @parent = parent_node
    if !parent_node.nil?
      @parent.children << self unless @parent.children.include?(self)
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if self.children.include?(child)
      child.parent = nil
    else
      raise "#{child.value} is not a child of #{self.value}}"
    end
  end

  def dfs(target)
    return self if self.value == target
    # debugger
    if !self.children.empty?
      # debugger
      self.children.each do |child|
        # debugger
        return_val = child.dfs(target)
        return return_val unless return_val.nil?
        # debugger
      end
      # debugger
    end
    nil
  end

  def bfs(target)
    queue = [ self ]
    until queue.empty?
      current_node = queue.pop
      return current_node if current_node.value == target
      current_node.children.each do |child|
        queue.unshift(child)
      end
    end
    nil

    # as we iterate over a node we want to add its children to the queue
    

  end

  def inspect
    { 'value' => @value, 'parent_node' => @parent.nil? ? nil : @parent.value, 'children_nodes' => @children.map { |child| child.value } }.inspect
  end

end