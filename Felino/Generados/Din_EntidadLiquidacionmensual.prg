
define class Din_EntidadLIQUIDACIONMENSUAL as entidad of entidad.prg

	cNombre = 'LIQUIDACIONMENSUAL'
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	SERIEMODIFICACIONFW = []
	ZADSFW = []
	HORAEXPO = []
	HORAALTAFW = []
	HORAMODIFICACIONFW = []
	HORAIMPO = []
	USUARIOALTAFW = []
	ESTADOTRANSFERENCIA = []
	VERSIONALTAFW = []
	VERSIONMODIFICACIONFW = []
	SERIEALTAFW = []
	BASEDEDATOSMODIFICACIONFW = []
	BASEDEDATOSALTAFW = []
	USUARIOMODIFICACIONFW = []
	ImpuestosDetalle = null
	FechaLiq = ctod( '  /  /    ' )
	TotalLiquidacion = 0
	Operadora_PK = []
	Operadora = null
	cAtributoPK = 'Codigo'
	Codigo = []
	Conceptosgenerales = null
	Conceptosdiarios = null
	ImpuestosComprobante = null
	FechaDesde = ctod( '  /  /    ' )
	NumInt = 0
	lHabilitarNumInt = .T.
	TotalGravado = 0
	PuntoDeVentaLiquidacion = 0
	FechaHasta = ctod( '  /  /    ' )
	TotalNoGravado = 0
	Obs = []
	NumeroLiquidacion = 0
	SubTotal = 0
	OtrosImpuestos = 0
	IdRegistroDeCuenta = []
	TotalIva = 0
	TotalOtroIva = 0
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Liquidación mensual]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''
	oAtributosCC =  Null
	oCompCuentaBancariaLiquidacionMensual = null
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarNumInt = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadLIQUIDACIONMENSUALAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestosdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestosdetalle ) = 'O' or isnull( this.Impuestosdetalle ) )
			this.Impuestosdetalle = this.crearobjeto( 'Din_DetalleLiquidacionmensualImpuestosdetalle' )
			this.Impuestosdetalle.inicializar()
			this.enlazar( 'Impuestosdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Impuestosdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Impuestosdetalle, 'CambioSumarizado', this, 'CambiosDetalleImpuestosdetalle', 1) 
			this.enlazar( 'Impuestosdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Impuestosdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Impuestosdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conceptosgenerales_Access() as variant
		if !this.ldestroy and ( !vartype( this.Conceptosgenerales ) = 'O' or isnull( this.Conceptosgenerales ) )
			this.Conceptosgenerales = this.crearobjeto( 'Din_DetalleLiquidacionmensualConceptosgenerales' )
			this.Conceptosgenerales.inicializar()
			this.enlazar( 'Conceptosgenerales.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Conceptosgenerales.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Conceptosgenerales, 'CambioSumarizado', this, 'CambiosDetalleConceptosgenerales', 1) 
			this.enlazar( 'Conceptosgenerales.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Conceptosgenerales.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Conceptosgenerales
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conceptosdiarios_Access() as variant
		if !this.ldestroy and ( !vartype( this.Conceptosdiarios ) = 'O' or isnull( this.Conceptosdiarios ) )
			this.Conceptosdiarios = this.crearobjeto( 'Din_DetalleLiquidacionmensualConceptosdiarios' )
			this.Conceptosdiarios.inicializar()
			this.enlazar( 'Conceptosdiarios.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Conceptosdiarios.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Conceptosdiarios, 'CambioSumarizado', this, 'CambiosDetalleConceptosdiarios', 1) 
			this.enlazar( 'Conceptosdiarios.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Conceptosdiarios.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Conceptosdiarios
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestoscomprobante_Access() as variant
		if !this.ldestroy and ( !vartype( this.Impuestoscomprobante ) = 'O' or isnull( this.Impuestoscomprobante ) )
			this.Impuestoscomprobante = this.crearobjeto( 'Din_DetalleLiquidacionmensualImpuestoscomprobante' )
			this.Impuestoscomprobante.inicializar()
			this.enlazar( 'Impuestoscomprobante.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Impuestoscomprobante.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Impuestoscomprobante, 'CambioSumarizado', this, 'CambiosDetalleImpuestoscomprobante', 1) 
			this.enlazar( 'Impuestoscomprobante.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Impuestoscomprobante.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Impuestoscomprobante
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.ImpuestosDetalle.oItem.lNuevo = this.lNuevo
		this.Conceptosgenerales.oItem.lNuevo = this.lNuevo
		this.Conceptosdiarios.oItem.lNuevo = this.lNuevo
		this.ImpuestosComprobante.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.ImpuestosDetalle.oItem.lEdicion = this.lEdicion
		this.Conceptosgenerales.oItem.lEdicion = this.lEdicion
		this.Conceptosdiarios.oItem.lEdicion = this.lEdicion
		this.ImpuestosComprobante.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleImpuestosdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleConceptosgenerales() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleConceptosdiarios() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleImpuestoscomprobante() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAALTAFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.HORAALTAFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
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
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaLiq) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHALIQ no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalLiquidacion) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALLIQUIDACION ) ) ) 
			lnValorDelDecimal = this.TOTALLIQUIDACION - int( this.TOTALLIQUIDACION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALLIQUIDACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALLIQUIDACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaDesde) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHADESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NumInt) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMINT ) ) ) 
			lnValorDelDecimal = this.NUMINT - int( this.NUMINT)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMINT es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMINT no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalGravado) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALGRAVADO ) ) ) 
			lnValorDelDecimal = this.TOTALGRAVADO - int( this.TOTALGRAVADO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALGRAVADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALGRAVADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PuntoDeVentaLiquidacion) = 'N' )
			lnLargoEntero  = len( transform( int( this.PUNTODEVENTALIQUIDACION ) ) ) 
			lnValorDelDecimal = this.PUNTODEVENTALIQUIDACION - int( this.PUNTODEVENTALIQUIDACION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTALIQUIDACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTALIQUIDACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaHasta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAHASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalNoGravado) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALNOGRAVADO ) ) ) 
			lnValorDelDecimal = this.TOTALNOGRAVADO - int( this.TOTALNOGRAVADO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALNOGRAVADO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALNOGRAVADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Obs) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NumeroLiquidacion) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMEROLIQUIDACION ) ) ) 
			lnValorDelDecimal = this.NUMEROLIQUIDACION - int( this.NUMEROLIQUIDACION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 15
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMEROLIQUIDACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMEROLIQUIDACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SubTotal) = 'N' )
			lnLargoEntero  = len( transform( int( this.SUBTOTAL ) ) ) 
			lnValorDelDecimal = this.SUBTOTAL - int( this.SUBTOTAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo SUBTOTAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUBTOTAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.OtrosImpuestos) = 'N' )
			lnLargoEntero  = len( transform( int( this.OTROSIMPUESTOS ) ) ) 
			lnValorDelDecimal = this.OTROSIMPUESTOS - int( this.OTROSIMPUESTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo OTROSIMPUESTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OTROSIMPUESTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IdRegistroDeCuenta) = 'C' )
			if len( alltrim( this.IDREGISTRODECUENTA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo IDREGISTRODECUENTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IDREGISTRODECUENTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalIva) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALIVA ) ) ) 
			lnValorDelDecimal = this.TOTALIVA - int( this.TOTALIVA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALIVA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALIVA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TotalOtroIva) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTALOTROIVA ) ) ) 
			lnValorDelDecimal = this.TOTALOTROIVA - int( this.TOTALOTROIVA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTALOTROIVA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTALOTROIVA no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarFechaliq() and llRetorno
			llRetorno = .ValidarOperadora() and llRetorno
			llRetorno = .ValidarFechadesde() and llRetorno
			llRetorno = .ValidarNumint() and llRetorno
			llRetorno = .ValidarFechahasta() and llRetorno
			llRetorno = .ValidacionAtributos() and llRetorno
			llRetorno = .ValidacionDetalles() and llRetorno
			llVotacion = .VotacionCambioEstadoGrabar( .ObtenerEstado() )
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

	*--------------------------------------------------------------------------------------------------------
	function ValidacionDetalles() as Boolean
		local llRetorno as boolean, llValAux as boolean
		llRetorno = dodefault()
		llRetorno = This.ValidarUnDetalle( this.ImpuestosDetalle, 'Impuesto Detalle' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.Conceptosgenerales, 'Conceptos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.Conceptosdiarios, 'Conceptos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ImpuestosComprobante, 'Impuesto comprobante' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompCuentaBancariaLiquidacionMensual.lNuevo = this.lNuevo
		this.oCompCuentaBancariaLiquidacionMensual.lEdicion = this.lEdicion
		this.oCompCuentaBancariaLiquidacionMensual.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFechaLiq() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaLiq )
			this.AgregarInformacion( 'Debe cargar el campo Fecha liquidación', 9005, 'FechaLiq' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFechaDesde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaDesde )
			this.AgregarInformacion( 'Debe cargar el campo Desde', 9005, 'FechaDesde' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNumInt() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.NumInt )
			this.AgregarInformacion( 'Debe cargar el campo Número interno', 9005, 'NumInt' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFechaHasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaHasta )
			this.AgregarInformacion( 'Debe cargar el campo Hasta', 9005, 'FechaHasta' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarOperadora() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Operadora_PK )
			this.AgregarInformacion( 'Debe cargar el campo Operadora', 9005, 'Operadora' )
			llRetorno = .F.
		else
			If this.Operadora.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Operadora_PK ))+ ' de la entidad ' +  upper( this.Operadora.cDescripcion ) + ' no existe.')
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
		.RestaurarGenHabilitar()
	Endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _Nuevo() As Boolean

		if this.EsNuevo()
			goServicios.Errores.LevantarExcepcion( "Cancele o grabe antes de intentar hacer 'Nuevo'." )
		else
			With This

				Local llVotacion as boolean
				llVotacion = .VotacionCambioEstadoNuevo( .ObtenerEstado() )

				if llVotacion
				else
					goServicios.Errores.LevantarExcepcion( this.oInformacion )
				Endif

				.lEdicion = .F.
				.lAnular = .F.
				.lNuevo = .T.
				.limpiar()
				.Codigo = goLibrerias.ObtenerGuidPk() 
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
					.InicializarComponentes()
				llVotacion = .VotacionCambioEstadoModificar( .ObtenerEstado() )
				if llVotacion
				else
					goServicios.Errores.LevantarExcepcion( this.oInformacion )
				Endif
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
					.InicializarComponentes()
					llVotacion = .VotacionCambioEstadoEliminar( .ObtenerEstado() )
					if llVotacion
					else
						goServicios.Errores.LevantarExcepcion( this.oInformacion )
					Endif
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

			llVotacion = .VotacionCambioEstadoCancelar( .ObtenerEstado() )
			if llVotacion
			else
				goServicios.Errores.LevantarExcepcion( this.oInformacion )
			Endif
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
			.RestaurarGenHabilitar()
			.actualizarEstado()
		EndWith

		dodefault()

	Endfunc
			*-----------------------------------------------------------------------------------------
	function oNumeraciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.oNumeraciones ) = 'O' or isnull( this.oNumeraciones ) )
			this.oNumeraciones = this.CrearObjeto( 'Numeraciones' )
			this.oNumeraciones.Inicializar()
			this.oNumeraciones.SetearEntidad( this )
		endif
		return this.oNumeraciones
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'FECHALIQ' )
		loAtributosObligatorios.add( 'OPERADORA' )
		loAtributosObligatorios.add( 'CODIGO' )
		loAtributosObligatorios.add( 'FECHADESDE' )
		loAtributosObligatorios.add( 'NUMINT' )
		loAtributosObligatorios.add( 'FECHAHASTA' )
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado NÚMERO INTERNO ' + transform( This.NumInt ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
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
		this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompCUENTABANCARIALIQUIDACIONMENSUAL.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<NOLISTAGENERICO>'
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		return this.oAd.ObtenerIdPorClaveCandidata()
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		this.oAtributosCC = _screen.zoo.crearobjeto( 'ZooColeccion' )
		this.oAtributosCC.add( "NumInt" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechaliq()','Fechaliq')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechadesde()','Fechadesde')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechahasta()','Fechahasta')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'LIQUIDACIONMENSUAL', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Operadora_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Operadora_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Operadora_PK = lxVal

		if this.Validar_Operadora( lxVal, lxValOld )
			This.Setear_Operadora( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Operadora( txVal as variant ) as void

		this.Operadora.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Operadora( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Fechaliq_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaliq
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaliq( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechaliq( lxVal )
			EndIf
		Else
			This.Setear_Fechaliq( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalliquidacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalliquidacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalliquidacion( lxVal )
				this.Setear_Totalliquidacion( lxVal )
			EndIf
		Else
			This.Setear_Totalliquidacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadesde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadesde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadesde( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechadesde( lxVal )
			EndIf
		Else
			This.Setear_Fechadesde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numint_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numint
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numint( lxVal )
				if ( this.lHabilitarNumint or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Numint( lxVal )
				else
					this.Numint = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Liquidación mensual - Atributo: Numint)" )
				endif 
			EndIf
		Else
			This.Setear_Numint( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalgravado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalgravado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalgravado( lxVal )
				this.Setear_Totalgravado( lxVal )
			EndIf
		Else
			This.Setear_Totalgravado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Puntodeventaliquidacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventaliquidacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventaliquidacion( lxVal )
				this.Setear_Puntodeventaliquidacion( lxVal )
			EndIf
		Else
			This.Setear_Puntodeventaliquidacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechahasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechahasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechahasta( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechahasta( lxVal )
			EndIf
		Else
			This.Setear_Fechahasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalnogravado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalnogravado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalnogravado( lxVal )
				this.Setear_Totalnogravado( lxVal )
			EndIf
		Else
			This.Setear_Totalnogravado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Obs_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Obs
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Obs( lxVal )
				this.Setear_Obs( lxVal )
			EndIf
		Else
			This.Setear_Obs( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numeroliquidacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numeroliquidacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numeroliquidacion( lxVal )
				this.Setear_Numeroliquidacion( lxVal )
			EndIf
		Else
			This.Setear_Numeroliquidacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Subtotal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Subtotal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Subtotal( lxVal )
				this.Setear_Subtotal( lxVal )
			EndIf
		Else
			This.Setear_Subtotal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Otrosimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Otrosimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Otrosimpuestos( lxVal )
				this.Setear_Otrosimpuestos( lxVal )
			EndIf
		Else
			This.Setear_Otrosimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idregistrodecuenta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idregistrodecuenta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idregistrodecuenta( lxVal )
				this.Setear_Idregistrodecuenta( lxVal )
			EndIf
		Else
			This.Setear_Idregistrodecuenta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totaliva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totaliva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totaliva( lxVal )
				this.Setear_Totaliva( lxVal )
			EndIf
		Else
			This.Setear_Totaliva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Totalotroiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Totalotroiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Totalotroiva( lxVal )
				this.Setear_Totalotroiva( lxVal )
			EndIf
		Else
			This.Setear_Totalotroiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
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
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaliq( txVal as variant ) as void

		this.Fechaliq = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalliquidacion( txVal as variant ) as void

		this.Totalliquidacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadesde( txVal as variant ) as void

		this.Fechadesde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numint( txVal as variant ) as void

		this.Numint = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalgravado( txVal as variant ) as void

		this.Totalgravado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventaliquidacion( txVal as variant ) as void

		this.Puntodeventaliquidacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechahasta( txVal as variant ) as void

		this.Fechahasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalnogravado( txVal as variant ) as void

		this.Totalnogravado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numeroliquidacion( txVal as variant ) as void

		this.Numeroliquidacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Subtotal( txVal as variant ) as void

		this.Subtotal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Otrosimpuestos( txVal as variant ) as void

		this.Otrosimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idregistrodecuenta( txVal as variant ) as void

		this.Idregistrodecuenta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totaliva( txVal as variant ) as void

		this.Totaliva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Totalotroiva( txVal as variant ) as void

		this.Totalotroiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

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
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaliq( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalliquidacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadesde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numint( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalgravado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventaliquidacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechahasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalnogravado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numeroliquidacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Subtotal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Otrosimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idregistrodecuenta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totaliva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Totalotroiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Operadora_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Operadora ) = 'O' or isnull( this.Operadora ) )
					this.Operadora = _Screen.zoo.instanciarentidad( 'Operadoradetarjeta' )
					this.Operadora.lEsSubEntidad = .t.
					this.enlazar( 'Operadora.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Operadora.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Operadora.CODIGO # this.Operadora_PK
						this.Operadora.CODIGO = this.Operadora_PK
					endif
				endif
			endif
		endif
		return this.Operadora
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompCuentabancarialiquidacionmensual_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompCuentabancarialiquidacionmensual ) = 'O' or isnull( this.oCompCuentabancarialiquidacionmensual ) )
			this.oCompCuentabancarialiquidacionmensual = _Screen.zoo.InstanciarComponente( 'ComponenteCuentabancarialiquidacionmensual' )
		this.oCompCuentabancarialiquidacionmensual.Inicializar()
		this.enlazar( 'oCompCuentabancarialiquidacionmensual.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompCuentabancarialiquidacionmensual.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompCuentabancarialiquidacionmensual
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechaexpo = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Seriemodificacionfw = []
				.Zadsfw = []
				.Horaexpo = []
				.Horaaltafw = []
				.Horamodificacionfw = []
				.Horaimpo = []
				.Usuarioaltafw = []
				.Estadotransferencia = []
				.Versionaltafw = []
				.Versionmodificacionfw = []
				.Seriealtafw = []
				.Basededatosmodificacionfw = []
				.Basededatosaltafw = []
				.Usuariomodificacionfw = []
				.Impuestosdetalle.Limpiar()
				.Fechaliq = ctod( '  /  /    ' )
				.Totalliquidacion = 0
				.Operadora_PK = []
				.Codigo = []
				.Conceptosgenerales.Limpiar()
				.Conceptosdiarios.Limpiar()
				.Impuestoscomprobante.Limpiar()
				.Fechadesde = ctod( '  /  /    ' )
				if .EsNuevo() and !.VerificarContexto( 'CB' )
					.NUMINT = .oNumeraciones.ObtenerNumero('NUMINT')
				else
					.NUMINT = iif( vartype( this.NUMINT ) = 'C', '', 0 )
				endif
				.Totalgravado = 0
				.Puntodeventaliquidacion = 0
				.Fechahasta = ctod( '  /  /    ' )
				.Totalnogravado = 0
				.Obs = []
				.Numeroliquidacion = 0
				.Subtotal = 0
				.Otrosimpuestos = 0
				.Idregistrodecuenta = []
				.Totaliva = 0
				.Totalotroiva = 0
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
				.CambioSumarizado()
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
			If .EsNuevo()
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
				for each ValorSugeridoDeFramework in this.oColeccionVSFW
					if ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWLISTADEPRECIOS()" and !empty( this.ListaDePrecios_PK )) or ;
					   ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWFECHA()" and !empty( this.Fecha ))
					else
						&ValorSugeridoDeFramework
					endif
				endfor
			EndIf
				endif
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaliq() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Fechaliq" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechaliq' )
						.Fechaliq = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha liquidación para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechaliq()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechaliq() as void
		with this
			.Fechaliq = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoOperadora() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Operadora" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Operadora_PK' )
						.Operadora_PK = lvValorSugeridoDefinidoPorElUsuario
						.Operadora.CODIGO = .Operadora_PK
					endif
				endif
			Catch to loError
				.Operadora_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Operadora para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechadesde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Fechadesde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechadesde' )
						.Fechadesde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Desde para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechadesde()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechadesde() as void
		with this
			.Fechadesde = goServicios.Librerias.ObtenerFecha() -(day(goServicios.Librerias.ObtenerFecha())-1)
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventaliquidacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Puntodeventaliquidacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Puntodeventaliquidacion' )
						.Puntodeventaliquidacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro.liquidación para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechahasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Fechahasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechahasta' )
						.Fechahasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Hasta para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechahasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechahasta() as void
		with this
			.Fechahasta = goServicios.Librerias.ObtenerUltimoDiaDelMes(goServicios.Librerias.ObtenerFecha())
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObs() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Obs" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Obs' )
						.Obs = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observación para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumeroliquidacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "LIQUIDACIONMENSUAL", "", "Numeroliquidacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numeroliquidacion' )
						.Numeroliquidacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro.liquidación para la entidad Liquidación mensual." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function ValidarDominio_Fechacalendario( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacalendario( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompCuentaBancariaLiquidacionMensual = null
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_LIQUIDACIONMENSUAL' )

		this.oAtributosCC =  Null
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
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