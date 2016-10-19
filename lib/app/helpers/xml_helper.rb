module XMLHelper
  # 4954
  def extract(xml_file)
    @noko_doc = Nokogiri::XML(xml_file)
    # @noko_doc.remove_namespaces!
  end

  def extract_comprobante
    xml_node = @noko_doc.xpath('//cfdi:Comprobante').first
    Comprobante.new(
        folio: xml_node['folio'],
        fecha: xml_node['fecha'],
        sello: xml_node['sello'],
        formaDePago: xml_node['formaDePago'],
        noCertificado: xml_node['noCertificado'],
        certificado: xml_node['certificado'],
        subTotal: xml_node['subTotal'],
        descuento: xml_node['descuento'],
        tipoCambio: xml_node['TipoCambio'],
        moneda: xml_node['Moneda'],
        total: xml_node['total'],
        tipoDeComprobante: xml_node['tipoDeComprobante'],
        metodoDePago: xml_node['metodoDePago'],
        lugarExpedicion: xml_node['LugarExpedicion'],
        serie: xml_node['serie'],
        numCtaPago: xml_node['NumCtaPago']
    )
  end

  def extract_emisor
    xml_node = @noko_doc.xpath('//cfdi:Emisor').first
    Emisor.new(
        rfc: xml_node['rfc'],
        nombre: xml_node['nombre']
    )
  end

  def extract_receptor
    xml_node = @noko_doc.xpath('//cfdi:Receptor').first
    Receptor.new(
        rfc: xml_node['rfc'],
        nombre: xml_node['nombre']
    )
  end

  def extract_domicilio_e
    xml_node = @noko_doc.xpath('//cfdi:DomicilioFiscal').first
    if xml_node
      Domicilio.new(
          calle: xml_node['calle'],
          noExterior: xml_node['noExterior'],
          noInterior: xml_node['noInterior'],
          colonia: xml_node['colonia'],
          localidad: xml_node['localidad'],
          municipio: xml_node['municipio'],
          estado: xml_node['estado'],
          pais: xml_node['pais'],
          codigoPostal: xml_node['codigoPostal']
      )
    end

  end

  def extract_domicilio_r
    xml_node = @noko_doc.xpath('//cfdi:Domicilio').first
    if xml_node
      Domicilio.new(
          calle: xml_node['calle'],
          noExterior: xml_node['noExterior'],
          noInterior: xml_node['noInterior'],
          colonia: xml_node['colonia'],
          localidad: xml_node['localidad'],
          municipio: xml_node['municipio'],
          estado: xml_node['estado'],
          pais: xml_node['pais'],
          codigoPostal: xml_node['codigoPostal']
      )
    end


  end

  def extract_producto(concepto_parent)
    Producto.new(
        PLU: concepto_parent['noIdentificacion'],
        descripcion: concepto_parent['descripcion']
    )
  end

  def extract_conceptos
    xml_nodeset = @noko_doc.xpath('//cfdi:Concepto')
    conceptos = []
    xml_nodeset.each do |xml_node|
      conceptos.push Concepto.new(
                         cantidad: xml_node['cantidad'],
                         unidad: xml_node['unidad'],
                         valorUnitario: xml_node['valorUnitario'],
                         importe: xml_node['importe'],
                         xml_node: xml_node
                     )
    end
    conceptos
  end

  def extract_infor_adu(concepto_parent)
    infor_adu = []
    concepto_parent.xpath('./cfdi:InformacionAduanera').each do |inf_ad|
      if inf_ad.present?
        infor_adu.push InformancionAduanera.new(
                           numero: inf_ad['numero'],
                           fecha: inf_ad['fecha'],
                           aduana: inf_ad['aduana']
                       )
      end

    end

    infor_adu


  end

  def extract_traslados
    xml_nodeset = @noko_doc.xpath('//cfdi:Traslado')
    traslados = []
    xml_nodeset.each do |xml_node|
      traslados.push Traslado.new(
                         impuesto_c: xml_node['impuesto'],
                         tasa: xml_node['tasa'],
                         importe: xml_node['importe']
                     )
    end
    traslados
  end

  def extract_impuesto
    xml_node = @noko_doc.xpath('//cfdi:Impuestos').first
    Impuesto.new(
        totalImpuestosTrasladados: xml_node['totalImpuestosTrasladados']
    )
  end

  def extract_tim_fis_dig
    xml_node = @noko_doc.xpath('//tfd:TimbreFiscalDigital', 'tfd' => "http://www.sat.gob.mx/TimbreFiscalDigital").first
    TimbreFiscalDigital.new(
        selloCFD: xml_node['selloCFD'],
        fechaTimbrado: xml_node['FechaTimbrado'],
        UUID: xml_node['UUID'],
        noCertificadoSAT: xml_node['noCertificadoSAT'],
        selloSAT: xml_node['selloSAT']
    )
  end


end
