class GenerateShoppingListFile < PowerTypes::Command.new(:shopping_list_json)
  def perform
    add_header
    add_body
    axlsx.to_stream.string
  end

  private

  def add_header
    xls_sheet.add_row(
      [
        'Proveedor',
        'Nombre',
        'Medida',
        'Cantidad',
        'Precio total'
      ]
    )
  end

  def add_body
    @shopping_list_json.each do |element|
      element[:ingredients].each do |ingredient|
        xls_sheet.add_row(
          [
            element[:provider],
            ingredient[:name],
            ingredient[:measure],
            ingredient[:quantity],
            ingredient[:total_price]
          ]
        )
      end
    end
  end

  def axlsx
    @axlsx ||= ::Axlsx::Package.new
  end

  def xls_sheet
    @xls_sheet ||= axlsx.workbook.add_worksheet
  end
end
