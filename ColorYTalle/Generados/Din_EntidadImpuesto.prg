
define class Din_EntidadIMPUESTO as entidad of entidad.prg

	cNombre = 'IMPUESTO'
	FECHAIMPO = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	HORAALTAFW = []
	HORAEXPO = []
	HORAIMPO = []
	SERIEALTAFW = []
	HORAMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	ZADSFW = []
	VERSIONALTAFW = []
	USUARIOMODIFICACIONFW = []
	SERIEMODIFICACIONFW = []
	USUARIOALTAFW = []
	BASEDEDATOSMODIFICACIONFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSALTAFW = []
	tipoagrupamientopublicaciones = 0
	TIMESTAMP = 0
	BLOQUEARREGISTRO = .F.
	cAtributoPK = 'Codigo'
	Codigo = []
	Observacion = []
	EscalaDetalle = null
	lHabilitarEscalaDetalle = .T.
	RG5329AplicaPorArticulo = .F.
	lHabilitarRG5329AplicaPorArticulo = .T.
	BaseDeCalculo = []
	lHabilitarBaseDeCalculo = .T.
	RG2616Regimen_PK = []
	RG2616Regimen = null
	lHabilitarRG2616Regimen_PK = .T.
	RG1575Regimen_PK = []
	RG1575Regimen = null
	lHabilitarRG1575Regimen_PK = .T.
	AgruPubliDetalle = null
	RG1575Porcentaje = 0
	lHabilitarRG1575Porcentaje = .T.
	PorcentajeBase = 0
	lHabilitarPorcentajeBase = .T.
	RG2616Porcentaje = 0
	lHabilitarRG2616Porcentaje = .T.
	Descripcion = []
	RG2616Meses = 0
	lHabilitarRG2616Meses = .T.
	PagoParcial = 0
	lHabilitarPagoParcial = .T.
	RG1575BaseDeCalculo = []
	lHabilitarRG1575BaseDeCalculo = .T.
	Aplicacion = []
	RG1575MontoMinimoRetencion = 0
	lHabilitarRG1575MontoMinimoRetencion = .T.
	RG5329Porcentaje = 0
	lHabilitarRG5329Porcentaje = .T.
	RG2616MontoMaximoServicios = 0
	lHabilitarRG2616MontoMaximoServicios = .T.
	Tipo_PK = []
	Tipo = null
	RG2616MontoMaximoBienes = 0
	lHabilitarRG2616MontoMaximoBienes = .T.
	Jurisdiccion_PK = []
	Jurisdiccion = null
	lHabilitarJurisdiccion_PK = .T.
	Resolucion = []
	RegimenImpositivo_PK = []
	RegimenImpositivo = null
	lHabilitarRegimenImpositivo_PK = .T.
	Escala = .F.
	lHabilitarEscala = .T.
	IIBBMenAlicuotaNoInscriptos = 0
	lHabilitarIIBBMenAlicuotaNoInscriptos = .T.
	Minimo = 0
	lHabilitarMinimo = .T.
	Monto = 0
	lHabilitarMonto = .T.
	Porcentaje = 0
	lHabilitarPorcentaje = .T.
	SegunConvenio = .F.
	lHabilitarSegunConvenio = .T.
	ConvenioLocal = 0
	lHabilitarConvenioLocal = .T.
	ConvenioMultilateral = 0
	lHabilitarConvenioMultilateral = .T.
	ConvenioMultilExtranaJuris = 0
	lHabilitarConvenioMultilExtranaJuris = .T.
	ConvenioNoInscripto = 0
	lHabilitarConvenioNoInscripto = .T.
	IIBBTucCoeficienteCero = 0
	lHabilitarIIBBTucCoeficienteCero = .T.
	IIBBTucReduccionAlicuota = 0
	lHabilitarIIBBTucReduccionAlicuota = .T.
	IIBBTucAlicuotaNoInscriptos = 0
	lHabilitarIIBBTucAlicuotaNoInscriptos = .T.
	Regimen = []
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Impuestos]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''

	lUsaAgrupamientoPublicaciones = .T.
	cValorComboToolbar = ''
	cValorComboToolbarAnterior = 'Todas'
lEsGuardarComo = .F.
cCodigoPrevioGuardarComo = ""
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarEscalaDetalle = .T.
		this.lHabilitarRG5329AplicaPorArticulo = .T.
		this.lHabilitarBaseDeCalculo = .T.
		this.lHabilitarRG2616Regimen_PK = .T.
		this.lHabilitarRG1575Regimen_PK = .T.
		this.lHabilitarRG1575Porcentaje = .T.
		this.lHabilitarPorcentajeBase = .T.
		this.lHabilitarRG2616Porcentaje = .T.
		this.lHabilitarRG2616Meses = .T.
		this.lHabilitarPagoParcial = .T.
		this.lHabilitarRG1575BaseDeCalculo = .T.
		this.lHabilitarRG1575MontoMinimoRetencion = .T.
		this.lHabilitarRG5329Porcentaje = .T.
		this.lHabilitarRG2616MontoMaximoServicios = .T.
		this.lHabilitarRG2616MontoMaximoBienes = .T.
		this.lHabilitarJurisdiccion_PK = .T.
		this.lHabilitarRegimenImpositivo_PK = .T.
		this.lHabilitarEscala = .T.
		this.lHabilitarIIBBMenAlicuotaNoInscriptos = .T.
		this.lHabilitarMinimo = .T.
		this.lHabilitarMonto = .T.
		this.lHabilitarPorcentaje = .T.
		this.lHabilitarSegunConvenio = .T.
		this.lHabilitarConvenioLocal = .T.
		this.lHabilitarConvenioMultilateral = .T.
		this.lHabilitarConvenioMultilExtranaJuris = .T.
		this.lHabilitarConvenioNoInscripto = .T.
		this.lHabilitarIIBBTucCoeficienteCero = .T.
		this.lHabilitarIIBBTucReduccionAlicuota = .T.
		this.lHabilitarIIBBTucAlicuotaNoInscriptos = .T.
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
			this.oAD = this.crearobjeto( 'Din_EntidadIMPUESTOAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escaladetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Escaladetalle ) = 'O' or isnull( this.Escaladetalle ) )
			this.Escaladetalle = this.crearobjeto( 'Din_DetalleImpuestoEscaladetalle' )
			this.Escaladetalle.inicializar()
			this.enlazar( 'Escaladetalle.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Escaladetalle.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Escaladetalle, 'CambioSumarizado', this, 'CambiosDetalleEscaladetalle', 1) 
			this.enlazar( 'Escaladetalle.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Escaladetalle.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
		endif
		return this.Escaladetalle
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Agrupublidetalle_Access() as variant
		if !this.ldestroy and ( !vartype( this.Agrupublidetalle ) = 'O' or isnull( this.Agrupublidetalle ) )
			this.Agrupublidetalle = this.crearobjeto( 'Din_DetalleImpuestoAgrupublidetalle' )
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
		this.EscalaDetalle.oItem.lNuevo = this.lNuevo
		this.AgruPubliDetalle.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.EscalaDetalle.oItem.lEdicion = this.lEdicion
		this.AgruPubliDetalle.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleEscaladetalle() as void
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
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.SERIEALTAFW) = 'C' )
			if len( alltrim( this.SERIEALTAFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEALTAFW no es el correcto.')
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
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
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
		 
		if ( vartype( this.BLOQUEARREGISTRO) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BLOQUEARREGISTRO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Codigo) = 'C' )
			if len( alltrim( this.CODIGO ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Observacion) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBSERVACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG5329AplicaPorArticulo) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG5329APLICAPORARTICULO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BaseDeCalculo) = 'C' )
			if len( alltrim( this.BASEDECALCULO ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDECALCULO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDECALCULO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG1575Porcentaje) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG1575PORCENTAJE ) ) ) 
			lnValorDelDecimal = this.RG1575PORCENTAJE - int( this.RG1575PORCENTAJE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG1575PORCENTAJE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG1575PORCENTAJE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PorcentajeBase) = 'N' )
			lnLargoEntero  = len( transform( int( this.PORCENTAJEBASE ) ) ) 
			lnValorDelDecimal = this.PORCENTAJEBASE - int( this.PORCENTAJEBASE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJEBASE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJEBASE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG2616Porcentaje) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG2616PORCENTAJE ) ) ) 
			lnValorDelDecimal = this.RG2616PORCENTAJE - int( this.RG2616PORCENTAJE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG2616PORCENTAJE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG2616PORCENTAJE no es el correcto.')
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
		 
		if ( vartype( this.RG2616Meses) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG2616MESES ) ) ) 
			lnValorDelDecimal = this.RG2616MESES - int( this.RG2616MESES)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 3
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG2616MESES es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG2616MESES no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PagoParcial) = 'N' )
			lnLargoEntero  = len( transform( int( this.PAGOPARCIAL ) ) ) 
			lnValorDelDecimal = this.PAGOPARCIAL - int( this.PAGOPARCIAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo PAGOPARCIAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PAGOPARCIAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG1575BaseDeCalculo) = 'C' )
			if len( alltrim( this.RG1575BASEDECALCULO ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo RG1575BASEDECALCULO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG1575BASEDECALCULO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Aplicacion) = 'C' )
			if len( alltrim( this.APLICACION ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo APLICACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo APLICACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG1575MontoMinimoRetencion) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG1575MONTOMINIMORETENCION ) ) ) 
			lnValorDelDecimal = this.RG1575MONTOMINIMORETENCION - int( this.RG1575MONTOMINIMORETENCION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG1575MONTOMINIMORETENCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG1575MONTOMINIMORETENCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG5329Porcentaje) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG5329PORCENTAJE ) ) ) 
			lnValorDelDecimal = this.RG5329PORCENTAJE - int( this.RG5329PORCENTAJE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG5329PORCENTAJE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG5329PORCENTAJE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG2616MontoMaximoServicios) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG2616MONTOMAXIMOSERVICIOS ) ) ) 
			lnValorDelDecimal = this.RG2616MONTOMAXIMOSERVICIOS - int( this.RG2616MONTOMAXIMOSERVICIOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 10
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG2616MONTOMAXIMOSERVICIOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG2616MONTOMAXIMOSERVICIOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RG2616MontoMaximoBienes) = 'N' )
			lnLargoEntero  = len( transform( int( this.RG2616MONTOMAXIMOBIENES ) ) ) 
			lnValorDelDecimal = this.RG2616MONTOMAXIMOBIENES - int( this.RG2616MONTOMAXIMOBIENES)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 10
				This.AgregarInformacion( 'La longitud entera del valor del atributo RG2616MONTOMAXIMOBIENES es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RG2616MONTOMAXIMOBIENES no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Resolucion) = 'C' )
			if len( alltrim( this.RESOLUCION ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo RESOLUCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RESOLUCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Escala) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESCALA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IIBBMenAlicuotaNoInscriptos) = 'N' )
			lnLargoEntero  = len( transform( int( this.IIBBMENALICUOTANOINSCRIPTOS ) ) ) 
			lnValorDelDecimal = this.IIBBMENALICUOTANOINSCRIPTOS - int( this.IIBBMENALICUOTANOINSCRIPTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo IIBBMENALICUOTANOINSCRIPTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IIBBMENALICUOTANOINSCRIPTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Minimo) = 'N' )
			lnLargoEntero  = len( transform( int( this.MINIMO ) ) ) 
			lnValorDelDecimal = this.MINIMO - int( this.MINIMO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 10
				This.AgregarInformacion( 'La longitud entera del valor del atributo MINIMO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MINIMO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Monto) = 'N' )
			lnLargoEntero  = len( transform( int( this.MONTO ) ) ) 
			lnValorDelDecimal = this.MONTO - int( this.MONTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo MONTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MONTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Porcentaje) = 'N' )
			lnLargoEntero  = len( transform( int( this.PORCENTAJE ) ) ) 
			lnValorDelDecimal = this.PORCENTAJE - int( this.PORCENTAJE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo PORCENTAJE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PORCENTAJE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SegunConvenio) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SEGUNCONVENIO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ConvenioLocal) = 'N' )
			lnLargoEntero  = len( transform( int( this.CONVENIOLOCAL ) ) ) 
			lnValorDelDecimal = this.CONVENIOLOCAL - int( this.CONVENIOLOCAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo CONVENIOLOCAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CONVENIOLOCAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ConvenioMultilateral) = 'N' )
			lnLargoEntero  = len( transform( int( this.CONVENIOMULTILATERAL ) ) ) 
			lnValorDelDecimal = this.CONVENIOMULTILATERAL - int( this.CONVENIOMULTILATERAL)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo CONVENIOMULTILATERAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CONVENIOMULTILATERAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ConvenioMultilExtranaJuris) = 'N' )
			lnLargoEntero  = len( transform( int( this.CONVENIOMULTILEXTRANAJURIS ) ) ) 
			lnValorDelDecimal = this.CONVENIOMULTILEXTRANAJURIS - int( this.CONVENIOMULTILEXTRANAJURIS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo CONVENIOMULTILEXTRANAJURIS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CONVENIOMULTILEXTRANAJURIS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ConvenioNoInscripto) = 'N' )
			lnLargoEntero  = len( transform( int( this.CONVENIONOINSCRIPTO ) ) ) 
			lnValorDelDecimal = this.CONVENIONOINSCRIPTO - int( this.CONVENIONOINSCRIPTO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo CONVENIONOINSCRIPTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CONVENIONOINSCRIPTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IIBBTucCoeficienteCero) = 'N' )
			lnLargoEntero  = len( transform( int( this.IIBBTUCCOEFICIENTECERO ) ) ) 
			lnValorDelDecimal = this.IIBBTUCCOEFICIENTECERO - int( this.IIBBTUCCOEFICIENTECERO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo IIBBTUCCOEFICIENTECERO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IIBBTUCCOEFICIENTECERO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IIBBTucReduccionAlicuota) = 'N' )
			lnLargoEntero  = len( transform( int( this.IIBBTUCREDUCCIONALICUOTA ) ) ) 
			lnValorDelDecimal = this.IIBBTUCREDUCCIONALICUOTA - int( this.IIBBTUCREDUCCIONALICUOTA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo IIBBTUCREDUCCIONALICUOTA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IIBBTUCREDUCCIONALICUOTA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.IIBBTucAlicuotaNoInscriptos) = 'N' )
			lnLargoEntero  = len( transform( int( this.IIBBTUCALICUOTANOINSCRIPTOS ) ) ) 
			lnValorDelDecimal = this.IIBBTUCALICUOTANOINSCRIPTOS - int( this.IIBBTUCALICUOTANOINSCRIPTOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo IIBBTUCALICUOTANOINSCRIPTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IIBBTUCALICUOTANOINSCRIPTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Regimen) = 'C' )
			if len( alltrim( this.REGIMEN ) ) > 50
				This.AgregarInformacion( 'La longitud del valor del atributo REGIMEN es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo REGIMEN no es el correcto.')
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
			llRetorno = .ValidarRg2616regimen() and llRetorno
			llRetorno = .ValidarRg1575regimen() and llRetorno
			llRetorno = .ValidarAplicacion() and llRetorno
			llRetorno = .ValidarTipo() and llRetorno
			llRetorno = .ValidarJurisdiccion() and llRetorno
			llRetorno = .ValidarRegimenimpositivo() and llRetorno
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
		llRetorno = This.ValidarUnDetalle( this.EscalaDetalle, 'Escalas aplicables' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.AgruPubliDetalle, 'Agrupamientos' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function lHabilitarEscalaDetalle_assign( txVal as variant ) as void
		this.lHabilitarEscalaDetalle = txVal
		this.EscalaDetalle.habilitarItems( txVal )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ValidarAplicacion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Aplicacion )
			this.AgregarInformacion( 'Debe cargar el campo Aplicación', 9005, 'Aplicacion' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarRG2616Regimen() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.RG2616Regimen_PK )
		else
			If this.RG2616Regimen.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.RG2616Regimen_PK ))+ ' de la entidad ' +  upper( this.RG2616Regimen.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarRG1575Regimen() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.RG1575Regimen_PK )
		else
			If this.RG1575Regimen.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.RG1575Regimen_PK ))+ ' de la entidad ' +  upper( this.RG1575Regimen.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTipo() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Tipo_PK )
			this.AgregarInformacion( 'Debe cargar el campo Tipo de impuesto', 9005, 'Tipo' )
			llRetorno = .F.
		else
			If this.Tipo.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Tipo_PK ))+ ' de la entidad ' +  upper( this.Tipo.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarJurisdiccion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Jurisdiccion_PK )
		else
			If this.Jurisdiccion.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Jurisdiccion_PK ))+ ' de la entidad ' +  upper( this.Jurisdiccion.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarRegimenImpositivo() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.RegimenImpositivo_PK )
		else
			If this.RegimenImpositivo.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.RegimenImpositivo_PK ))+ ' de la entidad ' +  upper( this.RegimenImpositivo.cDescripcion ) + ' no existe.')
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
				.lEsGuardarComo = .F.
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
		loAtributosObligatorios.add( 'APLICACION' )
		loAtributosObligatorios.add( 'TIPO' )
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
		return '<BLOQUEARREGISTRO><NOEXPO><GUARDARCOMO><PUBLICA>'
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function GuardarComo() as void
		if !this.ValidarPK()
			goServicios.Errores.LevantarExcepcion( "Seleccione un registro antes de intentar hacer 'Guardar como...'.")
		else
			With This
				._EsRegistroGuardableComo()
				.lEdicion = .F.
				.lEsGuardarComo = .T.
				.cCodigoPrevioGuardarComo = this.CODIGO
				.lAnular = .F.
				.lNuevo = .T.
				.BLOQUEARREGISTRO = .f.
				if this.DebeSugerirCodigo()
					this.SetearCodigoSugerido()
				endif
				.actualizarEstado()
				.SetearColeccionSentenciasAnterior_NUEVO()
			endwith
		endif
		dodefault()
		This.InicializarComponentes( .T. )
		This.Zadsfw = ''
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		bindevent( This, "Limpiar", this, "SetearValorComboPorDefecto", 1 )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWBasedecalculo()','Basedecalculo')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWAplicacion()','Aplicacion')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'IMPUESTO', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616regimen_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616regimen_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Rg2616regimen_PK = lxVal

		if this.Validar_Rg2616regimen( lxVal, lxValOld )
			if ( this.lHabilitarRg2616regimen_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Rg2616regimen( lxVal )
			else
				this.Rg2616regimen_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg2616regimen)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg1575regimen_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg1575regimen_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Rg1575regimen_PK = lxVal

		if this.Validar_Rg1575regimen( lxVal, lxValOld )
			if ( this.lHabilitarRg1575regimen_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Rg1575regimen( lxVal )
			else
				this.Rg1575regimen_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg1575regimen)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Tipo_PK = lxVal

		if this.Validar_Tipo( lxVal, lxValOld )
			This.Setear_Tipo( lxVal )
			This.Tipo_PK_DespuesDeAsignar()
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Jurisdiccion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Jurisdiccion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 8, padr( lxVal, 8 ), lxVal )
		this.Jurisdiccion_PK = lxVal

		if this.Validar_Jurisdiccion( lxVal, lxValOld )
			if ( this.lHabilitarJurisdiccion_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Jurisdiccion( lxVal )
				This.Jurisdiccion_PK_DespuesDeAsignar()
			else
				this.Jurisdiccion_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Jurisdiccion)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Regimenimpositivo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Regimenimpositivo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Regimenimpositivo_PK = lxVal

		if this.Validar_Regimenimpositivo( lxVal, lxValOld )
			if ( this.lHabilitarRegimenimpositivo_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Regimenimpositivo( lxVal )
			else
				this.Regimenimpositivo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Regimenimpositivo)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616regimen( txVal as variant ) as void

		this.Rg2616regimen.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575regimen( txVal as variant ) as void

		this.Rg1575regimen.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdiccion( txVal as variant ) as void

		this.Jurisdiccion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimenimpositivo( txVal as variant ) as void

		this.Regimenimpositivo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616regimen( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575regimen( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdiccion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimenimpositivo( txVal as variant, txValOld as variant ) as Boolean

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
	function Bloquearregistro_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bloquearregistro
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bloquearregistro( lxVal )
				this.Setear_Bloquearregistro( lxVal )
			EndIf
		Else
			This.Setear_Bloquearregistro( lxVal ) 
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
	function Rg5329aplicaporarticulo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg5329aplicaporarticulo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg5329aplicaporarticulo( lxVal )
				if ( this.lHabilitarRg5329aplicaporarticulo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Rg5329aplicaporarticulo( lxVal )
				else
					this.Rg5329aplicaporarticulo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg5329aplicaporarticulo)" )
				endif 
			EndIf
		Else
			This.Setear_Rg5329aplicaporarticulo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basedecalculo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basedecalculo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basedecalculo( lxVal )
				if ( this.lHabilitarBasedecalculo or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Basedecalculo( lxVal )
				else
					this.Basedecalculo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Basedecalculo)" )
				endif 
			EndIf
		Else
			This.Setear_Basedecalculo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg1575porcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg1575porcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg1575porcentaje( lxVal )
				if ( this.lHabilitarRg1575porcentaje or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg1575porcentaje( lxVal )
				else
					this.Rg1575porcentaje = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg1575porcentaje)" )
				endif 
			EndIf
		Else
			This.Setear_Rg1575porcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajebase_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajebase
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajebase( lxVal )
				if ( this.lHabilitarPorcentajebase or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Porcentajebase( lxVal )
				else
					this.Porcentajebase = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Porcentajebase)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajebase( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616porcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616porcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616porcentaje( lxVal )
				if ( this.lHabilitarRg2616porcentaje or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg2616porcentaje( lxVal )
				else
					this.Rg2616porcentaje = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg2616porcentaje)" )
				endif 
			EndIf
		Else
			This.Setear_Rg2616porcentaje( lxVal ) 
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
	function Rg2616meses_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616meses
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616meses( lxVal )
				if ( this.lHabilitarRg2616meses or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg2616meses( lxVal )
				else
					this.Rg2616meses = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg2616meses)" )
				endif 
			EndIf
		Else
			This.Setear_Rg2616meses( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pagoparcial_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pagoparcial
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Pagoparcial( lxVal )
				if ( this.lHabilitarPagoparcial or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Pagoparcial( lxVal )
				else
					this.Pagoparcial = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Pagoparcial)" )
				endif 
			EndIf
		Else
			This.Setear_Pagoparcial( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg1575basedecalculo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg1575basedecalculo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg1575basedecalculo( lxVal )
				if ( this.lHabilitarRg1575basedecalculo or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Rg1575basedecalculo( lxVal )
				else
					this.Rg1575basedecalculo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg1575basedecalculo)" )
				endif 
			EndIf
		Else
			This.Setear_Rg1575basedecalculo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Aplicacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Aplicacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Aplicacion( lxVal )
				this.Setear_Aplicacion( lxVal )
				 This.Aplicacion_DespuesDeAsignar()
			EndIf
		Else
			This.Setear_Aplicacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg1575montominimoretencion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg1575montominimoretencion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg1575montominimoretencion( lxVal )
				if ( this.lHabilitarRg1575montominimoretencion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg1575montominimoretencion( lxVal )
				else
					this.Rg1575montominimoretencion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg1575montominimoretencion)" )
				endif 
			EndIf
		Else
			This.Setear_Rg1575montominimoretencion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg5329porcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg5329porcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg5329porcentaje( lxVal )
				if ( this.lHabilitarRg5329porcentaje or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg5329porcentaje( lxVal )
				else
					this.Rg5329porcentaje = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg5329porcentaje)" )
				endif 
			EndIf
		Else
			This.Setear_Rg5329porcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616montomaximoservicios_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616montomaximoservicios
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616montomaximoservicios( lxVal )
				if ( this.lHabilitarRg2616montomaximoservicios or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg2616montomaximoservicios( lxVal )
				else
					this.Rg2616montomaximoservicios = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg2616montomaximoservicios)" )
				endif 
			EndIf
		Else
			This.Setear_Rg2616montomaximoservicios( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616montomaximobienes_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616montomaximobienes
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616montomaximobienes( lxVal )
				if ( this.lHabilitarRg2616montomaximobienes or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Rg2616montomaximobienes( lxVal )
				else
					this.Rg2616montomaximobienes = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Rg2616montomaximobienes)" )
				endif 
			EndIf
		Else
			This.Setear_Rg2616montomaximobienes( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Resolucion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Resolucion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Resolucion( lxVal )
				this.Setear_Resolucion( lxVal )
			EndIf
		Else
			This.Setear_Resolucion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escala_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Escala
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Escala( lxVal )
				if ( this.lHabilitarEscala or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Escala( lxVal )
					 This.Escala_DespuesDeAsignar()
				else
					this.Escala = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Escala)" )
				endif 
			EndIf
		Else
			This.Setear_Escala( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iibbmenalicuotanoinscriptos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iibbmenalicuotanoinscriptos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iibbmenalicuotanoinscriptos( lxVal )
				if ( this.lHabilitarIibbmenalicuotanoinscriptos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Iibbmenalicuotanoinscriptos( lxVal )
				else
					this.Iibbmenalicuotanoinscriptos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Iibbmenalicuotanoinscriptos)" )
				endif 
			EndIf
		Else
			This.Setear_Iibbmenalicuotanoinscriptos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Minimo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Minimo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Minimo( lxVal )
				if ( this.lHabilitarMinimo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Minimo( lxVal )
				else
					this.Minimo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Minimo)" )
				endif 
			EndIf
		Else
			This.Setear_Minimo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Monto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Monto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Monto( lxVal )
				if ( this.lHabilitarMonto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Monto( lxVal )
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentaje( lxVal )
				if ( this.lHabilitarPorcentaje or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Porcentaje( lxVal )
				else
					this.Porcentaje = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Porcentaje)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Segunconvenio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Segunconvenio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Segunconvenio( lxVal )
				if ( this.lHabilitarSegunconvenio or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Segunconvenio( lxVal )
					 This.Segunconvenio_DespuesDeAsignar()
				else
					this.Segunconvenio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Segunconvenio)" )
				endif 
			EndIf
		Else
			This.Setear_Segunconvenio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conveniolocal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conveniolocal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conveniolocal( lxVal )
				if ( this.lHabilitarConveniolocal or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Conveniolocal( lxVal )
				else
					this.Conveniolocal = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Conveniolocal)" )
				endif 
			EndIf
		Else
			This.Setear_Conveniolocal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conveniomultilateral_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conveniomultilateral
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conveniomultilateral( lxVal )
				if ( this.lHabilitarConveniomultilateral or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Conveniomultilateral( lxVal )
				else
					this.Conveniomultilateral = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Conveniomultilateral)" )
				endif 
			EndIf
		Else
			This.Setear_Conveniomultilateral( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conveniomultilextranajuris_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conveniomultilextranajuris
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conveniomultilextranajuris( lxVal )
				if ( this.lHabilitarConveniomultilextranajuris or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Conveniomultilextranajuris( lxVal )
				else
					this.Conveniomultilextranajuris = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Conveniomultilextranajuris)" )
				endif 
			EndIf
		Else
			This.Setear_Conveniomultilextranajuris( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Convenionoinscripto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Convenionoinscripto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Convenionoinscripto( lxVal )
				if ( this.lHabilitarConvenionoinscripto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Convenionoinscripto( lxVal )
				else
					this.Convenionoinscripto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Convenionoinscripto)" )
				endif 
			EndIf
		Else
			This.Setear_Convenionoinscripto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iibbtuccoeficientecero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iibbtuccoeficientecero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iibbtuccoeficientecero( lxVal )
				if ( this.lHabilitarIibbtuccoeficientecero or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Iibbtuccoeficientecero( lxVal )
				else
					this.Iibbtuccoeficientecero = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Iibbtuccoeficientecero)" )
				endif 
			EndIf
		Else
			This.Setear_Iibbtuccoeficientecero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iibbtucreduccionalicuota_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iibbtucreduccionalicuota
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iibbtucreduccionalicuota( lxVal )
				if ( this.lHabilitarIibbtucreduccionalicuota or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Iibbtucreduccionalicuota( lxVal )
				else
					this.Iibbtucreduccionalicuota = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Iibbtucreduccionalicuota)" )
				endif 
			EndIf
		Else
			This.Setear_Iibbtucreduccionalicuota( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iibbtucalicuotanoinscriptos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iibbtucalicuotanoinscriptos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iibbtucalicuotanoinscriptos( lxVal )
				if ( this.lHabilitarIibbtucalicuotanoinscriptos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Numericononegativo( lxVal )
					this.Setear_Iibbtucalicuotanoinscriptos( lxVal )
				else
					this.Iibbtucalicuotanoinscriptos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Impuestos - Atributo: Iibbtucalicuotanoinscriptos)" )
				endif 
			EndIf
		Else
			This.Setear_Iibbtucalicuotanoinscriptos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Regimen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Regimen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Regimen( lxVal )
				this.Setear_Regimen( lxVal )
			EndIf
		Else
			This.Setear_Regimen( lxVal ) 
		EndIf
		dodefault( lxVal )

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
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
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
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
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
	function Setear_Tipoagrupamientopublicaciones( txVal as variant ) as void

		this.Tipoagrupamientopublicaciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bloquearregistro( txVal as variant ) as void

		this.Bloquearregistro = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg5329aplicaporarticulo( txVal as variant ) as void

		this.Rg5329aplicaporarticulo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basedecalculo( txVal as variant ) as void

		this.Basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575porcentaje( txVal as variant ) as void

		this.Rg1575porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajebase( txVal as variant ) as void

		this.Porcentajebase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616porcentaje( txVal as variant ) as void

		this.Rg2616porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616meses( txVal as variant ) as void

		this.Rg2616meses = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pagoparcial( txVal as variant ) as void

		this.Pagoparcial = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575basedecalculo( txVal as variant ) as void

		this.Rg1575basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Aplicacion( txVal as variant ) as void

		this.Aplicacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575montominimoretencion( txVal as variant ) as void

		this.Rg1575montominimoretencion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg5329porcentaje( txVal as variant ) as void

		this.Rg5329porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616montomaximoservicios( txVal as variant ) as void

		this.Rg2616montomaximoservicios = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616montomaximobienes( txVal as variant ) as void

		this.Rg2616montomaximobienes = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Resolucion( txVal as variant ) as void

		this.Resolucion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escala( txVal as variant ) as void

		this.Escala = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iibbmenalicuotanoinscriptos( txVal as variant ) as void

		this.Iibbmenalicuotanoinscriptos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimo( txVal as variant ) as void

		this.Minimo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentaje( txVal as variant ) as void

		this.Porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Segunconvenio( txVal as variant ) as void

		this.Segunconvenio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conveniolocal( txVal as variant ) as void

		this.Conveniolocal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conveniomultilateral( txVal as variant ) as void

		this.Conveniomultilateral = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conveniomultilextranajuris( txVal as variant ) as void

		this.Conveniomultilextranajuris = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Convenionoinscripto( txVal as variant ) as void

		this.Convenionoinscripto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iibbtuccoeficientecero( txVal as variant ) as void

		this.Iibbtuccoeficientecero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iibbtucreduccionalicuota( txVal as variant ) as void

		this.Iibbtucreduccionalicuota = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iibbtucalicuotanoinscriptos( txVal as variant ) as void

		this.Iibbtucalicuotanoinscriptos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimen( txVal as variant ) as void

		this.Regimen = txVal
		dodefault( txVal )

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
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

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
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

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
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

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
	function Validar_Tipoagrupamientopublicaciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bloquearregistro( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg5329aplicaporarticulo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajebase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616meses( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pagoparcial( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Aplicacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575montominimoretencion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg5329porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616montomaximoservicios( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616montomaximobienes( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Resolucion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escala( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iibbmenalicuotanoinscriptos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Segunconvenio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conveniolocal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conveniomultilateral( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conveniomultilextranajuris( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Convenionoinscripto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iibbtuccoeficientecero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iibbtucreduccionalicuota( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iibbtucalicuotanoinscriptos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616regimen_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Rg2616regimen ) = 'O' or isnull( this.Rg2616regimen ) )
					this.Rg2616regimen = _Screen.zoo.instanciarentidad( 'Regimenimpositivo' )
					this.Rg2616regimen.lEsSubEntidad = .t.
					this.enlazar( 'Rg2616regimen.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Rg2616regimen.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Rg2616regimen.CODIGO # this.Rg2616regimen_PK
						this.Rg2616regimen.CODIGO = this.Rg2616regimen_PK
					endif
				endif
			endif
		endif
		return this.Rg2616regimen
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg1575regimen_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Rg1575regimen ) = 'O' or isnull( this.Rg1575regimen ) )
					this.Rg1575regimen = _Screen.zoo.instanciarentidad( 'Regimenimpositivo' )
					this.Rg1575regimen.lEsSubEntidad = .t.
					this.enlazar( 'Rg1575regimen.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Rg1575regimen.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Rg1575regimen.CODIGO # this.Rg1575regimen_PK
						this.Rg1575regimen.CODIGO = this.Rg1575regimen_PK
					endif
				endif
			endif
		endif
		return this.Rg1575regimen
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tipo ) = 'O' or isnull( this.Tipo ) )
					this.Tipo = _Screen.zoo.instanciarentidad( 'Tipoimpuesto' )
					this.Tipo.lEsSubEntidad = .t.
					this.enlazar( 'Tipo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tipo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tipo.CODIGO # this.Tipo_PK
						this.Tipo.CODIGO = this.Tipo_PK
					endif
				endif
			endif
		endif
		return this.Tipo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Jurisdiccion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Jurisdiccion ) = 'O' or isnull( this.Jurisdiccion ) )
					this.Jurisdiccion = _Screen.zoo.instanciarentidad( 'Jurisdiccion' )
					this.Jurisdiccion.lEsSubEntidad = .t.
					this.enlazar( 'Jurisdiccion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Jurisdiccion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Jurisdiccion.CODIGO # this.Jurisdiccion_PK
						this.Jurisdiccion.CODIGO = this.Jurisdiccion_PK
					endif
				endif
			endif
		endif
		return this.Jurisdiccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Regimenimpositivo_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Regimenimpositivo ) = 'O' or isnull( this.Regimenimpositivo ) )
					this.Regimenimpositivo = _Screen.zoo.instanciarentidad( 'Regimenimpositivo' )
					this.Regimenimpositivo.lEsSubEntidad = .t.
					this.enlazar( 'Regimenimpositivo.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Regimenimpositivo.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Regimenimpositivo.CODIGO # this.Regimenimpositivo_PK
						this.Regimenimpositivo.CODIGO = this.Regimenimpositivo_PK
					endif
				endif
			endif
		endif
		return this.Regimenimpositivo
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
				.Fechaaltafw = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Horaaltafw = []
				.Horaexpo = []
				.Horaimpo = []
				.Seriealtafw = []
				.Horamodificacionfw = []
				.Versionmodificacionfw = []
				.Zadsfw = []
				.Versionaltafw = []
				.Usuariomodificacionfw = []
				.Seriemodificacionfw = []
				.Usuarioaltafw = []
				.Basededatosmodificacionfw = []
				.Estadotransferencia = []
				.Basededatosaltafw = []
				.Tipoagrupamientopublicaciones = 0
				.Timestamp = 0
				.Bloquearregistro = .F.
				.Codigo = []
				.Observacion = []
				.Escaladetalle.Limpiar()
				.Rg5329aplicaporarticulo = .F.
				.Basedecalculo = []
				.Rg2616regimen_PK = []
				.Rg1575regimen_PK = []
				.Agrupublidetalle.Limpiar()
				.Rg1575porcentaje = 0
				.Porcentajebase = 0
				.Rg2616porcentaje = 0
				.Descripcion = []
				.Rg2616meses = 0
				.Pagoparcial = 0
				.Rg1575basedecalculo = []
				.Aplicacion = []
				.Rg1575montominimoretencion = 0
				.Rg5329porcentaje = 0
				.Rg2616montomaximoservicios = 0
				.Tipo_PK = []
				.Rg2616montomaximobienes = 0
				.Jurisdiccion_PK = []
				.Resolucion = []
				.Regimenimpositivo_PK = []
				.Escala = .F.
				.Iibbmenalicuotanoinscriptos = 0
				.Minimo = 0
				.Monto = 0
				.Porcentaje = 0
				.Segunconvenio = .F.
				.Conveniolocal = 0
				.Conveniomultilateral = 0
				.Conveniomultilextranajuris = 0
				.Convenionoinscripto = 0
				.Iibbtuccoeficientecero = 0
				.Iibbtucreduccionalicuota = 0
				.Iibbtucalicuotanoinscriptos = 0
				.Regimen = []
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
	Function ValorSugeridoObservacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Observacion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg5329aplicaporarticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg5329aplicaporarticulo" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg5329aplicaporarticulo' )
						.Rg5329aplicaporarticulo = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Aplica impuesto por artículo para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBasedecalculo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Basedecalculo" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Basedecalculo' )
						.Basedecalculo = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Base de cálculo para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWBasedecalculo()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWBasedecalculo() as void
		with this
			.Basedecalculo = 'TOT'
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg2616regimen() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg2616regimen" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg2616regimen_PK' )
						.Rg2616regimen_PK = lvValorSugeridoDefinidoPorElUsuario
						.Rg2616regimen.CODIGO = .Rg2616regimen_PK
					endif
				endif
			Catch to loError
				.Rg2616regimen_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Régimen para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg1575regimen() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg1575regimen" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg1575regimen_PK' )
						.Rg1575regimen_PK = lvValorSugeridoDefinidoPorElUsuario
						.Rg1575regimen.CODIGO = .Rg1575regimen_PK
					endif
				endif
			Catch to loError
				.Rg1575regimen_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Régimen para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg1575porcentaje() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg1575porcentaje" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg1575porcentaje' )
						.Rg1575porcentaje = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Porcentaje para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPorcentajebase() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Porcentajebase" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Porcentajebase' )
						.Porcentajebase = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Porcentaje de base para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg2616porcentaje() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg2616porcentaje" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg2616porcentaje' )
						.Rg2616porcentaje = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Porcentaje para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Descripcion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg2616meses() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg2616meses" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg2616meses' )
						.Rg2616meses = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad de meses para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPagoparcial() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Pagoparcial" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Pagoparcial' )
						.Pagoparcial = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pagos parciales para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg1575basedecalculo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg1575basedecalculo" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg1575basedecalculo' )
						.Rg1575basedecalculo = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Base de cálculo para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoAplicacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Aplicacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Aplicacion' )
						.Aplicacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Aplicación para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWAplicacion()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWAplicacion() as void
		with this
			.Aplicacion = 'PRC'
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg1575montominimoretencion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg1575montominimoretencion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg1575montominimoretencion' )
						.Rg1575montominimoretencion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Mínimo no imponible para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg5329porcentaje() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg5329porcentaje" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg5329porcentaje' )
						.Rg5329porcentaje = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Porcentaje alícuota reducida para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg2616montomaximoservicios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg2616montomaximoservicios" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg2616montomaximoservicios' )
						.Rg2616montomaximoservicios = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto máximo por servicios para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Tipo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipo_PK' )
						.Tipo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Tipo.CODIGO = .Tipo_PK
					endif
				endif
			Catch to loError
				.Tipo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo de impuesto para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRg2616montomaximobienes() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Rg2616montomaximobienes" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rg2616montomaximobienes' )
						.Rg2616montomaximobienes = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto máximo por venta para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoJurisdiccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Jurisdiccion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Jurisdiccion_PK' )
						.Jurisdiccion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Jurisdiccion.CODIGO = .Jurisdiccion_PK
					endif
				endif
			Catch to loError
				.Jurisdiccion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Jurisdicción para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoResolucion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Resolucion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Resolucion' )
						.Resolucion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Resolución para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRegimenimpositivo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Regimenimpositivo" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Regimenimpositivo_PK' )
						.Regimenimpositivo_PK = lvValorSugeridoDefinidoPorElUsuario
						.Regimenimpositivo.CODIGO = .Regimenimpositivo_PK
					endif
				endif
			Catch to loError
				.Regimenimpositivo_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Régimen para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEscala() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Escala" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Escala' )
						.Escala = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Según escala para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIibbmenalicuotanoinscriptos() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Iibbmenalicuotanoinscriptos" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Iibbmenalicuotanoinscriptos' )
						.Iibbmenalicuotanoinscriptos = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Alícuota no inscriptos para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMinimo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Minimo" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Minimo' )
						.Minimo = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Mínimo de impuesto para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMonto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Monto" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Monto' )
						.Monto = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Mínimo no imponible para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPorcentaje() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Porcentaje" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Porcentaje' )
						.Porcentaje = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Porcentaje para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSegunconvenio() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Segunconvenio" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Segunconvenio' )
						.Segunconvenio = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Según convenio para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoConveniolocal() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Conveniolocal" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Conveniolocal' )
						.Conveniolocal = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Contribuyente local para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoConveniomultilateral() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Conveniomultilateral" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Conveniomultilateral' )
						.Conveniomultilateral = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Convenio multilateral para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoConveniomultilextranajuris() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Conveniomultilextranajuris" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Conveniomultilextranajuris' )
						.Conveniomultilextranajuris = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Convenio multilateral con sede en extraña jurisdicción para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoConvenionoinscripto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Convenionoinscripto" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Convenionoinscripto' )
						.Convenionoinscripto = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Contribuyente no inscripto para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIibbtuccoeficientecero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Iibbtuccoeficientecero" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Iibbtuccoeficientecero' )
						.Iibbtuccoeficientecero = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Coeficiente igual a cero para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIibbtucreduccionalicuota() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Iibbtucreduccionalicuota" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Iibbtucreduccionalicuota' )
						.Iibbtucreduccionalicuota = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Reducción de alícuota para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIibbtucalicuotanoinscriptos() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPUESTO", "", "Iibbtucalicuotanoinscriptos" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Iibbtucalicuotanoinscriptos' )
						.Iibbtucalicuotanoinscriptos = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Alícuota no inscriptos para la entidad Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function Tipo_PK_DespuesDeAsignar() as void
		This.HabilitarAtributosSegunTipoYAplicacion()                                                       
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Jurisdiccion_PK_DespuesDeAsignar() as void
		This.HabilitarAtributosSegunTipoYAplicacion()                                                       
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Aplicacion_DespuesDeAsignar() as void
		This.HabilitarAtributosSegunTipoYAplicacion()                                                       
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escala_DespuesDeAsignar() as void
		This.HabilitarEscalaoPorcentaje()                                                                   
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Segunconvenio_DespuesDeAsignar() as void
		This.HabilitarConvenioAlicuotasIIBB()                                                               
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		use in select( 'c_IMPUESTO' )
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
	protected function _EsRegistroGuardableComo() as Void
		local lcMotivo as String
		
		lcMotivo = ''
		if !_Screen.Zoo.App.PermiteABM( this.oAd.cTablaPrincipal )
			lcMotivo = ' porque pertenece a una base réplica.'
		endif
		if !empty( lcMotivo )
			goServicios.Errores.LevantarExcepcion( 'El registro de la entidad ' + alltrim( this.cDescripcion ) + ' no puede guardarse como' + lcMotivo )
		endif
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