class Extractor
  DATE_REGEXP = /[0-9]{2} [a-zA-Z]{3}/
  DESCRIPTION_REGEXP = /.+?(?=-|R\$)/
  AMOUNT_REGEXP = /(- )?R\$ ([0-9]+\.?)+\,[0-9]{2}/
  INSTALLMENT_REGEXP = /.*\((?<current>\d+)\/(?<total>\d+)\)$/
  STATEMENT_REGEXP = /((?<date>#{DATE_REGEXP})\W+(?<name>#{DESCRIPTION_REGEXP})(?<amount>#{AMOUNT_REGEXP}))/

  def self.extract_statements(filepath)
    reader = PDF::Reader.new(filepath)

    pages = reader.pages.to_a

    # cover pages and closing remarks
    pages.shift(2)
    pages.pop

    pages.each_with_object([]) do |page, memo|
      lines = page.text.split("\n")

      lines.each do |line|
        line.scan(STATEMENT_REGEXP).each do |statement|
          description = statement[1].strip

          match = description.match(INSTALLMENT_REGEXP)
          installments = {
            current: match[:current].to_i,
            total: match[:total].to_i
          } if match

          memo << {
            description: description,
            date: statement[0].strip,
            amount: statement[2].strip,
            installments: installments
          }
        end
      end
    end
  end
end
