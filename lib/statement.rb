class Statement
  attr_reader :description, :amount, :date

  def initialize(description, amount, date)
    @description = description
    @amount = amount
    @date = date
  end
end
