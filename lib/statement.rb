class Statement
  attr_reader :description, :value, :date

  def initialize(description, value, date)
    @description = description
    @value = value
    @date = date
  end
end
