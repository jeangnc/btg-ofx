require 'date'

class DataTransformer
  MONTHS = {
    'Jan' => 1,
    'Fev' => 2,
    'Mar' => 3,
    'Abr' => 4,
    'Mai' => 5,
    'Jun' => 6,
    'Jul' => 7,
    'Ago' => 8,
    'Set' => 9,
    'Out' => 10,
    'Nov' => 11,
    'Dez' => 12
  }

  def self.amount(amount_string)
    amount_string.gsub('R$', '').gsub('.', '').gsub(',', '.').gsub(' ', '').to_f
  end

  def self.date(date_string)
    day, month = date_string.split(' ')
    month = MONTHS[month]
    year = Date.today.year

    # not ideal, but ok
    if month > Date.today.month
      year -= 1
    end

    Date.parse "#{year}-#{month}-#{day}"
  end
end
