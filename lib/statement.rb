class Statement
  attr_reader :description, :amount, :date

  def initialize(description, amount, date, current_installment, total_installments)
    @description = description
    @amount = amount
    @date = date
    @current_installment = current_installment
    @total_installments = total_installments
  end

  def total_amount
    return @amount unless @total_installments
    @amount * @total_installments
  end
end
