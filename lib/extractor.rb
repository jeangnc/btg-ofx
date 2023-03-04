
class Extractor
  DATE_REGEXP = /[0-9]{2} [a-zA-Z]{3}/
  NAME_REGEXP = /.+?(?=-|R\$)/
  VALUE_REGEXP = /(- )?R\$ ([0-9]+\.?)+\,[0-9]{2}/
  STATEMENT_REGEXP = /((?<date>#{DATE_REGEXP})\W+(?<name>#{NAME_REGEXP})(?<value>#{VALUE_REGEXP}))/

  def self.extract_statements(filepath)
    reader = PDF::Reader.new(filepath)

    pages = reader.pages.to_a
    pages.shift(2)
    pages.pop

    pages.each_with_object([]) do |page, memo|
      lines = page.text.split("\n")

      lines.each do |line|
        line.scan(STATEMENT_REGEXP).each do |statement|
          memo << {
            date: statement[0].strip,
            name: statement[1].strip,
            value: statement[2].strip
          }
        end
      end
    end
  end
end
