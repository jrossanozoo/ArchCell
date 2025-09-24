
define class Din_EntidadCANJEDECUPONES as Ent_ComprobanteDeFondos of Ent_ComprobanteDeFondos.prg

	cNombre = 'CANJEDECUPONES'
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	TipoComprobante = 0
	CuponValorTipo = 0
	SignodeMovimiento = 0
	HORAEXPO = []
	HORAIMPO = []
	BASEDEDATOSALTAFW = []
	HORAALTAFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSMODIFICACIONFW = []
	CuponValorDetalle = []
	ZADSFW = []
	HORAMODIFICACIONFW = []
	USUARIOALTAFW = []
	USUARIOMODIFICACIONFW = []
	SERIEMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	VERSIONALTAFW = []
	DescripcionFW = []
	SERIEALTAFW = []
	Cupon_PK = []
	Cupon = null
	lHabilitarCupon_PK = .T.
	CuponIdCaja_PK = 0
	CuponIdCaja = null
	cAtributoPK = 'Codigo'
	Codigo = []
	MonedaComprobante_PK = []
	MonedaComprobante = null
	CuponValor_PK = []
	CuponValor = null
	Letra = []
	CuponTipoComprobante = 0
	ValoresDetalle = null
	Cliente_PK = []
	Cliente = null
	lHabilitarCliente_PK = .T.
	Obs = []
	ValoresAEnt = null
	PuntoDeVenta = 0
	CuponLetraComprobante = []
	Diferencia = 0
	Proveedor_PK = []
	Proveedor = null
	lHabilitarProveedor_PK = .T.
	Numero = 0
	Fecha = ctod( '  /  /    ' )
	CuponPuntoDeVentaComprobante = 0
	CuponTipo = []
	Concepto_PK = []
	Concepto = null
	CuponNumeroComprobante = 0
	CuponNumeroCupon = 0
	Vendedor_PK = []
	Vendedor = null
	lHabilitarVendedor_PK = .T.
	CuponFechaComprobante = ctod( '  /  /    ' )
	CuponFecha = ctod( '  /  /    ' )
	CuponBaseDeDatos = []
	Total = 0
	CuponHora = []
	CuponSerieOrigen = []
	CuponMonto = 0
	Anulado = .F.
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Canje de valores]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_PK'
	oAtributosCC =  Null
	oCompCanjeDeCupones = null
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCupon_PK = .T.
		this.lHabilitarCliente_PK = .T.
		this.lHabilitarProveedor_PK = .T.
		this.lHabilitarVendedor_PK = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadCANJEDECUPONESAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valoresdetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Valoresdetalle ) = 'O' or isnull( this.Valoresdetalle ) )
			this.Valoresdetalle = this.crearobjeto( 'DetalleCanjedecuponesValoresdetalle' )
			this.Valoresdetalle.inicializar()
			this.enlazar( 'Valoresdetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Valoresdetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Valoresdetalle, 'CambioSumarizado', this, 'CambiosDetalleValoresdetalle', 1) 
			this.enlazar( 'Valoresdetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Valoresdetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Valoresdetalle.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Valoresdetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valoresaent_Access() as variant
		if !this.ldestroy and ( !vartype( this.Valoresaent ) = 'O' or isnull( this.Valoresaent ) )
			this.Valoresaent = this.crearobjeto( 'DetalleCanjedecuponesValoresaent' )
			this.Valoresaent.inicializar()
			this.enlazar( 'Valoresaent.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Valoresaent.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Valoresaent, 'CambioSumarizado', this, 'CambiosDetalleValoresaent', 1) 
			this.enlazar( 'Valoresaent.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Valoresaent.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Valoresaent.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Valoresaent
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.ValoresDetalle.oItem.lNuevo = this.lNuevo
		this.ValoresAEnt.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.ValoresDetalle.oItem.lEdicion = this.lEdicion
		this.ValoresAEnt.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleValoresdetalle() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleValoresaent() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FECHAALTAFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
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
		 
		if ( vartype( this.FECHAIMPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoComprobante) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOCOMPROBANTE ) ) ) 
			lnValorDelDecimal = this.TIPOCOMPROBANTE - int( this.TIPOCOMPROBANTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOCOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponValorTipo) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONVALORTIPO ) ) ) 
			lnValorDelDecimal = this.CUPONVALORTIPO - int( this.CUPONVALORTIPO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONVALORTIPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONVALORTIPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SignodeMovimiento) = 'N' )
			lnLargoEntero  = len( transform( int( this.SIGNODEMOVIMIENTO ) ) ) 
			lnValorDelDecimal = this.SIGNODEMOVIMIENTO - int( this.SIGNODEMOVIMIENTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo SIGNODEMOVIMIENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SIGNODEMOVIMIENTO no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponValorDetalle) = 'C' )
			if len( alltrim( this.CUPONVALORDETALLE ) ) > 30
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONVALORDETALLE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONVALORDETALLE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
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
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.DescripcionFW) = 'C' )
			if len( alltrim( this.DESCRIPCIONFW ) ) > 200
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCIONFW no es el correcto.')
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
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Letra) = 'C' )
			if len( alltrim( this.LETRA ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponTipoComprobante) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONTIPOCOMPROBANTE ) ) ) 
			lnValorDelDecimal = this.CUPONTIPOCOMPROBANTE - int( this.CUPONTIPOCOMPROBANTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONTIPOCOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONTIPOCOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Obs) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PuntoDeVenta) = 'N' )
			lnLargoEntero  = len( transform( int( this.PUNTODEVENTA ) ) ) 
			lnValorDelDecimal = this.PUNTODEVENTA - int( this.PUNTODEVENTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PUNTODEVENTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PUNTODEVENTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponLetraComprobante) = 'C' )
			if len( alltrim( this.CUPONLETRACOMPROBANTE ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONLETRACOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONLETRACOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Diferencia) = 'N' )
			lnLargoEntero  = len( transform( int( this.DIFERENCIA ) ) ) 
			lnValorDelDecimal = this.DIFERENCIA - int( this.DIFERENCIA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo DIFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DIFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Numero) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO ) ) ) 
			lnValorDelDecimal = this.NUMERO - int( this.NUMERO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 12
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Fecha) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponPuntoDeVentaComprobante) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONPUNTODEVENTACOMPROBANTE ) ) ) 
			lnValorDelDecimal = this.CUPONPUNTODEVENTACOMPROBANTE - int( this.CUPONPUNTODEVENTACOMPROBANTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONPUNTODEVENTACOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONPUNTODEVENTACOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponTipo) = 'C' )
			if len( alltrim( this.CUPONTIPO ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONTIPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONTIPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponNumeroComprobante) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONNUMEROCOMPROBANTE ) ) ) 
			lnValorDelDecimal = this.CUPONNUMEROCOMPROBANTE - int( this.CUPONNUMEROCOMPROBANTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONNUMEROCOMPROBANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONNUMEROCOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponNumeroCupon) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONNUMEROCUPON ) ) ) 
			lnValorDelDecimal = this.CUPONNUMEROCUPON - int( this.CUPONNUMEROCUPON)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 12
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONNUMEROCUPON es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONNUMEROCUPON no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponFechaComprobante) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONFECHACOMPROBANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponFecha) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONFECHA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponBaseDeDatos) = 'C' )
			if len( alltrim( this.CUPONBASEDEDATOS ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONBASEDEDATOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONBASEDEDATOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Total) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOTAL ) ) ) 
			lnValorDelDecimal = this.TOTAL - int( this.TOTAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOTAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOTAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponHora) = 'C' )
			if len( alltrim( this.CUPONHORA ) ) > 5
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONHORA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONHORA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponSerieOrigen) = 'C' )
			if len( alltrim( this.CUPONSERIEORIGEN ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo CUPONSERIEORIGEN es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONSERIEORIGEN no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CuponMonto) = 'N' )
			lnLargoEntero  = len( transform( int( this.CUPONMONTO ) ) ) 
			lnValorDelDecimal = this.CUPONMONTO - int( this.CUPONMONTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 15
				This.AgregarInformacion( 'La longitud entera del valor del atributo CUPONMONTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUPONMONTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoNUEVO( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoELIMINAR( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoMODIFICAR( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoCANCELAR( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoGRABAR( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoANULAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompCANJEDECUPONES.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.ValoresDetalle.oItem.oCompCAJERO.votarCambioEstadoANULAR( tcEstado )
		llVotacion = llVotacion and this.ValoresAEnt.oItem.oCompCajero.votarCambioEstadoANULAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarCupon() and llRetorno
			llRetorno = .ValidarCuponidcaja() and llRetorno
			llRetorno = .ValidarMonedacomprobante() and llRetorno
			llRetorno = .ValidarCuponvalor() and llRetorno
			llRetorno = .ValidarCliente() and llRetorno
			llRetorno = .ValidarProveedor() and llRetorno
			llRetorno = .ValidarConcepto() and llRetorno
			llRetorno = .ValidarVendedor() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.ValoresDetalle, 'Valores a recibir' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ValoresAEnt, 'Valores a entregar' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompCanjeDeCupones.lNuevo = this.lNuevo
		this.oCompCanjeDeCupones.lEdicion = this.lEdicion
		this.oCompCanjeDeCupones.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCupon() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cupon_PK )
		else
			If this.Cupon.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Cupon_PK ))+ ' de la entidad ' +  upper( this.Cupon.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCuponIdCaja() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CuponIdCaja_PK )
		else
			If this.CuponIdCaja.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CuponIdCaja_PK ))+ ' de la entidad ' +  upper( this.CuponIdCaja.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarMonedaComprobante() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.MonedaComprobante_PK )
		else
			If this.MonedaComprobante.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.MonedaComprobante_PK ))+ ' de la entidad ' +  upper( this.MonedaComprobante.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCuponValor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CuponValor_PK )
		else
			If this.CuponValor.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CuponValor_PK ))+ ' de la entidad ' +  upper( this.CuponValor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCliente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cliente_PK )
		else
			If this.Cliente.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Cliente_PK ))+ ' de la entidad ' +  upper( this.Cliente.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarProveedor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Proveedor_PK )
		else
			If this.Proveedor.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Proveedor_PK ))+ ' de la entidad ' +  upper( this.Proveedor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarConcepto() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Concepto_PK )
		else
			If this.Concepto.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Concepto_PK ))+ ' de la entidad ' +  upper( this.Concepto.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarVendedor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Vendedor_PK )
		else
			If this.Vendedor.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Vendedor_PK ))+ ' de la entidad ' +  upper( this.Vendedor.cDescripcion ) + ' no existe.')
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
				This.IniciarRegistroDeActividad( 'Grabar' )
				goServicios.RegistroDeActividad.HabilitarTrazaExtendidaMensajeria()
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
								this.EventoPorInsertar()
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
							.ErrorAlGrabar()
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
			This.EstablecerTiemposEnRegistroDeActividad( 'Grabar' )
			goServicios.RegistroDeActividad.DeshabilitarTrazaExtendidaMensajeria()
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
				*****Esta linea se genera solo para entidades anulables
				.Anulado = .F.
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
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Anular() As void
		with this
			.buscar()
			.Cargar()
			if pemstatus( this, 'oCompEnBaseA', 5 )
				.ValidarComprobantesAfectantes( 'Anular' )
			endif
			.InicializarComponentes()
			if .VotacionCambioEstadoAnular( .ObtenerEstado() )
			else
				goServicios.Errores.LevantarExcepcion( this.oInformacion )
			endif
		endwith
	endfunc
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
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado TIPOCOMPROBANTE ' + transform( This.TipoComprobante ) + ', LETRA ' + transform( This.Letra ) + ', PTO. VENTA ' + transform( This.PuntoDeVenta ) + ', NÚMERO ' + transform( This.Numero ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
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
		this.oCompCANJEDECUPONES.SetearColeccionSentenciasAnterior_NUEVO()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_NUEVO()
		this.ValoresAEnt.oItem.oCompCajero.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompCANJEDECUPONES.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_MODIFICAR()
		this.ValoresAEnt.oItem.oCompCajero.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompCANJEDECUPONES.SetearColeccionSentenciasAnterior_ANULAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_ANULAR()
		this.ValoresAEnt.oItem.oCompCajero.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompCANJEDECUPONES.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.ValoresDetalle.oItem.oCompCAJERO.SetearColeccionSentenciasAnterior_ELIMINAR()
		this.ValoresAEnt.oItem.oCompCajero.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<ANULABLE><COMPR_CAJA><NOIMPO><NOEXPO><FRMMODAL>'
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
		this.lHabilitaEnviarAlGrabar = .F.
		this.oAtributosCC = _screen.zoo.crearobjeto( 'ZooColeccion' )
		this.oAtributosCC.add( "TipoComprobante" )
		this.oAtributosCC.add( "Letra" )
		this.oAtributosCC.add( "PuntoDeVenta" )
		this.oAtributosCC.add( "Numero" )
		this.oProveedorAtributosAnulacion = newobject( "din_entidadCANJEDECUPONESAtributosAnulacion", "din_entidadCANJEDECUPONESAtributosAnulacion.prg" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipocomprobante()','Tipocomprobante')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSignodemovimiento()','Signodemovimiento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CANJEDECUPONES', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupon_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cupon_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Cupon_PK = lxVal

		if this.Validar_Cupon( lxVal, lxValOld )
			if ( this.lHabilitarCupon_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Cupon( lxVal )
				This.Cupon_PK_DespuesDeAsignar()
			If lxValOld != lxVal or empty( this.Cuponvalortipo ) 
				this.Cuponvalortipo = This.Cupon.Valor.Tipo
			endif
			If lxValOld != lxVal or empty( this.Cuponvalordetalle ) 
				this.Cuponvalordetalle = This.Cupon.Valor.Descripcion
			endif
			If lxValOld != lxVal or empty( this.Cuponidcaja_PK ) 
				this.Cuponidcaja_Pk = This.Cupon.IdCaja_PK
			endif
			If lxValOld != lxVal or empty( this.Monedacomprobante_PK ) 
				this.Monedacomprobante_Pk = This.Cupon.SimboloMonetario_PK
			endif
			If lxValOld != lxVal or empty( this.Cuponvalor_PK ) 
				this.Cuponvalor_Pk = This.Cupon.Valor_PK
			endif
			If lxValOld != lxVal or empty( this.Cupontipocomprobante ) 
				this.Cupontipocomprobante = This.Cupon.TipoComprobante
			endif
			If lxValOld != lxVal or empty( this.Cuponletracomprobante ) 
				this.Cuponletracomprobante = This.Cupon.LetraComprobante
			endif
			If lxValOld != lxVal or empty( this.Cuponpuntodeventacomprobante ) 
				this.Cuponpuntodeventacomprobante = This.Cupon.PuntoDeVentaComprobante
			endif
			If lxValOld != lxVal or empty( this.Cupontipo ) 
				this.Cupontipo = This.Cupon.TipoCupon
			endif
			If lxValOld != lxVal or empty( this.Cuponnumerocomprobante ) 
				this.Cuponnumerocomprobante = This.Cupon.NumeroComprobante
			endif
			If lxValOld != lxVal or empty( this.Cuponnumerocupon ) 
				this.Cuponnumerocupon = This.Cupon.NumeroCupon
			endif
			If lxValOld != lxVal or empty( this.Cuponfechacomprobante ) 
				this.Cuponfechacomprobante = This.Cupon.FechaComprobante
			endif
			If lxValOld != lxVal or empty( this.Cuponfecha ) 
				this.Cuponfecha = This.Cupon.FechaCupon
			endif
			If lxValOld != lxVal or empty( this.Cuponbasededatos ) 
				this.Cuponbasededatos = This.Cupon.BaseDeDatos
			endif
			If lxValOld != lxVal or empty( this.Cuponhora ) 
				this.Cuponhora = This.Cupon.HoraCupon
			endif
			If lxValOld != lxVal or empty( this.Cuponserieorigen ) 
				this.Cuponserieorigen = This.Cupon.SerieOrigen
			endif
			If lxValOld != lxVal or empty( this.Cuponmonto ) 
				this.Cuponmonto = This.Cupon.Monto
			endif
			else
				this.Cupon_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Cupon)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponidcaja_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponidcaja_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Cuponidcaja_PK = lxVal

		if this.Validar_Cuponidcaja( lxVal, lxValOld )
			This.Setear_Cuponidcaja( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monedacomprobante_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Monedacomprobante_PK = lxVal

		if this.Validar_Monedacomprobante( lxVal, lxValOld )
			This.Setear_Monedacomprobante( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponvalor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponvalor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Cuponvalor_PK = lxVal

		if this.Validar_Cuponvalor( lxVal, lxValOld )
			This.Setear_Cuponvalor( lxVal )
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
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Cliente_PK = lxVal

		if this.Validar_Cliente( lxVal, lxValOld )
			if ( this.lHabilitarCliente_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Cliente( lxVal )
			else
				this.Cliente_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Cliente)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Proveedor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Proveedor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Proveedor_PK = lxVal

		if this.Validar_Proveedor( lxVal, lxValOld )
			if ( this.lHabilitarProveedor_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Proveedor( lxVal )
			else
				this.Proveedor_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Proveedor)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Concepto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Concepto_PK = lxVal

		if this.Validar_Concepto( lxVal, lxValOld )
			This.Setear_Concepto( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Vendedor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Vendedor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Vendedor_PK = lxVal

		if this.Validar_Vendedor( lxVal, lxValOld )
			if ( this.lHabilitarVendedor_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Vendedor( lxVal )
			else
				this.Vendedor_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Canje de valores - Atributo: Vendedor)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cupon( txVal as variant ) as void

		this.Cupon.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponidcaja( txVal as variant ) as void

		this.Cuponidcaja.ID = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedacomprobante( txVal as variant ) as void

		this.Monedacomprobante.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponvalor( txVal as variant ) as void

		this.Cuponvalor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proveedor( txVal as variant ) as void

		this.Proveedor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Concepto( txVal as variant ) as void

		this.Concepto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cupon( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponidcaja( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedacomprobante( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponvalor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Concepto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Tipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipocomprobante( lxVal )
				this.Setear_Tipocomprobante( lxVal )
			EndIf
		Else
			This.Setear_Tipocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponvalortipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponvalortipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponvalortipo( lxVal )
				this.Setear_Cuponvalortipo( lxVal )
			EndIf
		Else
			This.Setear_Cuponvalortipo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Signodemovimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Signodemovimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Signodemovimiento( lxVal )
				this.Setear_Signodemovimiento( lxVal )
			EndIf
		Else
			This.Setear_Signodemovimiento( lxVal ) 
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
	function Cuponvalordetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponvalordetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponvalordetalle( lxVal )
				this.Setear_Cuponvalordetalle( lxVal )
			EndIf
		Else
			This.Setear_Cuponvalordetalle( lxVal ) 
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
	function Descripcionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcionfw( lxVal )
				this.Setear_Descripcionfw( lxVal )
			EndIf
		Else
			This.Setear_Descripcionfw( lxVal ) 
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
	function Letra_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letra
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letra( lxVal )
				this.Setear_Letra( lxVal )
			EndIf
		Else
			This.Setear_Letra( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupontipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cupontipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cupontipocomprobante( lxVal )
				this.Setear_Cupontipocomprobante( lxVal )
			EndIf
		Else
			This.Setear_Cupontipocomprobante( lxVal ) 
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
	function Puntodeventa_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventa
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventa( lxVal )
				this.Setear_Puntodeventa( lxVal )
			EndIf
		Else
			This.Setear_Puntodeventa( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponletracomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponletracomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponletracomprobante( lxVal )
				this.Setear_Cuponletracomprobante( lxVal )
			EndIf
		Else
			This.Setear_Cuponletracomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Diferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Diferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Diferencia( lxVal )
				this.Setear_Diferencia( lxVal )
			EndIf
		Else
			This.Setear_Diferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero( lxVal )
				this.Setear_Numero( lxVal )
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fecha( lxVal )
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponpuntodeventacomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponpuntodeventacomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponpuntodeventacomprobante( lxVal )
				this.Setear_Cuponpuntodeventacomprobante( lxVal )
			EndIf
		Else
			This.Setear_Cuponpuntodeventacomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupontipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cupontipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cupontipo( lxVal )
				this.Setear_Cupontipo( lxVal )
			EndIf
		Else
			This.Setear_Cupontipo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponnumerocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponnumerocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponnumerocomprobante( lxVal )
				this.Setear_Cuponnumerocomprobante( lxVal )
			EndIf
		Else
			This.Setear_Cuponnumerocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponnumerocupon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponnumerocupon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponnumerocupon( lxVal )
				this.Setear_Cuponnumerocupon( lxVal )
			EndIf
		Else
			This.Setear_Cuponnumerocupon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponfechacomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponfechacomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponfechacomprobante( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Cuponfechacomprobante( lxVal )
			EndIf
		Else
			This.Setear_Cuponfechacomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponfecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponfecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponfecha( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Cuponfecha( lxVal )
			EndIf
		Else
			This.Setear_Cuponfecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponbasededatos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponbasededatos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponbasededatos( lxVal )
				this.Setear_Cuponbasededatos( lxVal )
			EndIf
		Else
			This.Setear_Cuponbasededatos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Total_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Total
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Total( lxVal )
				this.Setear_Total( lxVal )
			EndIf
		Else
			This.Setear_Total( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponhora_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponhora
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponhora( lxVal )
				this.Setear_Cuponhora( lxVal )
			EndIf
		Else
			This.Setear_Cuponhora( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponserieorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponserieorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponserieorigen( lxVal )
				this.Setear_Cuponserieorigen( lxVal )
			EndIf
		Else
			This.Setear_Cuponserieorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponmonto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuponmonto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuponmonto( lxVal )
				this.Setear_Cuponmonto( lxVal )
			EndIf
		Else
			This.Setear_Cuponmonto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Anulado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Anulado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Anulado( lxVal )
				this.Setear_Anulado( lxVal )
			EndIf
		Else
			This.Setear_Anulado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

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
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponvalortipo( txVal as variant ) as void

		this.Cuponvalortipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Signodemovimiento( txVal as variant ) as void

		this.Signodemovimiento = txVal
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
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
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
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponvalordetalle( txVal as variant ) as void

		this.Cuponvalordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
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
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letra( txVal as variant ) as void

		this.Letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cupontipocomprobante( txVal as variant ) as void

		this.Cupontipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventa( txVal as variant ) as void

		this.Puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponletracomprobante( txVal as variant ) as void

		this.Cuponletracomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Diferencia( txVal as variant ) as void

		this.Diferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponpuntodeventacomprobante( txVal as variant ) as void

		this.Cuponpuntodeventacomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cupontipo( txVal as variant ) as void

		this.Cupontipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponnumerocomprobante( txVal as variant ) as void

		this.Cuponnumerocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponnumerocupon( txVal as variant ) as void

		this.Cuponnumerocupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponfechacomprobante( txVal as variant ) as void

		this.Cuponfechacomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponfecha( txVal as variant ) as void

		this.Cuponfecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponbasededatos( txVal as variant ) as void

		this.Cuponbasededatos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Total( txVal as variant ) as void

		this.Total = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponhora( txVal as variant ) as void

		this.Cuponhora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponserieorigen( txVal as variant ) as void

		this.Cuponserieorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuponmonto( txVal as variant ) as void

		this.Cuponmonto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Validar_Fechaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponvalortipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Signodemovimiento( txVal as variant ) as Boolean

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
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

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
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponvalordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

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
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cupontipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponletracomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Diferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponpuntodeventacomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cupontipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponnumerocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponnumerocupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponfechacomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponfecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponbasededatos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Total( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponhora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponserieorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuponmonto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupon_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cupon ) = 'O' or isnull( this.Cupon ) )
					this.Cupon = _Screen.zoo.instanciarentidad( 'Cupon' )
					this.Cupon.lEsSubEntidad = .t.
					this.enlazar( 'Cupon.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cupon.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cupon.CODIGO # this.Cupon_PK
						this.Cupon.CODIGO = this.Cupon_PK
					endif
				endif
			endif
		endif
		return this.Cupon
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponidcaja_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cuponidcaja ) = 'O' or isnull( this.Cuponidcaja ) )
					this.Cuponidcaja = _Screen.zoo.instanciarentidad( 'Cajaestado' )
					this.Cuponidcaja.lEsSubEntidad = .t.
					this.enlazar( 'Cuponidcaja.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cuponidcaja.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cuponidcaja.ID # this.Cuponidcaja_PK
						this.Cuponidcaja.ID = this.Cuponidcaja_PK
					endif
				endif
			endif
		endif
		return this.Cuponidcaja
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Monedacomprobante ) = 'O' or isnull( this.Monedacomprobante ) )
					this.Monedacomprobante = _Screen.zoo.instanciarentidad( 'Moneda' )
					this.Monedacomprobante.lEsSubEntidad = .t.
					this.enlazar( 'Monedacomprobante.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Monedacomprobante.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Monedacomprobante.CODIGO # this.Monedacomprobante_PK
						this.Monedacomprobante.CODIGO = this.Monedacomprobante_PK
					endif
				endif
			endif
		endif
		return this.Monedacomprobante
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuponvalor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cuponvalor ) = 'O' or isnull( this.Cuponvalor ) )
					this.Cuponvalor = _Screen.zoo.instanciarentidad( 'Valor' )
					this.Cuponvalor.lEsSubEntidad = .t.
					this.enlazar( 'Cuponvalor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cuponvalor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cuponvalor.CODIGO # this.Cuponvalor_PK
						this.Cuponvalor.CODIGO = this.Cuponvalor_PK
					endif
				endif
			endif
		endif
		return this.Cuponvalor
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
	function Proveedor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Proveedor ) = 'O' or isnull( this.Proveedor ) )
					this.Proveedor = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.Proveedor.lEsSubEntidad = .t.
					this.enlazar( 'Proveedor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Proveedor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Proveedor.CODIGO # this.Proveedor_PK
						this.Proveedor.CODIGO = this.Proveedor_PK
					endif
				endif
			endif
		endif
		return this.Proveedor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Concepto ) = 'O' or isnull( this.Concepto ) )
					this.Concepto = _Screen.zoo.instanciarentidad( 'Conceptocaja' )
					this.Concepto.lEsSubEntidad = .t.
					this.enlazar( 'Concepto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Concepto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Concepto.CODIGO # this.Concepto_PK
						this.Concepto.CODIGO = this.Concepto_PK
					endif
				endif
			endif
		endif
		return this.Concepto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Vendedor ) = 'O' or isnull( this.Vendedor ) )
					this.Vendedor = _Screen.zoo.instanciarentidad( 'Vendedor' )
					this.Vendedor.lEsSubEntidad = .t.
					this.enlazar( 'Vendedor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Vendedor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Vendedor.CODIGO # this.Vendedor_PK
						this.Vendedor.CODIGO = this.Vendedor_PK
					endif
				endif
			endif
		endif
		return this.Vendedor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompCanjedecupones_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompCanjedecupones ) = 'O' or isnull( this.oCompCanjedecupones ) )
			this.oCompCanjedecupones = _Screen.zoo.InstanciarComponente( 'ComponenteCanjedecupones' )
		this.oCompCanjedecupones.Inicializar()
		this.enlazar( 'oCompCanjedecupones.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompCanjedecupones.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompCanjedecupones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( transform( This.Numero, "@LZ 99999999" ) ) )
		Endif
		return this.DescripcionFW
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Tipocomprobante = 0
				.Cuponvalortipo = 0
				.Signodemovimiento = 0
				.Horaexpo = []
				.Horaimpo = []
				.Basededatosaltafw = []
				.Horaaltafw = []
				.Estadotransferencia = []
				.Basededatosmodificacionfw = []
				.Cuponvalordetalle = []
				.Zadsfw = []
				.Horamodificacionfw = []
				.Usuarioaltafw = []
				.Usuariomodificacionfw = []
				.Seriemodificacionfw = []
				.Versionmodificacionfw = []
				.Versionaltafw = []
				.Descripcionfw = []
				.Seriealtafw = []
				.Cupon_PK = []
				.Cuponidcaja_PK = 0
				.Codigo = []
				.Monedacomprobante_PK = []
				.Cuponvalor_PK = []
				.Letra = []
				.Cupontipocomprobante = 0
				.Valoresdetalle.Limpiar()
				.Cliente_PK = []
				.Obs = []
				.Valoresaent.Limpiar()
				.Puntodeventa = 0
				.Cuponletracomprobante = []
				.Proveedor_PK = []
				if .EsNuevo() and !.VerificarContexto( 'CB' )
					.NUMERO = .oNumeraciones.ObtenerNumero('NUMERO')
				else
					.NUMERO = iif( vartype( this.NUMERO ) = 'C', '', 0 )
				endif
				.Fecha = ctod( '  /  /    ' )
				.Cuponpuntodeventacomprobante = 0
				.Cupontipo = []
				.Concepto_PK = []
				.Cuponnumerocomprobante = 0
				.Cuponnumerocupon = 0
				.Vendedor_PK = []
				.Cuponfechacomprobante = ctod( '  /  /    ' )
				.Cuponfecha = ctod( '  /  /    ' )
				.Cuponbasededatos = []
				.Total = 0
				.Cuponhora = []
				.Cuponserieorigen = []
				.Cuponmonto = 0
				.Anulado = .F.
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
	Function ValorSugeridoFWTipocomprobante() as void
		with this
			.Tipocomprobante = 32
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocomprobante() as void
		with this
			.ValorSugeridoFWTipocomprobante()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWSignodemovimiento() as void
		with this
			.Signodemovimiento = 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSignodemovimiento() as void
		with this
			.ValorSugeridoFWSignodemovimiento()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLetra() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Letra" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Letra' )
						.Letra = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Letra para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Cliente" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObs() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Obs" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observación para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPuntodeventa() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Puntodeventa" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Puntodeventa' )
						.Puntodeventa = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pto. Venta para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProveedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Proveedor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Proveedor_PK' )
						.Proveedor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Proveedor.CODIGO = .Proveedor_PK
					endif
				endif
			Catch to loError
				.Proveedor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Fecha" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha' )
						.Fecha = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFecha()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFecha() as void
		with this
			.Fecha = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANJEDECUPONES", "", "Vendedor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vendedor_PK' )
						.Vendedor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Vendedor.CODIGO = .Vendedor_PK
					endif
				endif
			Catch to loError
				.Vendedor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor para la entidad Canje de valores." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cupon_PK_DespuesDeAsignar() as void
		this.SetearDatosAdicionales()                                                                       
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
		this.oCompCanjeDeCupones = null
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_CANJEDECUPONES' )

		this.oAtributosCC =  Null
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Diferencia = 0
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
		This.ValorSugeridoTipoComprobante()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveDeBusquedaNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
	endfunc

enddefine