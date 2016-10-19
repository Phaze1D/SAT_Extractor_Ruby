class CancelController
	include XMLHelper

	def cancel_comprobante(xml_file)
		extract xml_file
		comprobante = extract_comprobante
		emisor = extract_emisor

		emisor = Emisor.find_by(rfc: emisor.rfc)
		if emisor
			comprobante = Comprobante.find_by_folio_and_emisor_id_and_serie(comprobante.folio, emisor.id, comprobante.serie)
			if comprobante
				comprobante.update_attributes cancelado: true
			end
		else
			puts "Could not find emisor"
		end
	end
end
