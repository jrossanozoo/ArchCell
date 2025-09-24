
define class Din_EntidadSELECCIONPARAINSERTAR as ent_virtual of ent_virtual.prg

	cNombre = 'SELECCIONPARAINSERTAR'
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	Entidad = []
	Observacion = []
	IMPRESIONDEETIQUETA_PK = 0
	IMPRESIONDEETIQUETA = null
	FERIADO_PK = 0
	FERIADO = null
	VERSIONMODIFICACIONFW = []
	VERSIONALTAFW = []
	USUARIOMODIFICACIONFW = []
	ZADSFW = []
	BASEDEDATOSALTAFW = []
	BASEDEDATOSMODIFICACIONFW = []
	HORAALTAFW = []
	ESTADOTRANSFERENCIA = []
	SERIEMODIFICACIONFW = []
	USUARIOALTAFW = []
	SERIEALTAFW = []
	HORAEXPO = []
	HORAIMPO = []
	HORAMODIFICACIONFW = []
	TIMESTAMP = 0
	Descripcion = []
	PRESUPUESTO_PK = []
	PRESUPUESTO = null
	PREPARACIONDEMERCADERIA_PK = []
	PREPARACIONDEMERCADERIA = null
	PRESUPUESTODECOMPRA_PK = []
	PRESUPUESTODECOMPRA = null
	PEDIDO_PK = []
	PEDIDO = null
	REMITO_PK = []
	REMITO = null
	REMITODECOMPRA_PK = []
	REMITODECOMPRA = null
	PEDIDODECOMPRA_PK = []
	PEDIDODECOMPRA = null
	SOLICITUDDECOMPRA_PK = []
	SOLICITUDDECOMPRA = null
	TICKETNOTADEDEBITO_PK = []
	TICKETNOTADEDEBITO = null
	REQUERIMIENTODECOMPRA_PK = []
	REQUERIMIENTODECOMPRA = null
	NOTADEDEBITOELECTRONICADECREDITO_PK = []
	NOTADEDEBITOELECTRONICADECREDITO = null
	NOTADEDEBITO_PK = []
	NOTADEDEBITO = null
	FACTURAELECTRONICAEXPORTACION_PK = []
	FACTURAELECTRONICAEXPORTACION = null
	FACTURAELECTRONICADECREDITO_PK = []
	FACTURAELECTRONICADECREDITO = null
	FACTURAELECTRONICA_PK = []
	FACTURAELECTRONICA = null
	FACTURA_PK = []
	FACTURA = null
	MERCADERIAENTRANSITO_PK = []
	MERCADERIAENTRANSITO = null
	FINALDEPRODUCCION_PK = []
	FINALDEPRODUCCION = null
	FACTURADEEXPORTACION_PK = []
	FACTURADEEXPORTACION = null
	FACTURADECOMPRA_PK = []
	FACTURADECOMPRA = null
	BOLSASYCAJAS_PK = []
	BOLSASYCAJAS = null
	ASIENTO_PK = []
	ASIENTO = null
	CANCELACIONDECOMPRA_PK = []
	CANCELACIONDECOMPRA = null
	CLIENTE_PK = []
	CLIENTE = null
	DEVOLUCION_PK = []
	DEVOLUCION = null
	DATOSFISCALES_PK = []
	DATOSFISCALES = null
	MODIFICACIONPRECIOS_PK = []
	MODIFICACIONPRECIOS = null
	MOVIMIENTOSTOCKAINVENT_PK = []
	MOVIMIENTOSTOCKAINVENT = null
	MOVIMIENTODESTOCK_PK = []
	MOVIMIENTODESTOCK = null
	NOTADECREDITO_PK = []
	NOTADECREDITO = null
	NOTADECREDITOELECTRONICA_PK = []
	NOTADECREDITOELECTRONICA = null
	NOTADEDEBITOCOMPRA_PK = []
	NOTADEDEBITOCOMPRA = null
	NOTADEDEBITODEEXPORTACION_PK = []
	NOTADEDEBITODEEXPORTACION = null
	NOTADEDEBITOELECTRONICAEXPORTACION_PK = []
	NOTADEDEBITOELECTRONICAEXPORTACION = null
	cAtributoPK = 'Codigo'
	Codigo = []
	NOTADECREDITOELECTRONICAEXPORTACION_PK = []
	NOTADECREDITOELECTRONICAEXPORTACION = null
	NOTADECREDITOELECTRONICADECREDITO_PK = []
	NOTADECREDITOELECTRONICADECREDITO = null
	MOVIMIENTOSTOCKDESDEPRODUCC_PK = []
	MOVIMIENTOSTOCKDESDEPRODUCC = null
	MOVIMIENTOSTOCKAPRODUCC_PK = []
	MOVIMIENTOSTOCKAPRODUCC = null
	NOTADECREDITOCOMPRA_PK = []
	NOTADECREDITOCOMPRA = null
	NOTADECREDITODEEXPORTACION_PK = []
	NOTADECREDITODEEXPORTACION = null
	NOTADEDEBITOELECTRONICA_PK = []
	NOTADEDEBITOELECTRONICA = null
	TICKETNOTADECREDITO_PK = []
	TICKETNOTADECREDITO = null
	TICKETFACTURA_PK = []
	TICKETFACTURA = null
	Ordenar = .F.
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Selecciones de entidades]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigo_Assign( txVal as variant ) as void
		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean
		with this
			llEdicion = .EsEdicion()
			if !this.lPermiteMinusculasPK
				try
					txVal = upper( txVal )
				Catch
				Endtry
			endif
			if .lLimpiando or .lCargando
				.Codigo = .TransformarAlAsignar( txVal )
			else
				if llEdicion
				else
					llNuevo = .EsNuevo()
					.Codigo = .TransformarAlAsignar( txVal )
					if empty( txVal ) and !llNuevo
						.Limpiar()
					else
						if llNuevo
							if .ValidarIngreso( txVal, llNuevo )
							else
								goServicios.Errores.LevantarExcepcion( 'Caracter inválido en el código.' )
							endif
						endif
						llConsulta = .oAD.ConsultarPorClavePrimaria()
						do case
							case !llNuevo and llConsulta
								.Cargar()
							case !llNuevo and !llConsulta
								.Limpiar()
								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )
							case llNuevo and llConsulta
								.Codigo = []
								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )
						endcase
					endif
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oAD_Access() as variant
		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )
			this.oAD = this.crearobjeto( 'Din_EntidadSELECCIONPARAINSERTARAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAIMPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAALTAFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Entidad) = 'C' )
			if len( alltrim( this.ENTIDAD ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo ENTIDAD es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ENTIDAD no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Observacion) = 'C' )
			if len( alltrim( this.OBSERVACION ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo OBSERVACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBSERVACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONALTAFW) = 'C' )
			if len( alltrim( this.VERSIONALTAFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAALTAFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEALTAFW) = 'C' )
			if len( alltrim( this.SERIEALTAFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TIMESTAMP) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIMESTAMP ) ) ) 
			lnValorDelDecimal = this.TIMESTAMP - int( this.TIMESTAMP)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 20
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIMESTAMP es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIMESTAMP no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Descripcion) = 'C' )
			if len( alltrim( this.DESCRIPCION ) ) > 50
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Ordenar) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ORDENAR no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarImpresiondeetiqueta() and llRetorno
			llRetorno = .ValidarFeriado() and llRetorno
			llRetorno = .ValidarPresupuesto() and llRetorno
			llRetorno = .ValidarPreparaciondemercaderia() and llRetorno
			llRetorno = .ValidarPresupuestodecompra() and llRetorno
			llRetorno = .ValidarPedido() and llRetorno
			llRetorno = .ValidarRemito() and llRetorno
			llRetorno = .ValidarRemitodecompra() and llRetorno
			llRetorno = .ValidarPedidodecompra() and llRetorno
			llRetorno = .ValidarSolicituddecompra() and llRetorno
			llRetorno = .ValidarTicketnotadedebito() and llRetorno
			llRetorno = .ValidarRequerimientodecompra() and llRetorno
			llRetorno = .ValidarNotadedebitoelectronicadecredito() and llRetorno
			llRetorno = .ValidarNotadedebito() and llRetorno
			llRetorno = .ValidarFacturaelectronicaexportacion() and llRetorno
			llRetorno = .ValidarFacturaelectronicadecredito() and llRetorno
			llRetorno = .ValidarFacturaelectronica() and llRetorno
			llRetorno = .ValidarFactura() and llRetorno
			llRetorno = .ValidarMercaderiaentransito() and llRetorno
			llRetorno = .ValidarFinaldeproduccion() and llRetorno
			llRetorno = .ValidarFacturadeexportacion() and llRetorno
			llRetorno = .ValidarFacturadecompra() and llRetorno
			llRetorno = .ValidarBolsasycajas() and llRetorno
			llRetorno = .ValidarAsiento() and llRetorno
			llRetorno = .ValidarCancelaciondecompra() and llRetorno
			llRetorno = .ValidarCliente() and llRetorno
			llRetorno = .ValidarDevolucion() and llRetorno
			llRetorno = .ValidarDatosfiscales() and llRetorno
			llRetorno = .ValidarModificacionprecios() and llRetorno
			llRetorno = .ValidarMovimientostockainvent() and llRetorno
			llRetorno = .ValidarMovimientodestock() and llRetorno
			llRetorno = .ValidarNotadecredito() and llRetorno
			llRetorno = .ValidarNotadecreditoelectronica() and llRetorno
			llRetorno = .ValidarNotadedebitocompra() and llRetorno
			llRetorno = .ValidarNotadedebitodeexportacion() and llRetorno
			llRetorno = .ValidarNotadedebitoelectronicaexportacion() and llRetorno
			llRetorno = .ValidarNotadecreditoelectronicaexportacion() and llRetorno
			llRetorno = .ValidarNotadecreditoelectronicadecredito() and llRetorno
			llRetorno = .ValidarMovimientostockdesdeproducc() and llRetorno
			llRetorno = .ValidarMovimientostockaproducc() and llRetorno
			llRetorno = .ValidarNotadecreditocompra() and llRetorno
			llRetorno = .ValidarNotadecreditodeexportacion() and llRetorno
			llRetorno = .ValidarNotadedebitoelectronica() and llRetorno
			llRetorno = .ValidarTicketnotadecredito() and llRetorno
			llRetorno = .ValidarTicketfactura() and llRetorno
			llRetorno = .ValidacionAtributos() and llRetorno
			llRetorno = .ValidacionDetalles() and llRetorno
			if .VerificarContexto( 'CB' )
			else
				llRetorno = .ValidacionTimestamp() and llRetorno
			endif
		EndWith

		If Empty( this.CODIGO )
			llRetorno = .F.
			This.AgregarInformacion( 'No se puede grabar. Código Vacío', 0 )
		Endif
		if This.ValidarIngreso( transform( this.CODIGO ) )
		else
			llRetorno = .F.
			this.AgregarInformacion( 'Caracteres Inválidos en el código', 0 )
		EndIf
			return llRetorno and llVotacion

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionTimestamp() as Boolean
		Local lnTimestampactual as integer, llRetorno as boolean
		llRetorno = .T.
		if !this.EsNuevo() and this.EsEdicion()
			lnTimestampactual = this.oAd.ObtenerTimestampActual()
			if lnTimestampactual = this.Timestamp
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El registro fue modificado, no se pudo actualizar', this.ObtenerCodigoErrorParaValidacionTimestamp() )
			Endif
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionDetalles() as Boolean
		local llRetorno as boolean, llValAux as boolean
		llRetorno = dodefault()
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarIMPRESIONDEETIQUETA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.IMPRESIONDEETIQUETA_PK )
		else
			If this.IMPRESIONDEETIQUETA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.IMPRESIONDEETIQUETA_PK ))+ ' de la entidad ' +  upper( this.IMPRESIONDEETIQUETA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFERIADO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FERIADO_PK )
		else
			If this.FERIADO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FERIADO_PK ))+ ' de la entidad ' +  upper( this.FERIADO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPRESUPUESTO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PRESUPUESTO_PK )
		else
			If this.PRESUPUESTO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PRESUPUESTO_PK ))+ ' de la entidad ' +  upper( this.PRESUPUESTO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPREPARACIONDEMERCADERIA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PREPARACIONDEMERCADERIA_PK )
		else
			If this.PREPARACIONDEMERCADERIA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PREPARACIONDEMERCADERIA_PK ))+ ' de la entidad ' +  upper( this.PREPARACIONDEMERCADERIA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPRESUPUESTODECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PRESUPUESTODECOMPRA_PK )
		else
			If this.PRESUPUESTODECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PRESUPUESTODECOMPRA_PK ))+ ' de la entidad ' +  upper( this.PRESUPUESTODECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPEDIDO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PEDIDO_PK )
		else
			If this.PEDIDO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PEDIDO_PK ))+ ' de la entidad ' +  upper( this.PEDIDO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarREMITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.REMITO_PK )
		else
			If this.REMITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.REMITO_PK ))+ ' de la entidad ' +  upper( this.REMITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarREMITODECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.REMITODECOMPRA_PK )
		else
			If this.REMITODECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.REMITODECOMPRA_PK ))+ ' de la entidad ' +  upper( this.REMITODECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPEDIDODECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PEDIDODECOMPRA_PK )
		else
			If this.PEDIDODECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PEDIDODECOMPRA_PK ))+ ' de la entidad ' +  upper( this.PEDIDODECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarSOLICITUDDECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.SOLICITUDDECOMPRA_PK )
		else
			If this.SOLICITUDDECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.SOLICITUDDECOMPRA_PK ))+ ' de la entidad ' +  upper( this.SOLICITUDDECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTICKETNOTADEDEBITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.TICKETNOTADEDEBITO_PK )
		else
			If this.TICKETNOTADEDEBITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.TICKETNOTADEDEBITO_PK ))+ ' de la entidad ' +  upper( this.TICKETNOTADEDEBITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarREQUERIMIENTODECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.REQUERIMIENTODECOMPRA_PK )
		else
			If this.REQUERIMIENTODECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.REQUERIMIENTODECOMPRA_PK ))+ ' de la entidad ' +  upper( this.REQUERIMIENTODECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITOELECTRONICADECREDITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITOELECTRONICADECREDITO_PK )
		else
			If this.NOTADEDEBITOELECTRONICADECREDITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITOELECTRONICADECREDITO_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITOELECTRONICADECREDITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITO_PK )
		else
			If this.NOTADEDEBITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITO_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURAELECTRONICAEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURAELECTRONICAEXPORTACION_PK )
		else
			If this.FACTURAELECTRONICAEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURAELECTRONICAEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.FACTURAELECTRONICAEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURAELECTRONICADECREDITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURAELECTRONICADECREDITO_PK )
		else
			If this.FACTURAELECTRONICADECREDITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURAELECTRONICADECREDITO_PK ))+ ' de la entidad ' +  upper( this.FACTURAELECTRONICADECREDITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURAELECTRONICA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURAELECTRONICA_PK )
		else
			If this.FACTURAELECTRONICA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURAELECTRONICA_PK ))+ ' de la entidad ' +  upper( this.FACTURAELECTRONICA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURA_PK )
		else
			If this.FACTURA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURA_PK ))+ ' de la entidad ' +  upper( this.FACTURA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMERCADERIAENTRANSITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MERCADERIAENTRANSITO_PK )
		else
			If this.MERCADERIAENTRANSITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MERCADERIAENTRANSITO_PK ))+ ' de la entidad ' +  upper( this.MERCADERIAENTRANSITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFINALDEPRODUCCION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FINALDEPRODUCCION_PK )
		else
			If this.FINALDEPRODUCCION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FINALDEPRODUCCION_PK ))+ ' de la entidad ' +  upper( this.FINALDEPRODUCCION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURADEEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURADEEXPORTACION_PK )
		else
			If this.FACTURADEEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURADEEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.FACTURADEEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFACTURADECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FACTURADECOMPRA_PK )
		else
			If this.FACTURADECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.FACTURADECOMPRA_PK ))+ ' de la entidad ' +  upper( this.FACTURADECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarBOLSASYCAJAS() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.BOLSASYCAJAS_PK )
		else
			If this.BOLSASYCAJAS.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.BOLSASYCAJAS_PK ))+ ' de la entidad ' +  upper( this.BOLSASYCAJAS.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarASIENTO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.ASIENTO_PK )
		else
			If this.ASIENTO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.ASIENTO_PK ))+ ' de la entidad ' +  upper( this.ASIENTO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCANCELACIONDECOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CANCELACIONDECOMPRA_PK )
		else
			If this.CANCELACIONDECOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CANCELACIONDECOMPRA_PK ))+ ' de la entidad ' +  upper( this.CANCELACIONDECOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCLIENTE() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CLIENTE_PK )
		else
			If this.CLIENTE.oAD.ConsultarPorClavePrimaria()
				This.CLIENTE.oDesactivador.ValidarEstadoActivacion( this.CLIENTE_PK , goLibrerias.Valorvacioseguntipo( vartype(this.CLIENTE_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CLIENTE_PK ))+ ' de la entidad ' +  upper( this.CLIENTE.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDEVOLUCION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.DEVOLUCION_PK )
		else
			If this.DEVOLUCION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.DEVOLUCION_PK ))+ ' de la entidad ' +  upper( this.DEVOLUCION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDATOSFISCALES() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.DATOSFISCALES_PK )
		else
			If this.DATOSFISCALES.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.DATOSFISCALES_PK ))+ ' de la entidad ' +  upper( this.DATOSFISCALES.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMODIFICACIONPRECIOS() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MODIFICACIONPRECIOS_PK )
		else
			If this.MODIFICACIONPRECIOS.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MODIFICACIONPRECIOS_PK ))+ ' de la entidad ' +  upper( this.MODIFICACIONPRECIOS.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMOVIMIENTOSTOCKAINVENT() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MOVIMIENTOSTOCKAINVENT_PK )
		else
			If this.MOVIMIENTOSTOCKAINVENT.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MOVIMIENTOSTOCKAINVENT_PK ))+ ' de la entidad ' +  upper( this.MOVIMIENTOSTOCKAINVENT.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMOVIMIENTODESTOCK() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MOVIMIENTODESTOCK_PK )
		else
			If this.MOVIMIENTODESTOCK.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MOVIMIENTODESTOCK_PK ))+ ' de la entidad ' +  upper( this.MOVIMIENTODESTOCK.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITO_PK )
		else
			If this.NOTADECREDITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITO_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITOELECTRONICA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITOELECTRONICA_PK )
		else
			If this.NOTADECREDITOELECTRONICA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITOELECTRONICA_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITOELECTRONICA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITOCOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITOCOMPRA_PK )
		else
			If this.NOTADEDEBITOCOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITOCOMPRA_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITOCOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITODEEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITODEEXPORTACION_PK )
		else
			If this.NOTADEDEBITODEEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITODEEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITODEEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITOELECTRONICAEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITOELECTRONICAEXPORTACION_PK )
		else
			If this.NOTADEDEBITOELECTRONICAEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITOELECTRONICAEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITOELECTRONICAEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITOELECTRONICAEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITOELECTRONICAEXPORTACION_PK )
		else
			If this.NOTADECREDITOELECTRONICAEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITOELECTRONICAEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITOELECTRONICAEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITOELECTRONICADECREDITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITOELECTRONICADECREDITO_PK )
		else
			If this.NOTADECREDITOELECTRONICADECREDITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITOELECTRONICADECREDITO_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITOELECTRONICADECREDITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMOVIMIENTOSTOCKDESDEPRODUCC() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MOVIMIENTOSTOCKDESDEPRODUCC_PK )
		else
			If this.MOVIMIENTOSTOCKDESDEPRODUCC.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MOVIMIENTOSTOCKDESDEPRODUCC_PK ))+ ' de la entidad ' +  upper( this.MOVIMIENTOSTOCKDESDEPRODUCC.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMOVIMIENTOSTOCKAPRODUCC() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MOVIMIENTOSTOCKAPRODUCC_PK )
		else
			If this.MOVIMIENTOSTOCKAPRODUCC.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MOVIMIENTOSTOCKAPRODUCC_PK ))+ ' de la entidad ' +  upper( this.MOVIMIENTOSTOCKAPRODUCC.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITOCOMPRA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITOCOMPRA_PK )
		else
			If this.NOTADECREDITOCOMPRA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITOCOMPRA_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITOCOMPRA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADECREDITODEEXPORTACION() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADECREDITODEEXPORTACION_PK )
		else
			If this.NOTADECREDITODEEXPORTACION.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADECREDITODEEXPORTACION_PK ))+ ' de la entidad ' +  upper( this.NOTADECREDITODEEXPORTACION.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNOTADEDEBITOELECTRONICA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NOTADEDEBITOELECTRONICA_PK )
		else
			If this.NOTADEDEBITOELECTRONICA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.NOTADEDEBITOELECTRONICA_PK ))+ ' de la entidad ' +  upper( this.NOTADEDEBITOELECTRONICA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTICKETNOTADECREDITO() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.TICKETNOTADECREDITO_PK )
		else
			If this.TICKETNOTADECREDITO.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.TICKETNOTADECREDITO_PK ))+ ' de la entidad ' +  upper( this.TICKETNOTADECREDITO.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTICKETFACTURA() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.TICKETFACTURA_PK )
		else
			If this.TICKETFACTURA.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.TICKETFACTURA_PK ))+ ' de la entidad ' +  upper( this.TICKETFACTURA.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Grabar() As Void
	Local llRetorno As Boolean, llValidar as boolean, ;
	loEx As Exception, loError As Exception, llNuevo as Boolean, llEdicion as Boolean, llErrorAlValidar as Boolean 

	llValidar = .F.
	This.LimpiarRegistrosDeActividadAlGrabar()
	

	With This
		llNuevo = .EsNuevo()
		llEdicion = .EsEdicion()
		if llNuevo or llEdicion
			try
				.lProcesando = .T.
				this.ActualizarProgressBar( 20 )
				.LimpiarInformacion()
				this.ActualizarProgressBar( 30 )
				local lcAgrupadorDeActividad as String
				lcAgrupadorDeActividad = '<GDA:' + sys( 2015 ) + '>'
				This.IniciarRegistroDeActividadExtendido( 'Grabar' )
				This.IniciarRegistroDeActividadExtendido( 'AntesDeGrabar' )
				If .AntesDeGrabar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'AntesDeGrabar' )
					this.ActualizarProgressBar( 40 )
				try
					This.IniciarRegistroDeActividadExtendido( 'Validar' )
					llValidar = .Validar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'Validar' )
				Catch To loError
					llErrorAlValidar = .t.
					.ErrorAlValidar()
					This.EliminarRegistrosDeActividad()
					goServicios.Errores.LevantarExcepcion( loError )
				finally
					if !llErrorAlValidar and !llValidar
						.ErrorAlValidar()
					endif
				endtry
					this.ActualizarProgressBar( 60 )
					If llValidar
						try
							this.ActualizarProgressBar( 70 )
							.SetearComponentes()
							this.ActualizarProgressBar( 80 )
							if llNuevo
								This.IniciarRegistroDeActividadExtendido( 'oAD_Insertar' )
								lxCodigo = .oAD.Insertar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Insertar' )
								
							else
								This.IniciarRegistroDeActividadExtendido( 'oAD_Actualizar' )
								.oAD.Actualizar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Actualizar' )
							endif
							this.ActualizarProgressBar( 90 )
						Catch To loError
							This.EliminarRegistrosDeActividad()
							goServicios.Errores.LevantarExcepcion( loError )
						Finally
						EndTry
						This.IniciarRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Try
							llValidar = .DespuesDeGrabar()
						Catch to loError
							llValidar = .T.
							loEx = Newobject( 'ZooException', 'ZooException.prg' )
							loEx.Grabar( loError )
							This.oMensaje.Advertir( 'Se ha producido una excepción no controlada durante el proceso posterior a la grabación.Verifique el log de errores para mas detalles.')
						EndTry
						This.EstablecerTiemposEnRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Store .F. To .lEdicion , .lNuevo
						.actualizarEstado()
					endif
				endif
			Catch To loError
				This.EliminarRegistrosDeActividad()
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Grabar( loError )
					.Throw()
				EndWith
			finally
				.lProcesando = .F.
			EndTry
		else
			This.EliminarRegistrosDeActividad()
			local loEx as Object
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'Error al intentar Grabar'
				.Details = 'No se puede grabar sin estar en estado NUEVO o EDICION'
				.Grabar()
				.Throw()
			endwith
		endif
		
		If llValidar
			This.EstablecerTiemposEnRegistroDeActividadExtendido( 'Grabar' )
			lcAgrupadorDeActividad = lcAgrupadorDeActividad + '<PK:' + transform( This.CODIGO ) + '>'
			This.FinalizarRegistrosDeActividad( lcAgrupadorDeActividad )
		else
			This.EliminarRegistrosDeActividad()
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			loEx.oInformacion = .ObtenerInformacion()
			loEx.Throw()
		Endif
	Endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _Nuevo() As Boolean

		if this.EsNuevo()
			goServicios.Errores.LevantarExcepcion( "Cancele o grabe antes de intentar hacer 'Nuevo'." )
		else
			With This
				.lEdicion = .F.
				.lAnular = .F.
				.lNuevo = .T.
				.limpiar()
				.actualizarEstado()
				.SetearColeccionSentenciasAnterior_NUEVO()
			endwith
		endif

		dodefault()
		This.InicializarComponentes( .T. )

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Modificar() As void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception

		With This
			llValidacion = .ValidarPK()
			If llValidacion
				.Buscar()
				.Cargar()
				.SetearColeccionSentenciasAnterior_MODIFICAR()
				.lEdicion = .T.
				.lNuevo = .F.
				.lAnular = .F.
				.actualizarEstado()
			else
				loEx = _screen.zoo.crearObjeto( 'zooException' )
				loEx.oInformacion = this.oInformacion
				loEx.Throw()
			Endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected function _EliminarSinValidaciones() as Void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception
		llVotacion = .T.
		With This
			if .lEliminar
				llValidacion = .ValidarPK()
				If llValidacion
				.SetearColeccionSentenciasAnterior_Eliminar()
					Store .F. To .lEdicion, .lNuevo
					.oAD.Eliminar()
					.actualizarEstado()
				else
					loEx = _screen.zoo.crearObjeto( 'zooException' )
					loEx.oInformacion = this.oInformacion
					loEx.throw()
				endif
			endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Cancelar() As void
		local loEx As zooException of zooException.prg 

		With This

			Do Case
				case .lNuevo
					Store .F. To .lEdicion, .lNuevo
					.limpiar()

				case !.lNuevo and !.lEdicion
					loEx = Newobject( 'ZooException', 'ZooException.prg' )
					With loEx
						.Message = 'Error al intentar hacer cancelar'
						.Details = "Para hacer 'Cancelar' debe estar en modo Nuevo o Edicion"
						.Grabar()
						.Throw()
					endwith

				otherwise
					.Buscar()
					.Cargar()
					Store .F. To .lEdicion, .lNuevo

			EndCase
			.actualizarEstado()
		EndWith

		dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado  de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		else
			llRetorno = this.oAD.ConsultarPorClavePrimaria()
			lcMensaje = 'El dato buscado ' + alltrim( transform( This.CODIGO ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		endif
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( lcMensaje )
		endif
	endfunc	
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_NUEVO() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<SINTOOLBAR><NOLISTAGENERICO><NOIMPO><NOEXPO><NOREST>'
	Endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .F.
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'SELECCIONPARAINSERTAR', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impresiondeetiqueta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Impresiondeetiqueta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Impresiondeetiqueta_PK = lxVal

		if this.Validar_Impresiondeetiqueta( lxVal, lxValOld )
			This.Setear_Impresiondeetiqueta( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Feriado_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Feriado_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Feriado_PK = lxVal

		if this.Validar_Feriado( lxVal, lxValOld )
			This.Setear_Feriado( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Presupuesto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Presupuesto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Presupuesto_PK = lxVal

		if this.Validar_Presupuesto( lxVal, lxValOld )
			This.Setear_Presupuesto( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preparaciondemercaderia_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preparaciondemercaderia_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Preparaciondemercaderia_PK = lxVal

		if this.Validar_Preparaciondemercaderia( lxVal, lxValOld )
			This.Setear_Preparaciondemercaderia( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Presupuestodecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Presupuestodecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Presupuestodecompra_PK = lxVal

		if this.Validar_Presupuestodecompra( lxVal, lxValOld )
			This.Setear_Presupuestodecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pedido_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pedido_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Pedido_PK = lxVal

		if this.Validar_Pedido( lxVal, lxValOld )
			This.Setear_Pedido( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Remito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Remito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Remito_PK = lxVal

		if this.Validar_Remito( lxVal, lxValOld )
			This.Setear_Remito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Remitodecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Remitodecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Remitodecompra_PK = lxVal

		if this.Validar_Remitodecompra( lxVal, lxValOld )
			This.Setear_Remitodecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pedidodecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pedidodecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Pedidodecompra_PK = lxVal

		if this.Validar_Pedidodecompra( lxVal, lxValOld )
			This.Setear_Pedidodecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Solicituddecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Solicituddecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Solicituddecompra_PK = lxVal

		if this.Validar_Solicituddecompra( lxVal, lxValOld )
			This.Setear_Solicituddecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketnotadedebito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ticketnotadedebito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Ticketnotadedebito_PK = lxVal

		if this.Validar_Ticketnotadedebito( lxVal, lxValOld )
			This.Setear_Ticketnotadedebito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Requerimientodecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Requerimientodecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Requerimientodecompra_PK = lxVal

		if this.Validar_Requerimientodecompra( lxVal, lxValOld )
			This.Setear_Requerimientodecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronicadecredito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebitoelectronicadecredito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebitoelectronicadecredito_PK = lxVal

		if this.Validar_Notadedebitoelectronicadecredito( lxVal, lxValOld )
			This.Setear_Notadedebitoelectronicadecredito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebito_PK = lxVal

		if this.Validar_Notadedebito( lxVal, lxValOld )
			This.Setear_Notadedebito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronicaexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facturaelectronicaexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Facturaelectronicaexportacion_PK = lxVal

		if this.Validar_Facturaelectronicaexportacion( lxVal, lxValOld )
			This.Setear_Facturaelectronicaexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronicadecredito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facturaelectronicadecredito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Facturaelectronicadecredito_PK = lxVal

		if this.Validar_Facturaelectronicadecredito( lxVal, lxValOld )
			This.Setear_Facturaelectronicadecredito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronica_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facturaelectronica_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Facturaelectronica_PK = lxVal

		if this.Validar_Facturaelectronica( lxVal, lxValOld )
			This.Setear_Facturaelectronica( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Factura_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Factura_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Factura_PK = lxVal

		if this.Validar_Factura( lxVal, lxValOld )
			This.Setear_Factura( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Mercaderiaentransito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Mercaderiaentransito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Mercaderiaentransito_PK = lxVal

		if this.Validar_Mercaderiaentransito( lxVal, lxValOld )
			This.Setear_Mercaderiaentransito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Finaldeproduccion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Finaldeproduccion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Finaldeproduccion_PK = lxVal

		if this.Validar_Finaldeproduccion( lxVal, lxValOld )
			This.Setear_Finaldeproduccion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadeexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facturadeexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Facturadeexportacion_PK = lxVal

		if this.Validar_Facturadeexportacion( lxVal, lxValOld )
			This.Setear_Facturadeexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facturadecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Facturadecompra_PK = lxVal

		if this.Validar_Facturadecompra( lxVal, lxValOld )
			This.Setear_Facturadecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bolsasycajas_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bolsasycajas_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Bolsasycajas_PK = lxVal

		if this.Validar_Bolsasycajas( lxVal, lxValOld )
			This.Setear_Bolsasycajas( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Asiento_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Asiento_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Asiento.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Asiento )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Asiento_PK = lxVal

		if this.Validar_Asiento( lxVal, lxValOld )
			This.Setear_Asiento( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cancelaciondecompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cancelaciondecompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Cancelaciondecompra_PK = lxVal

		if this.Validar_Cancelaciondecompra( lxVal, lxValOld )
			This.Setear_Cancelaciondecompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Cliente_PK = lxVal

		if this.Validar_Cliente( lxVal, lxValOld )
			This.Setear_Cliente( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Devolucion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Devolucion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Devolucion_PK = lxVal

		if this.Validar_Devolucion( lxVal, lxValOld )
			This.Setear_Devolucion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Datosfiscales_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Datosfiscales_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 8, padr( lxVal, 8 ), lxVal )
		this.Datosfiscales_PK = lxVal

		if this.Validar_Datosfiscales( lxVal, lxValOld )
			This.Setear_Datosfiscales( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Modificacionprecios_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Modificacionprecios_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Modificacionprecios.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Modificacionprecios )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Modificacionprecios_PK = lxVal

		if this.Validar_Modificacionprecios( lxVal, lxValOld )
			This.Setear_Modificacionprecios( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockainvent_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movimientostockainvent_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Movimientostockainvent_PK = lxVal

		if this.Validar_Movimientostockainvent( lxVal, lxValOld )
			This.Setear_Movimientostockainvent( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientodestock_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movimientodestock_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Movimientodestock_PK = lxVal

		if this.Validar_Movimientodestock( lxVal, lxValOld )
			This.Setear_Movimientodestock( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecredito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecredito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecredito_PK = lxVal

		if this.Validar_Notadecredito( lxVal, lxValOld )
			This.Setear_Notadecredito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronica_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecreditoelectronica_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecreditoelectronica_PK = lxVal

		if this.Validar_Notadecreditoelectronica( lxVal, lxValOld )
			This.Setear_Notadecreditoelectronica( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitocompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebitocompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebitocompra_PK = lxVal

		if this.Validar_Notadedebitocompra( lxVal, lxValOld )
			This.Setear_Notadedebitocompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitodeexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebitodeexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebitodeexportacion_PK = lxVal

		if this.Validar_Notadedebitodeexportacion( lxVal, lxValOld )
			This.Setear_Notadedebitodeexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronicaexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebitoelectronicaexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebitoelectronicaexportacion_PK = lxVal

		if this.Validar_Notadedebitoelectronicaexportacion( lxVal, lxValOld )
			This.Setear_Notadedebitoelectronicaexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronicaexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecreditoelectronicaexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecreditoelectronicaexportacion_PK = lxVal

		if this.Validar_Notadecreditoelectronicaexportacion( lxVal, lxValOld )
			This.Setear_Notadecreditoelectronicaexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronicadecredito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecreditoelectronicadecredito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecreditoelectronicadecredito_PK = lxVal

		if this.Validar_Notadecreditoelectronicadecredito( lxVal, lxValOld )
			This.Setear_Notadecreditoelectronicadecredito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockdesdeproducc_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movimientostockdesdeproducc_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Movimientostockdesdeproducc_PK = lxVal

		if this.Validar_Movimientostockdesdeproducc( lxVal, lxValOld )
			This.Setear_Movimientostockdesdeproducc( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockaproducc_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movimientostockaproducc_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Movimientostockaproducc_PK = lxVal

		if this.Validar_Movimientostockaproducc( lxVal, lxValOld )
			This.Setear_Movimientostockaproducc( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditocompra_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecreditocompra_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecreditocompra_PK = lxVal

		if this.Validar_Notadecreditocompra( lxVal, lxValOld )
			This.Setear_Notadecreditocompra( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditodeexportacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecreditodeexportacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadecreditodeexportacion_PK = lxVal

		if this.Validar_Notadecreditodeexportacion( lxVal, lxValOld )
			This.Setear_Notadecreditodeexportacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronica_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadedebitoelectronica_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Notadedebitoelectronica_PK = lxVal

		if this.Validar_Notadedebitoelectronica( lxVal, lxValOld )
			This.Setear_Notadedebitoelectronica( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketnotadecredito_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ticketnotadecredito_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Ticketnotadecredito_PK = lxVal

		if this.Validar_Ticketnotadecredito( lxVal, lxValOld )
			This.Setear_Ticketnotadecredito( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketfactura_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ticketfactura_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Ticketfactura_PK = lxVal

		if this.Validar_Ticketfactura( lxVal, lxValOld )
			This.Setear_Ticketfactura( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impresiondeetiqueta( txVal as variant ) as void

		this.Impresiondeetiqueta.NUMERO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Feriado( txVal as variant ) as void

		this.Feriado.ANIO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Presupuesto( txVal as variant ) as void

		this.Presupuesto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preparaciondemercaderia( txVal as variant ) as void

		this.Preparaciondemercaderia.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Presupuestodecompra( txVal as variant ) as void

		this.Presupuestodecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pedido( txVal as variant ) as void

		this.Pedido.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Remito( txVal as variant ) as void

		this.Remito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Remitodecompra( txVal as variant ) as void

		this.Remitodecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pedidodecompra( txVal as variant ) as void

		this.Pedidodecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Solicituddecompra( txVal as variant ) as void

		this.Solicituddecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ticketnotadedebito( txVal as variant ) as void

		this.Ticketnotadedebito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Requerimientodecompra( txVal as variant ) as void

		this.Requerimientodecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebitoelectronicadecredito( txVal as variant ) as void

		this.Notadedebitoelectronicadecredito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebito( txVal as variant ) as void

		this.Notadedebito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facturaelectronicaexportacion( txVal as variant ) as void

		this.Facturaelectronicaexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facturaelectronicadecredito( txVal as variant ) as void

		this.Facturaelectronicadecredito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facturaelectronica( txVal as variant ) as void

		this.Facturaelectronica.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Factura( txVal as variant ) as void

		this.Factura.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Mercaderiaentransito( txVal as variant ) as void

		this.Mercaderiaentransito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Finaldeproduccion( txVal as variant ) as void

		this.Finaldeproduccion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facturadeexportacion( txVal as variant ) as void

		this.Facturadeexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facturadecompra( txVal as variant ) as void

		this.Facturadecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bolsasycajas( txVal as variant ) as void

		this.Bolsasycajas.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Asiento( txVal as variant ) as void

		this.Asiento.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cancelaciondecompra( txVal as variant ) as void

		this.Cancelaciondecompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Devolucion( txVal as variant ) as void

		this.Devolucion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Datosfiscales( txVal as variant ) as void

		this.Datosfiscales.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Modificacionprecios( txVal as variant ) as void

		this.Modificacionprecios.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movimientostockainvent( txVal as variant ) as void

		this.Movimientostockainvent.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movimientodestock( txVal as variant ) as void

		this.Movimientodestock.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecredito( txVal as variant ) as void

		this.Notadecredito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecreditoelectronica( txVal as variant ) as void

		this.Notadecreditoelectronica.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebitocompra( txVal as variant ) as void

		this.Notadedebitocompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebitodeexportacion( txVal as variant ) as void

		this.Notadedebitodeexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebitoelectronicaexportacion( txVal as variant ) as void

		this.Notadedebitoelectronicaexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecreditoelectronicaexportacion( txVal as variant ) as void

		this.Notadecreditoelectronicaexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecreditoelectronicadecredito( txVal as variant ) as void

		this.Notadecreditoelectronicadecredito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movimientostockdesdeproducc( txVal as variant ) as void

		this.Movimientostockdesdeproducc.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movimientostockaproducc( txVal as variant ) as void

		this.Movimientostockaproducc.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecreditocompra( txVal as variant ) as void

		this.Notadecreditocompra.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecreditodeexportacion( txVal as variant ) as void

		this.Notadecreditodeexportacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadedebitoelectronica( txVal as variant ) as void

		this.Notadedebitoelectronica.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ticketnotadecredito( txVal as variant ) as void

		this.Ticketnotadecredito.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ticketfactura( txVal as variant ) as void

		this.Ticketfactura.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impresiondeetiqueta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Feriado( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Presupuesto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preparaciondemercaderia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Presupuestodecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pedido( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Remito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Remitodecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pedidodecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Solicituddecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ticketnotadedebito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Requerimientodecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebitoelectronicadecredito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facturaelectronicaexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facturaelectronicadecredito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facturaelectronica( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Factura( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Mercaderiaentransito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Finaldeproduccion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facturadeexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facturadecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bolsasycajas( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Asiento( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cancelaciondecompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Devolucion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Datosfiscales( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Modificacionprecios( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movimientostockainvent( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movimientodestock( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecredito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecreditoelectronica( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebitocompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebitodeexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebitoelectronicaexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecreditoelectronicaexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecreditoelectronicadecredito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movimientostockdesdeproducc( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movimientostockaproducc( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecreditocompra( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecreditodeexportacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadedebitoelectronica( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ticketnotadecredito( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ticketfactura( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechatransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechatransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechatransferencia( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechatransferencia( lxVal )
			EndIf
		Else
			This.Setear_Fechatransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaexpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaexpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechamodificacionfw( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Fechamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaimpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaimpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaaltafw( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Fechaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entidad( lxVal )
				this.Setear_Entidad( lxVal )
			EndIf
		Else
			This.Setear_Entidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Observacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Observacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Observacion( lxVal )
				this.Setear_Observacion( lxVal )
			EndIf
		Else
			This.Setear_Observacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionmodificacionfw( lxVal )
				this.Setear_Versionmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Versionmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionaltafw( lxVal )
				this.Setear_Versionaltafw( lxVal )
			EndIf
		Else
			This.Setear_Versionaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuariomodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuariomodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuariomodificacionfw( lxVal )
				this.Setear_Usuariomodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Usuariomodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Zadsfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Zadsfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Zadsfw( lxVal )
				this.Setear_Zadsfw( lxVal )
			EndIf
		Else
			This.Setear_Zadsfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosaltafw( lxVal )
				this.Setear_Basededatosaltafw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosmodificacionfw( lxVal )
				this.Setear_Basededatosmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaaltafw( lxVal )
				this.Setear_Horaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Horaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadotransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadotransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadotransferencia( lxVal )
				this.Setear_Estadotransferencia( lxVal )
			EndIf
		Else
			This.Setear_Estadotransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriemodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriemodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriemodificacionfw( lxVal )
				this.Setear_Seriemodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Seriemodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuarioaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuarioaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuarioaltafw( lxVal )
				this.Setear_Usuarioaltafw( lxVal )
			EndIf
		Else
			This.Setear_Usuarioaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriealtafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriealtafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriealtafw( lxVal )
				this.Setear_Seriealtafw( lxVal )
			EndIf
		Else
			This.Setear_Seriealtafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaexpo( lxVal )
				this.Setear_Horaexpo( lxVal )
			EndIf
		Else
			This.Setear_Horaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaimpo( lxVal )
				this.Setear_Horaimpo( lxVal )
			EndIf
		Else
			This.Setear_Horaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horamodificacionfw( lxVal )
				this.Setear_Horamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Horamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Timestamp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Timestamp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Timestamp( lxVal )
				this.Setear_Timestamp( lxVal )
			EndIf
		Else
			This.Setear_Timestamp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcion( lxVal )
				this.Setear_Descripcion( lxVal )
			EndIf
		Else
			This.Setear_Descripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ordenar_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ordenar
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ordenar( lxVal )
				this.Setear_Ordenar( lxVal )
			EndIf
		Else
			This.Setear_Ordenar( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidad( txVal as variant ) as void

		this.Entidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ordenar( txVal as variant ) as void

		this.Ordenar = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ordenar( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impresiondeetiqueta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Impresiondeetiqueta ) = 'O' or isnull( this.Impresiondeetiqueta ) )
					this.Impresiondeetiqueta = _Screen.zoo.instanciarentidad( 'Impresiondeetiqueta' )
					this.Impresiondeetiqueta.lEsSubEntidad = .t.
					this.enlazar( 'Impresiondeetiqueta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Impresiondeetiqueta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Impresiondeetiqueta.NUMERO # this.Impresiondeetiqueta_PK
						this.Impresiondeetiqueta.NUMERO = this.Impresiondeetiqueta_PK
					endif
				endif
			endif
		endif
		return this.Impresiondeetiqueta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Feriado_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Feriado ) = 'O' or isnull( this.Feriado ) )
					this.Feriado = _Screen.zoo.instanciarentidad( 'Feriado' )
					this.Feriado.lEsSubEntidad = .t.
					this.enlazar( 'Feriado.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Feriado.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Feriado.ANIO # this.Feriado_PK
						this.Feriado.ANIO = this.Feriado_PK
					endif
				endif
			endif
		endif
		return this.Feriado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Presupuesto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Presupuesto ) = 'O' or isnull( this.Presupuesto ) )
					this.Presupuesto = _Screen.zoo.instanciarentidad( 'Presupuesto' )
					this.Presupuesto.lEsSubEntidad = .t.
					this.enlazar( 'Presupuesto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Presupuesto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Presupuesto.CODIGO # this.Presupuesto_PK
						this.Presupuesto.CODIGO = this.Presupuesto_PK
					endif
				endif
			endif
		endif
		return this.Presupuesto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preparaciondemercaderia_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Preparaciondemercaderia ) = 'O' or isnull( this.Preparaciondemercaderia ) )
					this.Preparaciondemercaderia = _Screen.zoo.instanciarentidad( 'Preparaciondemercaderia' )
					this.Preparaciondemercaderia.lEsSubEntidad = .t.
					this.enlazar( 'Preparaciondemercaderia.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Preparaciondemercaderia.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Preparaciondemercaderia.CODIGO # this.Preparaciondemercaderia_PK
						this.Preparaciondemercaderia.CODIGO = this.Preparaciondemercaderia_PK
					endif
				endif
			endif
		endif
		return this.Preparaciondemercaderia
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Presupuestodecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Presupuestodecompra ) = 'O' or isnull( this.Presupuestodecompra ) )
					this.Presupuestodecompra = _Screen.zoo.instanciarentidad( 'Presupuestodecompra' )
					this.Presupuestodecompra.lEsSubEntidad = .t.
					this.enlazar( 'Presupuestodecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Presupuestodecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Presupuestodecompra.CODIGO # this.Presupuestodecompra_PK
						this.Presupuestodecompra.CODIGO = this.Presupuestodecompra_PK
					endif
				endif
			endif
		endif
		return this.Presupuestodecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pedido_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Pedido ) = 'O' or isnull( this.Pedido ) )
					this.Pedido = _Screen.zoo.instanciarentidad( 'Pedido' )
					this.Pedido.lEsSubEntidad = .t.
					this.enlazar( 'Pedido.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Pedido.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Pedido.CODIGO # this.Pedido_PK
						this.Pedido.CODIGO = this.Pedido_PK
					endif
				endif
			endif
		endif
		return this.Pedido
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Remito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Remito ) = 'O' or isnull( this.Remito ) )
					this.Remito = _Screen.zoo.instanciarentidad( 'Remito' )
					this.Remito.lEsSubEntidad = .t.
					this.enlazar( 'Remito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Remito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Remito.CODIGO # this.Remito_PK
						this.Remito.CODIGO = this.Remito_PK
					endif
				endif
			endif
		endif
		return this.Remito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Remitodecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Remitodecompra ) = 'O' or isnull( this.Remitodecompra ) )
					this.Remitodecompra = _Screen.zoo.instanciarentidad( 'Remitodecompra' )
					this.Remitodecompra.lEsSubEntidad = .t.
					this.enlazar( 'Remitodecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Remitodecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Remitodecompra.CODIGO # this.Remitodecompra_PK
						this.Remitodecompra.CODIGO = this.Remitodecompra_PK
					endif
				endif
			endif
		endif
		return this.Remitodecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pedidodecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Pedidodecompra ) = 'O' or isnull( this.Pedidodecompra ) )
					this.Pedidodecompra = _Screen.zoo.instanciarentidad( 'Pedidodecompra' )
					this.Pedidodecompra.lEsSubEntidad = .t.
					this.enlazar( 'Pedidodecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Pedidodecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Pedidodecompra.CODIGO # this.Pedidodecompra_PK
						this.Pedidodecompra.CODIGO = this.Pedidodecompra_PK
					endif
				endif
			endif
		endif
		return this.Pedidodecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Solicituddecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Solicituddecompra ) = 'O' or isnull( this.Solicituddecompra ) )
					this.Solicituddecompra = _Screen.zoo.instanciarentidad( 'Solicituddecompra' )
					this.Solicituddecompra.lEsSubEntidad = .t.
					this.enlazar( 'Solicituddecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Solicituddecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Solicituddecompra.CODIGO # this.Solicituddecompra_PK
						this.Solicituddecompra.CODIGO = this.Solicituddecompra_PK
					endif
				endif
			endif
		endif
		return this.Solicituddecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketnotadedebito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Ticketnotadedebito ) = 'O' or isnull( this.Ticketnotadedebito ) )
					this.Ticketnotadedebito = _Screen.zoo.instanciarentidad( 'Ticketnotadedebito' )
					this.Ticketnotadedebito.lEsSubEntidad = .t.
					this.enlazar( 'Ticketnotadedebito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Ticketnotadedebito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Ticketnotadedebito.CODIGO # this.Ticketnotadedebito_PK
						this.Ticketnotadedebito.CODIGO = this.Ticketnotadedebito_PK
					endif
				endif
			endif
		endif
		return this.Ticketnotadedebito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Requerimientodecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Requerimientodecompra ) = 'O' or isnull( this.Requerimientodecompra ) )
					this.Requerimientodecompra = _Screen.zoo.instanciarentidad( 'Requerimientodecompra' )
					this.Requerimientodecompra.lEsSubEntidad = .t.
					this.enlazar( 'Requerimientodecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Requerimientodecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Requerimientodecompra.CODIGO # this.Requerimientodecompra_PK
						this.Requerimientodecompra.CODIGO = this.Requerimientodecompra_PK
					endif
				endif
			endif
		endif
		return this.Requerimientodecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronicadecredito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebitoelectronicadecredito ) = 'O' or isnull( this.Notadedebitoelectronicadecredito ) )
					this.Notadedebitoelectronicadecredito = _Screen.zoo.instanciarentidad( 'Notadedebitoelectronicadecredito' )
					this.Notadedebitoelectronicadecredito.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebitoelectronicadecredito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebitoelectronicadecredito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebitoelectronicadecredito.CODIGO # this.Notadedebitoelectronicadecredito_PK
						this.Notadedebitoelectronicadecredito.CODIGO = this.Notadedebitoelectronicadecredito_PK
					endif
				endif
			endif
		endif
		return this.Notadedebitoelectronicadecredito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebito ) = 'O' or isnull( this.Notadedebito ) )
					this.Notadedebito = _Screen.zoo.instanciarentidad( 'Notadedebito' )
					this.Notadedebito.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebito.CODIGO # this.Notadedebito_PK
						this.Notadedebito.CODIGO = this.Notadedebito_PK
					endif
				endif
			endif
		endif
		return this.Notadedebito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronicaexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Facturaelectronicaexportacion ) = 'O' or isnull( this.Facturaelectronicaexportacion ) )
					this.Facturaelectronicaexportacion = _Screen.zoo.instanciarentidad( 'Facturaelectronicaexportacion' )
					this.Facturaelectronicaexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Facturaelectronicaexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Facturaelectronicaexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Facturaelectronicaexportacion.CODIGO # this.Facturaelectronicaexportacion_PK
						this.Facturaelectronicaexportacion.CODIGO = this.Facturaelectronicaexportacion_PK
					endif
				endif
			endif
		endif
		return this.Facturaelectronicaexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronicadecredito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Facturaelectronicadecredito ) = 'O' or isnull( this.Facturaelectronicadecredito ) )
					this.Facturaelectronicadecredito = _Screen.zoo.instanciarentidad( 'Facturaelectronicadecredito' )
					this.Facturaelectronicadecredito.lEsSubEntidad = .t.
					this.enlazar( 'Facturaelectronicadecredito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Facturaelectronicadecredito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Facturaelectronicadecredito.CODIGO # this.Facturaelectronicadecredito_PK
						this.Facturaelectronicadecredito.CODIGO = this.Facturaelectronicadecredito_PK
					endif
				endif
			endif
		endif
		return this.Facturaelectronicadecredito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturaelectronica_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Facturaelectronica ) = 'O' or isnull( this.Facturaelectronica ) )
					this.Facturaelectronica = _Screen.zoo.instanciarentidad( 'Facturaelectronica' )
					this.Facturaelectronica.lEsSubEntidad = .t.
					this.enlazar( 'Facturaelectronica.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Facturaelectronica.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Facturaelectronica.CODIGO # this.Facturaelectronica_PK
						this.Facturaelectronica.CODIGO = this.Facturaelectronica_PK
					endif
				endif
			endif
		endif
		return this.Facturaelectronica
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Factura_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Factura ) = 'O' or isnull( this.Factura ) )
					this.Factura = _Screen.zoo.instanciarentidad( 'Factura' )
					this.Factura.lEsSubEntidad = .t.
					this.enlazar( 'Factura.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Factura.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Factura.CODIGO # this.Factura_PK
						this.Factura.CODIGO = this.Factura_PK
					endif
				endif
			endif
		endif
		return this.Factura
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Mercaderiaentransito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Mercaderiaentransito ) = 'O' or isnull( this.Mercaderiaentransito ) )
					this.Mercaderiaentransito = _Screen.zoo.instanciarentidad( 'Mercaderiaentransito' )
					this.Mercaderiaentransito.lEsSubEntidad = .t.
					this.enlazar( 'Mercaderiaentransito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Mercaderiaentransito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Mercaderiaentransito.CODIGO # this.Mercaderiaentransito_PK
						this.Mercaderiaentransito.CODIGO = this.Mercaderiaentransito_PK
					endif
				endif
			endif
		endif
		return this.Mercaderiaentransito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Finaldeproduccion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Finaldeproduccion ) = 'O' or isnull( this.Finaldeproduccion ) )
					this.Finaldeproduccion = _Screen.zoo.instanciarentidad( 'Finaldeproduccion' )
					this.Finaldeproduccion.lEsSubEntidad = .t.
					this.enlazar( 'Finaldeproduccion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Finaldeproduccion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Finaldeproduccion.CODIGO # this.Finaldeproduccion_PK
						this.Finaldeproduccion.CODIGO = this.Finaldeproduccion_PK
					endif
				endif
			endif
		endif
		return this.Finaldeproduccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadeexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Facturadeexportacion ) = 'O' or isnull( this.Facturadeexportacion ) )
					this.Facturadeexportacion = _Screen.zoo.instanciarentidad( 'Facturadeexportacion' )
					this.Facturadeexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Facturadeexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Facturadeexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Facturadeexportacion.CODIGO # this.Facturadeexportacion_PK
						this.Facturadeexportacion.CODIGO = this.Facturadeexportacion_PK
					endif
				endif
			endif
		endif
		return this.Facturadeexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facturadecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Facturadecompra ) = 'O' or isnull( this.Facturadecompra ) )
					this.Facturadecompra = _Screen.zoo.instanciarentidad( 'Facturadecompra' )
					this.Facturadecompra.lEsSubEntidad = .t.
					this.enlazar( 'Facturadecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Facturadecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Facturadecompra.CODIGO # this.Facturadecompra_PK
						this.Facturadecompra.CODIGO = this.Facturadecompra_PK
					endif
				endif
			endif
		endif
		return this.Facturadecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bolsasycajas_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Bolsasycajas ) = 'O' or isnull( this.Bolsasycajas ) )
					this.Bolsasycajas = _Screen.zoo.instanciarentidad( 'Bolsasycajas' )
					this.Bolsasycajas.lEsSubEntidad = .t.
					this.enlazar( 'Bolsasycajas.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Bolsasycajas.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Bolsasycajas.CODIGO # this.Bolsasycajas_PK
						this.Bolsasycajas.CODIGO = this.Bolsasycajas_PK
					endif
				endif
			endif
		endif
		return this.Bolsasycajas
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Asiento_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Asiento ) = 'O' or isnull( this.Asiento ) )
					this.Asiento = _Screen.zoo.instanciarentidad( 'Asiento' )
					this.Asiento.lEsSubEntidad = .t.
					this.enlazar( 'Asiento.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Asiento.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Asiento.CODIGO # this.Asiento_PK
						this.Asiento.CODIGO = this.Asiento_PK
					endif
				endif
			endif
		endif
		return this.Asiento
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cancelaciondecompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cancelaciondecompra ) = 'O' or isnull( this.Cancelaciondecompra ) )
					this.Cancelaciondecompra = _Screen.zoo.instanciarentidad( 'Cancelaciondecompra' )
					this.Cancelaciondecompra.lEsSubEntidad = .t.
					this.enlazar( 'Cancelaciondecompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cancelaciondecompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cancelaciondecompra.CODIGO # this.Cancelaciondecompra_PK
						this.Cancelaciondecompra.CODIGO = this.Cancelaciondecompra_PK
					endif
				endif
			endif
		endif
		return this.Cancelaciondecompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )
					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Cliente.lEsSubEntidad = .t.
					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente.CODIGO # this.Cliente_PK
						this.Cliente.CODIGO = this.Cliente_PK
					endif
				endif
			endif
		endif
		return this.Cliente
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Devolucion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Devolucion ) = 'O' or isnull( this.Devolucion ) )
					this.Devolucion = _Screen.zoo.instanciarentidad( 'Devolucion' )
					this.Devolucion.lEsSubEntidad = .t.
					this.enlazar( 'Devolucion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Devolucion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Devolucion.CODIGO # this.Devolucion_PK
						this.Devolucion.CODIGO = this.Devolucion_PK
					endif
				endif
			endif
		endif
		return this.Devolucion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Datosfiscales_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Datosfiscales ) = 'O' or isnull( this.Datosfiscales ) )
					this.Datosfiscales = _Screen.zoo.instanciarentidad( 'Datosfiscales' )
					this.Datosfiscales.lEsSubEntidad = .t.
					this.enlazar( 'Datosfiscales.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Datosfiscales.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Datosfiscales.CODIGO # this.Datosfiscales_PK
						this.Datosfiscales.CODIGO = this.Datosfiscales_PK
					endif
				endif
			endif
		endif
		return this.Datosfiscales
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Modificacionprecios_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Modificacionprecios ) = 'O' or isnull( this.Modificacionprecios ) )
					this.Modificacionprecios = _Screen.zoo.instanciarentidad( 'Modificacionprecios' )
					this.Modificacionprecios.lEsSubEntidad = .t.
					this.enlazar( 'Modificacionprecios.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Modificacionprecios.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Modificacionprecios.CODIGO # this.Modificacionprecios_PK
						this.Modificacionprecios.CODIGO = this.Modificacionprecios_PK
					endif
				endif
			endif
		endif
		return this.Modificacionprecios
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockainvent_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Movimientostockainvent ) = 'O' or isnull( this.Movimientostockainvent ) )
					this.Movimientostockainvent = _Screen.zoo.instanciarentidad( 'Movimientostockainvent' )
					this.Movimientostockainvent.lEsSubEntidad = .t.
					this.enlazar( 'Movimientostockainvent.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Movimientostockainvent.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Movimientostockainvent.CODIGO # this.Movimientostockainvent_PK
						this.Movimientostockainvent.CODIGO = this.Movimientostockainvent_PK
					endif
				endif
			endif
		endif
		return this.Movimientostockainvent
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientodestock_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Movimientodestock ) = 'O' or isnull( this.Movimientodestock ) )
					this.Movimientodestock = _Screen.zoo.instanciarentidad( 'Movimientodestock' )
					this.Movimientodestock.lEsSubEntidad = .t.
					this.enlazar( 'Movimientodestock.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Movimientodestock.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Movimientodestock.CODIGO # this.Movimientodestock_PK
						this.Movimientodestock.CODIGO = this.Movimientodestock_PK
					endif
				endif
			endif
		endif
		return this.Movimientodestock
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecredito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecredito ) = 'O' or isnull( this.Notadecredito ) )
					this.Notadecredito = _Screen.zoo.instanciarentidad( 'Notadecredito' )
					this.Notadecredito.lEsSubEntidad = .t.
					this.enlazar( 'Notadecredito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecredito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecredito.CODIGO # this.Notadecredito_PK
						this.Notadecredito.CODIGO = this.Notadecredito_PK
					endif
				endif
			endif
		endif
		return this.Notadecredito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronica_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecreditoelectronica ) = 'O' or isnull( this.Notadecreditoelectronica ) )
					this.Notadecreditoelectronica = _Screen.zoo.instanciarentidad( 'Notadecreditoelectronica' )
					this.Notadecreditoelectronica.lEsSubEntidad = .t.
					this.enlazar( 'Notadecreditoelectronica.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecreditoelectronica.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecreditoelectronica.CODIGO # this.Notadecreditoelectronica_PK
						this.Notadecreditoelectronica.CODIGO = this.Notadecreditoelectronica_PK
					endif
				endif
			endif
		endif
		return this.Notadecreditoelectronica
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitocompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebitocompra ) = 'O' or isnull( this.Notadedebitocompra ) )
					this.Notadedebitocompra = _Screen.zoo.instanciarentidad( 'Notadedebitocompra' )
					this.Notadedebitocompra.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebitocompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebitocompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebitocompra.CODIGO # this.Notadedebitocompra_PK
						this.Notadedebitocompra.CODIGO = this.Notadedebitocompra_PK
					endif
				endif
			endif
		endif
		return this.Notadedebitocompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitodeexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebitodeexportacion ) = 'O' or isnull( this.Notadedebitodeexportacion ) )
					this.Notadedebitodeexportacion = _Screen.zoo.instanciarentidad( 'Notadedebitodeexportacion' )
					this.Notadedebitodeexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebitodeexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebitodeexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebitodeexportacion.CODIGO # this.Notadedebitodeexportacion_PK
						this.Notadedebitodeexportacion.CODIGO = this.Notadedebitodeexportacion_PK
					endif
				endif
			endif
		endif
		return this.Notadedebitodeexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronicaexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebitoelectronicaexportacion ) = 'O' or isnull( this.Notadedebitoelectronicaexportacion ) )
					this.Notadedebitoelectronicaexportacion = _Screen.zoo.instanciarentidad( 'Notadedebitoelectronicaexportacion' )
					this.Notadedebitoelectronicaexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebitoelectronicaexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebitoelectronicaexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebitoelectronicaexportacion.CODIGO # this.Notadedebitoelectronicaexportacion_PK
						this.Notadedebitoelectronicaexportacion.CODIGO = this.Notadedebitoelectronicaexportacion_PK
					endif
				endif
			endif
		endif
		return this.Notadedebitoelectronicaexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronicaexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecreditoelectronicaexportacion ) = 'O' or isnull( this.Notadecreditoelectronicaexportacion ) )
					this.Notadecreditoelectronicaexportacion = _Screen.zoo.instanciarentidad( 'Notadecreditoelectronicaexportacion' )
					this.Notadecreditoelectronicaexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Notadecreditoelectronicaexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecreditoelectronicaexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecreditoelectronicaexportacion.CODIGO # this.Notadecreditoelectronicaexportacion_PK
						this.Notadecreditoelectronicaexportacion.CODIGO = this.Notadecreditoelectronicaexportacion_PK
					endif
				endif
			endif
		endif
		return this.Notadecreditoelectronicaexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditoelectronicadecredito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecreditoelectronicadecredito ) = 'O' or isnull( this.Notadecreditoelectronicadecredito ) )
					this.Notadecreditoelectronicadecredito = _Screen.zoo.instanciarentidad( 'Notadecreditoelectronicadecredito' )
					this.Notadecreditoelectronicadecredito.lEsSubEntidad = .t.
					this.enlazar( 'Notadecreditoelectronicadecredito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecreditoelectronicadecredito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecreditoelectronicadecredito.CODIGO # this.Notadecreditoelectronicadecredito_PK
						this.Notadecreditoelectronicadecredito.CODIGO = this.Notadecreditoelectronicadecredito_PK
					endif
				endif
			endif
		endif
		return this.Notadecreditoelectronicadecredito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockdesdeproducc_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Movimientostockdesdeproducc ) = 'O' or isnull( this.Movimientostockdesdeproducc ) )
					this.Movimientostockdesdeproducc = _Screen.zoo.instanciarentidad( 'Movimientostockdesdeproducc' )
					this.Movimientostockdesdeproducc.lEsSubEntidad = .t.
					this.enlazar( 'Movimientostockdesdeproducc.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Movimientostockdesdeproducc.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Movimientostockdesdeproducc.CODIGO # this.Movimientostockdesdeproducc_PK
						this.Movimientostockdesdeproducc.CODIGO = this.Movimientostockdesdeproducc_PK
					endif
				endif
			endif
		endif
		return this.Movimientostockdesdeproducc
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Movimientostockaproducc_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Movimientostockaproducc ) = 'O' or isnull( this.Movimientostockaproducc ) )
					this.Movimientostockaproducc = _Screen.zoo.instanciarentidad( 'Movimientostockaproducc' )
					this.Movimientostockaproducc.lEsSubEntidad = .t.
					this.enlazar( 'Movimientostockaproducc.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Movimientostockaproducc.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Movimientostockaproducc.CODIGO # this.Movimientostockaproducc_PK
						this.Movimientostockaproducc.CODIGO = this.Movimientostockaproducc_PK
					endif
				endif
			endif
		endif
		return this.Movimientostockaproducc
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditocompra_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecreditocompra ) = 'O' or isnull( this.Notadecreditocompra ) )
					this.Notadecreditocompra = _Screen.zoo.instanciarentidad( 'Notadecreditocompra' )
					this.Notadecreditocompra.lEsSubEntidad = .t.
					this.enlazar( 'Notadecreditocompra.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecreditocompra.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecreditocompra.CODIGO # this.Notadecreditocompra_PK
						this.Notadecreditocompra.CODIGO = this.Notadecreditocompra_PK
					endif
				endif
			endif
		endif
		return this.Notadecreditocompra
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecreditodeexportacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadecreditodeexportacion ) = 'O' or isnull( this.Notadecreditodeexportacion ) )
					this.Notadecreditodeexportacion = _Screen.zoo.instanciarentidad( 'Notadecreditodeexportacion' )
					this.Notadecreditodeexportacion.lEsSubEntidad = .t.
					this.enlazar( 'Notadecreditodeexportacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadecreditodeexportacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadecreditodeexportacion.CODIGO # this.Notadecreditodeexportacion_PK
						this.Notadecreditodeexportacion.CODIGO = this.Notadecreditodeexportacion_PK
					endif
				endif
			endif
		endif
		return this.Notadecreditodeexportacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadedebitoelectronica_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Notadedebitoelectronica ) = 'O' or isnull( this.Notadedebitoelectronica ) )
					this.Notadedebitoelectronica = _Screen.zoo.instanciarentidad( 'Notadedebitoelectronica' )
					this.Notadedebitoelectronica.lEsSubEntidad = .t.
					this.enlazar( 'Notadedebitoelectronica.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Notadedebitoelectronica.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Notadedebitoelectronica.CODIGO # this.Notadedebitoelectronica_PK
						this.Notadedebitoelectronica.CODIGO = this.Notadedebitoelectronica_PK
					endif
				endif
			endif
		endif
		return this.Notadedebitoelectronica
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketnotadecredito_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Ticketnotadecredito ) = 'O' or isnull( this.Ticketnotadecredito ) )
					this.Ticketnotadecredito = _Screen.zoo.instanciarentidad( 'Ticketnotadecredito' )
					this.Ticketnotadecredito.lEsSubEntidad = .t.
					this.enlazar( 'Ticketnotadecredito.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Ticketnotadecredito.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Ticketnotadecredito.CODIGO # this.Ticketnotadecredito_PK
						this.Ticketnotadecredito.CODIGO = this.Ticketnotadecredito_PK
					endif
				endif
			endif
		endif
		return this.Ticketnotadecredito
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ticketfactura_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Ticketfactura ) = 'O' or isnull( this.Ticketfactura ) )
					this.Ticketfactura = _Screen.zoo.instanciarentidad( 'Ticketfactura' )
					this.Ticketfactura.lEsSubEntidad = .t.
					this.enlazar( 'Ticketfactura.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Ticketfactura.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Ticketfactura.CODIGO # this.Ticketfactura_PK
						this.Ticketfactura.CODIGO = this.Ticketfactura_PK
					endif
				endif
			endif
		endif
		return this.Ticketfactura
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Versionmodificacionfw = []
				.Versionaltafw = []
				.Usuariomodificacionfw = []
				.Zadsfw = []
				.Basededatosaltafw = []
				.Basededatosmodificacionfw = []
				.Horaaltafw = []
				.Estadotransferencia = []
				.Seriemodificacionfw = []
				.Usuarioaltafw = []
				.Seriealtafw = []
				.Horaexpo = []
				.Horaimpo = []
				.Horamodificacionfw = []
				.Timestamp = 0
				.Codigo = []
				.LimpiarAtributosVirtuales()
				.oAD.Limpiar()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
				endif
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
				if !this.lEsSubEntidad
				if this.oColeccionVSFW.Buscar( "Fecha" )
					lcValorSugeridoFecha = this.oColeccionVSFW.Item[ "Fecha" ]
					&lcValorSugeridoFecha
				endif
				if this.oColeccionVSFW.Buscar( "Listadeprecios" )
					lcValorSugeridoListaDePrecios = this.oColeccionVSFW.Item[ "Listadeprecios" ]
					&lcValorSugeridoListaDePrecios
				endif
				for each ValorSugeridoPorEntidadSaltoDeCampo in this.oColeccionVS
					&ValorSugeridoPorEntidadSaltoDeCampo
				endfor
				endif
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEntidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Entidad" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Entidad' )
						.Entidad = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Entidad para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImpresiondeetiqueta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Impresiondeetiqueta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Impresiondeetiqueta_PK' )
						.Impresiondeetiqueta_PK = lvValorSugeridoDefinidoPorElUsuario
						.Impresiondeetiqueta.NUMERO = .Impresiondeetiqueta_PK
					endif
				endif
			Catch to loError
				.Impresiondeetiqueta_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFeriado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Feriado" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Feriado_PK' )
						.Feriado_PK = lvValorSugeridoDefinidoPorElUsuario
						.Feriado.ANIO = .Feriado_PK
					endif
				endif
			Catch to loError
				.Feriado_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Año para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPresupuesto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Presupuesto" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Presupuesto_PK' )
						.Presupuesto_PK = lvValorSugeridoDefinidoPorElUsuario
						.Presupuesto.CODIGO = .Presupuesto_PK
					endif
				endif
			Catch to loError
				.Presupuesto_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPreparaciondemercaderia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Preparaciondemercaderia" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Preparaciondemercaderia_PK' )
						.Preparaciondemercaderia_PK = lvValorSugeridoDefinidoPorElUsuario
						.Preparaciondemercaderia.CODIGO = .Preparaciondemercaderia_PK
					endif
				endif
			Catch to loError
				.Preparaciondemercaderia_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPresupuestodecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Presupuestodecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Presupuestodecompra_PK' )
						.Presupuestodecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Presupuestodecompra.CODIGO = .Presupuestodecompra_PK
					endif
				endif
			Catch to loError
				.Presupuestodecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPedido() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Pedido" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Pedido_PK' )
						.Pedido_PK = lvValorSugeridoDefinidoPorElUsuario
						.Pedido.CODIGO = .Pedido_PK
					endif
				endif
			Catch to loError
				.Pedido_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRemito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Remito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Remito_PK' )
						.Remito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Remito.CODIGO = .Remito_PK
					endif
				endif
			Catch to loError
				.Remito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRemitodecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Remitodecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Remitodecompra_PK' )
						.Remitodecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Remitodecompra.CODIGO = .Remitodecompra_PK
					endif
				endif
			Catch to loError
				.Remitodecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPedidodecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Pedidodecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Pedidodecompra_PK' )
						.Pedidodecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Pedidodecompra.CODIGO = .Pedidodecompra_PK
					endif
				endif
			Catch to loError
				.Pedidodecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSolicituddecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Solicituddecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Solicituddecompra_PK' )
						.Solicituddecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Solicituddecompra.CODIGO = .Solicituddecompra_PK
					endif
				endif
			Catch to loError
				.Solicituddecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTicketnotadedebito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Ticketnotadedebito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Ticketnotadedebito_PK' )
						.Ticketnotadedebito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Ticketnotadedebito.CODIGO = .Ticketnotadedebito_PK
					endif
				endif
			Catch to loError
				.Ticketnotadedebito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRequerimientodecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Requerimientodecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Requerimientodecompra_PK' )
						.Requerimientodecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Requerimientodecompra.CODIGO = .Requerimientodecompra_PK
					endif
				endif
			Catch to loError
				.Requerimientodecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebitoelectronicadecredito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebitoelectronicadecredito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebitoelectronicadecredito_PK' )
						.Notadedebitoelectronicadecredito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebitoelectronicadecredito.CODIGO = .Notadedebitoelectronicadecredito_PK
					endif
				endif
			Catch to loError
				.Notadedebitoelectronicadecredito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebito_PK' )
						.Notadedebito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebito.CODIGO = .Notadedebito_PK
					endif
				endif
			Catch to loError
				.Notadedebito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFacturaelectronicaexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Facturaelectronicaexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Facturaelectronicaexportacion_PK' )
						.Facturaelectronicaexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Facturaelectronicaexportacion.CODIGO = .Facturaelectronicaexportacion_PK
					endif
				endif
			Catch to loError
				.Facturaelectronicaexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFacturaelectronicadecredito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Facturaelectronicadecredito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Facturaelectronicadecredito_PK' )
						.Facturaelectronicadecredito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Facturaelectronicadecredito.CODIGO = .Facturaelectronicadecredito_PK
					endif
				endif
			Catch to loError
				.Facturaelectronicadecredito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFacturaelectronica() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Facturaelectronica" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Facturaelectronica_PK' )
						.Facturaelectronica_PK = lvValorSugeridoDefinidoPorElUsuario
						.Facturaelectronica.CODIGO = .Facturaelectronica_PK
					endif
				endif
			Catch to loError
				.Facturaelectronica_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFactura() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Factura" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Factura_PK' )
						.Factura_PK = lvValorSugeridoDefinidoPorElUsuario
						.Factura.CODIGO = .Factura_PK
					endif
				endif
			Catch to loError
				.Factura_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMercaderiaentransito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Mercaderiaentransito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Mercaderiaentransito_PK' )
						.Mercaderiaentransito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Mercaderiaentransito.CODIGO = .Mercaderiaentransito_PK
					endif
				endif
			Catch to loError
				.Mercaderiaentransito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFinaldeproduccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Finaldeproduccion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Finaldeproduccion_PK' )
						.Finaldeproduccion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Finaldeproduccion.CODIGO = .Finaldeproduccion_PK
					endif
				endif
			Catch to loError
				.Finaldeproduccion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFacturadeexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Facturadeexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Facturadeexportacion_PK' )
						.Facturadeexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Facturadeexportacion.CODIGO = .Facturadeexportacion_PK
					endif
				endif
			Catch to loError
				.Facturadeexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFacturadecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Facturadecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Facturadecompra_PK' )
						.Facturadecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Facturadecompra.CODIGO = .Facturadecompra_PK
					endif
				endif
			Catch to loError
				.Facturadecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. Interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBolsasycajas() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Bolsasycajas" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Bolsasycajas_PK' )
						.Bolsasycajas_PK = lvValorSugeridoDefinidoPorElUsuario
						.Bolsasycajas.CODIGO = .Bolsasycajas_PK
					endif
				endif
			Catch to loError
				.Bolsasycajas_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAsiento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Asiento" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Asiento_PK' )
						.Asiento_PK = lvValorSugeridoDefinidoPorElUsuario
						.Asiento.CODIGO = .Asiento_PK
					endif
				endif
			Catch to loError
				.Asiento_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Identificador para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCancelaciondecompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Cancelaciondecompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cancelaciondecompra_PK' )
						.Cancelaciondecompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Cancelaciondecompra.CODIGO = .Cancelaciondecompra_PK
					endif
				endif
			Catch to loError
				.Cancelaciondecompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Cliente" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cliente_PK' )
						.Cliente_PK = lvValorSugeridoDefinidoPorElUsuario
						.Cliente.CODIGO = .Cliente_PK
					endif
				endif
			Catch to loError
				.Cliente_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDevolucion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Devolucion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Devolucion_PK' )
						.Devolucion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Devolucion.CODIGO = .Devolucion_PK
					endif
				endif
			Catch to loError
				.Devolucion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDatosfiscales() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Datosfiscales" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Datosfiscales_PK' )
						.Datosfiscales_PK = lvValorSugeridoDefinidoPorElUsuario
						.Datosfiscales.CODIGO = .Datosfiscales_PK
					endif
				endif
			Catch to loError
				.Datosfiscales_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoModificacionprecios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Modificacionprecios" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Modificacionprecios_PK' )
						.Modificacionprecios_PK = lvValorSugeridoDefinidoPorElUsuario
						.Modificacionprecios.CODIGO = .Modificacionprecios_PK
					endif
				endif
			Catch to loError
				.Modificacionprecios_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Identificador para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMovimientostockainvent() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Movimientostockainvent" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Movimientostockainvent_PK' )
						.Movimientostockainvent_PK = lvValorSugeridoDefinidoPorElUsuario
						.Movimientostockainvent.CODIGO = .Movimientostockainvent_PK
					endif
				endif
			Catch to loError
				.Movimientostockainvent_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMovimientodestock() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Movimientodestock" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Movimientodestock_PK' )
						.Movimientodestock_PK = lvValorSugeridoDefinidoPorElUsuario
						.Movimientodestock.CODIGO = .Movimientodestock_PK
					endif
				endif
			Catch to loError
				.Movimientodestock_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecredito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecredito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecredito_PK' )
						.Notadecredito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecredito.CODIGO = .Notadecredito_PK
					endif
				endif
			Catch to loError
				.Notadecredito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecreditoelectronica() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecreditoelectronica" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecreditoelectronica_PK' )
						.Notadecreditoelectronica_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecreditoelectronica.CODIGO = .Notadecreditoelectronica_PK
					endif
				endif
			Catch to loError
				.Notadecreditoelectronica_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebitocompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebitocompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebitocompra_PK' )
						.Notadedebitocompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebitocompra.CODIGO = .Notadedebitocompra_PK
					endif
				endif
			Catch to loError
				.Notadedebitocompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebitodeexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebitodeexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebitodeexportacion_PK' )
						.Notadedebitodeexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebitodeexportacion.CODIGO = .Notadedebitodeexportacion_PK
					endif
				endif
			Catch to loError
				.Notadedebitodeexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebitoelectronicaexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebitoelectronicaexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebitoelectronicaexportacion_PK' )
						.Notadedebitoelectronicaexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebitoelectronicaexportacion.CODIGO = .Notadedebitoelectronicaexportacion_PK
					endif
				endif
			Catch to loError
				.Notadedebitoelectronicaexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecreditoelectronicaexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecreditoelectronicaexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecreditoelectronicaexportacion_PK' )
						.Notadecreditoelectronicaexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecreditoelectronicaexportacion.CODIGO = .Notadecreditoelectronicaexportacion_PK
					endif
				endif
			Catch to loError
				.Notadecreditoelectronicaexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecreditoelectronicadecredito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecreditoelectronicadecredito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecreditoelectronicadecredito_PK' )
						.Notadecreditoelectronicadecredito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecreditoelectronicadecredito.CODIGO = .Notadecreditoelectronicadecredito_PK
					endif
				endif
			Catch to loError
				.Notadecreditoelectronicadecredito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMovimientostockdesdeproducc() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Movimientostockdesdeproducc" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Movimientostockdesdeproducc_PK' )
						.Movimientostockdesdeproducc_PK = lvValorSugeridoDefinidoPorElUsuario
						.Movimientostockdesdeproducc.CODIGO = .Movimientostockdesdeproducc_PK
					endif
				endif
			Catch to loError
				.Movimientostockdesdeproducc_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMovimientostockaproducc() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Movimientostockaproducc" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Movimientostockaproducc_PK' )
						.Movimientostockaproducc_PK = lvValorSugeridoDefinidoPorElUsuario
						.Movimientostockaproducc.CODIGO = .Movimientostockaproducc_PK
					endif
				endif
			Catch to loError
				.Movimientostockaproducc_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecreditocompra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecreditocompra" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecreditocompra_PK' )
						.Notadecreditocompra_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecreditocompra.CODIGO = .Notadecreditocompra_PK
					endif
				endif
			Catch to loError
				.Notadecreditocompra_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número interno para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadecreditodeexportacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadecreditodeexportacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadecreditodeexportacion_PK' )
						.Notadecreditodeexportacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadecreditodeexportacion.CODIGO = .Notadecreditodeexportacion_PK
					endif
				endif
			Catch to loError
				.Notadecreditodeexportacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNotadedebitoelectronica() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Notadedebitoelectronica" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Notadedebitoelectronica_PK' )
						.Notadedebitoelectronica_PK = lvValorSugeridoDefinidoPorElUsuario
						.Notadedebitoelectronica.CODIGO = .Notadedebitoelectronica_PK
					endif
				endif
			Catch to loError
				.Notadedebitoelectronica_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTicketnotadecredito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Ticketnotadecredito" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Ticketnotadecredito_PK' )
						.Ticketnotadecredito_PK = lvValorSugeridoDefinidoPorElUsuario
						.Ticketnotadecredito.CODIGO = .Ticketnotadecredito_PK
					endif
				endif
			Catch to loError
				.Ticketnotadecredito_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTicketfactura() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Ticketfactura" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Ticketfactura_PK' )
						.Ticketfactura_PK = lvValorSugeridoDefinidoPorElUsuario
						.Ticketfactura.CODIGO = .Ticketfactura_PK
					endif
				endif
			Catch to loError
				.Ticketfactura_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoOrdenar() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECCIONPARAINSERTAR", "", "Ordenar" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Ordenar' )
						.Ordenar = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Ordenar alfabéticamente para la entidad Selección de entidades." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Fecha( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fecha( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		use in select( 'c_SELECCIONPARAINSERTAR' )
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Entidad = []
			.Observacion = []
			.Impresiondeetiqueta_PK = 0
			.Feriado_PK = 0
			.Descripcion = []
			.Presupuesto_PK = []
			.Preparaciondemercaderia_PK = []
			.Presupuestodecompra_PK = []
			.Pedido_PK = []
			.Remito_PK = []
			.Remitodecompra_PK = []
			.Pedidodecompra_PK = []
			.Solicituddecompra_PK = []
			.Ticketnotadedebito_PK = []
			.Requerimientodecompra_PK = []
			.Notadedebitoelectronicadecredito_PK = []
			.Notadedebito_PK = []
			.Facturaelectronicaexportacion_PK = []
			.Facturaelectronicadecredito_PK = []
			.Facturaelectronica_PK = []
			.Factura_PK = []
			.Mercaderiaentransito_PK = []
			.Finaldeproduccion_PK = []
			.Facturadeexportacion_PK = []
			.Facturadecompra_PK = []
			.Bolsasycajas_PK = []
			.Asiento_PK = []
			.Cancelaciondecompra_PK = []
			.Cliente_PK = []
			.Devolucion_PK = []
			.Datosfiscales_PK = []
			.Modificacionprecios_PK = []
			.Movimientostockainvent_PK = []
			.Movimientodestock_PK = []
			.Notadecredito_PK = []
			.Notadecreditoelectronica_PK = []
			.Notadedebitocompra_PK = []
			.Notadedebitodeexportacion_PK = []
			.Notadedebitoelectronicaexportacion_PK = []
			.Notadecreditoelectronicaexportacion_PK = []
			.Notadecreditoelectronicadecredito_PK = []
			.Movimientostockdesdeproducc_PK = []
			.Movimientostockaproducc_PK = []
			.Notadecreditocompra_PK = []
			.Notadecreditodeexportacion_PK = []
			.Notadedebitoelectronica_PK = []
			.Ticketnotadecredito_PK = []
			.Ticketfactura_PK = []
			.Ordenar = .F.
		endwith
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributosCombinacion() as object
		local loColRetorno as object
		
		loColRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		return loColRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributoDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function TieneDetallesConPrePantalla() as Boolean
		local llRetorno as Boolean
		llRetorno = .f.
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombreDetallesConPrePantalla() as ZooColeccion of ZooColeccion.prg
		local loRetorno as ZooColeccion OF ZooColeccion.prg
		loRetorno = _screen.zoo.CrearObjeto("ZooColeccion")
		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveCandidataNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveDeBusquedaNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
	endfunc

enddefine