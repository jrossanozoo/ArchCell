
define class Din_EntidadNUEVOENBASEA as ent_virtual of ent_virtual.prg

	cNombre = 'NUEVOENBASEA'
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	Entidad = []
	Filtro = []
	Observacion = []
	HORAIMPO = []
	HORAEXPO = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSMODIFICACIONFW = []
	BASEDEDATOSALTAFW = []
	HORAALTAFW = []
	HORAMODIFICACIONFW = []
	VERSIONALTAFW = []
	SERIEALTAFW = []
	ZADSFW = []
	USUARIOMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	USUARIOALTAFW = []
	SERIEMODIFICACIONFW = []
	Descripcion = []
	cAtributoPK = 'Codigo'
	Codigo = []
	Operatoria = 0
	TipoComprobante = 0
	DetalleComprobantes = null
	cliente_Desde_PK = []
	cliente_Desde = null
	lHabilitarcliente_Desde_PK = .T.
	BolsasyCajas_PK = []
	BolsasyCajas = null
	lHabilitarBolsasyCajas_PK = .T.
	cliente_Hasta_PK = []
	cliente_Hasta = null
	lHabilitarcliente_Hasta_PK = .T.
	numero_desde = 0
	lHabilitarnumero_desde = .T.
	numero_Hasta = 0
	lHabilitarnumero_Hasta = .T.
	fecha_Desde = ctod( '  /  /    ' )
	fecha_hasta = ctod( '  /  /    ' )
	fechafactura_Desde = ctod( '  /  /    ' )
	fechafactura_Hasta = ctod( '  /  /    ' )
	proveedor_Desde_PK = []
	proveedor_Desde = null
	lHabilitarproveedor_Desde_PK = .T.
	MercaderiaConsignacion = .F.
	lHabilitarMercaderiaConsignacion = .T.
	proveedor_Hasta_PK = []
	proveedor_Hasta = null
	lHabilitarproveedor_Hasta_PK = .T.
	vendedor_desde_PK = []
	vendedor_desde = null
	lHabilitarvendedor_desde_PK = .T.
	vendedor_hasta_PK = []
	vendedor_hasta = null
	lHabilitarvendedor_hasta_PK = .T.
	monedaComprobante_desde_PK = []
	monedaComprobante_desde = null
	lHabilitarmonedaComprobante_desde_PK = .T.
	monedaComprobante_hasta_PK = []
	monedaComprobante_hasta = null
	lHabilitarmonedaComprobante_hasta_PK = .T.
	ClienteConsignacion_PK = []
	ClienteConsignacion = null
	lHabilitarClienteConsignacion_PK = .T.
	f_Articulo_Desde_PK = []
	f_Articulo_Desde = null
	f_Articulo_Hasta_PK = []
	f_Articulo_Hasta = null
	f_Color_Desde_PK = []
	f_Color_Desde = null
	f_Color_Hasta_PK = []
	f_Color_Hasta = null
	f_Talle_Desde_PK = []
	f_Talle_Desde = null
	f_Talle_Hasta_PK = []
	f_Talle_Hasta = null
	BDConsignacion = []
	lHabilitarBDConsignacion = .T.
	f_Articulo_Proveedor_Desde_PK = []
	f_Articulo_Proveedor_Desde = null
	f_Articulo_Proveedor_Hasta_PK = []
	f_Articulo_Proveedor_Hasta = null
	f_Articulo_Temporada_Desde_PK = []
	f_Articulo_Temporada_Desde = null
	f_Articulo_Temporada_Hasta_PK = []
	f_Articulo_Temporada_Hasta = null
	f_Articulo_Ano_Desde = 0
	f_Articulo_Ano_Hasta = 0
	f_Articulo_Familia_Desde_PK = []
	f_Articulo_Familia_Desde = null
	f_Articulo_Familia_Hasta_PK = []
	f_Articulo_Familia_Hasta = null
	f_Articulo_Material_Desde_PK = []
	f_Articulo_Material_Desde = null
	f_Articulo_Material_Hasta_PK = []
	f_Articulo_Material_Hasta = null
	fecha_Consignacion_Desde = ctod( '  /  /    ' )
	lHabilitarfecha_Consignacion_Desde = .T.
	f_Articulo_Linea_Desde_PK = []
	f_Articulo_Linea_Desde = null
	f_Articulo_Linea_Hasta_PK = []
	f_Articulo_Linea_Hasta = null
	f_Articulo_Grupo_Desde_PK = []
	f_Articulo_Grupo_Desde = null
	f_Articulo_Grupo_Hasta_PK = []
	f_Articulo_Grupo_Hasta = null
	f_Articulo_CategoriaDeArticulo_Desde_PK = []
	f_Articulo_CategoriaDeArticulo_Desde = null
	f_Articulo_CategoriaDeArticulo_Hasta_PK = []
	f_Articulo_CategoriaDeArticulo_Hasta = null
	f_Articulo_Clasificacion_Desde_PK = []
	f_Articulo_Clasificacion_Desde = null
	f_Articulo_Clasificacion_Hasta_PK = []
	f_Articulo_Clasificacion_Hasta = null
	f_Articulo_TipoDeArticulo_Desde_PK = []
	f_Articulo_TipoDeArticulo_Desde = null
	f_Articulo_TipoDeArticulo_Hasta_PK = []
	f_Articulo_TipoDeArticulo_Hasta = null
	fecha_Consignacion_Hasta = ctod( '  /  /    ' )
	lHabilitarfecha_Consignacion_Hasta = .T.
	f_Articulo_PaletaDeColores_Desde_PK = []
	f_Articulo_PaletaDeColores_Desde = null
	f_Articulo_PaletaDeColores_Hasta_PK = []
	f_Articulo_PaletaDeColores_Hasta = null
	f_Articulo_CurvaDeTalles_Desde_PK = []
	f_Articulo_CurvaDeTalles_Desde = null
	f_Articulo_CurvaDeTalles_Hasta_PK = []
	f_Articulo_CurvaDeTalles_Hasta = null
	Diferencia = []
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Nuevo en base a]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_HASTA_PK'
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarcliente_Desde_PK = .T.
		this.lHabilitarBolsasyCajas_PK = .T.
		this.lHabilitarcliente_Hasta_PK = .T.
		this.lHabilitarnumero_desde = .T.
		this.lHabilitarnumero_Hasta = .T.
		this.lHabilitarproveedor_Desde_PK = .T.
		this.lHabilitarMercaderiaConsignacion = .T.
		this.lHabilitarproveedor_Hasta_PK = .T.
		this.lHabilitarvendedor_desde_PK = .T.
		this.lHabilitarvendedor_hasta_PK = .T.
		this.lHabilitarmonedaComprobante_desde_PK = .T.
		this.lHabilitarmonedaComprobante_hasta_PK = .T.
		this.lHabilitarClienteConsignacion_PK = .T.
		this.lHabilitarBDConsignacion = .T.
		this.lHabilitarfecha_Consignacion_Desde = .T.
		this.lHabilitarfecha_Consignacion_Hasta = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadNUEVOENBASEAAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Detallecomprobantes_Access() as variant
		if !this.ldestroy and ( !vartype( this.Detallecomprobantes ) = 'O' or isnull( this.Detallecomprobantes ) )
			this.Detallecomprobantes = this.crearobjeto( 'Din_DetalleNuevoenbaseaDetallecomprobantes' )
			this.Detallecomprobantes.inicializar()
			this.enlazar( 'Detallecomprobantes.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Detallecomprobantes.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Detallecomprobantes, 'CambioSumarizado', this, 'CambiosDetalleDetallecomprobantes', 1) 
			this.enlazar( 'Detallecomprobantes.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Detallecomprobantes.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Detallecomprobantes
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.DetalleComprobantes.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.DetalleComprobantes.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleDetallecomprobantes() as void
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
		 
		if ( vartype( this.Entidad) = 'C' )
			if len( alltrim( this.ENTIDAD ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo ENTIDAD es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ENTIDAD no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Filtro) = 'C' )
			if len( alltrim( this.FILTRO ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo FILTRO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FILTRO no es el correcto.')
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
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.SERIEALTAFW) = 'C' )
			if len( alltrim( this.SERIEALTAFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.Operatoria) = 'N' )
			lnLargoEntero  = len( transform( int( this.OPERATORIA ) ) ) 
			lnValorDelDecimal = this.OPERATORIA - int( this.OPERATORIA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo OPERATORIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OPERATORIA no es el correcto.')
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
		 
		if ( vartype( this.numero_desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO_DESDE ) ) ) 
			lnValorDelDecimal = this.NUMERO_DESDE - int( this.NUMERO_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.numero_Hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO_HASTA ) ) ) 
			lnValorDelDecimal = this.NUMERO_HASTA - int( this.NUMERO_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fecha_Desde) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fecha_hasta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fechafactura_Desde) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAFACTURA_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fechafactura_Hasta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAFACTURA_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.MercaderiaConsignacion) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MERCADERIACONSIGNACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BDConsignacion) = 'C' )
			if len( alltrim( this.BDCONSIGNACION ) ) > 11
				This.AgregarInformacion( 'La longitud del valor del atributo BDCONSIGNACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BDCONSIGNACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Ano_Desde) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_ANO_DESDE ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_ANO_DESDE - int( this.F_ARTICULO_ANO_DESDE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_ANO_DESDE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ANO_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.f_Articulo_Ano_Hasta) = 'N' )
			lnLargoEntero  = len( transform( int( this.F_ARTICULO_ANO_HASTA ) ) ) 
			lnValorDelDecimal = this.F_ARTICULO_ANO_HASTA - int( this.F_ARTICULO_ANO_HASTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo F_ARTICULO_ANO_HASTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo F_ARTICULO_ANO_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fecha_Consignacion_Desde) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA_CONSIGNACION_DESDE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.fecha_Consignacion_Hasta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHA_CONSIGNACION_HASTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Diferencia) = 'C' )
			if len( alltrim( this.DIFERENCIA ) ) > 40
				This.AgregarInformacion( 'La longitud del valor del atributo DIFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DIFERENCIA no es el correcto.')
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
			llRetorno = .ValidarBolsasycajas() and llRetorno
			llRetorno = .ValidarClienteconsignacion() and llRetorno
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

	*--------------------------------------------------------------------------------------------------------
	function ValidacionDetalles() as Boolean
		local llRetorno as boolean, llValAux as boolean
		llRetorno = dodefault()
		llRetorno = This.ValidarUnDetalle( this.DetalleComprobantes, 'Comprobantes' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarcliente_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.cliente_Desde_PK )
		else
			If this.cliente_Desde.oAD.ConsultarPorClavePrimaria()
				This.cliente_Desde.oDesactivador.ValidarEstadoActivacion( this.cliente_Desde_PK , goLibrerias.Valorvacioseguntipo( vartype(this.cliente_Desde_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.cliente_Desde_PK ))+ ' de la entidad ' +  upper( this.cliente_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarBolsasyCajas() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.BolsasyCajas_PK )
		else
			If this.BolsasyCajas.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.BolsasyCajas_PK ))+ ' de la entidad ' +  upper( this.BolsasyCajas.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarcliente_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.cliente_Hasta_PK )
		else
			If this.cliente_Hasta.oAD.ConsultarPorClavePrimaria()
				This.cliente_Hasta.oDesactivador.ValidarEstadoActivacion( this.cliente_Hasta_PK , goLibrerias.Valorvacioseguntipo( vartype(this.cliente_Hasta_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.cliente_Hasta_PK ))+ ' de la entidad ' +  upper( this.cliente_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarproveedor_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.proveedor_Desde_PK )
		else
			If this.proveedor_Desde.oAD.ConsultarPorClavePrimaria()
				This.proveedor_Desde.oDesactivador.ValidarEstadoActivacion( this.proveedor_Desde_PK , goLibrerias.Valorvacioseguntipo( vartype(this.proveedor_Desde_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.proveedor_Desde_PK ))+ ' de la entidad ' +  upper( this.proveedor_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarproveedor_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.proveedor_Hasta_PK )
		else
			If this.proveedor_Hasta.oAD.ConsultarPorClavePrimaria()
				This.proveedor_Hasta.oDesactivador.ValidarEstadoActivacion( this.proveedor_Hasta_PK , goLibrerias.Valorvacioseguntipo( vartype(this.proveedor_Hasta_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.proveedor_Hasta_PK ))+ ' de la entidad ' +  upper( this.proveedor_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarvendedor_desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.vendedor_desde_PK )
		else
			If this.vendedor_desde.oAD.ConsultarPorClavePrimaria()
				This.vendedor_desde.oDesactivador.ValidarEstadoActivacion( this.vendedor_desde_PK , goLibrerias.Valorvacioseguntipo( vartype(this.vendedor_desde_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.vendedor_desde_PK ))+ ' de la entidad ' +  upper( this.vendedor_desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarvendedor_hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.vendedor_hasta_PK )
		else
			If this.vendedor_hasta.oAD.ConsultarPorClavePrimaria()
				This.vendedor_hasta.oDesactivador.ValidarEstadoActivacion( this.vendedor_hasta_PK , goLibrerias.Valorvacioseguntipo( vartype(this.vendedor_hasta_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.vendedor_hasta_PK ))+ ' de la entidad ' +  upper( this.vendedor_hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarmonedaComprobante_desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.monedaComprobante_desde_PK )
		else
			If this.monedaComprobante_desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.monedaComprobante_desde_PK ))+ ' de la entidad ' +  upper( this.monedaComprobante_desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarmonedaComprobante_hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.monedaComprobante_hasta_PK )
		else
			If this.monedaComprobante_hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.monedaComprobante_hasta_PK ))+ ' de la entidad ' +  upper( this.monedaComprobante_hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarClienteConsignacion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.ClienteConsignacion_PK )
			this.AgregarInformacion( 'Debe cargar el campo Cliente consignación', 9005, 'ClienteConsignacion' )
			llRetorno = .F.
		else
			If this.ClienteConsignacion.oAD.ConsultarPorClavePrimaria()
				This.ClienteConsignacion.oDesactivador.ValidarEstadoActivacion( this.ClienteConsignacion_PK , goLibrerias.Valorvacioseguntipo( vartype(this.ClienteConsignacion_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.ClienteConsignacion_PK ))+ ' de la entidad ' +  upper( this.ClienteConsignacion.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
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
	function Validarf_Talle_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Talle_Desde_PK )
		else
			If this.f_Talle_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Talle_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Talle_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Talle_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Talle_Hasta_PK )
		else
			If this.f_Talle_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Talle_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Talle_Hasta.cDescripcion ) + ' no existe.')
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
				This.f_Articulo_Proveedor_Desde.oDesactivador.ValidarEstadoActivacion( this.f_Articulo_Proveedor_Desde_PK , goLibrerias.Valorvacioseguntipo( vartype(this.f_Articulo_Proveedor_Desde_PK ) ), this.lnuevo, this.ledicion )
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
				This.f_Articulo_Proveedor_Hasta.oDesactivador.ValidarEstadoActivacion( this.f_Articulo_Proveedor_Hasta_PK , goLibrerias.Valorvacioseguntipo( vartype(this.f_Articulo_Proveedor_Hasta_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Proveedor_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Proveedor_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Temporada_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Temporada_Desde_PK )
		else
			If this.f_Articulo_Temporada_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Temporada_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Temporada_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Temporada_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Temporada_Hasta_PK )
		else
			If this.f_Articulo_Temporada_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Temporada_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Temporada_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Familia_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Familia_Desde_PK )
		else
			If this.f_Articulo_Familia_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Familia_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Familia_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Familia_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Familia_Hasta_PK )
		else
			If this.f_Articulo_Familia_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Familia_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Familia_Hasta.cDescripcion ) + ' no existe.')
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
	function Validarf_Articulo_Linea_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Linea_Desde_PK )
		else
			If this.f_Articulo_Linea_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Linea_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Linea_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Linea_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Linea_Hasta_PK )
		else
			If this.f_Articulo_Linea_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Linea_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Linea_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Grupo_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Grupo_Desde_PK )
		else
			If this.f_Articulo_Grupo_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Grupo_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Grupo_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Grupo_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Grupo_Hasta_PK )
		else
			If this.f_Articulo_Grupo_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Grupo_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Grupo_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_CategoriaDeArticulo_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_CategoriaDeArticulo_Desde_PK )
		else
			If this.f_Articulo_CategoriaDeArticulo_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_CategoriaDeArticulo_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_CategoriaDeArticulo_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_CategoriaDeArticulo_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_CategoriaDeArticulo_Hasta_PK )
		else
			If this.f_Articulo_CategoriaDeArticulo_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_CategoriaDeArticulo_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_CategoriaDeArticulo_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Clasificacion_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Clasificacion_Desde_PK )
		else
			If this.f_Articulo_Clasificacion_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Clasificacion_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Clasificacion_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_Clasificacion_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_Clasificacion_Hasta_PK )
		else
			If this.f_Articulo_Clasificacion_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_Clasificacion_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_Clasificacion_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_TipoDeArticulo_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_TipoDeArticulo_Desde_PK )
		else
			If this.f_Articulo_TipoDeArticulo_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_TipoDeArticulo_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_TipoDeArticulo_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_TipoDeArticulo_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_TipoDeArticulo_Hasta_PK )
		else
			If this.f_Articulo_TipoDeArticulo_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_TipoDeArticulo_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_TipoDeArticulo_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_PaletaDeColores_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_PaletaDeColores_Desde_PK )
		else
			If this.f_Articulo_PaletaDeColores_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_PaletaDeColores_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_PaletaDeColores_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_PaletaDeColores_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_PaletaDeColores_Hasta_PK )
		else
			If this.f_Articulo_PaletaDeColores_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_PaletaDeColores_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_PaletaDeColores_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_CurvaDeTalles_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_CurvaDeTalles_Desde_PK )
		else
			If this.f_Articulo_CurvaDeTalles_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_CurvaDeTalles_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_CurvaDeTalles_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Articulo_CurvaDeTalles_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Articulo_CurvaDeTalles_Hasta_PK )
		else
			If this.f_Articulo_CurvaDeTalles_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Articulo_CurvaDeTalles_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Articulo_CurvaDeTalles_Hasta.cDescripcion ) + ' no existe.')
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
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'CLIENTECONSIGNACION' )
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
		return '<SINTOOLBAR><NOIMPO><NOEXPO><NOLISTAGENERICO>'
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWMercaderiaconsignacion()','Mercaderiaconsignacion')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWMonedacomprobante_hasta()','Monedacomprobante_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_hasta()','F_articulo_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_color_hasta()','F_color_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_talle_hasta()','F_talle_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_proveedor_hasta()','F_articulo_proveedor_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_temporada_hasta()','F_articulo_temporada_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_ano_hasta()','F_articulo_ano_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_familia_hasta()','F_articulo_familia_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_material_hasta()','F_articulo_material_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_linea_hasta()','F_articulo_linea_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_grupo_hasta()','F_articulo_grupo_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_categoriadearticulo_hasta()','F_articulo_categoriadearticulo_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_clasificacion_hasta()','F_articulo_clasificacion_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_tipodearticulo_hasta()','F_articulo_tipodearticulo_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_paletadecolores_hasta()','F_articulo_paletadecolores_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_articulo_curvadetalles_hasta()','F_articulo_curvadetalles_hasta')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'NUEVOENBASEA', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Cliente_desde_PK = lxVal

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
			if ( this.lHabilitarBolsasycajas_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Bolsasycajas( lxVal )
			else
				this.Bolsasycajas_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Bolsasycajas)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Cliente_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedor_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Proveedor_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Proveedor_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Proveedor_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedor_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Proveedor_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Proveedor_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Proveedor_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Vendedor_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Vendedor_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Vendedor_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Vendedor_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Vendedor_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Vendedor_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monedacomprobante_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Monedacomprobante_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monedacomprobante_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Monedacomprobante_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clienteconsignacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clienteconsignacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Clienteconsignacion.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Clienteconsignacion )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Clienteconsignacion_PK = lxVal

		if this.Validar_Clienteconsignacion( lxVal, lxValOld )
			if ( this.lHabilitarClienteconsignacion_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Clienteconsignacion( lxVal )
			else
				this.Clienteconsignacion_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Clienteconsignacion)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.F_articulo_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.F_articulo_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_color_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_color_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_color_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.F_color_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_color_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_color_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_color_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_color_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.F_color_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_talle_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_talle_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_talle_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_talle_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_talle_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_talle_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_talle_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_talle_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_talle_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_talle_hasta_PK = lxVal

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
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
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
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_proveedor_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_temporada_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_temporada_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_temporada_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_temporada_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_articulo_temporada_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_temporada_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_temporada_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_temporada_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_temporada_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_articulo_temporada_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_familia_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_familia_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_familia_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_familia_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_familia_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_familia_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_familia_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_familia_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_familia_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_familia_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_material_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_material_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_material_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_material_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
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
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_material_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_material_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_material_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_linea_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_linea_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_linea_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_linea_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_linea_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_linea_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_linea_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_linea_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_linea_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_linea_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_grupo_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_grupo_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_grupo_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_grupo_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_grupo_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_grupo_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_grupo_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_grupo_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_grupo_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_grupo_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_categoriadearticulo_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_categoriadearticulo_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_categoriadearticulo_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_categoriadearticulo_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_categoriadearticulo_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_categoriadearticulo_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_categoriadearticulo_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_categoriadearticulo_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_categoriadearticulo_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_categoriadearticulo_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_clasificacion_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_clasificacion_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_clasificacion_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_clasificacion_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_clasificacion_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_clasificacion_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_clasificacion_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_clasificacion_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_clasificacion_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_tipodearticulo_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_tipodearticulo_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_tipodearticulo_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_tipodearticulo_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_tipodearticulo_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_tipodearticulo_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_tipodearticulo_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_articulo_tipodearticulo_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_articulo_tipodearticulo_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_tipodearticulo_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_paletadecolores_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_paletadecolores_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_paletadecolores_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_paletadecolores_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_paletadecolores_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_paletadecolores_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_curvadetalles_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_curvadetalles_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_curvadetalles_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_curvadetalles_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_curvadetalles_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_articulo_curvadetalles_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente_desde( txVal as variant ) as void

		this.Cliente_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bolsasycajas( txVal as variant ) as void

		this.Bolsasycajas.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente_hasta( txVal as variant ) as void

		this.Cliente_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proveedor_desde( txVal as variant ) as void

		this.Proveedor_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proveedor_hasta( txVal as variant ) as void

		this.Proveedor_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor_desde( txVal as variant ) as void

		this.Vendedor_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor_hasta( txVal as variant ) as void

		this.Vendedor_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedacomprobante_desde( txVal as variant ) as void

		this.Monedacomprobante_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monedacomprobante_hasta( txVal as variant ) as void

		this.Monedacomprobante_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clienteconsignacion( txVal as variant ) as void

		this.Clienteconsignacion.CODIGO = txVal
		dodefault( txVal )

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
	function Setear_F_talle_desde( txVal as variant ) as void

		this.F_talle_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_talle_hasta( txVal as variant ) as void

		this.F_talle_hasta.CODIGO = txVal
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
	function Setear_F_articulo_temporada_desde( txVal as variant ) as void

		this.F_articulo_temporada_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_temporada_hasta( txVal as variant ) as void

		this.F_articulo_temporada_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_familia_desde( txVal as variant ) as void

		this.F_articulo_familia_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_familia_hasta( txVal as variant ) as void

		this.F_articulo_familia_hasta.CODIGO = txVal
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
	function Setear_F_articulo_linea_desde( txVal as variant ) as void

		this.F_articulo_linea_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_linea_hasta( txVal as variant ) as void

		this.F_articulo_linea_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_grupo_desde( txVal as variant ) as void

		this.F_articulo_grupo_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_grupo_hasta( txVal as variant ) as void

		this.F_articulo_grupo_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_categoriadearticulo_desde( txVal as variant ) as void

		this.F_articulo_categoriadearticulo_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_categoriadearticulo_hasta( txVal as variant ) as void

		this.F_articulo_categoriadearticulo_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_clasificacion_desde( txVal as variant ) as void

		this.F_articulo_clasificacion_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_clasificacion_hasta( txVal as variant ) as void

		this.F_articulo_clasificacion_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_tipodearticulo_desde( txVal as variant ) as void

		this.F_articulo_tipodearticulo_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_tipodearticulo_hasta( txVal as variant ) as void

		this.F_articulo_tipodearticulo_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_paletadecolores_desde( txVal as variant ) as void

		this.F_articulo_paletadecolores_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_paletadecolores_hasta( txVal as variant ) as void

		this.F_articulo_paletadecolores_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_curvadetalles_desde( txVal as variant ) as void

		this.F_articulo_curvadetalles_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_curvadetalles_hasta( txVal as variant ) as void

		this.F_articulo_curvadetalles_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente_desde.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bolsasycajas( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente_hasta.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedor_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Proveedor_desde.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedor_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Proveedor_hasta.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Vendedor_desde.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Vendedor_hasta.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedacomprobante_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monedacomprobante_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clienteconsignacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Clienteconsignacion.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

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
	function Validar_F_talle_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_talle_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_proveedor_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.F_articulo_proveedor_desde.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_proveedor_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.F_articulo_proveedor_hasta.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_temporada_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_temporada_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_familia_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_familia_hasta( txVal as variant, txValOld as variant ) as Boolean

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
	function Validar_F_articulo_linea_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_linea_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_grupo_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_grupo_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_categoriadearticulo_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_categoriadearticulo_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_clasificacion_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_clasificacion_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_tipodearticulo_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_tipodearticulo_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_paletadecolores_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_paletadecolores_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_curvadetalles_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_curvadetalles_hasta( txVal as variant, txValOld as variant ) as Boolean

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
	function Entidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entidad( lxVal )
				this.Setear_Entidad( lxVal )
				 This.Entidad_DespuesDeAsignar()
			EndIf
		Else
			This.Setear_Entidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Filtro_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Filtro
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Filtro( lxVal )
				this.Setear_Filtro( lxVal )
			EndIf
		Else
			This.Setear_Filtro( lxVal ) 
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
	function Operatoria_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Operatoria
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Operatoria( lxVal )
				this.Setear_Operatoria( lxVal )
			EndIf
		Else
			This.Setear_Operatoria( lxVal ) 
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
	function Numero_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero_desde( lxVal )
				if ( this.lHabilitarNumero_desde or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Numero_desde( lxVal )
				else
					this.Numero_desde = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Numero_desde)" )
				endif 
			EndIf
		Else
			This.Setear_Numero_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numero_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numero_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numero_hasta( lxVal )
				if ( this.lHabilitarNumero_hasta or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Numero_hasta( lxVal )
				else
					this.Numero_hasta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Numero_hasta)" )
				endif 
			EndIf
		Else
			This.Setear_Numero_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha_desde( lxVal )
				this.Setear_Fecha_desde( lxVal )
			EndIf
		Else
			This.Setear_Fecha_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha_hasta( lxVal )
				this.Setear_Fecha_hasta( lxVal )
			EndIf
		Else
			This.Setear_Fecha_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechafactura_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechafactura_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechafactura_desde( lxVal )
				this.Setear_Fechafactura_desde( lxVal )
			EndIf
		Else
			This.Setear_Fechafactura_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechafactura_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechafactura_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechafactura_hasta( lxVal )
				this.Setear_Fechafactura_hasta( lxVal )
			EndIf
		Else
			This.Setear_Fechafactura_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Mercaderiaconsignacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Mercaderiaconsignacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Mercaderiaconsignacion( lxVal )
				if ( this.lHabilitarMercaderiaconsignacion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Mercaderiaconsignacion( lxVal )
				else
					this.Mercaderiaconsignacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Mercaderiaconsignacion)" )
				endif 
			EndIf
		Else
			This.Setear_Mercaderiaconsignacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bdconsignacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bdconsignacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bdconsignacion( lxVal )
				if ( this.lHabilitarBdconsignacion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Bdconsignacion( lxVal )
				else
					this.Bdconsignacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Bdconsignacion)" )
				endif 
			EndIf
		Else
			This.Setear_Bdconsignacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_ano_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_ano_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_ano_desde( lxVal )
				this.Setear_F_articulo_ano_desde( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_ano_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_ano_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_articulo_ano_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_F_articulo_ano_hasta( lxVal )
				this.Setear_F_articulo_ano_hasta( lxVal )
			EndIf
		Else
			This.Setear_F_articulo_ano_hasta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_consignacion_desde_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha_consignacion_desde
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha_consignacion_desde( lxVal )
				if ( this.lHabilitarFecha_consignacion_desde or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Fecha_consignacion_desde( lxVal )
				else
					this.Fecha_consignacion_desde = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Fecha_consignacion_desde)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha_consignacion_desde( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_consignacion_hasta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha_consignacion_hasta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha_consignacion_hasta( lxVal )
				if ( this.lHabilitarFecha_consignacion_hasta or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Fecha_consignacion_hasta( lxVal )
				else
					this.Fecha_consignacion_hasta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nuevo en base a - Atributo: Fecha_consignacion_hasta)" )
				endif 
			EndIf
		Else
			This.Setear_Fecha_consignacion_hasta( lxVal ) 
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
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
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
	function Setear_Entidad( txVal as variant ) as void

		this.Entidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Filtro( txVal as variant ) as void

		this.Filtro = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
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
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
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
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Operatoria( txVal as variant ) as void

		this.Operatoria = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero_desde( txVal as variant ) as void

		this.Numero_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero_hasta( txVal as variant ) as void

		this.Numero_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha_desde( txVal as variant ) as void

		this.Fecha_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha_hasta( txVal as variant ) as void

		this.Fecha_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechafactura_desde( txVal as variant ) as void

		this.Fechafactura_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechafactura_hasta( txVal as variant ) as void

		this.Fechafactura_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Mercaderiaconsignacion( txVal as variant ) as void

		this.Mercaderiaconsignacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bdconsignacion( txVal as variant ) as void

		this.Bdconsignacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_ano_desde( txVal as variant ) as void

		this.F_articulo_ano_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_articulo_ano_hasta( txVal as variant ) as void

		this.F_articulo_ano_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha_consignacion_desde( txVal as variant ) as void

		this.Fecha_consignacion_desde = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha_consignacion_hasta( txVal as variant ) as void

		this.Fecha_consignacion_hasta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Diferencia( txVal as variant ) as void

		this.Diferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaimpo( txVal as variant ) as Boolean

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
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Filtro( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

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
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

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
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

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
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Operatoria( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechafactura_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechafactura_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Mercaderiaconsignacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bdconsignacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_ano_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_articulo_ano_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha_consignacion_desde( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha_consignacion_hasta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Diferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente_desde ) = 'O' or isnull( this.Cliente_desde ) )
					this.Cliente_desde = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Cliente_desde.lEsSubEntidad = .t.
					this.enlazar( 'Cliente_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente_desde.CODIGO # this.Cliente_desde_PK
						this.Cliente_desde.CODIGO = this.Cliente_desde_PK
					endif
				endif
			endif
		endif
		return this.Cliente_desde
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
	function Cliente_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente_hasta ) = 'O' or isnull( this.Cliente_hasta ) )
					this.Cliente_hasta = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Cliente_hasta.lEsSubEntidad = .t.
					this.enlazar( 'Cliente_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente_hasta.CODIGO # this.Cliente_hasta_PK
						this.Cliente_hasta.CODIGO = this.Cliente_hasta_PK
					endif
				endif
			endif
		endif
		return this.Cliente_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Proveedor_desde ) = 'O' or isnull( this.Proveedor_desde ) )
					this.Proveedor_desde = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.Proveedor_desde.lEsSubEntidad = .t.
					this.enlazar( 'Proveedor_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Proveedor_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Proveedor_desde.CODIGO # this.Proveedor_desde_PK
						this.Proveedor_desde.CODIGO = this.Proveedor_desde_PK
					endif
				endif
			endif
		endif
		return this.Proveedor_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Proveedor_hasta ) = 'O' or isnull( this.Proveedor_hasta ) )
					this.Proveedor_hasta = _Screen.zoo.instanciarentidad( 'Proveedor' )
					this.Proveedor_hasta.lEsSubEntidad = .t.
					this.enlazar( 'Proveedor_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Proveedor_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Proveedor_hasta.CODIGO # this.Proveedor_hasta_PK
						this.Proveedor_hasta.CODIGO = this.Proveedor_hasta_PK
					endif
				endif
			endif
		endif
		return this.Proveedor_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Vendedor_desde ) = 'O' or isnull( this.Vendedor_desde ) )
					this.Vendedor_desde = _Screen.zoo.instanciarentidad( 'Vendedor' )
					this.Vendedor_desde.lEsSubEntidad = .t.
					this.enlazar( 'Vendedor_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Vendedor_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Vendedor_desde.CODIGO # this.Vendedor_desde_PK
						this.Vendedor_desde.CODIGO = this.Vendedor_desde_PK
					endif
				endif
			endif
		endif
		return this.Vendedor_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Vendedor_hasta ) = 'O' or isnull( this.Vendedor_hasta ) )
					this.Vendedor_hasta = _Screen.zoo.instanciarentidad( 'Vendedor' )
					this.Vendedor_hasta.lEsSubEntidad = .t.
					this.enlazar( 'Vendedor_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Vendedor_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Vendedor_hasta.CODIGO # this.Vendedor_hasta_PK
						this.Vendedor_hasta.CODIGO = this.Vendedor_hasta_PK
					endif
				endif
			endif
		endif
		return this.Vendedor_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Monedacomprobante_desde ) = 'O' or isnull( this.Monedacomprobante_desde ) )
					this.Monedacomprobante_desde = _Screen.zoo.instanciarentidad( 'Moneda' )
					this.Monedacomprobante_desde.lEsSubEntidad = .t.
					this.enlazar( 'Monedacomprobante_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Monedacomprobante_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Monedacomprobante_desde.CODIGO # this.Monedacomprobante_desde_PK
						this.Monedacomprobante_desde.CODIGO = this.Monedacomprobante_desde_PK
					endif
				endif
			endif
		endif
		return this.Monedacomprobante_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monedacomprobante_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Monedacomprobante_hasta ) = 'O' or isnull( this.Monedacomprobante_hasta ) )
					this.Monedacomprobante_hasta = _Screen.zoo.instanciarentidad( 'Moneda' )
					this.Monedacomprobante_hasta.lEsSubEntidad = .t.
					this.enlazar( 'Monedacomprobante_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Monedacomprobante_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Monedacomprobante_hasta.CODIGO # this.Monedacomprobante_hasta_PK
						this.Monedacomprobante_hasta.CODIGO = this.Monedacomprobante_hasta_PK
					endif
				endif
			endif
		endif
		return this.Monedacomprobante_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clienteconsignacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Clienteconsignacion ) = 'O' or isnull( this.Clienteconsignacion ) )
					this.Clienteconsignacion = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Clienteconsignacion.lEsSubEntidad = .t.
					this.enlazar( 'Clienteconsignacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Clienteconsignacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Clienteconsignacion.CODIGO # this.Clienteconsignacion_PK
						this.Clienteconsignacion.CODIGO = this.Clienteconsignacion_PK
					endif
				endif
			endif
		endif
		return this.Clienteconsignacion
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
	function F_talle_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_talle_desde ) = 'O' or isnull( this.F_talle_desde ) )
					this.F_talle_desde = _Screen.zoo.instanciarentidad( 'Talle' )
					this.F_talle_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_talle_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_talle_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_talle_desde.CODIGO # this.F_talle_desde_PK
						this.F_talle_desde.CODIGO = this.F_talle_desde_PK
					endif
				endif
			endif
		endif
		return this.F_talle_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_talle_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_talle_hasta ) = 'O' or isnull( this.F_talle_hasta ) )
					this.F_talle_hasta = _Screen.zoo.instanciarentidad( 'Talle' )
					this.F_talle_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_talle_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_talle_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_talle_hasta.CODIGO # this.F_talle_hasta_PK
						this.F_talle_hasta.CODIGO = this.F_talle_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_talle_hasta
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
	function F_articulo_temporada_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_temporada_desde ) = 'O' or isnull( this.F_articulo_temporada_desde ) )
					this.F_articulo_temporada_desde = _Screen.zoo.instanciarentidad( 'Temporada' )
					this.F_articulo_temporada_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_temporada_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_temporada_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_temporada_desde.CODIGO # this.F_articulo_temporada_desde_PK
						this.F_articulo_temporada_desde.CODIGO = this.F_articulo_temporada_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_temporada_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_temporada_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_temporada_hasta ) = 'O' or isnull( this.F_articulo_temporada_hasta ) )
					this.F_articulo_temporada_hasta = _Screen.zoo.instanciarentidad( 'Temporada' )
					this.F_articulo_temporada_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_temporada_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_temporada_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_temporada_hasta.CODIGO # this.F_articulo_temporada_hasta_PK
						this.F_articulo_temporada_hasta.CODIGO = this.F_articulo_temporada_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_temporada_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_familia_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_familia_desde ) = 'O' or isnull( this.F_articulo_familia_desde ) )
					this.F_articulo_familia_desde = _Screen.zoo.instanciarentidad( 'Familia' )
					this.F_articulo_familia_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_familia_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_familia_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_familia_desde.CODIGO # this.F_articulo_familia_desde_PK
						this.F_articulo_familia_desde.CODIGO = this.F_articulo_familia_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_familia_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_familia_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_familia_hasta ) = 'O' or isnull( this.F_articulo_familia_hasta ) )
					this.F_articulo_familia_hasta = _Screen.zoo.instanciarentidad( 'Familia' )
					this.F_articulo_familia_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_familia_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_familia_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_familia_hasta.CODIGO # this.F_articulo_familia_hasta_PK
						this.F_articulo_familia_hasta.CODIGO = this.F_articulo_familia_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_familia_hasta
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
	function F_articulo_linea_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_linea_desde ) = 'O' or isnull( this.F_articulo_linea_desde ) )
					this.F_articulo_linea_desde = _Screen.zoo.instanciarentidad( 'Linea' )
					this.F_articulo_linea_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_linea_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_linea_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_linea_desde.CODIGO # this.F_articulo_linea_desde_PK
						this.F_articulo_linea_desde.CODIGO = this.F_articulo_linea_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_linea_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_linea_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_linea_hasta ) = 'O' or isnull( this.F_articulo_linea_hasta ) )
					this.F_articulo_linea_hasta = _Screen.zoo.instanciarentidad( 'Linea' )
					this.F_articulo_linea_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_linea_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_linea_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_linea_hasta.CODIGO # this.F_articulo_linea_hasta_PK
						this.F_articulo_linea_hasta.CODIGO = this.F_articulo_linea_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_linea_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_grupo_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_grupo_desde ) = 'O' or isnull( this.F_articulo_grupo_desde ) )
					this.F_articulo_grupo_desde = _Screen.zoo.instanciarentidad( 'Grupo' )
					this.F_articulo_grupo_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_grupo_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_grupo_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_grupo_desde.CODIGO # this.F_articulo_grupo_desde_PK
						this.F_articulo_grupo_desde.CODIGO = this.F_articulo_grupo_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_grupo_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_grupo_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_grupo_hasta ) = 'O' or isnull( this.F_articulo_grupo_hasta ) )
					this.F_articulo_grupo_hasta = _Screen.zoo.instanciarentidad( 'Grupo' )
					this.F_articulo_grupo_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_grupo_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_grupo_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_grupo_hasta.CODIGO # this.F_articulo_grupo_hasta_PK
						this.F_articulo_grupo_hasta.CODIGO = this.F_articulo_grupo_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_grupo_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_categoriadearticulo_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_categoriadearticulo_desde ) = 'O' or isnull( this.F_articulo_categoriadearticulo_desde ) )
					this.F_articulo_categoriadearticulo_desde = _Screen.zoo.instanciarentidad( 'Categoriadearticulo' )
					this.F_articulo_categoriadearticulo_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_categoriadearticulo_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_categoriadearticulo_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_categoriadearticulo_desde.CODIGO # this.F_articulo_categoriadearticulo_desde_PK
						this.F_articulo_categoriadearticulo_desde.CODIGO = this.F_articulo_categoriadearticulo_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_categoriadearticulo_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_categoriadearticulo_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_categoriadearticulo_hasta ) = 'O' or isnull( this.F_articulo_categoriadearticulo_hasta ) )
					this.F_articulo_categoriadearticulo_hasta = _Screen.zoo.instanciarentidad( 'Categoriadearticulo' )
					this.F_articulo_categoriadearticulo_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_categoriadearticulo_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_categoriadearticulo_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_categoriadearticulo_hasta.CODIGO # this.F_articulo_categoriadearticulo_hasta_PK
						this.F_articulo_categoriadearticulo_hasta.CODIGO = this.F_articulo_categoriadearticulo_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_categoriadearticulo_hasta
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
	function F_articulo_tipodearticulo_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_tipodearticulo_desde ) = 'O' or isnull( this.F_articulo_tipodearticulo_desde ) )
					this.F_articulo_tipodearticulo_desde = _Screen.zoo.instanciarentidad( 'Tipodearticulo' )
					this.F_articulo_tipodearticulo_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_tipodearticulo_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_tipodearticulo_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_tipodearticulo_desde.CODIGO # this.F_articulo_tipodearticulo_desde_PK
						this.F_articulo_tipodearticulo_desde.CODIGO = this.F_articulo_tipodearticulo_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_tipodearticulo_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_tipodearticulo_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_tipodearticulo_hasta ) = 'O' or isnull( this.F_articulo_tipodearticulo_hasta ) )
					this.F_articulo_tipodearticulo_hasta = _Screen.zoo.instanciarentidad( 'Tipodearticulo' )
					this.F_articulo_tipodearticulo_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_tipodearticulo_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_tipodearticulo_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_tipodearticulo_hasta.CODIGO # this.F_articulo_tipodearticulo_hasta_PK
						this.F_articulo_tipodearticulo_hasta.CODIGO = this.F_articulo_tipodearticulo_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_tipodearticulo_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_paletadecolores_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_paletadecolores_desde ) = 'O' or isnull( this.F_articulo_paletadecolores_desde ) )
					this.F_articulo_paletadecolores_desde = _Screen.zoo.instanciarentidad( 'Paletadecolores' )
					this.F_articulo_paletadecolores_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_paletadecolores_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_paletadecolores_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_paletadecolores_desde.CODIGO # this.F_articulo_paletadecolores_desde_PK
						this.F_articulo_paletadecolores_desde.CODIGO = this.F_articulo_paletadecolores_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_paletadecolores_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_paletadecolores_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_paletadecolores_hasta ) = 'O' or isnull( this.F_articulo_paletadecolores_hasta ) )
					this.F_articulo_paletadecolores_hasta = _Screen.zoo.instanciarentidad( 'Paletadecolores' )
					this.F_articulo_paletadecolores_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_paletadecolores_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_paletadecolores_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_paletadecolores_hasta.CODIGO # this.F_articulo_paletadecolores_hasta_PK
						this.F_articulo_paletadecolores_hasta.CODIGO = this.F_articulo_paletadecolores_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_paletadecolores_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_curvadetalles_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_curvadetalles_desde ) = 'O' or isnull( this.F_articulo_curvadetalles_desde ) )
					this.F_articulo_curvadetalles_desde = _Screen.zoo.instanciarentidad( 'Curvadetalles' )
					this.F_articulo_curvadetalles_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_curvadetalles_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_curvadetalles_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_curvadetalles_desde.CODIGO # this.F_articulo_curvadetalles_desde_PK
						this.F_articulo_curvadetalles_desde.CODIGO = this.F_articulo_curvadetalles_desde_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_curvadetalles_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_articulo_curvadetalles_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_articulo_curvadetalles_hasta ) = 'O' or isnull( this.F_articulo_curvadetalles_hasta ) )
					this.F_articulo_curvadetalles_hasta = _Screen.zoo.instanciarentidad( 'Curvadetalles' )
					this.F_articulo_curvadetalles_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_articulo_curvadetalles_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_articulo_curvadetalles_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_articulo_curvadetalles_hasta.CODIGO # this.F_articulo_curvadetalles_hasta_PK
						this.F_articulo_curvadetalles_hasta.CODIGO = this.F_articulo_curvadetalles_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_articulo_curvadetalles_hasta
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
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Horaimpo = []
				.Horaexpo = []
				.Estadotransferencia = []
				.Basededatosmodificacionfw = []
				.Basededatosaltafw = []
				.Horaaltafw = []
				.Horamodificacionfw = []
				.Versionaltafw = []
				.Seriealtafw = []
				.Zadsfw = []
				.Usuariomodificacionfw = []
				.Versionmodificacionfw = []
				.Usuarioaltafw = []
				.Seriemodificacionfw = []
				.Codigo = []
				.Detallecomprobantes.Limpiar()
				.Bolsasycajas_PK = []
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
	Function ValorSugeridoEntidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Entidad" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Comprobante para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFiltro() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Filtro" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Filtro' )
						.Filtro = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Filtro para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoOperatoria() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Operatoria" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Operatoria' )
						.Operatoria = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Operatoria para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Cliente_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cliente_desde_PK' )
						.Cliente_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.Cliente_desde.CODIGO = .Cliente_desde_PK
					endif
				endif
			Catch to loError
				.Cliente_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Bolsasycajas" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Bolsas y cajas para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCliente_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Cliente_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cliente_hasta_PK' )
						.Cliente_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.Cliente_hasta.CODIGO = .Cliente_hasta_PK
					endif
				endif
			Catch to loError
				.Cliente_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumero_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Numero_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numero_desde' )
						.Numero_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número de comprobante para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumero_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Numero_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numero_hasta' )
						.Numero_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Número de comprobante hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fecha_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha_desde' )
						.Fecha_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha comprobante para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fecha_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha_hasta' )
						.Fecha_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha comprobante hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechafactura_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fechafactura_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechafactura_desde' )
						.Fechafactura_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha emisión para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechafactura_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fechafactura_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechafactura_hasta' )
						.Fechafactura_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha emisión hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProveedor_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Proveedor_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Proveedor_desde_PK' )
						.Proveedor_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.Proveedor_desde.CODIGO = .Proveedor_desde_PK
					endif
				endif
			Catch to loError
				.Proveedor_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMercaderiaconsignacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Mercaderiaconsignacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Mercaderiaconsignacion' )
						.Mercaderiaconsignacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Mercadería en consignación para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWMercaderiaconsignacion()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWMercaderiaconsignacion() as void
		with this
			.Mercaderiaconsignacion = 'F'
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProveedor_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Proveedor_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Proveedor_hasta_PK' )
						.Proveedor_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.Proveedor_hasta.CODIGO = .Proveedor_hasta_PK
					endif
				endif
			Catch to loError
				.Proveedor_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Vendedor_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vendedor_desde_PK' )
						.Vendedor_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.Vendedor_desde.CODIGO = .Vendedor_desde_PK
					endif
				endif
			Catch to loError
				.Vendedor_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Vendedor_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vendedor_hasta_PK' )
						.Vendedor_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.Vendedor_hasta.CODIGO = .Vendedor_hasta_PK
					endif
				endif
			Catch to loError
				.Vendedor_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonedacomprobante_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Monedacomprobante_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Monedacomprobante_desde_PK' )
						.Monedacomprobante_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.Monedacomprobante_desde.CODIGO = .Monedacomprobante_desde_PK
					endif
				endif
			Catch to loError
				.Monedacomprobante_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Moneda para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonedacomprobante_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Monedacomprobante_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Monedacomprobante_hasta_PK' )
						.Monedacomprobante_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.Monedacomprobante_hasta.CODIGO = .Monedacomprobante_hasta_PK
					endif
				else
					.ValorSugeridoFWMonedacomprobante_hasta()
				endif
			Catch to loError
				.Monedacomprobante_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Moneda hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWMonedacomprobante_hasta() as void
		with this
			try
				.Monedacomprobante_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.Monedacomprobante_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClienteconsignacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Clienteconsignacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Clienteconsignacion_PK' )
						.Clienteconsignacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Clienteconsignacion.CODIGO = .Clienteconsignacion_PK
					endif
				endif
			Catch to loError
				.Clienteconsignacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente consignación para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_desde" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_hasta" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_color_desde" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_color_hasta" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	Function ValorSugeridoF_talle_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_talle_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_talle_desde_PK' )
						.F_talle_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_talle_desde.CODIGO = .F_talle_desde_PK
					endif
				endif
			Catch to loError
				.F_talle_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_talle_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_talle_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_talle_hasta_PK' )
						.F_talle_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_talle_hasta.CODIGO = .F_talle_hasta_PK
					endif
				else
					.ValorSugeridoFWF_talle_hasta()
				endif
			Catch to loError
				.F_talle_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_talle_hasta() as void
		with this
			try
				.F_talle_hasta_PK = 'ZZZ'
			Catch to loError
				.F_talle_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBdconsignacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Bdconsignacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Bdconsignacion' )
						.Bdconsignacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Base de datos para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_proveedor_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_proveedor_desde" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor del artículo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_proveedor_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_proveedor_hasta" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Proveedor de artículo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_proveedor_hasta() as void
		with this
			try
				.F_articulo_proveedor_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_proveedor_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_temporada_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_temporada_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_temporada_desde_PK' )
						.F_articulo_temporada_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_temporada_desde.CODIGO = .F_articulo_temporada_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_temporada_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Temporada para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_temporada_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_temporada_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_temporada_hasta_PK' )
						.F_articulo_temporada_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_temporada_hasta.CODIGO = .F_articulo_temporada_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_temporada_hasta()
				endif
			Catch to loError
				.F_articulo_temporada_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Temporada hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_temporada_hasta() as void
		with this
			try
				.F_articulo_temporada_hasta_PK = 'ZZZZZ'
			Catch to loError
				.F_articulo_temporada_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_ano_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_ano_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_ano_desde' )
						.F_articulo_ano_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Año para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_ano_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_ano_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_ano_hasta' )
						.F_articulo_ano_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Año hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWF_articulo_ano_hasta()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_ano_hasta() as void
		with this
			.F_articulo_ano_hasta = 9999
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_familia_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_familia_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_familia_desde_PK' )
						.F_articulo_familia_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_familia_desde.CODIGO = .F_articulo_familia_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_familia_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Familia para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_familia_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_familia_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_familia_hasta_PK' )
						.F_articulo_familia_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_familia_hasta.CODIGO = .F_articulo_familia_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_familia_hasta()
				endif
			Catch to loError
				.F_articulo_familia_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Familia hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_familia_hasta() as void
		with this
			try
				.F_articulo_familia_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_familia_hasta_PK=[]
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_material_desde" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Material para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_material_hasta" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Material hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	Function ValorSugeridoFecha_consignacion_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fecha_consignacion_desde" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha_consignacion_desde' )
						.Fecha_consignacion_desde = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Período de ventas a liquidar para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_linea_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_linea_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_linea_desde_PK' )
						.F_articulo_linea_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_linea_desde.CODIGO = .F_articulo_linea_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_linea_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Línea para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_linea_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_linea_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_linea_hasta_PK' )
						.F_articulo_linea_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_linea_hasta.CODIGO = .F_articulo_linea_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_linea_hasta()
				endif
			Catch to loError
				.F_articulo_linea_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Línea hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_linea_hasta() as void
		with this
			try
				.F_articulo_linea_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_linea_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_grupo_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_grupo_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_grupo_desde_PK' )
						.F_articulo_grupo_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_grupo_desde.CODIGO = .F_articulo_grupo_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_grupo_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Grupo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_grupo_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_grupo_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_grupo_hasta_PK' )
						.F_articulo_grupo_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_grupo_hasta.CODIGO = .F_articulo_grupo_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_grupo_hasta()
				endif
			Catch to loError
				.F_articulo_grupo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Grupo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_grupo_hasta() as void
		with this
			try
				.F_articulo_grupo_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_grupo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_categoriadearticulo_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_categoriadearticulo_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_categoriadearticulo_desde_PK' )
						.F_articulo_categoriadearticulo_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_categoriadearticulo_desde.CODIGO = .F_articulo_categoriadearticulo_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_categoriadearticulo_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Categoría de artículo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_categoriadearticulo_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_categoriadearticulo_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_categoriadearticulo_hasta_PK' )
						.F_articulo_categoriadearticulo_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_categoriadearticulo_hasta.CODIGO = .F_articulo_categoriadearticulo_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_categoriadearticulo_hasta()
				endif
			Catch to loError
				.F_articulo_categoriadearticulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Categoría de artículo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_categoriadearticulo_hasta() as void
		with this
			try
				.F_articulo_categoriadearticulo_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_categoriadearticulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_clasificacion_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_clasificacion_desde" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación de artículo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_clasificacion_hasta" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación de artículo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	Function ValorSugeridoF_articulo_tipodearticulo_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_tipodearticulo_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_tipodearticulo_desde_PK' )
						.F_articulo_tipodearticulo_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_tipodearticulo_desde.CODIGO = .F_articulo_tipodearticulo_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_tipodearticulo_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo de artículo para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_tipodearticulo_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_tipodearticulo_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_tipodearticulo_hasta_PK' )
						.F_articulo_tipodearticulo_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_tipodearticulo_hasta.CODIGO = .F_articulo_tipodearticulo_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_tipodearticulo_hasta()
				endif
			Catch to loError
				.F_articulo_tipodearticulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo de artículo hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_tipodearticulo_hasta() as void
		with this
			try
				.F_articulo_tipodearticulo_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_tipodearticulo_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFecha_consignacion_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Fecha_consignacion_hasta" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fecha_consignacion_hasta' )
						.Fecha_consignacion_hasta = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Período de ventas a liquidar hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_paletadecolores_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_paletadecolores_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_paletadecolores_desde_PK' )
						.F_articulo_paletadecolores_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_paletadecolores_desde.CODIGO = .F_articulo_paletadecolores_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_paletadecolores_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Paleta de colores para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_paletadecolores_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_paletadecolores_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_paletadecolores_hasta_PK' )
						.F_articulo_paletadecolores_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_paletadecolores_hasta.CODIGO = .F_articulo_paletadecolores_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_paletadecolores_hasta()
				endif
			Catch to loError
				.F_articulo_paletadecolores_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Paleta de colores hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_paletadecolores_hasta() as void
		with this
			try
				.F_articulo_paletadecolores_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_paletadecolores_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_curvadetalles_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_curvadetalles_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_curvadetalles_desde_PK' )
						.F_articulo_curvadetalles_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_curvadetalles_desde.CODIGO = .F_articulo_curvadetalles_desde_PK
					endif
				endif
			Catch to loError
				.F_articulo_curvadetalles_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Curva de talles para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_articulo_curvadetalles_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "F_articulo_curvadetalles_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_articulo_curvadetalles_hasta_PK' )
						.F_articulo_curvadetalles_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_articulo_curvadetalles_hasta.CODIGO = .F_articulo_curvadetalles_hasta_PK
					endif
				else
					.ValorSugeridoFWF_articulo_curvadetalles_hasta()
				endif
			Catch to loError
				.F_articulo_curvadetalles_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Curva de talles hasta para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_articulo_curvadetalles_hasta() as void
		with this
			try
				.F_articulo_curvadetalles_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_articulo_curvadetalles_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDiferencia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NUEVOENBASEA", "", "Diferencia" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Diferencia' )
						.Diferencia = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Diferencias para la entidad Nuevo en base a." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidad_DespuesDeAsignar() as void
		this.AsignarTipoDeComprobante()                                                                     
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
		use in select( 'c_NUEVOENBASEA' )
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Entidad = []
			.Filtro = []
			.Observacion = []
			.Descripcion = []
			.Operatoria = 0
			.Tipocomprobante = 0
			.Cliente_desde_PK = []
			.Cliente_hasta_PK = []
			.Numero_desde = 0
			.Numero_hasta = 0
			.Fecha_desde = ctod( '  /  /    ' )
			.Fecha_hasta = ctod( '  /  /    ' )
			.Fechafactura_desde = ctod( '  /  /    ' )
			.Fechafactura_hasta = ctod( '  /  /    ' )
			.Proveedor_desde_PK = []
			.Mercaderiaconsignacion = .F.
			.Proveedor_hasta_PK = []
			.Vendedor_desde_PK = []
			.Vendedor_hasta_PK = []
			.Monedacomprobante_desde_PK = []
			.Monedacomprobante_hasta_PK = []
			.Clienteconsignacion_PK = []
			.F_articulo_desde_PK = []
			.F_articulo_hasta_PK = []
			.F_color_desde_PK = []
			.F_color_hasta_PK = []
			.F_talle_desde_PK = []
			.F_talle_hasta_PK = []
			.Bdconsignacion = []
			.F_articulo_proveedor_desde_PK = []
			.F_articulo_proveedor_hasta_PK = []
			.F_articulo_temporada_desde_PK = []
			.F_articulo_temporada_hasta_PK = []
			.F_articulo_ano_desde = 0
			.F_articulo_ano_hasta = 0
			.F_articulo_familia_desde_PK = []
			.F_articulo_familia_hasta_PK = []
			.F_articulo_material_desde_PK = []
			.F_articulo_material_hasta_PK = []
			.Fecha_consignacion_desde = ctod( '  /  /    ' )
			.F_articulo_linea_desde_PK = []
			.F_articulo_linea_hasta_PK = []
			.F_articulo_grupo_desde_PK = []
			.F_articulo_grupo_hasta_PK = []
			.F_articulo_categoriadearticulo_desde_PK = []
			.F_articulo_categoriadearticulo_hasta_PK = []
			.F_articulo_clasificacion_desde_PK = []
			.F_articulo_clasificacion_hasta_PK = []
			.F_articulo_tipodearticulo_desde_PK = []
			.F_articulo_tipodearticulo_hasta_PK = []
			.Fecha_consignacion_hasta = ctod( '  /  /    ' )
			.F_articulo_paletadecolores_desde_PK = []
			.F_articulo_paletadecolores_hasta_PK = []
			.F_articulo_curvadetalles_desde_PK = []
			.F_articulo_curvadetalles_hasta_PK = []
			.Diferencia = []
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