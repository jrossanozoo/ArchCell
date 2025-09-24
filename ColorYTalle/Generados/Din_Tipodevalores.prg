
define class Din_TipoDeValores as zoosession of zoosession.prg


	*-----------------------------------------------------------------------------------------
	function GenerarXmlTipoDeValores()
		local lcNombreCursor as String, lcTipoDeValoresXML as String
		lcNombreCursor = 'c_' + sys( 2015 )
		create cursor &lcNombreCursor( Codigo n(4), Descripcion c(50), Orden n(2,0) )

		insert into &lcNombreCursor values( 1, 'Moneda Local', 1)
		insert into &lcNombreCursor values( 2, 'Moneda Extranjera', 2)
		insert into &lcNombreCursor values( 3, 'Tarjeta de Crédito / Débito', 3)
		insert into &lcNombreCursor values( 4, 'Cheque de Terceros (discontinuado)', 97)
		insert into &lcNombreCursor values( 5, 'Pagaré', 6)
		insert into &lcNombreCursor values( 6, 'Cuenta Corriente', 7)
		insert into &lcNombreCursor values( 7, 'Ticket', 8)
		insert into &lcNombreCursor values( 8, 'Vale de Cambio', 9)
		insert into &lcNombreCursor values( 9, 'Cheque Propio (discontinuado)', 98)
		insert into &lcNombreCursor values( 10, 'Ajuste de Cupones', 99)
		insert into &lcNombreCursor values( 11, 'Pago Electrónico', 10)
		insert into &lcNombreCursor values( 12, 'Cheque de Terceros', 4)
		insert into &lcNombreCursor values( 13, 'Cuenta Bancaria', 11)
		insert into &lcNombreCursor values( 14, 'Cheque Propio', 5)
		Index On Orden to &lcNombreCursor

		lcTipoDeValoresXML = this.CursorAXml( lcNombreCursor )
		use in select ( lcNombreCursor )
		return lcTipoDeValoresXML
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerComponente( tnTipoDeValor as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoDeValor = 1
				lcRetorno = 'Valores'
			case tnTipoDeValor = 2
				lcRetorno = 'Valores'
			case tnTipoDeValor = 3
				lcRetorno = 'TarjetaDeCredito'
			case tnTipoDeValor = 4
				lcRetorno = 'ChequesDeTerceros'
			case tnTipoDeValor = 5
				lcRetorno = 'Valores'
			case tnTipoDeValor = 6
				lcRetorno = 'CuentaCorrienteValores'
			case tnTipoDeValor = 7
				lcRetorno = 'Valores'
			case tnTipoDeValor = 8
				lcRetorno = 'ValesDeCambio'
			case tnTipoDeValor = 9
				lcRetorno = 'ChequesPropios'
			case tnTipoDeValor = 10
				lcRetorno = 'AjusteDeCupones'
			case tnTipoDeValor = 11
				lcRetorno = 'TarjetaDeCredito'
			case tnTipoDeValor = 12
				lcRetorno = 'ChequesDeTerceros'
			case tnTipoDeValor = 13
				lcRetorno = 'CuentaBancariaValores'
			case tnTipoDeValor = 14
				lcRetorno = 'ChequesPropios'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerDescripcion( tnTipoDeValor as integer ) as String
		Local lcRetorno as String
		
		lcretorno = ''
		do case
			case tnTipoDeValor = 1
				lcRetorno = 'Moneda Local'
			case tnTipoDeValor = 2
				lcRetorno = 'Moneda Extranjera'
			case tnTipoDeValor = 3
				lcRetorno = 'Tarjeta de Crédito / Débito'
			case tnTipoDeValor = 4
				lcRetorno = 'Cheque de Terceros (discontinuado)'
			case tnTipoDeValor = 5
				lcRetorno = 'Pagaré'
			case tnTipoDeValor = 6
				lcRetorno = 'Cuenta Corriente'
			case tnTipoDeValor = 7
				lcRetorno = 'Ticket'
			case tnTipoDeValor = 8
				lcRetorno = 'Vale de Cambio'
			case tnTipoDeValor = 9
				lcRetorno = 'Cheque Propio (discontinuado)'
			case tnTipoDeValor = 10
				lcRetorno = 'Ajuste de Cupones'
			case tnTipoDeValor = 11
				lcRetorno = 'Pago Electrónico'
			case tnTipoDeValor = 12
				lcRetorno = 'Cheque de Terceros'
			case tnTipoDeValor = 13
				lcRetorno = 'Cuenta Bancaria'
			case tnTipoDeValor = 14
				lcRetorno = 'Cheque Propio'
		endcase
		return lcRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function ObtenerAtributos( tnTipoDeValor as integer ) as Object
		Local loRetorno as String
		
		loRetorno = newobject( 'empty')
		do case
			case tnTipoDeValor = 1
				addproperty( loRetorno, 'DescripcionEntrega', .F. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .T. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 2
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .T. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 3
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .T. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 4
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 5
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .T. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 6
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .T. )
				addproperty( loRetorno, 'FechaEntrega', .T. )
				addproperty( loRetorno, 'FechaRecibe', .T. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .T. )
			case tnTipoDeValor = 7
				addproperty( loRetorno, 'DescripcionEntrega', .F. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 8
				addproperty( loRetorno, 'DescripcionEntrega', .F. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .F. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .T. )
			case tnTipoDeValor = 9
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 10
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .T. )
				addproperty( loRetorno, 'FechaEntrega', .T. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .T. )
			case tnTipoDeValor = 11
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .T. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 12
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .T. )
			case tnTipoDeValor = 13
				addproperty( loRetorno, 'DescripcionEntrega', .F. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .F. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .T. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			case tnTipoDeValor = 14
				addproperty( loRetorno, 'DescripcionEntrega', .T. )
				addproperty( loRetorno, 'Descripcionrecibe', .F. )
				addproperty( loRetorno, 'FechaEntrega', .F. )
				addproperty( loRetorno, 'FechaRecibe', .F. )
				addproperty( loRetorno, 'nroInternoEntrega', .F. )
				addproperty( loRetorno, 'nroInternoRecibe', .T. )
				addproperty( loRetorno, 'importeRecibe', .T. )
				addproperty( loRetorno, 'importeEntrega', .T. )
				addproperty( loRetorno, 'PermiteVuelto', .F. )
				addproperty( loRetorno, 'PersonalizarComprobante', .F. )
			Otherwise
				addproperty( loRetorno, 'DescripcionEntrega', .t. )
				addproperty( loRetorno, 'Descripcionrecibe', .t. )
				addproperty( loRetorno, 'FechaEntrega', .t. )
				addproperty( loRetorno, 'FechaRecibe', .t. )
				addproperty( loRetorno, 'nroInternoEntrega', .t. )
				addproperty( loRetorno, 'nroInternoRecibe', .t. )
				addproperty( loRetorno, 'importeRecibe', .t. )
				addproperty( loRetorno, 'importeEntrega', .t. )
				addproperty( loRetorno, 'PermiteVuelto', .t. )
				addproperty( loRetorno, 'PersonalizarComprobante', .t. )
		endcase
		return loRetorno
	endfunc

enddefine