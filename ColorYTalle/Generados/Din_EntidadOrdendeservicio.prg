
define class Din_EntidadORDENDESERVICIO as entidad of entidad.prg

	cNombre = 'ORDENDESERVICIO'
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	ZADSFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSMODIFICACIONFW = []
	HORAIMPO = []
	HORAALTAFW = []
	USUARIOMODIFICACIONFW = []
	USUARIOALTAFW = []
	SERIEMODIFICACIONFW = []
	HORAEXPO = []
	HORAMODIFICACIONFW = []
	SERIEALTAFW = []
	VERSIONALTAFW = []
	VERSIONMODIFICACIONFW = []
	tipoagrupamientopublicaciones = 0
	anulado = .F.
	FechaAdicional1 = ctod( '  /  /    ' )
	Fecha = ctod( '  /  /    ' )
	Cliente_PK = []
	Cliente = null
	lHabilitarCliente_PK = .T.
	Vendedor_PK = []
	Vendedor = null
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	Obs = []
	DetalleInteracciones = null
	DetalleCodigoDeServicio = null
	AgruPubliDetalle = null
	FechaAdicional2 = ctod( '  /  /    ' )
	FechaEntrega = ctod( '  /  /    ' )
	ClienteDescripcion = []
	lHabilitarClienteDescripcion = .T.
	VendedorDescripcion = []
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	FechaAdicional3 = ctod( '  /  /    ' )
	GuidPresupuesto = []
	LetraPresupuesto = []
	NumeroPresupuesto = 0
	PtoVtaPresupuesto = 0
	IdGlobalCliente = []
	lHabilitarIdGlobalCliente = .T.
	Presupuesto_PK = []
	Presupuesto = null
	lHabilitarPresupuesto_PK = .T.
	TipoDeOrden_PK = []
	TipoDeOrden = null
	lHabilitarTipoDeOrden_PK = .T.
	Talle_PK = []
	Talle = null
	lHabilitarTalle_PK = .T.
	NroFactura = []
	Sucursal_PK = []
	Sucursal = null
	Estado_PK = []
	Estado = null
	EntidadAdicional1_PK = []
	EntidadAdicional1 = null
	FechaFactura = ctod( '  /  /    ' )
	Valor = 0
	lHabilitarValor = .T.
	BaseDeDatosAltaFW = []
	EntidadAdicional2_PK = []
	EntidadAdicional2 = null
	EntidadAdicional3_PK = []
	EntidadAdicional3 = null
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Orden de servicio]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_PK'

	lUsaAgrupamientoPublicaciones = .T.
	cValorComboToolbar = ''
	cValorComboToolbarAnterior = 'Todas'
	oCompServiciosAlCliente = null
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarCliente_PK = .T.
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarClienteDescripcion = .T.
		this.lHabilitarColor_PK = .T.
		this.lHabilitarIdGlobalCliente = .T.
		this.lHabilitarPresupuesto_PK = .T.
		this.lHabilitarTipoDeOrden_PK = .T.
		this.lHabilitarTalle_PK = .T.
		this.lHabilitarValor = .T.
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
						if !llConsulta
							if !this.lEsSubEntidad and !llNuevo and this.SoportaBusquedaExtendida()
								llConsulta = .ConsultarPorClavePrimariaSugerida()
							endif
						endif
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
			this.oAD = this.crearobjeto( 'Din_EntidadORDENDESERVICIOAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Detalleinteracciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.Detalleinteracciones ) = 'O' or isnull( this.Detalleinteracciones ) )
			this.Detalleinteracciones = this.crearobjeto( 'DetalleOrdendeservicioDetalleinteracciones' )
			this.Detalleinteracciones.inicializar()
			this.enlazar( 'Detalleinteracciones.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Detalleinteracciones.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Detalleinteracciones, 'CambioSumarizado', this, 'CambiosDetalleDetalleinteracciones', 1) 
			this.enlazar( 'Detalleinteracciones.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Detalleinteracciones.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Detalleinteracciones.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Detalleinteracciones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Detallecodigodeservicio_Access() as variant
		if !this.ldestroy and ( !vartype( this.Detallecodigodeservicio ) = 'O' or isnull( this.Detallecodigodeservicio ) )
			this.Detallecodigodeservicio = this.crearobjeto( 'Din_DetalleOrdendeservicioDetallecodigodeservicio' )
			this.Detallecodigodeservicio.inicializar()
			this.enlazar( 'Detallecodigodeservicio.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Detallecodigodeservicio.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Detallecodigodeservicio, 'CambioSumarizado', this, 'CambiosDetalleDetallecodigodeservicio', 1) 
			this.enlazar( 'Detallecodigodeservicio.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Detallecodigodeservicio.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Detallecodigodeservicio.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Detallecodigodeservicio
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Agrupublidetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Agrupublidetalle ) = 'O' or isnull( this.Agrupublidetalle ) )
			this.Agrupublidetalle = this.crearobjeto( 'Din_DetalleOrdendeservicioAgrupublidetalle' )
			this.Agrupublidetalle.inicializar()
			this.enlazar( 'Agrupublidetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Agrupublidetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Agrupublidetalle, 'CambioSumarizado', this, 'CambiosDetalleAgrupublidetalle', 1) 
			this.enlazar( 'Agrupublidetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Agrupublidetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Agrupublidetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.DetalleInteracciones.oItem.lNuevo = this.lNuevo
		this.DetalleCodigoDeServicio.oItem.lNuevo = this.lNuevo
		this.AgruPubliDetalle.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.DetalleInteracciones.oItem.lEdicion = this.lEdicion
		this.DetalleCodigoDeServicio.oItem.lEdicion = this.lEdicion
		this.AgruPubliDetalle.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleDetalleinteracciones() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleDetallecodigodeservicio() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleAgrupublidetalle() as void
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
		 
		if ( vartype( this.FECHAALTAFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
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
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.tipoagrupamientopublicaciones) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOAGRUPAMIENTOPUBLICACIONES ) ) ) 
			lnValorDelDecimal = this.TIPOAGRUPAMIENTOPUBLICACIONES - int( this.TIPOAGRUPAMIENTOPUBLICACIONES)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOAGRUPAMIENTOPUBLICACIONES es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOAGRUPAMIENTOPUBLICACIONES no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaAdicional1) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAADICIONAL1 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Fecha) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Obs) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaAdicional2) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAADICIONAL2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaEntrega) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAENTREGA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ClienteDescripcion) = 'C' )
			if len( alltrim( this.CLIENTEDESCRIPCION ) ) > 185
				This.AgregarInformacion( 'La longitud del valor del atributo CLIENTEDESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CLIENTEDESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VendedorDescripcion) = 'C' )
			if len( alltrim( this.VENDEDORDESCRIPCION ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo VENDEDORDESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VENDEDORDESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaAdicional3) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAADICIONAL3 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.GuidPresupuesto) = 'C' )
			if len( alltrim( this.GUIDPRESUPUESTO ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo GUIDPRESUPUESTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo GUIDPRESUPUESTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.LetraPresupuesto) = 'C' )
			if len( alltrim( this.LETRAPRESUPUESTO ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo LETRAPRESUPUESTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LETRAPRESUPUESTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NumeroPresupuesto) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMEROPRESUPUESTO ) ) ) 
			lnValorDelDecimal = this.NUMEROPRESUPUESTO - int( this.NUMEROPRESUPUESTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMEROPRESUPUESTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMEROPRESUPUESTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PtoVtaPresupuesto) = 'N' )
			lnLargoEntero  = len( transform( int( this.PTOVTAPRESUPUESTO ) ) ) 
			lnValorDelDecimal = this.PTOVTAPRESUPUESTO - int( this.PTOVTAPRESUPUESTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PTOVTAPRESUPUESTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PTOVTAPRESUPUESTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IdGlobalCliente) = 'C' )
			if len( alltrim( this.IDGLOBALCLIENTE ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo IDGLOBALCLIENTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IDGLOBALCLIENTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NroFactura) = 'C' )
			if len( alltrim( this.NROFACTURA ) ) > 30
				This.AgregarInformacion( 'La longitud del valor del atributo NROFACTURA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NROFACTURA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaFactura) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAFACTURA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Valor) = 'N' )
			lnLargoEntero  = len( transform( int( this.VALOR ) ) ) 
			lnValorDelDecimal = this.VALOR - int( this.VALOR)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo VALOR es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VALOR no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BaseDeDatosAltaFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearCodigoSugerido() as void
		this.CODIGO = This.oComportamientoCodigoSugerido.ObtenerCodigoDisponible( this )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function DebeSugerirCodigo() as Boolean
		return this.oComportamientoCodigoSugerido.Sugerir
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoNUEVO( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoANULAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompSERVICIOSALCLIENTE.votarCambioEstadoANULAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarFecha() and llRetorno
			llRetorno = .ValidarCliente() and llRetorno
			llRetorno = .ValidarVendedor() and llRetorno
			llRetorno = .ValidarArticulo() and llRetorno
			llRetorno = .ValidarFechaentrega() and llRetorno
			llRetorno = .ValidarColor() and llRetorno
			llRetorno = .ValidarPresupuesto() and llRetorno
			llRetorno = .ValidarTipodeorden() and llRetorno
			llRetorno = .ValidarTalle() and llRetorno
			llRetorno = .ValidarSucursal() and llRetorno
			llRetorno = .ValidarEstado() and llRetorno
			llRetorno = .ValidarEntidadadicional1() and llRetorno
			llRetorno = .ValidarEntidadadicional2() and llRetorno
			llRetorno = .ValidarEntidadadicional3() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.DetalleInteracciones, 'Historial de interacciones' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.DetalleCodigoDeServicio, 'Detalle de códigos de servicio' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.AgruPubliDetalle, 'Agrupamientos' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompServiciosAlCliente.lNuevo = this.lNuevo
		this.oCompServiciosAlCliente.lEdicion = this.lEdicion
		this.oCompServiciosAlCliente.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFecha() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Fecha )
			this.AgregarInformacion( 'Debe cargar el campo Fecha', 9005, 'Fecha' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFechaEntrega() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaEntrega )
			this.AgregarInformacion( 'Debe cargar el campo Fecha de entrega', 9005, 'FechaEntrega' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCliente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Cliente_PK )
			this.AgregarInformacion( 'Debe cargar el campo Cliente', 9005, 'Cliente' )
			llRetorno = .F.
		else
			If this.Cliente.oAD.ConsultarPorClavePrimaria()
				This.Cliente.oDesactivador.ValidarEstadoActivacion( this.Cliente_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Cliente_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Cliente_PK ))+ ' de la entidad ' +  upper( this.Cliente.cDescripcion ) + ' no existe.')
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
			this.AgregarInformacion( 'Debe cargar el campo Recibido por', 9005, 'Vendedor' )
			llRetorno = .F.
		else
			If this.Vendedor.oAD.ConsultarPorClavePrimaria()
				This.Vendedor.oDesactivador.ValidarEstadoActivacion( this.Vendedor_PK , goLibrerias.Valorvacioseguntipo( vartype(this.Vendedor_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Vendedor_PK ))+ ' de la entidad ' +  upper( this.Vendedor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarArticulo() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Articulo_PK )
			this.AgregarInformacion( 'Debe cargar el campo Código', 9005, 'Articulo' )
			llRetorno = .F.
		else
			If this.Articulo.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Articulo_PK ))+ ' de la entidad ' +  upper( this.Articulo.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarColor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Color_PK )
		else
			If this.Color.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Color_PK ))+ ' de la entidad ' +  upper( this.Color.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPresupuesto() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Presupuesto_PK )
		else
			If this.Presupuesto.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Presupuesto_PK ))+ ' de la entidad ' +  upper( this.Presupuesto.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTipoDeOrden() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.TipoDeOrden_PK )
			this.AgregarInformacion( 'Debe cargar el campo Tipo de orden', 9005, 'TipoDeOrden' )
			llRetorno = .F.
		else
			If this.TipoDeOrden.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.TipoDeOrden_PK ))+ ' de la entidad ' +  upper( this.TipoDeOrden.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTalle() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Talle_PK )
		else
			If this.Talle.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Talle_PK ))+ ' de la entidad ' +  upper( this.Talle.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarSucursal() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Sucursal_PK )
		else
			If this.Sucursal.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Sucursal_PK ))+ ' de la entidad ' +  upper( this.Sucursal.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarEstado() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Estado_PK )
		else
			If this.Estado.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Estado_PK ))+ ' de la entidad ' +  upper( this.Estado.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarEntidadAdicional1() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.EntidadAdicional1_PK )
		else
			If this.EntidadAdicional1.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.EntidadAdicional1_PK ))+ ' de la entidad ' +  upper( this.EntidadAdicional1.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarEntidadAdicional2() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.EntidadAdicional2_PK )
		else
			If this.EntidadAdicional2.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.EntidadAdicional2_PK ))+ ' de la entidad ' +  upper( this.EntidadAdicional2.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarEntidadAdicional3() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.EntidadAdicional3_PK )
		else
			If this.EntidadAdicional3.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.EntidadAdicional3_PK ))+ ' de la entidad ' +  upper( this.EntidadAdicional3.cDescripcion ) + ' no existe.')
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
	*--------------------------------------------------------------------------------------------------------
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'FECHA' )
		loAtributosObligatorios.add( 'CLIENTE' )
		loAtributosObligatorios.add( 'VENDEDOR' )
		loAtributosObligatorios.add( 'ARTICULO' )
		loAtributosObligatorios.add( 'FECHAENTREGA' )
		loAtributosObligatorios.add( 'TIPODEORDEN' )
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
		this.oCompSERVICIOSALCLIENTE.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompSERVICIOSALCLIENTE.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompSERVICIOSALCLIENTE.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompSERVICIOSALCLIENTE.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<PUBLICA><CODIGOSUGERIDO><ANULABLE>'
	Endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		this.oProveedorAtributosAnulacion = newobject( "din_entidadORDENDESERVICIOAtributosAnulacion", "din_entidadORDENDESERVICIOAtributosAnulacion.prg" )
		bindevent( This, "Limpiar", this, "SetearValorComboPorDefecto", 1 )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWBasededatosaltafw()','Basededatosaltafw')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ORDENDESERVICIO', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
			if ( this.lHabilitarCliente_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Cliente( lxVal )
			If lxValOld != lxVal or empty( this.Clientedescripcion ) 
				this.Clientedescripcion = This.Cliente.Nombre
			endif
			If lxValOld != lxVal or empty( this.Idglobalcliente ) 
				this.Idglobalcliente = This.Cliente.Idglobal
			endif
			else
				this.Cliente_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Cliente)" )
			endif 
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
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Vendedor_PK = lxVal

		if this.Validar_Vendedor( lxVal, lxValOld )
			This.Setear_Vendedor( lxVal )
			If lxValOld != lxVal or empty( this.Vendedordescripcion ) 
				this.Vendedordescripcion = This.Vendedor.Nombre
			endif
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Articulo.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Articulo )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Articulo_PK = lxVal

		if this.Validar_Articulo( lxVal, lxValOld )
			if ( this.lHabilitarArticulo_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Articulo( lxVal )
			else
				this.Articulo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Articulo)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Color_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Color_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Color.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Color )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Color_PK = lxVal

		if this.Validar_Color( lxVal, lxValOld )
			if ( this.lHabilitarColor_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Color( lxVal )
			else
				this.Color_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Color)" )
			endif 
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
			if ( this.lHabilitarPresupuesto_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Presupuesto( lxVal )
				This.Presupuesto_PK_DespuesDeAsignar()
			else
				this.Presupuesto_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Presupuesto)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodeorden_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodeorden_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Tipodeorden_PK = lxVal

		if this.Validar_Tipodeorden( lxVal, lxValOld )
			if ( this.lHabilitarTipodeorden_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Tipodeorden( lxVal )
			else
				this.Tipodeorden_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Tipodeorden)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talle_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talle_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Talle.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Talle )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Talle_PK = lxVal

		if this.Validar_Talle( lxVal, lxValOld )
			if ( this.lHabilitarTalle_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Talle( lxVal )
			else
				this.Talle_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Talle)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sucursal_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Sucursal_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Sucursal_PK = lxVal

		if this.Validar_Sucursal( lxVal, lxValOld )
			This.Setear_Sucursal( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estado_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estado_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.Estado_PK = lxVal

		if this.Validar_Estado( lxVal, lxValOld )
			This.Setear_Estado( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional1_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadadicional1_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Entidadadicional1_PK = lxVal

		if this.Validar_Entidadadicional1( lxVal, lxValOld )
			This.Setear_Entidadadicional1( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional2_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadadicional2_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Entidadadicional2_PK = lxVal

		if this.Validar_Entidadadicional2( lxVal, lxValOld )
			This.Setear_Entidadadicional2( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional3_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadadicional3_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Entidadadicional3_PK = lxVal

		if this.Validar_Entidadadicional3( lxVal, lxValOld )
			This.Setear_Entidadadicional3( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo( txVal as variant ) as void

		this.Articulo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Color( txVal as variant ) as void

		this.Color.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Presupuesto( txVal as variant ) as void

		this.Presupuesto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodeorden( txVal as variant ) as void

		this.Tipodeorden.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talle( txVal as variant ) as void

		this.Talle.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Sucursal( txVal as variant ) as void

		this.Sucursal.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estado( txVal as variant ) as void

		this.Estado.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadadicional1( txVal as variant ) as void

		this.Entidadadicional1.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadadicional2( txVal as variant ) as void

		this.Entidadadicional2.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadadicional3( txVal as variant ) as void

		this.Entidadadicional3.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Vendedor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Presupuesto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodeorden( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Sucursal( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estado( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadadicional1( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadadicional2( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadadicional3( txVal as variant, txValOld as variant ) as Boolean

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
	function Tipoagrupamientopublicaciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipoagrupamientopublicaciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipoagrupamientopublicaciones( lxVal )
				this.Setear_Tipoagrupamientopublicaciones( lxVal )
			EndIf
		Else
			This.Setear_Tipoagrupamientopublicaciones( lxVal ) 
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
	function Fechaadicional1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaadicional1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaadicional1( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechaadicional1( lxVal )
			EndIf
		Else
			This.Setear_Fechaadicional1( lxVal ) 
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
	function Fechaadicional2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaadicional2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaadicional2( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechaadicional2( lxVal )
			EndIf
		Else
			This.Setear_Fechaadicional2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaentrega_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaentrega
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaentrega( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechaentrega( lxVal )
			EndIf
		Else
			This.Setear_Fechaentrega( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedescripcion( lxVal )
				if ( this.lHabilitarClientedescripcion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Clientedescripcion( lxVal )
				else
					this.Clientedescripcion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Clientedescripcion)" )
				endif 
			EndIf
		Else
			This.Setear_Clientedescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedordescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedordescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vendedordescripcion( lxVal )
				this.Setear_Vendedordescripcion( lxVal )
			EndIf
		Else
			This.Setear_Vendedordescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaadicional3_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaadicional3
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaadicional3( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechaadicional3( lxVal )
			EndIf
		Else
			This.Setear_Fechaadicional3( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Guidpresupuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Guidpresupuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Guidpresupuesto( lxVal )
				this.Setear_Guidpresupuesto( lxVal )
			EndIf
		Else
			This.Setear_Guidpresupuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letrapresupuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letrapresupuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letrapresupuesto( lxVal )
				this.Setear_Letrapresupuesto( lxVal )
			EndIf
		Else
			This.Setear_Letrapresupuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numeropresupuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numeropresupuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numeropresupuesto( lxVal )
				this.Setear_Numeropresupuesto( lxVal )
			EndIf
		Else
			This.Setear_Numeropresupuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ptovtapresupuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ptovtapresupuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ptovtapresupuesto( lxVal )
				this.Setear_Ptovtapresupuesto( lxVal )
			EndIf
		Else
			This.Setear_Ptovtapresupuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idglobalcliente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idglobalcliente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idglobalcliente( lxVal )
				if ( this.lHabilitarIdglobalcliente or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Idglobalcliente( lxVal )
				else
					this.Idglobalcliente = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Idglobalcliente)" )
				endif 
			EndIf
		Else
			This.Setear_Idglobalcliente( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nrofactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nrofactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nrofactura( lxVal )
				this.Setear_Nrofactura( lxVal )
			EndIf
		Else
			This.Setear_Nrofactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechafactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechafactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechafactura( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechafactura( lxVal )
			EndIf
		Else
			This.Setear_Fechafactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Valor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Valor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Valor( lxVal )
				if ( this.lHabilitarValor or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Valor( lxVal )
				else
					this.Valor = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Orden de servicio - Atributo: Valor)" )
				endif 
			EndIf
		Else
			This.Setear_Valor( lxVal ) 
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
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
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
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
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
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
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
	function Setear_Tipoagrupamientopublicaciones( txVal as variant ) as void

		this.Tipoagrupamientopublicaciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaadicional1( txVal as variant ) as void

		this.Fechaadicional1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Obs( txVal as variant ) as void

		this.Obs = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaadicional2( txVal as variant ) as void

		this.Fechaadicional2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaentrega( txVal as variant ) as void

		this.Fechaentrega = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedordescripcion( txVal as variant ) as void

		this.Vendedordescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaadicional3( txVal as variant ) as void

		this.Fechaadicional3 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Guidpresupuesto( txVal as variant ) as void

		this.Guidpresupuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letrapresupuesto( txVal as variant ) as void

		this.Letrapresupuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numeropresupuesto( txVal as variant ) as void

		this.Numeropresupuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ptovtapresupuesto( txVal as variant ) as void

		this.Ptovtapresupuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idglobalcliente( txVal as variant ) as void

		this.Idglobalcliente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrofactura( txVal as variant ) as void

		this.Nrofactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechafactura( txVal as variant ) as void

		this.Fechafactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Valor( txVal as variant ) as void

		this.Valor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

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
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

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
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

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
	function Validar_Tipoagrupamientopublicaciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaadicional1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Obs( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaadicional2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaentrega( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedordescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaadicional3( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Guidpresupuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letrapresupuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numeropresupuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ptovtapresupuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idglobalcliente( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrofactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechafactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Valor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Articulo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Articulo ) = 'O' or isnull( this.Articulo ) )
					this.Articulo = _Screen.zoo.instanciarentidad( 'Articulo' )
					this.Articulo.lEsSubEntidad = .t.
					this.enlazar( 'Articulo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Articulo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Articulo.CODIGO # this.Articulo_PK
						this.Articulo.CODIGO = this.Articulo_PK
					endif
				endif
			endif
		endif
		return this.Articulo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Color_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Color ) = 'O' or isnull( this.Color ) )
					this.Color = _Screen.zoo.instanciarentidad( 'Color' )
					this.Color.lEsSubEntidad = .t.
					this.enlazar( 'Color.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Color.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Color.CODIGO # this.Color_PK
						this.Color.CODIGO = this.Color_PK
					endif
				endif
			endif
		endif
		return this.Color
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
	function Tipodeorden_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tipodeorden ) = 'O' or isnull( this.Tipodeorden ) )
					this.Tipodeorden = _Screen.zoo.instanciarentidad( 'Tipodeorden' )
					this.Tipodeorden.lEsSubEntidad = .t.
					this.enlazar( 'Tipodeorden.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tipodeorden.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tipodeorden.CODIGO # this.Tipodeorden_PK
						this.Tipodeorden.CODIGO = this.Tipodeorden_PK
					endif
				endif
			endif
		endif
		return this.Tipodeorden
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talle_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Talle ) = 'O' or isnull( this.Talle ) )
					this.Talle = _Screen.zoo.instanciarentidad( 'Talle' )
					this.Talle.lEsSubEntidad = .t.
					this.enlazar( 'Talle.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Talle.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Talle.CODIGO # this.Talle_PK
						this.Talle.CODIGO = this.Talle_PK
					endif
				endif
			endif
		endif
		return this.Talle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sucursal_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Sucursal ) = 'O' or isnull( this.Sucursal ) )
					this.Sucursal = _Screen.zoo.instanciarentidad( 'Sucursal' )
					this.Sucursal.lEsSubEntidad = .t.
					this.enlazar( 'Sucursal.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Sucursal.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Sucursal.CODIGO # this.Sucursal_PK
						this.Sucursal.CODIGO = this.Sucursal_PK
					endif
				endif
			endif
		endif
		return this.Sucursal
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estado_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Estado ) = 'O' or isnull( this.Estado ) )
					this.Estado = _Screen.zoo.instanciarentidad( 'Estadosdeinteraccion' )
					this.Estado.lEsSubEntidad = .t.
					this.enlazar( 'Estado.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Estado.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Estado.CODIGO # this.Estado_PK
						this.Estado.CODIGO = this.Estado_PK
					endif
				endif
			endif
		endif
		return this.Estado
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional1_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Entidadadicional1 ) = 'O' or isnull( this.Entidadadicional1 ) )
					this.Entidadadicional1 = _Screen.zoo.instanciarentidad( 'Entidadadicional1' )
					this.Entidadadicional1.lEsSubEntidad = .t.
					this.enlazar( 'Entidadadicional1.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Entidadadicional1.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Entidadadicional1.CODIGO # this.Entidadadicional1_PK
						this.Entidadadicional1.CODIGO = this.Entidadadicional1_PK
					endif
				endif
			endif
		endif
		return this.Entidadadicional1
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional2_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Entidadadicional2 ) = 'O' or isnull( this.Entidadadicional2 ) )
					this.Entidadadicional2 = _Screen.zoo.instanciarentidad( 'Entidadadicional2' )
					this.Entidadadicional2.lEsSubEntidad = .t.
					this.enlazar( 'Entidadadicional2.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Entidadadicional2.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Entidadadicional2.CODIGO # this.Entidadadicional2_PK
						this.Entidadadicional2.CODIGO = this.Entidadadicional2_PK
					endif
				endif
			endif
		endif
		return this.Entidadadicional2
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadadicional3_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Entidadadicional3 ) = 'O' or isnull( this.Entidadadicional3 ) )
					this.Entidadadicional3 = _Screen.zoo.instanciarentidad( 'Entidadadicional3' )
					this.Entidadadicional3.lEsSubEntidad = .t.
					this.enlazar( 'Entidadadicional3.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Entidadadicional3.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Entidadadicional3.CODIGO # this.Entidadadicional3_PK
						this.Entidadadicional3.CODIGO = this.Entidadadicional3_PK
					endif
				endif
			endif
		endif
		return this.Entidadadicional3
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompServiciosalcliente_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompServiciosalcliente ) = 'O' or isnull( this.oCompServiciosalcliente ) )
			this.oCompServiciosalcliente = _Screen.zoo.InstanciarComponente( 'ComponenteServiciosalcliente' )
		this.oCompServiciosalcliente.Inicializar()
		this.enlazar( 'oCompServiciosalcliente.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompServiciosalcliente.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompServiciosalcliente
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
				.Fechaimpo = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Zadsfw = []
				.Estadotransferencia = []
				.Basededatosmodificacionfw = []
				.Horaimpo = []
				.Horaaltafw = []
				.Usuariomodificacionfw = []
				.Usuarioaltafw = []
				.Seriemodificacionfw = []
				.Horaexpo = []
				.Horamodificacionfw = []
				.Seriealtafw = []
				.Versionaltafw = []
				.Versionmodificacionfw = []
				.Tipoagrupamientopublicaciones = 0
				.Anulado = .F.
				.Fechaadicional1 = ctod( '  /  /    ' )
				.Fecha = ctod( '  /  /    ' )
				.Cliente_PK = []
				.Vendedor_PK = []
				.Articulo_PK = []
				.Obs = []
				.Detallecodigodeservicio.Limpiar()
				.Agrupublidetalle.Limpiar()
				.Fechaadicional2 = ctod( '  /  /    ' )
				.Fechaentrega = ctod( '  /  /    ' )
				.Clientedescripcion = []
				.Vendedordescripcion = []
				.Color_PK = []
				.Codigo = []
				.Fechaadicional3 = ctod( '  /  /    ' )
				.Guidpresupuesto = []
				.Letrapresupuesto = []
				.Numeropresupuesto = 0
				.Ptovtapresupuesto = 0
				.Idglobalcliente = []
				.Tipodeorden_PK = []
				.Talle_PK = []
				.Nrofactura = []
				.Sucursal_PK = []
				.Estado_PK = []
				.Entidadadicional1_PK = []
				.Fechafactura = ctod( '  /  /    ' )
				.Valor = 0
				.Basededatosaltafw = []
				.Entidadadicional2_PK = []
				.Entidadadicional3_PK = []
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
			if this.EsNuevo() and this.DebeSugerirCodigo() and this.EstaEnProceso()
				this.SetearCodigoSugerido()
			endif
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
	Function ValorSugeridoFechaadicional1() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fechaadicional1" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechaadicional1' )
						.Fechaadicional1 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha adicional 1 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fecha" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
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
			.Fecha = golibrerias.obtenerfecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Cliente" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Vendedor" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Recibido por para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoArticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Articulo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Articulo_PK' )
						.Articulo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Articulo.CODIGO = .Articulo_PK
					endif
				endif
			Catch to loError
				.Articulo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Obs" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaadicional2() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fechaadicional2" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechaadicional2' )
						.Fechaadicional2 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha adicional 2 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaentrega() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fechaentrega" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechaentrega' )
						.Fechaentrega = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de entrega para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClientedescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Clientedescripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Clientedescripcion' )
						.Clientedescripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente descripción para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedordescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Vendedordescripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vendedordescripcion' )
						.Vendedordescripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Recibido descripción para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoColor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Color" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Color_PK' )
						.Color_PK = lvValorSugeridoDefinidoPorElUsuario
						.Color.CODIGO = .Color_PK
					endif
				endif
			Catch to loError
				.Color_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaadicional3() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fechaadicional3" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechaadicional3' )
						.Fechaadicional3 = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha adicional 3 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPresupuesto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Presupuesto" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Presupuesto número para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipodeorden() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Tipodeorden" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipodeorden_PK' )
						.Tipodeorden_PK = lvValorSugeridoDefinidoPorElUsuario
						.Tipodeorden.CODIGO = .Tipodeorden_PK
					endif
				endif
			Catch to loError
				.Tipodeorden_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo de orden para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Talle" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Talle_PK' )
						.Talle_PK = lvValorSugeridoDefinidoPorElUsuario
						.Talle.CODIGO = .Talle_PK
					endif
				endif
			Catch to loError
				.Talle_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNrofactura() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Nrofactura" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Nrofactura' )
						.Nrofactura = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nro. de ticket/Fac. para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEntidadadicional1() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Entidadadicional1" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Entidadadicional1_PK' )
						.Entidadadicional1_PK = lvValorSugeridoDefinidoPorElUsuario
						.Entidadadicional1.CODIGO = .Entidadadicional1_PK
					endif
				endif
			Catch to loError
				.Entidadadicional1_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Entidad adicional 1 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechafactura() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Fechafactura" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechafactura' )
						.Fechafactura = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de ticket/Fac. para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoValor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Valor" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Valor' )
						.Valor = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Valor para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWBasededatosaltafw() as void
		with this
			.Basededatosaltafw = _screen.Zoo.App.cSucursalActiva
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBasededatosaltafw() as void
		with this
			.ValorSugeridoFWBasededatosaltafw()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEntidadadicional2() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Entidadadicional2" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Entidadadicional2_PK' )
						.Entidadadicional2_PK = lvValorSugeridoDefinidoPorElUsuario
						.Entidadadicional2.CODIGO = .Entidadadicional2_PK
					endif
				endif
			Catch to loError
				.Entidadadicional2_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Entidad adicional 2 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEntidadadicional3() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ORDENDESERVICIO", "", "Entidadadicional3" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Entidadadicional3_PK' )
						.Entidadadicional3_PK = lvValorSugeridoDefinidoPorElUsuario
						.Entidadadicional3.CODIGO = .Entidadadicional3_PK
					endif
				endif
			Catch to loError
				.Entidadadicional3_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Entidad adicional 3 para la entidad Orden de servicio." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Presupuesto_PK_DespuesDeAsignar() as void
		This.CompletarDatosPresupuesto()                                                                    
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompServiciosAlCliente = null
		use in select( 'c_ORDENDESERVICIO' )
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Detalleinteracciones.Limpiar()
			.Presupuesto_PK = []
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
	
	*-----------------------------------------------------------------------------------------
	function LimpiarDatosDetalleAgrupamientoPublicaciones() as Void
		local lnItem as Integer
		for lnItem = 1 to This.AgruPubliDetalle.Count
			This.AgruPubliDetalle.oItem.Limpiar()
			This.AgruPubliDetalle.CargarItem( lnItem )
			This.AgruPubliDetalle.oItem.Limpiar()
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function CargarCadenaAgrupamientosParaComboToolbar( tnOpcion as Integer ) as String
		local cCadenaAgrupamientos as String, lnItem as Integer, llHayDatos as Boolean
		
		cCadenaAgrupamientos = ''
		llHayDatos = .F.
		for lnItem = 1 to This.AgruPubliDetalle.Count
			if !empty( alltrim( This.AgruPubliDetalle.Item[lnItem].Agrupamiento_PK ) )
				cCadenaAgrupamientos = cCadenaAgrupamientos + alltrim( This.AgruPubliDetalle.Item[lnItem].Agrupamiento_PK ) + '; '
				llHayDatos = .T.
			endif
		endfor
		if llHayDatos
			cCadenaAgrupamientos = left( cCadenaAgrupamientos , len( cCadenaAgrupamientos ) - 2 )
			if tnOpcion == 1
				if len( cCadenaAgrupamientos ) > 21
					cCadenaAgrupamientos = substr( cCadenaAgrupamientos, 1, 21 ) + '...'
				endif
			endif
		endif
		
		Return cCadenaAgrupamientos
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearValorComboPorDefecto() as Void
		this.EventoSetearValorComboPorDefecto()
	Endfunc
	
	*-----------------------------------------------------------------------------------------
	function EventoSetearValorComboPorDefecto() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
	endfunc

enddefine