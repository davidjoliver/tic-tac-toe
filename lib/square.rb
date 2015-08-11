class Square
  attr_accessor :value, :row, :column

  def initialize options={}
    @value = options[:value]
    @row = options[:row]
    @column = options[:column]
  end
end

