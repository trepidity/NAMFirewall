class Rule
  # def initialize(item_name)
  #   @item_name = item_name
  # end

  attr_accessor :source, :dest, :port, :comment

  def to_s
    "Item: #{@item_name}"
  end
end
