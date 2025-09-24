
define class Din_EntidadCALCULODEPRECIOS as entidad of entidad.prg

	cNombre = 'CALCULODEPRECIOS'
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	cAtributoPK = 'Codigo'
	Codigo = 0
	TIMESTAMP = 0
	Anulado = .F.
	SERIEALTAFW = []
	VERSIONALTAFW = []
	USUARIOALTAFW = []
	VERSIONMODIFICACIONFW = []
	HORAALTAFW = []
	DescripcionFW = []
	ZADSFW = []
	BASEDEDATOSMODIFICACIONFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSALTAFW = []
	HORAEXPO = []
	USUARIOMODIFICACIONFW = []
	HORAIMPO = []
	SERIEMODIFICACIONFW = []
	HORAMODIFICACIONFW = []
	Descripcion = []
	Fecha = ctod( '  /  /    ' )
	FechaProceso = ctod( '  /  /    ' )
	FechaVigencia = ctod( '  /  /    ' )
	FechaBase = ctod( '  /  /    ' )
	f_Articulo_Desde_PK = []
	f_Articulo_Desde = null
	ImportarSinTransaccion = .F.
	f_Articulo_Hasta_PK = []
	f_Articulo_Hasta = null
	f_Color_Desde_PK = []
	f_Color_Desde = null
	lHabilitarf_Color_Desde_PK = .T.
	f_Color_Hasta_PK = []
	f_Color_Hasta = null
	lHabilitarf_Color_Hasta_PK = .T.
	Articulo_Comportamiento = []
	f_Talle_Desde = []
	lHabilitarf_Talle_Desde = .T.
	PrecioKitPackxParticipante = .F.
	lHabilitarPrecioKitPackxParticipante = .T.
	f_Talle_Hasta = []
	lHabilitarf_Talle_Hasta = .T.
	f_Articulo_Proveedor_Desde_PK = []
	f_Articulo_Proveedor_Desde = null
	UsaCombinacion = .F.
	f_Articulo_Proveedor_Hasta_PK = []
	f_Articulo_Proveedor_Hasta = null
	f_Articulo_Unidad_Desde_PK = []
	f_Articulo_Unidad_Desde = null
	f_Articulo_Unidad_Hasta_PK = []
	f_Articulo_Unidad_Hasta = null
	f_Articulo_Material_Desde_PK = []
	f_Articulo_Material_Desde = null
	f_Articulo_Material_Hasta_PK = []
	f_Articulo_Material_Hasta = null
	f_Articulo_Estacion_Desde = 0
	f_Articulo_Estacion_Hasta = 0
	f_Articulo_UsuarioAltaFw = []
	ModPrecios = null
	f_Articulo_Anio_Desde = []
	f_Articulo_UsuarioModificacionFw = []
	Observacion = []
	f_Articulo_Anio_Hasta = []
	f_Articulo_clasificacion_desde_PK = []
	f_Articulo_clasificacion_desde = null
	f_Articulo_Nomenclador_Desde_PK = []
	f_Articulo_Nomenclador_Desde = null
	f_Articulo_clasificacion_hasta_PK = []
	f_Articulo_clasificacion_hasta = null
	f_Articulo_Nomenclador_Hasta_PK = []
	f_Articulo_Nomenclador_Hasta = null
	f_TimestampAlta_desde = 0
	f_TimestampAlta_hasta = 0
	f_Articulo_FechaAltaFW_Desde = ctod( '  /  /    ' )
	f_Articulo_FechaAltaFW_Hasta = ctod( '  /  /    ' )
	f_Articulo_Comportamiento_Desde = 0
	f_Articulo_Comportamiento_Hasta = 0
	f_Preciodirecto_Desde = 0
	lHabilitarf_Preciodirecto_Desde = .T.
	f_Preciodirecto_Hasta = 0
	lHabilitarf_Preciodirecto_Hasta = .T.
	f_Articulo_Marca_Desde_PK = []
	f_Articulo_Marca_Desde = null
	f_Articulo_Marca_Hasta_PK = []
	f_Articulo_Marca_Hasta = null
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Modificación masiva de precios]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarf_Color_Desde_PK = .T.
		this.lHabilitarf_Color_Hasta_PK = .T.
		this.lHabilitarf_Talle_Desde = .T.
		this.lHabilitarPrecioKitPackxParticipante = .T.
		this.lHabilitarf_Talle_Hasta = .T.
		this.lHabilitarf_Preciodirecto_Desde = .T.
		this.lHabilitarf_Preciodirecto_Hasta = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigo_Assign( txVal as variant ) as void
		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean
		with this
			llEdicion = .EsEdicion()
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
						llConsulta = .oAD.ConsultarPorClavePrimaria()
						do case
							case !llNuevo and llConsulta
								.Cargar()
							case !llNuevo and !llConsulta
								.Limpiar()
								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )
							case llNuevo and llConsulta
								.Codigo = 0
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
			this.oAD = this.crearobjeto( 'Din_EntidadCALCULODEPRECIOSAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Modprecios_Access() as variant
		if !this.ldestroy and ( !vartype( this.Modprecios ) = 'O' or isnull( this.Modprecios ) )
			this.Modprecios = this.crearobjeto( 'Din_DetalleCalculodepreciosModprecios' )
			this.Modprecios.inicializar()
			this.enlazar( 'Modprecios.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Modprecios.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Modprecios, 'CambioSumarizado', this, 'CambiosDetalleModprecios', 1) 
			this.enlazar( 'Modprecios.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Modprecios.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Modprecios
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.ModPrecios.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.ModPrecios.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleModprecios() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
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
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.Codigo) = 'N' )
			lnLargoEntero  = len( transform( int( this.CODIGO ) ) ) 
			lnValorDelDecimal = this.CODIGO - int( this.CODIGO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
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
		 
		if ( vartype( this.Anulado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ANULADO no es el correcto.')
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
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
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
		 
		if ( vartype( this.HORAALTAFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
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
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
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
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
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
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Descripcion) = 'C' )
			if len( alltrim( this.DESCRIPCION ) ) > 40
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Fecha) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaProceso) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAPROCESO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaVigencia) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAVIGENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaBase) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHABASE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ImportarSinTransaccion) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IMPORTARSINTRANSACCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Articulo_Comportamiento) = 'C' )
			if len( alltrim( this.ARTICULO_COMPORTAMIENTO ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo ARTICULO_COMPORTAMIENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ARTICULO_COMPORTAMIENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Talle_Desde) = 'C' )
			if len( alltrim( this.F_TALLE_DESDE ) ) > 3
				This.AgregarInformacion( 'La longitud del valor del atributo F_TALLE_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_TALLE_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PrecioKitPackxParticipante) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PRECIOKITPACKXPARTICIPANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Talle_Hasta) = 'C' )
			if len( alltrim( this.F_TALLE_HASTA ) ) > 3
				This.AgregarInformacion( 'La longitud del valor del atributo F_TALLE_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_TALLE_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.UsaCombinacion) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USACOMBINACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Estacion_Desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_ESTACION_DESDE ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_ESTACION_DESDE - int( this.F_ARTICULO_ESTACION_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_ESTACION_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ESTACION_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Estacion_Hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_ESTACION_HASTA ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_ESTACION_HASTA - int( this.F_ARTICULO_ESTACION_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_ESTACION_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ESTACION_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_UsuarioAltaFw) = 'C' )
			if len( alltrim( this.F_ARTICULO_USUARIOALTAFW ) ) > 65
				This.AgregarInformacion( 'La longitud del valor del atributo F_ARTICULO_USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_USUARIOALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Anio_Desde) = 'C' )
			if len( alltrim( this.F_ARTICULO_ANIO_DESDE ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo F_ARTICULO_ANIO_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ANIO_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_UsuarioModificacionFw) = 'C' )
			if len( alltrim( this.F_ARTICULO_USUARIOMODIFICACIONFW ) ) > 65
				This.AgregarInformacion( 'La longitud del valor del atributo F_ARTICULO_USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_USUARIOMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Observacion) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBSERVACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Anio_Hasta) = 'C' )
			if len( alltrim( this.F_ARTICULO_ANIO_HASTA ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo F_ARTICULO_ANIO_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ANIO_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_TimestampAlta_desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_TIMESTAMPALTA_DESDE ) ) ) 
			lnValorDelDecimal = this.F_TIMESTAMPALTA_DESDE - int( this.F_TIMESTAMPALTA_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 14
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_TIMESTAMPALTA_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_TIMESTAMPALTA_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_TimestampAlta_hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_TIMESTAMPALTA_HASTA ) ) ) 
			lnValorDelDecimal = this.F_TIMESTAMPALTA_HASTA - int( this.F_TIMESTAMPALTA_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 14
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_TIMESTAMPALTA_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_TIMESTAMPALTA_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_FechaAltaFW_Desde) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_FECHAALTAFW_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_FechaAltaFW_Hasta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_FECHAALTAFW_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Comportamiento_Desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_COMPORTAMIENTO_DESDE ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_COMPORTAMIENTO_DESDE - int( this.F_ARTICULO_COMPORTAMIENTO_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_COMPORTAMIENTO_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_COMPORTAMIENTO_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Comportamiento_Hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_COMPORTAMIENTO_HASTA ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_COMPORTAMIENTO_HASTA - int( this.F_ARTICULO_COMPORTAMIENTO_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_COMPORTAMIENTO_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_COMPORTAMIENTO_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Preciodirecto_Desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_PRECIODIRECTO_DESDE ) ) ) 
			lnValorDelDecimal = this.F_PRECIODIRECTO_DESDE - int( this.F_PRECIODIRECTO_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_PRECIODIRECTO_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_PRECIODIRECTO_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Preciodirecto_Hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_PRECIODIRECTO_HASTA ) ) ) 
			lnValorDelDecimal = this.F_PRECIODIRECTO_HASTA - int( this.F_PRECIODIRECTO_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_PRECIODIRECTO_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_PRECIODIRECTO_HASTA no es el correcto.')
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
			llRetorno = .ValidarFecha() and llRetorno
			llRetorno = .ValidarFechavigencia() and llRetorno
			llRetorno = .ValidarFechabase() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.ModPrecios, 'ModPrecios' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

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
	function ValidarFechaVigencia() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaVigencia )
			this.AgregarInformacion( 'Debe cargar el campo Vigencia desde', 9005, 'FechaVigencia' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarFechaBase() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.FechaBase )
			this.AgregarInformacion( 'Debe cargar el campo Fecha base de precios', 9005, 'FechaBase' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Desde_PK )
		else
			If this.f_Articulo_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Hasta_PK )
		else
			If this.f_Articulo_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Color_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Color_Desde_PK )
		else
			If this.f_Color_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Color_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Color_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Color_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Color_Hasta_PK )
		else
			If this.f_Color_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Color_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Color_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Proveedor_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Proveedor_Desde_PK )
		else
			If this.f_Articulo_Proveedor_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Proveedor_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Proveedor_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Proveedor_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Proveedor_Hasta_PK )
		else
			If this.f_Articulo_Proveedor_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Proveedor_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Proveedor_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Unidad_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Unidad_Desde_PK )
		else
			If this.f_Articulo_Unidad_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Unidad_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Unidad_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Unidad_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Unidad_Hasta_PK )
		else
			If this.f_Articulo_Unidad_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Unidad_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Unidad_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Material_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Material_Desde_PK )
		else
			If this.f_Articulo_Material_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Material_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Material_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Material_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Material_Hasta_PK )
		else
			If this.f_Articulo_Material_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Material_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Material_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_clasificacion_desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_clasificacion_desde_PK )
		else
			If this.f_Articulo_clasificacion_desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_clasificacion_desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_clasificacion_desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Nomenclador_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Nomenclador_Desde_PK )
		else
			If this.f_Articulo_Nomenclador_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Nomenclador_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Nomenclador_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_clasificacion_hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_clasificacion_hasta_PK )
		else
			If this.f_Articulo_clasificacion_hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_clasificacion_hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_clasificacion_hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Nomenclador_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Nomenclador_Hasta_PK )
		else
			If this.f_Articulo_Nomenclador_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Nomenclador_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Nomenclador_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Marca_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Marca_Desde_PK )
		else
			If this.f_Articulo_Marca_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Marca_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Marca_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Marca_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Marca_Hasta_PK )
		else
			If this.f_Articulo_Marca_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Marca_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Marca_Hasta.cDescripcion ) + ' no existe.')
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
	protected Function ValidarExistencia() As Boolean
		local llRetorno as Boolean
		if This.EsNuevo()
			llRetorno = .F.
		else
			llRetorno = dodefault()
		endif
		return llRetorno
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
		loAtributosObligatorios.add( 'CODIGO' )
		loAtributosObligatorios.add( 'FECHA' )
		loAtributosObligatorios.add( 'FECHAVIGENCIA' )
		loAtributosObligatorios.add( 'FECHABASE' )
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
		return '<NOIMPO><NOEXPO><ANULABLE><INSERTCONTINUO>'
	Endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .F.
		this.oProveedorAtributosAnulacion = newobject( "din_entidadCALCULODEPRECIOSAtributosAnulacion", "din_entidadCALCULODEPRECIOSAtributosAnulacion.prg" )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFecha()','Fecha')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechavigencia()','Fechavigencia')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechabase()','Fechabase')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWImportarsintransaccion()','Importarsintransaccion')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_hasta()','F_articulo_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_color_hasta()','F_color_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWPreciokitpackxparticipante()','Preciokitpackxparticipante')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_talle_hasta()','F_talle_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWUsacombinacion()','Usacombinacion')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_proveedor_hasta()','F_articulo_proveedor_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_unidad_hasta()','F_articulo_unidad_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_material_hasta()','F_articulo_material_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_estacion_desde()','F_articulo_estacion_desde')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_estacion_hasta()','F_articulo_estacion_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_anio_hasta()','F_articulo_anio_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_clasificacion_hasta()','F_articulo_clasificacion_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_nomenclador_hasta()','F_articulo_nomenclador_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_timestampalta_hasta()','F_timestampalta_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_fechaaltafw_hasta()','F_articulo_fechaaltafw_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_comportamiento_desde()','F_articulo_comportamiento_desde')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_comportamiento_hasta()','F_articulo_comportamiento_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_preciodirecto_hasta()','F_preciodirecto_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_marca_hasta()','F_articulo_marca_hasta')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CALCULODEPRECIOS', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 13, padr( lxVal, 13 ), lxVal )
		this.F_articulo_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 13, padr( lxVal, 13 ), lxVal )
		this.F_articulo_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_color_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 2, padr( lxVal, 2 ), lxVal )
		this.F_color_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_color_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 2, padr( lxVal, 2 ), lxVal )
		this.F_color_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_proveedor_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_proveedor_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_proveedor_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_proveedor_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_articulo_proveedor_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_proveedor_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_proveedor_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_proveedor_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_proveedor_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_articulo_proveedor_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_unidad_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_unidad_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_unidad_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_unidad_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )
		this.F_articulo_unidad_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_unidad_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_unidad_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_unidad_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_unidad_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )
		this.F_articulo_unidad_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_material_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_material_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_material_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_material_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_material_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_material_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_clasificacion_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_clasificacion_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_nomenclador_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_nomenclador_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.F_articulo_nomenclador_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_clasificacion_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_clasificacion_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_nomenclador_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_nomenclador_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.F_articulo_nomenclador_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_marca_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_marca_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_marca_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_marca_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.F_articulo_marca_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_marca_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_marca_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_marca_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_marca_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.F_articulo_marca_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_desde( txVal as variant ) as void

		this.F_articulo_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_hasta( txVal as variant ) as void

		this.F_articulo_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_color_desde( txVal as variant ) as void

		this.F_color_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_color_hasta( txVal as variant ) as void

		this.F_color_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_proveedor_desde( txVal as variant ) as void

		this.F_articulo_proveedor_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_proveedor_hasta( txVal as variant ) as void

		this.F_articulo_proveedor_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_unidad_desde( txVal as variant ) as void

		this.F_articulo_unidad_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_unidad_hasta( txVal as variant ) as void

		this.F_articulo_unidad_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_material_desde( txVal as variant ) as void

		this.F_articulo_material_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_material_hasta( txVal as variant ) as void

		this.F_articulo_material_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_clasificacion_desde( txVal as variant ) as void

		this.F_articulo_clasificacion_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_nomenclador_desde( txVal as variant ) as void

		this.F_articulo_nomenclador_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_clasificacion_hasta( txVal as variant ) as void

		this.F_articulo_clasificacion_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_nomenclador_hasta( txVal as variant ) as void

		this.F_articulo_nomenclador_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_marca_desde( txVal as variant ) as void

		this.F_articulo_marca_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_marca_hasta( txVal as variant ) as void

		this.F_articulo_marca_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_color_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_color_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_proveedor_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_proveedor_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_unidad_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_unidad_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_material_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_material_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_clasificacion_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_nomenclador_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_clasificacion_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_nomenclador_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_marca_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_marca_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Fechaproceso_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaproceso
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaproceso( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaproceso( lxVal )
			EndIf
		Else
			This.Setear_Fechaproceso( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechavigencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechavigencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechavigencia( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechavigencia( lxVal )
			EndIf
		Else
			This.Setear_Fechavigencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechabase_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechabase
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechabase( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechabase( lxVal )
			EndIf
		Else
			This.Setear_Fechabase( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Importarsintransaccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Importarsintransaccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Importarsintransaccion( lxVal )
				this.Setear_Importarsintransaccion( lxVal )
			EndIf
		Else
			This.Setear_Importarsintransaccion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_comportamiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_comportamiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulo_comportamiento( lxVal )
				this.Setear_Articulo_comportamiento( lxVal )
				 This.Articulo_comportamiento_DespuesDeAsignar()
			EndIf
		Else
			This.Setear_Articulo_comportamiento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_talle_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_talle_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_talle_desde( lxVal )
				if ( this.lHabilitarF_talle_desde or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_F_talle_desde( lxVal )
				else
					this.F_talle_desde = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modificación masiva de precios - Atributo: F_talle_desde)" )
				endif 
			EndIf
		Else
			This.Setear_F_talle_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preciokitpackxparticipante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciokitpackxparticipante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciokitpackxparticipante( lxVal )
				if ( this.lHabilitarPreciokitpackxparticipante or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Preciokitpackxparticipante( lxVal )
				else
					this.Preciokitpackxparticipante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modificación masiva de precios - Atributo: Preciokitpackxparticipante)" )
				endif 
			EndIf
		Else
			This.Setear_Preciokitpackxparticipante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_talle_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_talle_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_talle_hasta( lxVal )
				if ( this.lHabilitarF_talle_hasta or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_F_talle_hasta( lxVal )
				else
					this.F_talle_hasta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modificación masiva de precios - Atributo: F_talle_hasta)" )
				endif 
			EndIf
		Else
			This.Setear_F_talle_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usacombinacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usacombinacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usacombinacion( lxVal )
				this.Setear_Usacombinacion( lxVal )
			EndIf
		Else
			This.Setear_Usacombinacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_estacion_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_estacion_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_estacion_desde( lxVal )
				this.Setear_F_articulo_estacion_desde( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_estacion_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_estacion_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_estacion_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_estacion_hasta( lxVal )
				this.Setear_F_articulo_estacion_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_estacion_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_usuarioaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_usuarioaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_usuarioaltafw( lxVal )
				this.Setear_F_articulo_usuarioaltafw( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_usuarioaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_anio_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_anio_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_anio_desde( lxVal )
				this.Setear_F_articulo_anio_desde( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_anio_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_usuariomodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_usuariomodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_usuariomodificacionfw( lxVal )
				this.Setear_F_articulo_usuariomodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_usuariomodificacionfw( lxVal ) 
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
	function F_articulo_anio_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_anio_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_anio_hasta( lxVal )
				this.Setear_F_articulo_anio_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_anio_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_timestampalta_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_timestampalta_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_timestampalta_desde( lxVal )
				this.Setear_F_timestampalta_desde( lxVal )
			EndIf
		Else
			This.Setear_F_timestampalta_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_timestampalta_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_timestampalta_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_timestampalta_hasta( lxVal )
				this.Setear_F_timestampalta_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_timestampalta_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_fechaaltafw_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_fechaaltafw_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_fechaaltafw_desde( lxVal )
				this.Setear_F_articulo_fechaaltafw_desde( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_fechaaltafw_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_fechaaltafw_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_fechaaltafw_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_fechaaltafw_hasta( lxVal )
				this.Setear_F_articulo_fechaaltafw_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_fechaaltafw_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_comportamiento_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_comportamiento_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_comportamiento_desde( lxVal )
				this.Setear_F_articulo_comportamiento_desde( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_comportamiento_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_comportamiento_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_comportamiento_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_comportamiento_hasta( lxVal )
				this.Setear_F_articulo_comportamiento_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_comportamiento_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_preciodirecto_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_preciodirecto_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_preciodirecto_desde( lxVal )
				if ( this.lHabilitarF_preciodirecto_desde or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_F_preciodirecto_desde( lxVal )
				else
					this.F_preciodirecto_desde = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modificación masiva de precios - Atributo: F_preciodirecto_desde)" )
				endif 
			EndIf
		Else
			This.Setear_F_preciodirecto_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_preciodirecto_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_preciodirecto_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_preciodirecto_hasta( lxVal )
				if ( this.lHabilitarF_preciodirecto_hasta or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_F_preciodirecto_hasta( lxVal )
				else
					this.F_preciodirecto_hasta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Modificación masiva de precios - Atributo: F_preciodirecto_hasta)" )
				endif 
			EndIf
		Else
			This.Setear_F_preciodirecto_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

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
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
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
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Anulado( txVal as variant ) as void

		this.Anulado = txVal
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
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaproceso( txVal as variant ) as void

		this.Fechaproceso = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechavigencia( txVal as variant ) as void

		this.Fechavigencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechabase( txVal as variant ) as void

		this.Fechabase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Importarsintransaccion( txVal as variant ) as void

		this.Importarsintransaccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_comportamiento( txVal as variant ) as void

		this.Articulo_comportamiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_talle_desde( txVal as variant ) as void

		this.F_talle_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciokitpackxparticipante( txVal as variant ) as void

		this.Preciokitpackxparticipante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_talle_hasta( txVal as variant ) as void

		this.F_talle_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usacombinacion( txVal as variant ) as void

		this.Usacombinacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_estacion_desde( txVal as variant ) as void

		this.F_articulo_estacion_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_estacion_hasta( txVal as variant ) as void

		this.F_articulo_estacion_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_usuarioaltafw( txVal as variant ) as void

		this.F_articulo_usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_anio_desde( txVal as variant ) as void

		this.F_articulo_anio_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_usuariomodificacionfw( txVal as variant ) as void

		this.F_articulo_usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_anio_hasta( txVal as variant ) as void

		this.F_articulo_anio_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_timestampalta_desde( txVal as variant ) as void

		this.F_timestampalta_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_timestampalta_hasta( txVal as variant ) as void

		this.F_timestampalta_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_fechaaltafw_desde( txVal as variant ) as void

		this.F_articulo_fechaaltafw_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_fechaaltafw_hasta( txVal as variant ) as void

		this.F_articulo_fechaaltafw_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_comportamiento_desde( txVal as variant ) as void

		this.F_articulo_comportamiento_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_comportamiento_hasta( txVal as variant ) as void

		this.F_articulo_comportamiento_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_preciodirecto_desde( txVal as variant ) as void

		this.F_preciodirecto_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_preciodirecto_hasta( txVal as variant ) as void

		this.F_preciodirecto_hasta = txVal
		dodefault( txVal )

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
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

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
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Anulado( txVal as variant ) as Boolean

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
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaproceso( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechavigencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechabase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Importarsintransaccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_comportamiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_talle_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciokitpackxparticipante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_talle_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usacombinacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_estacion_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_estacion_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_anio_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_anio_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_timestampalta_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_timestampalta_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_fechaaltafw_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_fechaaltafw_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_comportamiento_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_comportamiento_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_preciodirecto_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_preciodirecto_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_desde ) = 'O' or isnull( this.F_articulo_desde ) )
					this.F_articulo_desde = _Screen.zoo.instanciarentidad( 'Articulo' )
					this.F_articulo_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_desde.CODIGO # this.F_articulo_desde_PK
						this.F_articulo_desde.CODIGO = this.F_articulo_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_hasta ) = 'O' or isnull( this.F_articulo_hasta ) )
					this.F_articulo_hasta = _Screen.zoo.instanciarentidad( 'Articulo' )
					this.F_articulo_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_hasta.CODIGO # this.F_articulo_hasta_PK
						this.F_articulo_hasta.CODIGO = this.F_articulo_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_color_desde ) = 'O' or isnull( this.F_color_desde ) )
					this.F_color_desde = _Screen.zoo.instanciarentidad( 'Color' )
					this.F_color_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_color_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_color_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_color_desde.CODIGO # this.F_color_desde_PK
						this.F_color_desde.CODIGO = this.F_color_desde_PK
					endif
				endif
			endif
		endif
		return this.F_color_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_color_hasta ) = 'O' or isnull( this.F_color_hasta ) )
					this.F_color_hasta = _Screen.zoo.instanciarentidad( 'Color' )
					this.F_color_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_color_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_color_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_color_hasta.CODIGO # this.F_color_hasta_PK
						this.F_color_hasta.CODIGO = this.F_color_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_color_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_proveedor_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_proveedor_desde ) = 'O' or isnull( this.F_articulo_proveedor_desde ) )
					this.F_articulo_proveedor_desde = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.F_articulo_proveedor_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_proveedor_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_proveedor_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_proveedor_desde.CODIGO # this.F_articulo_proveedor_desde_PK
						this.F_articulo_proveedor_desde.CODIGO = this.F_articulo_proveedor_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_proveedor_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_proveedor_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_proveedor_hasta ) = 'O' or isnull( this.F_articulo_proveedor_hasta ) )
					this.F_articulo_proveedor_hasta = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.F_articulo_proveedor_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_proveedor_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_proveedor_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_proveedor_hasta.CODIGO # this.F_articulo_proveedor_hasta_PK
						this.F_articulo_proveedor_hasta.CODIGO = this.F_articulo_proveedor_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_proveedor_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_unidad_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_unidad_desde ) = 'O' or isnull( this.F_articulo_unidad_desde ) )
					this.F_articulo_unidad_desde = _Screen.zoo.instanciarentidad( 'Unidaddemedida' )
					this.F_articulo_unidad_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_unidad_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_unidad_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_unidad_desde.CODIGO # this.F_articulo_unidad_desde_PK
						this.F_articulo_unidad_desde.CODIGO = this.F_articulo_unidad_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_unidad_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_unidad_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_unidad_hasta ) = 'O' or isnull( this.F_articulo_unidad_hasta ) )
					this.F_articulo_unidad_hasta = _Screen.zoo.instanciarentidad( 'Unidaddemedida' )
					this.F_articulo_unidad_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_unidad_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_unidad_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_unidad_hasta.CODIGO # this.F_articulo_unidad_hasta_PK
						this.F_articulo_unidad_hasta.CODIGO = this.F_articulo_unidad_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_unidad_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_material_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_material_desde ) = 'O' or isnull( this.F_articulo_material_desde ) )
					this.F_articulo_material_desde = _Screen.zoo.instanciarentidad( 'Material' )
					this.F_articulo_material_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_material_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_material_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_material_desde.CODIGO # this.F_articulo_material_desde_PK
						this.F_articulo_material_desde.CODIGO = this.F_articulo_material_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_material_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_material_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_material_hasta ) = 'O' or isnull( this.F_articulo_material_hasta ) )
					this.F_articulo_material_hasta = _Screen.zoo.instanciarentidad( 'Material' )
					this.F_articulo_material_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_material_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_material_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_material_hasta.CODIGO # this.F_articulo_material_hasta_PK
						this.F_articulo_material_hasta.CODIGO = this.F_articulo_material_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_material_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_clasificacion_desde ) = 'O' or isnull( this.F_articulo_clasificacion_desde ) )
					this.F_articulo_clasificacion_desde = _Screen.zoo.instanciarentidad( 'Clasificacionarticulo' )
					this.F_articulo_clasificacion_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_clasificacion_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_clasificacion_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_clasificacion_desde.CODIGO # this.F_articulo_clasificacion_desde_PK
						this.F_articulo_clasificacion_desde.CODIGO = this.F_articulo_clasificacion_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_clasificacion_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_nomenclador_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_nomenclador_desde ) = 'O' or isnull( this.F_articulo_nomenclador_desde ) )
					this.F_articulo_nomenclador_desde = _Screen.zoo.instanciarentidad( 'Nomencladorarba' )
					this.F_articulo_nomenclador_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_nomenclador_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_nomenclador_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_nomenclador_desde.CODIGO # this.F_articulo_nomenclador_desde_PK
						this.F_articulo_nomenclador_desde.CODIGO = this.F_articulo_nomenclador_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_nomenclador_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_clasificacion_hasta ) = 'O' or isnull( this.F_articulo_clasificacion_hasta ) )
					this.F_articulo_clasificacion_hasta = _Screen.zoo.instanciarentidad( 'Clasificacionarticulo' )
					this.F_articulo_clasificacion_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_clasificacion_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_clasificacion_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_clasificacion_hasta.CODIGO # this.F_articulo_clasificacion_hasta_PK
						this.F_articulo_clasificacion_hasta.CODIGO = this.F_articulo_clasificacion_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_clasificacion_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_nomenclador_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_nomenclador_hasta ) = 'O' or isnull( this.F_articulo_nomenclador_hasta ) )
					this.F_articulo_nomenclador_hasta = _Screen.zoo.instanciarentidad( 'Nomencladorarba' )
					this.F_articulo_nomenclador_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_nomenclador_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_nomenclador_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_nomenclador_hasta.CODIGO # this.F_articulo_nomenclador_hasta_PK
						this.F_articulo_nomenclador_hasta.CODIGO = this.F_articulo_nomenclador_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_nomenclador_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_marca_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_marca_desde ) = 'O' or isnull( this.F_articulo_marca_desde ) )
					this.F_articulo_marca_desde = _Screen.zoo.instanciarentidad( 'Marca' )
					this.F_articulo_marca_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_marca_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_marca_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_marca_desde.CODIGO # this.F_articulo_marca_desde_PK
						this.F_articulo_marca_desde.CODIGO = this.F_articulo_marca_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_marca_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_marca_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_marca_hasta ) = 'O' or isnull( this.F_articulo_marca_hasta ) )
					this.F_articulo_marca_hasta = _Screen.zoo.instanciarentidad( 'Marca' )
					this.F_articulo_marca_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_marca_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_marca_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_marca_hasta.CODIGO # this.F_articulo_marca_hasta_PK
						this.F_articulo_marca_hasta.CODIGO = this.F_articulo_marca_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_marca_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.ObtenerNombre() + " - " + transform( This.Codigo, "@LZ 99999999" ) ) )
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

				.Fechaimpo = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				if .EsNuevo() and !.VerificarContexto( 'CB' )
					.CODIGO = .oNumeraciones.ObtenerNumero('CODIGO')
				else
					.CODIGO = iif( vartype( this.CODIGO ) = 'C', '', 0 )
				endif
				.Timestamp = 0
				.Anulado = .F.
				.Seriealtafw = []
				.Versionaltafw = []
				.Usuarioaltafw = []
				.Versionmodificacionfw = []
				.Horaaltafw = []
				.Descripcionfw = []
				.Zadsfw = []
				.Basededatosmodificacionfw = []
				.Estadotransferencia = []
				.Basededatosaltafw = []
				.Horaexpo = []
				.Usuariomodificacionfw = []
				.Horaimpo = []
				.Seriemodificacionfw = []
				.Horamodificacionfw = []
				.Descripcion = []
				.Fecha = ctod( '  /  /    ' )
				.Fechaproceso = ctod( '  /  /    ' )
				.Fechavigencia = ctod( '  /  /    ' )
				.Fechabase = ctod( '  /  /    ' )
				.F_articulo_desde_PK = []
				.Importarsintransaccion = .F.
				.F_articulo_hasta_PK = []
				.F_color_desde_PK = []
				.F_color_hasta_PK = []
				.Articulo_comportamiento = []
				.F_talle_desde = []
				.Preciokitpackxparticipante = .F.
				.F_talle_hasta = []
				.F_articulo_proveedor_desde_PK = []
				.Usacombinacion = .F.
				.F_articulo_proveedor_hasta_PK = []
				.F_articulo_unidad_desde_PK = []
				.F_articulo_unidad_hasta_PK = []
				.F_articulo_material_desde_PK = []
				.F_articulo_material_hasta_PK = []
				.F_articulo_estacion_desde = 0
				.F_articulo_estacion_hasta = 0
				.F_articulo_usuarioaltafw = []
				.Modprecios.Limpiar()
				.F_articulo_anio_desde = []
				.F_articulo_usuariomodificacionfw = []
				.Observacion = []
				.F_articulo_anio_hasta = []
				.F_articulo_clasificacion_desde_PK = []
				.F_articulo_nomenclador_desde_PK = []
				.F_articulo_clasificacion_hasta_PK = []
				.F_articulo_nomenclador_hasta_PK = []
				.F_timestampalta_desde = 0
				.F_timestampalta_hasta = 0
				.F_articulo_fechaaltafw_desde = ctod( '  /  /    ' )
				.F_articulo_fechaaltafw_hasta = ctod( '  /  /    ' )
				.F_articulo_comportamiento_desde = 0
				.F_articulo_comportamiento_hasta = 0
				.F_preciodirecto_desde = 0
				.F_preciodirecto_hasta = 0
				.F_articulo_marca_desde_PK = []
				.F_articulo_marca_hasta_PK = []
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
	Function ValorSugeridoDescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Descripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Descripcion' )
						.Descripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
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
	Function ValorSugeridoFecha() as void
		with this
			.ValorSugeridoFWFecha()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechavigencia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Fechavigencia" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechavigencia' )
						.Fechavigencia = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vigencia desde para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechavigencia()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechavigencia() as void
		with this
			.Fechavigencia = goServicios.librerias.ObtenerFecha() +1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechabase() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Fechabase" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechabase' )
						.Fechabase = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha base de precios para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechabase()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechabase() as void
		with this
			.Fechabase = goServicios.librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_desde_PK' )
						.F_articulo_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_desde.CODIGO = .F_articulo_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImportarsintransaccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Importarsintransaccion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Importarsintransaccion' )
						.Importarsintransaccion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Procesar modo rápido para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWImportarsintransaccion()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWImportarsintransaccion() as void
		with this
			.Importarsintransaccion = .T.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_hasta_PK' )
						.F_articulo_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_hasta.CODIGO = .F_articulo_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_hasta()
				endif
			Catch to loError
				.F_articulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_hasta() as void
		with this
			try
				.F_articulo_hasta_PK = 'ZZZZZZZZZZZZZ'
			Catch to loError
				.F_articulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_color_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_color_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_color_desde_PK' )
						.F_color_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_color_desde.CODIGO = .F_color_desde_PK
					endif
				endif
			Catch to loError
				.F_color_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_color_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_color_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_color_hasta_PK' )
						.F_color_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_color_hasta.CODIGO = .F_color_hasta_PK
					endif
				else
					.ValorSugeridoFWF_color_hasta()
				endif
			Catch to loError
				.F_color_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_color_hasta() as void
		with this
			try
				.F_color_hasta_PK = 'ZZ'
			Catch to loError
				.F_color_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoArticulo_comportamiento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Articulo_comportamiento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Articulo_comportamiento' )
						.Articulo_comportamiento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Comportamiento para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_talle_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_talle_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_talle_desde' )
						.F_talle_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPreciokitpackxparticipante() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Preciokitpackxparticipante" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Preciokitpackxparticipante' )
						.Preciokitpackxparticipante = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cálculo de precio de kit / pack en base a sus participantes para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWPreciokitpackxparticipante()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWPreciokitpackxparticipante() as void
		with this
			.Preciokitpackxparticipante = .F.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_talle_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_talle_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_talle_hasta' )
						.F_talle_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_talle_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_talle_hasta() as void
		with this
			.F_talle_hasta = 'ZZZ'
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_proveedor_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_proveedor_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_proveedor_desde_PK' )
						.F_articulo_proveedor_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_proveedor_desde.CODIGO = .F_articulo_proveedor_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_proveedor_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoUsacombinacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Usacombinacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Usacombinacion' )
						.Usacombinacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Maneja precio por combinación para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWUsacombinacion()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWUsacombinacion() as void
		with this
			.Usacombinacion = .F.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_proveedor_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_proveedor_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_proveedor_hasta_PK' )
						.F_articulo_proveedor_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_proveedor_hasta.CODIGO = .F_articulo_proveedor_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_proveedor_hasta()
				endif
			Catch to loError
				.F_articulo_proveedor_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_proveedor_hasta() as void
		with this
			try
				.F_articulo_proveedor_hasta_PK = 'ZZZZZ'
			Catch to loError
				.F_articulo_proveedor_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_unidad_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_unidad_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_unidad_desde_PK' )
						.F_articulo_unidad_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_unidad_desde.CODIGO = .F_articulo_unidad_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_unidad_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Unidad para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_unidad_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_unidad_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_unidad_hasta_PK' )
						.F_articulo_unidad_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_unidad_hasta.CODIGO = .F_articulo_unidad_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_unidad_hasta()
				endif
			Catch to loError
				.F_articulo_unidad_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Unidad para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_unidad_hasta() as void
		with this
			try
				.F_articulo_unidad_hasta_PK = 'ZZZ'
			Catch to loError
				.F_articulo_unidad_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_material_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_material_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_material_desde_PK' )
						.F_articulo_material_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_material_desde.CODIGO = .F_articulo_material_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_material_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Material para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_material_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_material_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_material_hasta_PK' )
						.F_articulo_material_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_material_hasta.CODIGO = .F_articulo_material_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_material_hasta()
				endif
			Catch to loError
				.F_articulo_material_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Material para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_material_hasta() as void
		with this
			try
				.F_articulo_material_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_material_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_estacion_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_estacion_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_estacion_desde' )
						.F_articulo_estacion_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Estación para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_articulo_estacion_desde()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_estacion_desde() as void
		with this
			.F_articulo_estacion_desde = 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_estacion_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_estacion_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_estacion_hasta' )
						.F_articulo_estacion_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Estación para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_articulo_estacion_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_estacion_hasta() as void
		with this
			.F_articulo_estacion_hasta = 4
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_usuarioaltafw() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_usuarioaltafw" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_usuarioaltafw' )
						.F_articulo_usuarioaltafw = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Usuario que dio de alta para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_anio_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_anio_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_anio_desde' )
						.F_articulo_anio_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Año para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_usuariomodificacionfw() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_usuariomodificacionfw" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_usuariomodificacionfw' )
						.F_articulo_usuariomodificacionfw = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Ultimo usuario que modifico para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObservacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "Observacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Observacion' )
						.Observacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_anio_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_anio_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_anio_hasta' )
						.F_articulo_anio_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Año para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_articulo_anio_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_anio_hasta() as void
		with this
			.F_articulo_anio_hasta = '99'
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_clasificacion_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_clasificacion_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_clasificacion_desde_PK' )
						.F_articulo_clasificacion_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_clasificacion_desde.CODIGO = .F_articulo_clasificacion_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_clasificacion_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_nomenclador_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_nomenclador_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_nomenclador_desde_PK' )
						.F_articulo_nomenclador_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_nomenclador_desde.CODIGO = .F_articulo_nomenclador_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_nomenclador_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código del nomenclador ARBA para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_clasificacion_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_clasificacion_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_clasificacion_hasta_PK' )
						.F_articulo_clasificacion_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_clasificacion_hasta.CODIGO = .F_articulo_clasificacion_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_clasificacion_hasta()
				endif
			Catch to loError
				.F_articulo_clasificacion_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_clasificacion_hasta() as void
		with this
			try
				.F_articulo_clasificacion_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_clasificacion_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_nomenclador_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_nomenclador_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_nomenclador_hasta_PK' )
						.F_articulo_nomenclador_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_nomenclador_hasta.CODIGO = .F_articulo_nomenclador_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_nomenclador_hasta()
				endif
			Catch to loError
				.F_articulo_nomenclador_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Código del nomenclador ARBA para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_nomenclador_hasta() as void
		with this
			try
				.F_articulo_nomenclador_hasta_PK = 'ZZZZZZ'
			Catch to loError
				.F_articulo_nomenclador_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_timestampalta_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_timestampalta_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_timestampalta_desde' )
						.F_timestampalta_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Timestamp alta para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_timestampalta_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_timestampalta_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_timestampalta_hasta' )
						.F_timestampalta_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Timestamp alta para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_timestampalta_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_timestampalta_hasta() as void
		with this
			.F_timestampalta_hasta = 99999999999999
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_fechaaltafw_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_fechaaltafw_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_fechaaltafw_desde' )
						.F_articulo_fechaaltafw_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de Alta para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_fechaaltafw_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_fechaaltafw_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_fechaaltafw_hasta' )
						.F_articulo_fechaaltafw_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de Alta para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_articulo_fechaaltafw_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_fechaaltafw_hasta() as void
		with this
			.F_articulo_fechaaltafw_hasta = goServicios.Librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_comportamiento_desde() as void
		with this
			.F_articulo_comportamiento_desde = 0
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_comportamiento_desde() as void
		with this
			.ValorSugeridoFWF_articulo_comportamiento_desde()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_comportamiento_hasta() as void
		with this
			.F_articulo_comportamiento_hasta = 9
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_comportamiento_hasta() as void
		with this
			.ValorSugeridoFWF_articulo_comportamiento_hasta()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_preciodirecto_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_preciodirecto_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_preciodirecto_desde' )
						.F_preciodirecto_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Precio para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_preciodirecto_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_preciodirecto_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_preciodirecto_hasta' )
						.F_preciodirecto_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Precio para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_preciodirecto_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_preciodirecto_hasta() as void
		with this
			.F_preciodirecto_hasta = 999999999999.99
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_marca_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_marca_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_marca_desde_PK' )
						.F_articulo_marca_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_marca_desde.CODIGO = .F_articulo_marca_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_marca_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Marca para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_marca_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CALCULODEPRECIOS", "", "F_articulo_marca_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_marca_hasta_PK' )
						.F_articulo_marca_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_marca_hasta.CODIGO = .F_articulo_marca_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_marca_hasta()
				endif
			Catch to loError
				.F_articulo_marca_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Marca para la entidad Modificación masiva de precios." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_marca_hasta() as void
		with this
			try
				.F_articulo_marca_hasta_PK = Replicate( "Z",30)
			Catch to loError
				.F_articulo_marca_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_comportamiento_DespuesDeAsignar() as void
		This.SetearFiltrosComportamiento()                                                                  
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
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_CALCULODEPRECIOS' )
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