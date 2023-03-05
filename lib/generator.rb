class Generator
  def initialize(statements)
    @statements = statements
  end

  def generate
    <<~OFX
    OFXHEADER:100
    DATA:OFXSGML
    VERSION:102
    SECURITY:NONE
    ENCODING:USASCII
    CHARSET:1252
    COMPRESSION:NONE
    OLDFILEUID:NONE
    NEWFILEUID:NONE

    <OFX>
      <BANKMSGSRSV1>
        <STMTTRNRS>
          <STMTRS>
            <BANKTRANLIST>
              #{statements_ofx}
            </BANKTRANLIST>
          </STMTRS>
        </STMTTRNRS>
      </BANKMSGSRSV1>
    </OFX>
    OFX
  end

  private

  def statements_ofx
    @statements.map do |statement|
      <<-OFX
      <STMTTRN>
        <TRNTYPE>OTHER</TRNTYPE>
        <DTPOSTED>#{statement.date.strftime('%Y%m%d000000[-3:GMT]')}</DTPOSTED>
        <TRNAMT>#{statement.amount}</TRNAMT>
        <MEMO>#{statement.description}</MEMO>
      </STMTTRN>
      OFX
    end.join("\n")
  end
end
