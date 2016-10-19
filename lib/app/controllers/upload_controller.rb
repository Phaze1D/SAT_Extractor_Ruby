class UploadController
  include XMLHelper

  def begin_extraction(xml_file)
    extract xml_file

    comprobante = extract_comprobante
    emisor = extract_emisor
    receptor = extract_receptor
    dom_e = extract_domicilio_e
    dom_r = extract_domicilio_r
    conceptos = extract_conceptos
    traslados = extract_traslados
    impuesto = extract_impuesto
    tim = extract_tim_fis_dig


    emisor = Emisor.find_by(rfc: emisor.rfc) ? Emisor.find_by(rfc: emisor.rfc) : emisor
    receptor = Receptor.find_by(rfc: receptor.rfc) ? Receptor.find_by(rfc: receptor.rfc) : receptor


    unless emisor.id && Comprobante.find_by_folio_and_emisor_id_and_serie(comprobante.folio, emisor.id, comprobante.serie)
      emisor.save
      receptor.save
      comprobante.emisor = emisor
      comprobante.receptor = receptor
      comprobante.save


      if dom_e
        unless Domicilio.find_by_calle_and_codigoPostal_and_estado(dom_e.calle, dom_e.codigoPostal, dom_e.estado)
          dom_e.emisor = emisor
          dom_e.save
        end
      end

      if dom_r
        unless Domicilio.find_by_calle_and_codigoPostal_and_estado(dom_r.calle, dom_r.codigoPostal, dom_r.estado)
          dom_r.receptor = receptor
          dom_r.save
        end
      end

      tim.comprobante = comprobante
      tim.save

      impuesto.comprobante = comprobante
      impuesto.save

      traslados.each do |traslado|
        traslado.impuesto = impuesto
        traslado.save
      end

      conceptos.each do |concepto|

        producto = extract_producto concepto.xml_node

        producto = Producto.find_by(PLU: producto.PLU) ? Producto.find_by(PLU: producto.PLU) : producto
        producto.save
        concepto.producto = producto
        concepto.comprobante = comprobante
        concepto.save

        extract_infor_adu(concepto.xml_node).each do |info_ad|
          info_ad.concepto = concepto
          info_ad.save
        end

      end

    end

  end

end
