require "byebug"

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

end