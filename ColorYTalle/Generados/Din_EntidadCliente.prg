
define class Din_EntidadCLIENTE as entidad of entidad.prg

	cNombre = 'CLIENTE'
	FECHAIMPO = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FechaUltimaModificacion = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	Clasificacion2 = 0
	FechaDeAlta = ctod( '  /  /    ' )
	ZADSFW = []
	ESTADOTRANSFERENCIA = []
	BASEDEDATOSALTAFW = []
	idglobal = []
	DescripcionFW = []
	NombreRecomendante = []
	CodRecomendante = []
	BASEDEDATOSMODIFICACIONFW = []
	VERSIONMODIFICACIONFW = []
	SERIEALTAFW = []
	HORAMODIFICACIONFW = []
	SERIEMODIFICACIONFW = []
	Jurisdiccion = []
	HORAIMPO = []
	HORAEXPO = []
	VERSIONALTAFW = []
	USUARIOALTAFW = []
	HORAALTAFW = []
	USUARIOMODIFICACIONFW = []
	PIN = []
	TIMESTAMP = 0
	IdCentralizador = 0
	TipoInterno = 0
	INACTIVOFW = .F.
	Imagen = []
	Vendedor_PK = []
	Vendedor = null
	cAtributoPK = 'Codigo'
	Codigo = []
	Observacion = []
	CuitPais = []
	PercepcionIngresosBrutos = []
	Calle = []
	ClasificacionSecundaria = []
	Telefono = []
	SituacionFiscal_PK = 0
	SituacionFiscal = null
	RecomendadoPor_PK = []
	RecomendadoPor = null
	Clasificacion_PK = []
	Clasificacion = null
	Transportista_PK = []
	Transportista = null
	OtrasDirecciones = null
	CodNombreFantasia_PK = []
	CodNombreFantasia = null
	ExcluidoPercepcionGanancias = .F.
	ExcluidoPercepcionIVA = .F.
	TipoConvenio = 0
	lHabilitarTipoConvenio = .T.
	TipoDocumento = []
	lHabilitarTipoDocumento = .T.
	ExcluidoOtraPercep = null
	CFI = 0
	Numero = 0
	Movil = []
	SitFiscalUruguay = 0
	ListaDePrecio_PK = []
	ListaDePrecio = null
	lHabilitarListaDePrecio_PK = .T.
	TipoCli_PK = []
	TipoCli = null
	Contacto = null
	VigenciaHastaGan = ctod( '  /  /    ' )
	VigenciaHastaIva = ctod( '  /  /    ' )
	NroIIBB = 0
	lHabilitarNroIIBB = .T.
	CUIT = []
	lHabilitarCUIT = .T.
	NroDocumento = []
	lHabilitarNroDocumento = .T.
	Piso = []
	Fax = []
	Credito = 0
	Percepciones = null
	Sexo = []
	SituacionGanancias = 0
	RUT = []
	lHabilitarRUT = .T.
	CategCli_PK = []
	CategCli = null
	PercepcionIva_PK = []
	PercepcionIva = null
	DescuentoPreferente_PK = []
	DescuentoPreferente = null
	FechaNacimiento = ctod( '  /  /    ' )
	PaginaWeb = []
	Departamento = []
	DolaresAcumulados = 0
	TopeCtaCte = 0
	CodigoSiprib_PK = []
	CodigoSiprib = null
	lHabilitarCodigoSiprib_PK = .T.
	PercepcionGanancias_PK = []
	PercepcionGanancias = null
	PrimerNombre = []
	TopeFacturacion = 0
	SujetoVinculado = .F.
	lHabilitarSujetoVinculado = .T.
	Localidad = []
	EstadoCivil = []
	CondicionDePago_PK = []
	CondicionDePago = null
	SegundoNombre = []
	TasaCeroPorcen = 0
	lHabilitarTasaCeroPorcen = .T.
	CodigoPostal = []
	Hijos = 0
	Apellido = []
	TasaCeroAplica = .F.
	Provincia_PK = []
	Provincia = null
	Nombre = []
	Pais_PK = []
	Pais = null
	EMail = []
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Clientes]
	lEntidadEditable =  .t.
	oDesactivador = null
	lDesactivar = .t.
	lActivar = .t.
	lTieneVendedorComoClaveForanea = .t.
	cAtributoVendedor = 'VENDEDOR_PK'
	lInicializarCodigoSugeridoHabilitado = .t.
	oCompDatosAdicionalesSIPRIB = null
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarTipoConvenio = .T.
		this.lHabilitarTipoDocumento = .T.
		this.lHabilitarListaDePrecio_PK = .T.
		this.lHabilitarNroIIBB = .T.
		this.lHabilitarCUIT = .T.
		this.lHabilitarNroDocumento = .T.
		this.lHabilitarRUT = .T.
		this.lHabilitarCodigoSiprib_PK = .T.
		this.lHabilitarSujetoVinculado = .T.
		this.lHabilitarTasaCeroPorcen = .T.
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
								goServicios.Errores.LevantarExcepcion( 'Caracter inv�lido en el c�digo.' )
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
								goServicios.Errores.LevantarExcepcion( 'El c�digo ' + alltrim( transform( txVal ) ) + ' ya existe.' )
						endcase
					endif
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oAD_Access() as variant
		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )
			this.oAD = this.crearobjeto( 'Din_EntidadCLIENTEAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Otrasdirecciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.Otrasdirecciones ) = 'O' or isnull( this.Otrasdirecciones ) )
			this.Otrasdirecciones = this.crearobjeto( 'DetalleClienteOtrasdirecciones' )
			this.Otrasdirecciones.inicializar()
			this.enlazar( 'Otrasdirecciones.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Otrasdirecciones.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Otrasdirecciones, 'CambioSumarizado', this, 'CambiosDetalleOtrasdirecciones', 1) 
			this.enlazar( 'Otrasdirecciones.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Otrasdirecciones.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Otrasdirecciones.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Otrasdirecciones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Excluidootrapercep_Access() as variant
		if !this.ldestroy and ( !vartype( this.Excluidootrapercep ) = 'O' or isnull( this.Excluidootrapercep ) )
			this.Excluidootrapercep = this.crearobjeto( 'Din_DetalleClienteExcluidootrapercep' )
			this.Excluidootrapercep.inicializar()
			this.enlazar( 'Excluidootrapercep.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Excluidootrapercep.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Excluidootrapercep, 'CambioSumarizado', this, 'CambiosDetalleExcluidootrapercep', 1) 
			this.enlazar( 'Excluidootrapercep.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Excluidootrapercep.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Excluidootrapercep.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Excluidootrapercep
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Contacto_Access() as variant
		if !this.ldestroy and ( !vartype( this.Contacto ) = 'O' or isnull( this.Contacto ) )
			this.Contacto = this.crearobjeto( 'Din_DetalleClienteContacto' )
			this.Contacto.inicializar()
			this.enlazar( 'Contacto.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Contacto.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Contacto, 'CambioSumarizado', this, 'CambiosDetalleContacto', 1) 
			this.enlazar( 'Contacto.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Contacto.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Contacto.lVerificarLimitesEnDisenoImpresion = .t.
		endif
		return this.Contacto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.Percepciones ) = 'O' or isnull( this.Percepciones ) )
			this.Percepciones = this.crearobjeto( 'DetalleClientePercepciones' )
			this.Percepciones.inicializar()
			this.enlazar( 'Percepciones.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'Percepciones.EventoObtenerInformacion', 'inyectarInformacion' )
			bindevent( this.Percepciones, 'CambioSumarizado', this, 'CambiosDetallePercepciones', 1) 
			this.enlazar( 'Percepciones.EventoAdvertirLimitePorDiseno', 'EventoAdvertirLimitePorDiseno') 
			this.enlazar( 'Percepciones.EventoCancelarCargaLimitePorDiseno', 'EventoCancelarCargaLimitePorDiseno') 
			this.Percepciones.lVerificarLimitesEnDisenoImpresion = .t.
				this.Percepciones.lHabilitaInsertarDetalle = .t.
		endif
		return this.Percepciones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
		this.OtrasDirecciones.oItem.lNuevo = this.lNuevo
		this.ExcluidoOtraPercep.oItem.lNuevo = this.lNuevo
		this.Contacto.oItem.lNuevo = this.lNuevo
		this.Percepciones.oItem.lNuevo = this.lNuevo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
		this.OtrasDirecciones.oItem.lEdicion = this.lEdicion
		this.ExcluidoOtraPercep.oItem.lEdicion = this.lEdicion
		this.Contacto.oItem.lEdicion = this.lEdicion
		this.Percepciones.oItem.lEdicion = this.lEdicion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleOtrasdirecciones() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleExcluidootrapercep() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetalleContacto() as void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CambiosDetallePercepciones() as void
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
		 
		if ( vartype( this.FechaUltimaModificacion) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAULTIMAMODIFICACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
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
		 
		if ( vartype( this.Clasificacion2) = 'N' )
			lnLargoEntero  = len( transform( int( this.CLASIFICACION2 ) ) ) 
			lnValorDelDecimal = this.CLASIFICACION2 - int( this.CLASIFICACION2)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo CLASIFICACION2 es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CLASIFICACION2 no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaDeAlta) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHADEALTA no es el correcto.')
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
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.idglobal) = 'C' )
			if len( alltrim( this.IDGLOBAL ) ) > 38
				This.AgregarInformacion( 'La longitud del valor del atributo IDGLOBAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IDGLOBAL no es el correcto.')
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
		 
		if ( vartype( this.NombreRecomendante) = 'C' )
			if len( alltrim( this.NOMBRERECOMENDANTE ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo NOMBRERECOMENDANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NOMBRERECOMENDANTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CodRecomendante) = 'C' )
			if len( alltrim( this.CODRECOMENDANTE ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo CODRECOMENDANTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODRECOMENDANTE no es el correcto.')
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
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
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
		 
		if ( vartype( this.Jurisdiccion) = 'C' )
			if len( alltrim( this.JURISDICCION ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo JURISDICCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo JURISDICCION no es el correcto.')
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
		 
		if ( vartype( this.PIN) = 'C' )
			if len( alltrim( this.PIN ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo PIN es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PIN no es el correcto.')
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
		 
		if ( vartype( this.IdCentralizador) = 'N' )
			lnLargoEntero  = len( transform( int( this.IDCENTRALIZADOR ) ) ) 
			lnValorDelDecimal = this.IDCENTRALIZADOR - int( this.IDCENTRALIZADOR)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 10
				This.AgregarInformacion( 'La longitud entera del valor del atributo IDCENTRALIZADOR es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IDCENTRALIZADOR no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoInterno) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOINTERNO ) ) ) 
			lnValorDelDecimal = this.TIPOINTERNO - int( this.TIPOINTERNO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOINTERNO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOINTERNO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.INACTIVOFW) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo INACTIVOFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Imagen) = 'C' )
			if len( alltrim( this.IMAGEN ) ) > 180
				This.AgregarInformacion( 'La longitud del valor del atributo IMAGEN es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IMAGEN no es el correcto.')
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
		 
		if ( vartype( this.CuitPais) = 'C' )
			if len( alltrim( this.CUITPAIS ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo CUITPAIS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUITPAIS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PercepcionIngresosBrutos) = 'C' )
			if len( alltrim( this.PERCEPCIONINGRESOSBRUTOS ) ) > 1
				This.AgregarInformacion( 'La longitud del valor del atributo PERCEPCIONINGRESOSBRUTOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PERCEPCIONINGRESOSBRUTOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Calle) = 'C' )
			if len( alltrim( this.CALLE ) ) > 250
				This.AgregarInformacion( 'La longitud del valor del atributo CALLE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CALLE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ClasificacionSecundaria) = 'C' )
			if len( alltrim( this.CLASIFICACIONSECUNDARIA ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo CLASIFICACIONSECUNDARIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CLASIFICACIONSECUNDARIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Telefono) = 'C' )
			if len( alltrim( this.TELEFONO ) ) > 30
				This.AgregarInformacion( 'La longitud del valor del atributo TELEFONO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TELEFONO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ExcluidoPercepcionGanancias) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo EXCLUIDOPERCEPCIONGANANCIAS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ExcluidoPercepcionIVA) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo EXCLUIDOPERCEPCIONIVA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoConvenio) = 'N' )
			lnLargoEntero  = len( transform( int( this.TIPOCONVENIO ) ) ) 
			lnValorDelDecimal = this.TIPOCONVENIO - int( this.TIPOCONVENIO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo TIPOCONVENIO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPOCONVENIO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TipoDocumento) = 'C' )
			if len( alltrim( this.TIPODOCUMENTO ) ) > 2
				This.AgregarInformacion( 'La longitud del valor del atributo TIPODOCUMENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TIPODOCUMENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CFI) = 'N' )
			lnLargoEntero  = len( transform( int( this.CFI ) ) ) 
			lnValorDelDecimal = this.CFI - int( this.CFI)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo CFI es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CFI no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Numero) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO ) ) ) 
			lnValorDelDecimal = this.NUMERO - int( this.NUMERO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 5
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Movil) = 'C' )
			if len( alltrim( this.MOVIL ) ) > 30
				This.AgregarInformacion( 'La longitud del valor del atributo MOVIL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo MOVIL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SitFiscalUruguay) = 'N' )
			lnLargoEntero  = len( transform( int( this.SITFISCALURUGUAY ) ) ) 
			lnValorDelDecimal = this.SITFISCALURUGUAY - int( this.SITFISCALURUGUAY)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo SITFISCALURUGUAY es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SITFISCALURUGUAY no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VigenciaHastaGan) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VIGENCIAHASTAGAN no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VigenciaHastaIva) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VIGENCIAHASTAIVA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NroIIBB) = 'N' )
			lnLargoEntero  = len( transform( int( this.NROIIBB ) ) ) 
			lnValorDelDecimal = this.NROIIBB - int( this.NROIIBB)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 11
				This.AgregarInformacion( 'La longitud entera del valor del atributo NROIIBB es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NROIIBB no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CUIT) = 'C' )
			if len( alltrim( this.CUIT ) ) > 15
				This.AgregarInformacion( 'La longitud del valor del atributo CUIT es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CUIT no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.NroDocumento) = 'C' )
			if len( alltrim( this.NRODOCUMENTO ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo NRODOCUMENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NRODOCUMENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Piso) = 'C' )
			if len( alltrim( this.PISO ) ) > 3
				This.AgregarInformacion( 'La longitud del valor del atributo PISO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PISO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Fax) = 'C' )
			if len( alltrim( this.FAX ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo FAX es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FAX no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Credito) = 'N' )
			lnLargoEntero  = len( transform( int( this.CREDITO ) ) ) 
			lnValorDelDecimal = this.CREDITO - int( this.CREDITO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo CREDITO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CREDITO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Sexo) = 'C' )
			if len( alltrim( this.SEXO ) ) > 10
				This.AgregarInformacion( 'La longitud del valor del atributo SEXO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SEXO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SituacionGanancias) = 'N' )
			lnLargoEntero  = len( transform( int( this.SITUACIONGANANCIAS ) ) ) 
			lnValorDelDecimal = this.SITUACIONGANANCIAS - int( this.SITUACIONGANANCIAS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 1
				This.AgregarInformacion( 'La longitud entera del valor del atributo SITUACIONGANANCIAS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SITUACIONGANANCIAS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.RUT) = 'C' )
			if len( alltrim( this.RUT ) ) > 12
				This.AgregarInformacion( 'La longitud del valor del atributo RUT es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo RUT no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FechaNacimiento) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHANACIMIENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PaginaWeb) = 'C' )
			if len( alltrim( this.PAGINAWEB ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo PAGINAWEB es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PAGINAWEB no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Departamento) = 'C' )
			if len( alltrim( this.DEPARTAMENTO ) ) > 3
				This.AgregarInformacion( 'La longitud del valor del atributo DEPARTAMENTO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DEPARTAMENTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.DolaresAcumulados) = 'N' )
			lnLargoEntero  = len( transform( int( this.DOLARESACUMULADOS ) ) ) 
			lnValorDelDecimal = this.DOLARESACUMULADOS - int( this.DOLARESACUMULADOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo DOLARESACUMULADOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DOLARESACUMULADOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TopeCtaCte) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOPECTACTE ) ) ) 
			lnValorDelDecimal = this.TOPECTACTE - int( this.TOPECTACTE)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOPECTACTE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOPECTACTE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.PrimerNombre) = 'C' )
			if len( alltrim( this.PRIMERNOMBRE ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo PRIMERNOMBRE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo PRIMERNOMBRE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TopeFacturacion) = 'N' )
			lnLargoEntero  = len( transform( int( this.TOPEFACTURACION ) ) ) 
			lnValorDelDecimal = this.TOPEFACTURACION - int( this.TOPEFACTURACION)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 13
				This.AgregarInformacion( 'La longitud entera del valor del atributo TOPEFACTURACION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TOPEFACTURACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SujetoVinculado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SUJETOVINCULADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Localidad) = 'C' )
			if len( alltrim( this.LOCALIDAD ) ) > 70
				This.AgregarInformacion( 'La longitud del valor del atributo LOCALIDAD es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo LOCALIDAD no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoCivil) = 'C' )
			if len( alltrim( this.ESTADOCIVIL ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOCIVIL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOCIVIL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SegundoNombre) = 'C' )
			if len( alltrim( this.SEGUNDONOMBRE ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo SEGUNDONOMBRE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SEGUNDONOMBRE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TasaCeroPorcen) = 'N' )
			lnLargoEntero  = len( transform( int( this.TASACEROPORCEN ) ) ) 
			lnValorDelDecimal = this.TASACEROPORCEN - int( this.TASACEROPORCEN)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 4
				This.AgregarInformacion( 'La longitud entera del valor del atributo TASACEROPORCEN es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TASACEROPORCEN no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.CodigoPostal) = 'C' )
			if len( alltrim( this.CODIGOPOSTAL ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo CODIGOPOSTAL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo CODIGOPOSTAL no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Hijos) = 'N' )
			lnLargoEntero  = len( transform( int( this.HIJOS ) ) ) 
			lnValorDelDecimal = this.HIJOS - int( this.HIJOS)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 2
				This.AgregarInformacion( 'La longitud entera del valor del atributo HIJOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HIJOS no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Apellido) = 'C' )
			if len( alltrim( this.APELLIDO ) ) > 60
				This.AgregarInformacion( 'La longitud del valor del atributo APELLIDO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo APELLIDO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.TasaCeroAplica) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo TASACEROAPLICA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Nombre) = 'C' )
			if len( alltrim( this.NOMBRE ) ) > 185
				This.AgregarInformacion( 'La longitud del valor del atributo NOMBRE es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NOMBRE no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EMail) = 'C' )
			if len( alltrim( this.EMAIL ) ) > 250
				This.AgregarInformacion( 'La longitud del valor del atributo EMAIL es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo EMAIL no es el correcto.')
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
		llVotacion = llVotacion and this.oCompDatosAdicionalesSIPRIB.votarCambioEstadoNUEVO( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoELIMINAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompDatosAdicionalesSIPRIB.votarCambioEstadoELIMINAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoMODIFICAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompDatosAdicionalesSIPRIB.votarCambioEstadoMODIFICAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoCANCELAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompDatosAdicionalesSIPRIB.votarCambioEstadoCANCELAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VotacionCambioEstadoGRABAR( tcEstado as string ) as Boolean
		*!*Se ejecuta antes de hacer el cambio de estado
		local llVotacion as boolean
		llVotacion = dodefault()
		llVotacion = llVotacion and this.oCompDatosAdicionalesSIPRIB.votarCambioEstadoGRABAR( tcEstado )
		return llVotacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarVendedor() and llRetorno
			llRetorno = .ValidarSituacionfiscal() and llRetorno
			llRetorno = .ValidarRecomendadopor() and llRetorno
			llRetorno = .ValidarClasificacion() and llRetorno
			llRetorno = .ValidarTransportista() and llRetorno
			llRetorno = .ValidarCodnombrefantasia() and llRetorno
			llRetorno = .ValidarListadeprecio() and llRetorno
			llRetorno = .ValidarTipocli() and llRetorno
			llRetorno = .ValidarCategcli() and llRetorno
			llRetorno = .ValidarPercepcioniva() and llRetorno
			llRetorno = .ValidarDescuentopreferente() and llRetorno
			llRetorno = .ValidarCodigosiprib() and llRetorno
			llRetorno = .ValidarPercepcionganancias() and llRetorno
			llRetorno = .ValidarCondiciondepago() and llRetorno
			llRetorno = .ValidarProvincia() and llRetorno
			llRetorno = .ValidarNombre() and llRetorno
			llRetorno = .ValidarPais() and llRetorno
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
			This.AgregarInformacion( 'No se puede grabar. C�digo Vac�o', 0 )
		Endif
		if This.ValidarIngreso( transform( this.CODIGO ) )
		else
			llRetorno = .F.
			this.AgregarInformacion( 'Caracteres Inv�lidos en el c�digo', 0 )
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
		llRetorno = This.ValidarUnDetalle( this.OtrasDirecciones, 'Otras direcciones' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.ExcluidoOtraPercep, 'Impuestos excluidos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.Contacto, 'Contactos' ) and llRetorno
		llRetorno = This.ValidarUnDetalle( this.Percepciones, 'Percepciones' ) and llRetorno
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

		this.oCompDatosAdicionalesSIPRIB.lNuevo = this.lNuevo
		this.oCompDatosAdicionalesSIPRIB.lEdicion = this.lEdicion
		this.oCompDatosAdicionalesSIPRIB.lEliminar = this.lEliminar

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarNombre() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Nombre )
			this.AgregarInformacion( 'Debe cargar el campo Denominaci�n o raz�n social', 9005, 'Nombre' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarVendedor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Vendedor_PK )
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
	function ValidarSituacionFiscal() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.SituacionFiscal_PK )
		else
			If this.SituacionFiscal.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.SituacionFiscal_PK ))+ ' de la entidad ' +  upper( this.SituacionFiscal.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarRecomendadoPor() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.RecomendadoPor_PK )
		else
			If this.RecomendadoPor.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.RecomendadoPor_PK ))+ ' de la entidad ' +  upper( this.RecomendadoPor.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarClasificacion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Clasificacion_PK )
		else
			If this.Clasificacion.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Clasificacion_PK ))+ ' de la entidad ' +  upper( this.Clasificacion.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTransportista() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Transportista_PK )
		else
			If this.Transportista.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Transportista_PK ))+ ' de la entidad ' +  upper( this.Transportista.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCodNombreFantasia() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CodNombreFantasia_PK )
		else
			If this.CodNombreFantasia.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CodNombreFantasia_PK ))+ ' de la entidad ' +  upper( this.CodNombreFantasia.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarListaDePrecio() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.ListaDePrecio_PK )
		else
			If this.ListaDePrecio.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.ListaDePrecio_PK ))+ ' de la entidad ' +  upper( this.ListaDePrecio.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarTipoCli() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.TipoCli_PK )
		else
			If this.TipoCli.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.TipoCli_PK ))+ ' de la entidad ' +  upper( this.TipoCli.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCategCli() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CategCli_PK )
		else
			If this.CategCli.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CategCli_PK ))+ ' de la entidad ' +  upper( this.CategCli.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPercepcionIva() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PercepcionIva_PK )
		else
			If this.PercepcionIva.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PercepcionIva_PK ))+ ' de la entidad ' +  upper( this.PercepcionIva.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDescuentoPreferente() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.DescuentoPreferente_PK )
		else
			If this.DescuentoPreferente.oAD.ConsultarPorClavePrimaria()
				This.DescuentoPreferente.oDesactivador.ValidarEstadoActivacion( this.DescuentoPreferente_PK , goLibrerias.Valorvacioseguntipo( vartype(this.DescuentoPreferente_PK ) ), this.lnuevo, this.ledicion )
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.DescuentoPreferente_PK ))+ ' de la entidad ' +  upper( this.DescuentoPreferente.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCodigoSiprib() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CodigoSiprib_PK )
		else
			If this.CodigoSiprib.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CodigoSiprib_PK ))+ ' de la entidad ' +  upper( this.CodigoSiprib.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPercepcionGanancias() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PercepcionGanancias_PK )
		else
			If this.PercepcionGanancias.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PercepcionGanancias_PK ))+ ' de la entidad ' +  upper( this.PercepcionGanancias.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarCondicionDePago() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.CondicionDePago_PK )
		else
			If this.CondicionDePago.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.CondicionDePago_PK ))+ ' de la entidad ' +  upper( this.CondicionDePago.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarProvincia() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Provincia_PK )
		else
			If this.Provincia.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Provincia_PK ))+ ' de la entidad ' +  upper( this.Provincia.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPais() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Pais_PK )
		else
			If this.Pais.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Pais_PK ))+ ' de la entidad ' +  upper( this.Pais.cDescripcion ) + ' no existe.')
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
							This.oMensaje.Advertir( 'Se ha producido una excepci�n no controlada durante el proceso posterior a la grabaci�n.Verifique el log de errores para mas detalles.')
						Finally
							.InformarWebHook()
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
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'CODIGO' )
		loAtributosObligatorios.add( 'NOMBRE' )
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
		this.oCompDatosAdicionalesSIPRIB.SetearColeccionSentenciasAnterior_NUEVO()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
		this.oCompDatosAdicionalesSIPRIB.SetearColeccionSentenciasAnterior_MODIFICAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
		this.oCompDatosAdicionalesSIPRIB.SetearColeccionSentenciasAnterior_ANULAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
		this.oCompDatosAdicionalesSIPRIB.SetearColeccionSentenciasAnterior_ELIMINAR()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<AUDITORIA<MODULOSLISTADO:PQDHJ><LINCE><CODIGOSUGERIDO:.T.><WEBHOOK><IMPOGENERICA><EXPOGENERICA><TRANSFERALTAS><LISTARTODOSSUSATRIBUTOS><BAJALOGICA><DESACTIVABLE><BUSCAENALTAS>'
	Endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWClasificacion2()','Clasificacion2')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechadealta()','Fechadealta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipointerno()','Tipointerno')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSituacionfiscal()','Situacionfiscal')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWTipodocumento()','Tipodocumento')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWSitfiscaluruguay()','Sitfiscaluruguay')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CLIENTE', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
		this.lWHIngresar = goServicios.WebHook.TieneQueMandar( 'CLIENTE', 'INGRESAR' )
		this.lWHModificar = goServicios.WebHook.TieneQueMandar( 'CLIENTE', 'MODIFICAR' )
		this.lWHEliminar = goServicios.WebHook.TieneQueMandar( 'CLIENTE', 'ELIMINAR' )
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
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Situacionfiscal_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Situacionfiscal_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Situacionfiscal_PK = lxVal

		if this.Validar_Situacionfiscal( lxVal, lxValOld )
			This.Setear_Situacionfiscal( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recomendadopor_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Recomendadopor_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Recomendadopor.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Recomendadopor )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Recomendadopor_PK = lxVal

		if this.Validar_Recomendadopor( lxVal, lxValOld )
			This.Setear_Recomendadopor( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clasificacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clasificacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Clasificacion_PK = lxVal

		if this.Validar_Clasificacion( lxVal, lxValOld )
			This.Setear_Clasificacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Transportista_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Transportista_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Transportista.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Transportista )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 15, padr( lxVal, 15 ), lxVal )
		this.Transportista_PK = lxVal

		if this.Validar_Transportista( lxVal, lxValOld )
			This.Setear_Transportista( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codnombrefantasia_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codnombrefantasia_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 50, padr( lxVal, 50 ), lxVal )
		this.Codnombrefantasia_PK = lxVal

		if this.Validar_Codnombrefantasia( lxVal, lxValOld )
			This.Setear_Codnombrefantasia( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadeprecio_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Listadeprecio_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 6, padr( lxVal, 6 ), lxVal )
		this.Listadeprecio_PK = lxVal

		if this.Validar_Listadeprecio( lxVal, lxValOld )
			if ( this.lHabilitarListadeprecio_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Listadeprecio( lxVal )
			else
				this.Listadeprecio_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Listadeprecio)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipocli_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipocli_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Tipocli_PK = lxVal

		if this.Validar_Tipocli( lxVal, lxValOld )
			This.Setear_Tipocli( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Categcli_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Categcli_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Categcli_PK = lxVal

		if this.Validar_Categcli( lxVal, lxValOld )
			This.Setear_Categcli( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcioniva_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Percepcioniva_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Percepcioniva_PK = lxVal

		if this.Validar_Percepcioniva( lxVal, lxValOld )
			This.Setear_Percepcioniva( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentopreferente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuentopreferente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Descuentopreferente_PK = lxVal

		if this.Validar_Descuentopreferente( lxVal, lxValOld )
			This.Setear_Descuentopreferente( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigosiprib_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigosiprib_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Codigosiprib.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Codigosiprib )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Codigosiprib_PK = lxVal

		if this.Validar_Codigosiprib( lxVal, lxValOld )
			if ( this.lHabilitarCodigosiprib_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				This.Setear_Codigosiprib( lxVal )
			else
				this.Codigosiprib_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Codigosiprib)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcionganancias_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Percepcionganancias_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Percepcionganancias_PK = lxVal

		if this.Validar_Percepcionganancias( lxVal, lxValOld )
			This.Setear_Percepcionganancias( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Condiciondepago_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Condiciondepago_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Condiciondepago_PK = lxVal

		if this.Validar_Condiciondepago( lxVal, lxValOld )
			This.Setear_Condiciondepago( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Provincia_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Provincia_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 2, padr( lxVal, 2 ), lxVal )
		this.Provincia_PK = lxVal

		if this.Validar_Provincia( lxVal, lxValOld )
			This.Setear_Provincia( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pais_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pais_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )
		this.Pais_PK = lxVal

		if this.Validar_Pais( lxVal, lxValOld )
			This.Setear_Pais( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Situacionfiscal( txVal as variant ) as void

		this.Situacionfiscal.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Recomendadopor( txVal as variant ) as void

		this.Recomendadopor.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clasificacion( txVal as variant ) as void

		this.Clasificacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Transportista( txVal as variant ) as void

		this.Transportista.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codnombrefantasia( txVal as variant ) as void

		this.Codnombrefantasia.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Listadeprecio( txVal as variant ) as void

		this.Listadeprecio.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocli( txVal as variant ) as void

		this.Tipocli.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Categcli( txVal as variant ) as void

		this.Categcli.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepcioniva( txVal as variant ) as void

		this.Percepcioniva.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuentopreferente( txVal as variant ) as void

		this.Descuentopreferente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigosiprib( txVal as variant ) as void

		this.Codigosiprib.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepcionganancias( txVal as variant ) as void

		this.Percepcionganancias.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Condiciondepago( txVal as variant ) as void

		this.Condiciondepago.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Provincia( txVal as variant ) as void

		this.Provincia.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pais( txVal as variant ) as void

		this.Pais.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Vendedor.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Situacionfiscal( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Recomendadopor( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clasificacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Transportista( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codnombrefantasia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Listadeprecio( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocli( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Categcli( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepcioniva( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuentopreferente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Descuentopreferente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigosiprib( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepcionganancias( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Condiciondepago( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Provincia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pais( txVal as variant, txValOld as variant ) as Boolean

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
	function Fechaultimamodificacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaultimamodificacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaultimamodificacion( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaultimamodificacion( lxVal )
			EndIf
		Else
			This.Setear_Fechaultimamodificacion( lxVal ) 
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
	function Clasificacion2_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clasificacion2
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clasificacion2( lxVal )
				this.Setear_Clasificacion2( lxVal )
			EndIf
		Else
			This.Setear_Clasificacion2( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadealta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadealta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadealta( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.Setear_Fechadealta( lxVal )
			EndIf
		Else
			This.Setear_Fechadealta( lxVal ) 
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
	function Idglobal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idglobal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idglobal( lxVal )
				this.Setear_Idglobal( lxVal )
			EndIf
		Else
			This.Setear_Idglobal( lxVal ) 
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
	function Nombrerecomendante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nombrerecomendante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nombrerecomendante( lxVal )
				this.Setear_Nombrerecomendante( lxVal )
			EndIf
		Else
			This.Setear_Nombrerecomendante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codrecomendante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codrecomendante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codrecomendante( lxVal )
				this.Setear_Codrecomendante( lxVal )
			EndIf
		Else
			This.Setear_Codrecomendante( lxVal ) 
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
	function Jurisdiccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Jurisdiccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Jurisdiccion( lxVal )
				this.Setear_Jurisdiccion( lxVal )
			EndIf
		Else
			This.Setear_Jurisdiccion( lxVal ) 
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
	function Pin_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pin
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Pin( lxVal )
				this.Setear_Pin( lxVal )
			EndIf
		Else
			This.Setear_Pin( lxVal ) 
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
	function Idcentralizador_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idcentralizador
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idcentralizador( lxVal )
				this.Setear_Idcentralizador( lxVal )
			EndIf
		Else
			This.Setear_Idcentralizador( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipointerno( lxVal )
				this.Setear_Tipointerno( lxVal )
			EndIf
		Else
			This.Setear_Tipointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inactivofw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Inactivofw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Inactivofw( lxVal )
				this.Setear_Inactivofw( lxVal )
			EndIf
		Else
			This.Setear_Inactivofw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Imagen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Imagen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Imagen( lxVal )
				this.Setear_Imagen( lxVal )
			EndIf
		Else
			This.Setear_Imagen( lxVal ) 
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
	function Cuitpais_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuitpais
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuitpais( lxVal )
				this.Setear_Cuitpais( lxVal )
			EndIf
		Else
			This.Setear_Cuitpais( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcioningresosbrutos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Percepcioningresosbrutos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Percepcioningresosbrutos( lxVal )
				this.Setear_Percepcioningresosbrutos( lxVal )
			EndIf
		Else
			This.Setear_Percepcioningresosbrutos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Calle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Calle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Calle( lxVal )
				this.Setear_Calle( lxVal )
			EndIf
		Else
			This.Setear_Calle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clasificacionsecundaria_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clasificacionsecundaria
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clasificacionsecundaria( lxVal )
				this.Setear_Clasificacionsecundaria( lxVal )
			EndIf
		Else
			This.Setear_Clasificacionsecundaria( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Telefono_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Telefono
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Telefono( lxVal )
				this.Setear_Telefono( lxVal )
			EndIf
		Else
			This.Setear_Telefono( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Excluidopercepcionganancias_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Excluidopercepcionganancias
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Excluidopercepcionganancias( lxVal )
				this.Setear_Excluidopercepcionganancias( lxVal )
			EndIf
		Else
			This.Setear_Excluidopercepcionganancias( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Excluidopercepcioniva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Excluidopercepcioniva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Excluidopercepcioniva( lxVal )
				this.Setear_Excluidopercepcioniva( lxVal )
			EndIf
		Else
			This.Setear_Excluidopercepcioniva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipoconvenio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipoconvenio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipoconvenio( lxVal )
				if ( this.lHabilitarTipoconvenio or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Tipoconvenio( lxVal )
				else
					this.Tipoconvenio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Tipoconvenio)" )
				endif 
			EndIf
		Else
			This.Setear_Tipoconvenio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodocumento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodocumento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodocumento( lxVal )
				if ( this.lHabilitarTipodocumento or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Tipodocumento( lxVal )
				else
					this.Tipodocumento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Tipodocumento)" )
				endif 
			EndIf
		Else
			This.Setear_Tipodocumento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cfi_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cfi
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cfi( lxVal )
				this.Setear_Cfi( lxVal )
			EndIf
		Else
			This.Setear_Cfi( lxVal ) 
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
	function Movil_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Movil
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Movil( lxVal )
				this.Setear_Movil( lxVal )
			EndIf
		Else
			This.Setear_Movil( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sitfiscaluruguay_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Sitfiscaluruguay
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Sitfiscaluruguay( lxVal )
				this.Setear_Sitfiscaluruguay( lxVal )
			EndIf
		Else
			This.Setear_Sitfiscaluruguay( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vigenciahastagan_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vigenciahastagan
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vigenciahastagan( lxVal )
				this.Setear_Vigenciahastagan( lxVal )
			EndIf
		Else
			This.Setear_Vigenciahastagan( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vigenciahastaiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vigenciahastaiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vigenciahastaiva( lxVal )
				this.Setear_Vigenciahastaiva( lxVal )
			EndIf
		Else
			This.Setear_Vigenciahastaiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nroiibb_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nroiibb
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nroiibb( lxVal )
				if ( this.lHabilitarNroiibb or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Nroiibb( lxVal )
				else
					this.Nroiibb = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Nroiibb)" )
				endif 
			EndIf
		Else
			This.Setear_Nroiibb( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuit_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuit
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuit( lxVal )
				if ( this.lHabilitarCuit or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Cuit( lxVal )
					 This.Cuit_DespuesDeAsignar()
				else
					this.Cuit = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Cuit)" )
				endif 
			EndIf
		Else
			This.Setear_Cuit( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nrodocumento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nrodocumento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nrodocumento( lxVal )
				if ( this.lHabilitarNrodocumento or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Nrodocumento( lxVal )
				else
					this.Nrodocumento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Nrodocumento)" )
				endif 
			EndIf
		Else
			This.Setear_Nrodocumento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Piso_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Piso
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Piso( lxVal )
				this.Setear_Piso( lxVal )
			EndIf
		Else
			This.Setear_Piso( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fax_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fax
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fax( lxVal )
				this.Setear_Fax( lxVal )
			EndIf
		Else
			This.Setear_Fax( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Credito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Credito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Credito( lxVal )
				this.Setear_Credito( lxVal )
			EndIf
		Else
			This.Setear_Credito( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sexo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Sexo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Sexo( lxVal )
				this.Setear_Sexo( lxVal )
			EndIf
		Else
			This.Setear_Sexo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Situacionganancias_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Situacionganancias
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Situacionganancias( lxVal )
				this.Setear_Situacionganancias( lxVal )
			EndIf
		Else
			This.Setear_Situacionganancias( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rut_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rut
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rut( lxVal )
				if ( this.lHabilitarRut or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.Setear_Rut( lxVal )
				else
					this.Rut = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Rut)" )
				endif 
			EndIf
		Else
			This.Setear_Rut( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechanacimiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechanacimiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechanacimiento( lxVal )
				this.ValidarDominio_Fechalargacalendario( lxVal )
				this.Setear_Fechanacimiento( lxVal )
			EndIf
		Else
			This.Setear_Fechanacimiento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Paginaweb_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Paginaweb
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Paginaweb( lxVal )
				this.Setear_Paginaweb( lxVal )
			EndIf
		Else
			This.Setear_Paginaweb( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Departamento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Departamento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Departamento( lxVal )
				this.Setear_Departamento( lxVal )
			EndIf
		Else
			This.Setear_Departamento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Dolaresacumulados_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Dolaresacumulados
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Dolaresacumulados( lxVal )
				this.Setear_Dolaresacumulados( lxVal )
			EndIf
		Else
			This.Setear_Dolaresacumulados( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Topectacte_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Topectacte
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Topectacte( lxVal )
				this.Setear_Topectacte( lxVal )
			EndIf
		Else
			This.Setear_Topectacte( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Primernombre_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Primernombre
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Primernombre( lxVal )
				this.Setear_Primernombre( lxVal )
			EndIf
		Else
			This.Setear_Primernombre( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Topefacturacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Topefacturacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Topefacturacion( lxVal )
				this.Setear_Topefacturacion( lxVal )
			EndIf
		Else
			This.Setear_Topefacturacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Sujetovinculado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Sujetovinculado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Sujetovinculado( lxVal )
				if ( this.lHabilitarSujetovinculado or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Sujetovinculado( lxVal )
				else
					this.Sujetovinculado = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Sujetovinculado)" )
				endif 
			EndIf
		Else
			This.Setear_Sujetovinculado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Localidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Localidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Localidad( lxVal )
				this.Setear_Localidad( lxVal )
			EndIf
		Else
			This.Setear_Localidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadocivil_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadocivil
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadocivil( lxVal )
				this.Setear_Estadocivil( lxVal )
			EndIf
		Else
			This.Setear_Estadocivil( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Segundonombre_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Segundonombre
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Segundonombre( lxVal )
				this.Setear_Segundonombre( lxVal )
			EndIf
		Else
			This.Setear_Segundonombre( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tasaceroporcen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tasaceroporcen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tasaceroporcen( lxVal )
				if ( this.lHabilitarTasaceroporcen or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.Setear_Tasaceroporcen( lxVal )
				else
					this.Tasaceroporcen = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Clientes - Atributo: Tasaceroporcen)" )
				endif 
			EndIf
		Else
			This.Setear_Tasaceroporcen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigopostal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigopostal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigopostal( lxVal )
				this.Setear_Codigopostal( lxVal )
			EndIf
		Else
			This.Setear_Codigopostal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Hijos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Hijos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Hijos( lxVal )
				this.Setear_Hijos( lxVal )
			EndIf
		Else
			This.Setear_Hijos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Apellido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Apellido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Apellido( lxVal )
				this.Setear_Apellido( lxVal )
			EndIf
		Else
			This.Setear_Apellido( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tasaceroaplica_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tasaceroaplica
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tasaceroaplica( lxVal )
				this.Setear_Tasaceroaplica( lxVal )
			EndIf
		Else
			This.Setear_Tasaceroaplica( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nombre_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nombre
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nombre( lxVal )
				this.Setear_Nombre( lxVal )
			EndIf
		Else
			This.Setear_Nombre( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Email_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Email
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Email( lxVal )
				this.Setear_Email( lxVal )
			EndIf
		Else
			This.Setear_Email( lxVal ) 
		EndIf
		dodefault( lxVal )

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
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaultimamodificacion( txVal as variant ) as void

		this.Fechaultimamodificacion = txVal
		dodefault( txVal )

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
	function Setear_Clasificacion2( txVal as variant ) as void

		this.Clasificacion2 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadealta( txVal as variant ) as void

		this.Fechadealta = txVal
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
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idglobal( txVal as variant ) as void

		this.Idglobal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcionfw( txVal as variant ) as void

		this.Descripcionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nombrerecomendante( txVal as variant ) as void

		this.Nombrerecomendante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codrecomendante( txVal as variant ) as void

		this.Codrecomendante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
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
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdiccion( txVal as variant ) as void

		this.Jurisdiccion = txVal
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
	function Setear_Pin( txVal as variant ) as void

		this.Pin = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Timestamp( txVal as variant ) as void

		this.Timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idcentralizador( txVal as variant ) as void

		this.Idcentralizador = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipointerno( txVal as variant ) as void

		this.Tipointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Inactivofw( txVal as variant ) as void

		this.Inactivofw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Imagen( txVal as variant ) as void

		this.Imagen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuitpais( txVal as variant ) as void

		this.Cuitpais = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepcioningresosbrutos( txVal as variant ) as void

		this.Percepcioningresosbrutos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Calle( txVal as variant ) as void

		this.Calle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clasificacionsecundaria( txVal as variant ) as void

		this.Clasificacionsecundaria = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Telefono( txVal as variant ) as void

		this.Telefono = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Excluidopercepcionganancias( txVal as variant ) as void

		this.Excluidopercepcionganancias = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Excluidopercepcioniva( txVal as variant ) as void

		this.Excluidopercepcioniva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipoconvenio( txVal as variant ) as void

		this.Tipoconvenio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodocumento( txVal as variant ) as void

		this.Tipodocumento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cfi( txVal as variant ) as void

		this.Cfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Movil( txVal as variant ) as void

		this.Movil = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Sitfiscaluruguay( txVal as variant ) as void

		this.Sitfiscaluruguay = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vigenciahastagan( txVal as variant ) as void

		this.Vigenciahastagan = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vigenciahastaiva( txVal as variant ) as void

		this.Vigenciahastaiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroiibb( txVal as variant ) as void

		this.Nroiibb = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuit( txVal as variant ) as void

		this.Cuit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nrodocumento( txVal as variant ) as void

		this.Nrodocumento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Piso( txVal as variant ) as void

		this.Piso = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fax( txVal as variant ) as void

		this.Fax = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Credito( txVal as variant ) as void

		this.Credito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Sexo( txVal as variant ) as void

		this.Sexo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Situacionganancias( txVal as variant ) as void

		this.Situacionganancias = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rut( txVal as variant ) as void

		this.Rut = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechanacimiento( txVal as variant ) as void

		this.Fechanacimiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Paginaweb( txVal as variant ) as void

		this.Paginaweb = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Departamento( txVal as variant ) as void

		this.Departamento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Dolaresacumulados( txVal as variant ) as void

		this.Dolaresacumulados = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Topectacte( txVal as variant ) as void

		this.Topectacte = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Primernombre( txVal as variant ) as void

		this.Primernombre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Topefacturacion( txVal as variant ) as void

		this.Topefacturacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Sujetovinculado( txVal as variant ) as void

		this.Sujetovinculado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Localidad( txVal as variant ) as void

		this.Localidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadocivil( txVal as variant ) as void

		this.Estadocivil = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Segundonombre( txVal as variant ) as void

		this.Segundonombre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tasaceroporcen( txVal as variant ) as void

		this.Tasaceroporcen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigopostal( txVal as variant ) as void

		this.Codigopostal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hijos( txVal as variant ) as void

		this.Hijos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Apellido( txVal as variant ) as void

		this.Apellido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tasaceroaplica( txVal as variant ) as void

		this.Tasaceroaplica = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nombre( txVal as variant ) as void

		this.Nombre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Email( txVal as variant ) as void

		this.Email = txVal
		dodefault( txVal )

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
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaultimamodificacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Validar_Clasificacion2( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadealta( txVal as variant ) as Boolean

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
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idglobal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nombrerecomendante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codrecomendante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

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
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdiccion( txVal as variant ) as Boolean

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
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

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
	function Validar_Pin( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idcentralizador( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Inactivofw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Imagen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuitpais( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepcioningresosbrutos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Calle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clasificacionsecundaria( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Telefono( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Excluidopercepcionganancias( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Excluidopercepcioniva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipoconvenio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodocumento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Movil( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Sitfiscaluruguay( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vigenciahastagan( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vigenciahastaiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroiibb( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nrodocumento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Piso( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fax( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Credito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Sexo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Situacionganancias( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rut( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechanacimiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Paginaweb( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Departamento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Dolaresacumulados( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Topectacte( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Primernombre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Topefacturacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Sujetovinculado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Localidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadocivil( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Segundonombre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tasaceroporcen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigopostal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hijos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Apellido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tasaceroaplica( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nombre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Email( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Situacionfiscal_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Situacionfiscal ) = 'O' or isnull( this.Situacionfiscal ) )
					this.Situacionfiscal = _Screen.zoo.instanciarentidad( 'Situacionfiscal' )
					this.Situacionfiscal.lEsSubEntidad = .t.
					this.enlazar( 'Situacionfiscal.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Situacionfiscal.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Situacionfiscal.CODIGO # this.Situacionfiscal_PK
						this.Situacionfiscal.CODIGO = this.Situacionfiscal_PK
					endif
				endif
			endif
		endif
		return this.Situacionfiscal
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recomendadopor_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Recomendadopor ) = 'O' or isnull( this.Recomendadopor ) )
					this.Recomendadopor = _Screen.zoo.instanciarentidad( 'Clienterecomendante' )
					this.Recomendadopor.lEsSubEntidad = .t.
					this.enlazar( 'Recomendadopor.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Recomendadopor.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Recomendadopor.CODIGO # this.Recomendadopor_PK
						this.Recomendadopor.CODIGO = this.Recomendadopor_PK
					endif
				endif
			endif
		endif
		return this.Recomendadopor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clasificacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Clasificacion ) = 'O' or isnull( this.Clasificacion ) )
					this.Clasificacion = _Screen.zoo.instanciarentidad( 'Clasificacioncliente' )
					this.Clasificacion.lEsSubEntidad = .t.
					this.enlazar( 'Clasificacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Clasificacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Clasificacion.CODIGO # this.Clasificacion_PK
						this.Clasificacion.CODIGO = this.Clasificacion_PK
					endif
				endif
			endif
		endif
		return this.Clasificacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Transportista_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Transportista ) = 'O' or isnull( this.Transportista ) )
					this.Transportista = _Screen.zoo.instanciarentidad( 'Transportista' )
					this.Transportista.lEsSubEntidad = .t.
					this.enlazar( 'Transportista.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Transportista.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Transportista.CODIGO # this.Transportista_PK
						this.Transportista.CODIGO = this.Transportista_PK
					endif
				endif
			endif
		endif
		return this.Transportista
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codnombrefantasia_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codnombrefantasia ) = 'O' or isnull( this.Codnombrefantasia ) )
					this.Codnombrefantasia = _Screen.zoo.instanciarentidad( 'Nombredefantasia' )
					this.Codnombrefantasia.lEsSubEntidad = .t.
					this.enlazar( 'Codnombrefantasia.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codnombrefantasia.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codnombrefantasia.CODIGO # this.Codnombrefantasia_PK
						this.Codnombrefantasia.CODIGO = this.Codnombrefantasia_PK
					endif
				endif
			endif
		endif
		return this.Codnombrefantasia
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Listadeprecio_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Listadeprecio ) = 'O' or isnull( this.Listadeprecio ) )
					this.Listadeprecio = _Screen.zoo.instanciarentidad( 'Listadeprecios' )
					this.Listadeprecio.lEsSubEntidad = .t.
					this.enlazar( 'Listadeprecio.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Listadeprecio.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Listadeprecio.CODIGO # this.Listadeprecio_PK
						this.Listadeprecio.CODIGO = this.Listadeprecio_PK
					endif
				endif
			endif
		endif
		return this.Listadeprecio
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipocli_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Tipocli ) = 'O' or isnull( this.Tipocli ) )
					this.Tipocli = _Screen.zoo.instanciarentidad( 'Tipocliente' )
					this.Tipocli.lEsSubEntidad = .t.
					this.enlazar( 'Tipocli.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Tipocli.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Tipocli.CODIGO # this.Tipocli_PK
						this.Tipocli.CODIGO = this.Tipocli_PK
					endif
				endif
			endif
		endif
		return this.Tipocli
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Categcli_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Categcli ) = 'O' or isnull( this.Categcli ) )
					this.Categcli = _Screen.zoo.instanciarentidad( 'Categoriacliente' )
					this.Categcli.lEsSubEntidad = .t.
					this.enlazar( 'Categcli.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Categcli.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Categcli.CODIGO # this.Categcli_PK
						this.Categcli.CODIGO = this.Categcli_PK
					endif
				endif
			endif
		endif
		return this.Categcli
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcioniva_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Percepcioniva ) = 'O' or isnull( this.Percepcioniva ) )
					this.Percepcioniva = _Screen.zoo.instanciarentidad( 'Impuesto' )
					this.Percepcioniva.lEsSubEntidad = .t.
					this.enlazar( 'Percepcioniva.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Percepcioniva.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Percepcioniva.CODIGO # this.Percepcioniva_PK
						this.Percepcioniva.CODIGO = this.Percepcioniva_PK
					endif
				endif
			endif
		endif
		return this.Percepcioniva
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuentopreferente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Descuentopreferente ) = 'O' or isnull( this.Descuentopreferente ) )
					this.Descuentopreferente = _Screen.zoo.instanciarentidad( 'Descuento' )
					this.Descuentopreferente.lEsSubEntidad = .t.
					this.enlazar( 'Descuentopreferente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Descuentopreferente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Descuentopreferente.CODIGO # this.Descuentopreferente_PK
						this.Descuentopreferente.CODIGO = this.Descuentopreferente_PK
					endif
				endif
			endif
		endif
		return this.Descuentopreferente
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigosiprib_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codigosiprib ) = 'O' or isnull( this.Codigosiprib ) )
					this.Codigosiprib = _Screen.zoo.instanciarentidad( 'Datosadicionalessiprib' )
					this.Codigosiprib.lEsSubEntidad = .t.
					this.enlazar( 'Codigosiprib.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codigosiprib.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codigosiprib.CODIGO # this.Codigosiprib_PK
						this.Codigosiprib.CODIGO = this.Codigosiprib_PK
					endif
				endif
			endif
		endif
		return this.Codigosiprib
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcionganancias_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Percepcionganancias ) = 'O' or isnull( this.Percepcionganancias ) )
					this.Percepcionganancias = _Screen.zoo.instanciarentidad( 'Impuesto' )
					this.Percepcionganancias.lEsSubEntidad = .t.
					this.enlazar( 'Percepcionganancias.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Percepcionganancias.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Percepcionganancias.CODIGO # this.Percepcionganancias_PK
						this.Percepcionganancias.CODIGO = this.Percepcionganancias_PK
					endif
				endif
			endif
		endif
		return this.Percepcionganancias
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Condiciondepago_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Condiciondepago ) = 'O' or isnull( this.Condiciondepago ) )
					this.Condiciondepago = _Screen.zoo.instanciarentidad( 'Condiciondepago' )
					this.Condiciondepago.lEsSubEntidad = .t.
					this.enlazar( 'Condiciondepago.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Condiciondepago.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Condiciondepago.CODIGO # this.Condiciondepago_PK
						this.Condiciondepago.CODIGO = this.Condiciondepago_PK
					endif
				endif
			endif
		endif
		return this.Condiciondepago
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Provincia_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Provincia ) = 'O' or isnull( this.Provincia ) )
					this.Provincia = _Screen.zoo.instanciarentidad( 'Provincia' )
					this.Provincia.lEsSubEntidad = .t.
					this.enlazar( 'Provincia.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Provincia.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Provincia.CODIGO # this.Provincia_PK
						this.Provincia.CODIGO = this.Provincia_PK
					endif
				endif
			endif
		endif
		return this.Provincia
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pais_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Pais ) = 'O' or isnull( this.Pais ) )
					this.Pais = _Screen.zoo.instanciarentidad( 'Paises' )
					this.Pais.lEsSubEntidad = .t.
					this.enlazar( 'Pais.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Pais.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Pais.CODIGO # this.Pais_PK
						this.Pais.CODIGO = this.Pais_PK
					endif
				endif
			endif
		endif
		return this.Pais
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompDatosadicionalessiprib_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompDatosadicionalessiprib ) = 'O' or isnull( this.oCompDatosadicionalessiprib ) )
			this.oCompDatosadicionalessiprib = _Screen.zoo.InstanciarComponente( 'ComponenteDatosadicionalessiprib' )
		this.oCompDatosadicionalessiprib.Inicializar()
		this.enlazar( 'oCompDatosadicionalessiprib.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompDatosadicionalessiprib.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompDatosadicionalessiprib
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( this.Nombre ) )
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
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaultimamodificacion = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Clasificacion2 = 0
				.Fechadealta = ctod( '  /  /    ' )
				.Zadsfw = []
				.Estadotransferencia = []
				.Basededatosaltafw = []
				.Idglobal = []
				.Descripcionfw = []
				.Nombrerecomendante = []
				.Codrecomendante = []
				.Basededatosmodificacionfw = []
				.Versionmodificacionfw = []
				.Seriealtafw = []
				.Horamodificacionfw = []
				.Seriemodificacionfw = []
				.Jurisdiccion = []
				.Horaimpo = []
				.Horaexpo = []
				.Versionaltafw = []
				.Usuarioaltafw = []
				.Horaaltafw = []
				.Usuariomodificacionfw = []
				.Pin = []
				.Timestamp = 0
				.Idcentralizador = 0
				.Tipointerno = 0
				.Inactivofw = .F.
				.Imagen = []
				.Vendedor_PK = []
				.Codigo = []
				.Observacion = []
				.Cuitpais = []
				.Percepcioningresosbrutos = []
				.Calle = []
				.Clasificacionsecundaria = []
				.Telefono = []
				.Situacionfiscal_PK = 0
				.Clasificacion_PK = []
				.Transportista_PK = []
				.Otrasdirecciones.Limpiar()
				.Codnombrefantasia_PK = []
				.Excluidopercepcionganancias = .F.
				.Excluidopercepcioniva = .F.
				.Tipoconvenio = 0
				.Tipodocumento = []
				.Excluidootrapercep.Limpiar()
				.Cfi = 0
				.Numero = 0
				.Movil = []
				.Listadeprecio_PK = []
				.Tipocli_PK = []
				.Contacto.Limpiar()
				.Vigenciahastagan = ctod( '  /  /    ' )
				.Vigenciahastaiva = ctod( '  /  /    ' )
				.Nroiibb = 0
				.Cuit = []
				.Nrodocumento = []
				.Piso = []
				.Fax = []
				.Credito = 0
				.Percepciones.Limpiar()
				.Sexo = []
				.Situacionganancias = 0
				.Rut = []
				.Categcli_PK = []
				.Percepcioniva_PK = []
				.Descuentopreferente_PK = []
				.Fechanacimiento = ctod( '  /  /    ' )
				.Paginaweb = []
				.Departamento = []
				.Dolaresacumulados = 0
				.Topectacte = 0
				.Codigosiprib_PK = []
				.Percepcionganancias_PK = []
				.Primernombre = []
				.Topefacturacion = 0
				.Sujetovinculado = .F.
				.Localidad = []
				.Estadocivil = []
				.Condiciondepago_PK = []
				.Segundonombre = []
				.Tasaceroporcen = 0
				.Codigopostal = []
				.Hijos = 0
				.Apellido = []
				.Tasaceroaplica = .F.
				.Provincia_PK = []
				.Nombre = []
				.Pais_PK = []
				.Email = []
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
	Function ValorSugeridoFWClasificacion2() as void
		with this
			.Clasificacion2 = 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClasificacion2() as void
		with this
			.ValorSugeridoFWClasificacion2()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechadealta() as void
		with this
			.Fechadealta = goServicios.librerias.ObtenerFecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechadealta() as void
		with this
			.ValorSugeridoFWFechadealta()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWTipointerno() as void
		with this
			.Tipointerno = 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipointerno() as void
		with this
			.ValorSugeridoFWTipointerno()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImagen() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Imagen" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Imagen' )
						.Imagen = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Imagen para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVendedor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Vendedor" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vendedor para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObservacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Observacion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCuitpais() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Cuitpais" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cuitpais' )
						.Cuitpais = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo CUIT pa�s para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Calle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Calle' )
						.Calle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Calle para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTelefono() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Telefono" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Telefono' )
						.Telefono = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tel�fono para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSituacionfiscal() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Situacionfiscal" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Situacionfiscal_PK' )
						.Situacionfiscal_PK = lvValorSugeridoDefinidoPorElUsuario
						.Situacionfiscal.CODIGO = .Situacionfiscal_PK
					endif
				else
					.ValorSugeridoFWSituacionfiscal()
				endif
			Catch to loError
				.Situacionfiscal_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Situaci�n fiscal para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWSituacionfiscal() as void
		with this
			try
				.Situacionfiscal_PK = 3
				.Situacionfiscal.CODIGO = .Situacionfiscal_PK
			Catch to loError
				.Situacionfiscal_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRecomendadopor() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Recomendadopor" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Recomendadopor_PK' )
						.Recomendadopor_PK = lvValorSugeridoDefinidoPorElUsuario
						.Recomendadopor.CODIGO = .Recomendadopor_PK
					endif
				endif
			Catch to loError
				.Recomendadopor_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Recomendado por para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClasificacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Clasificacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Clasificacion_PK' )
						.Clasificacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Clasificacion.CODIGO = .Clasificacion_PK
					endif
				endif
			Catch to loError
				.Clasificacion_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificaci�n para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTransportista() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Transportista" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Transportista_PK' )
						.Transportista_PK = lvValorSugeridoDefinidoPorElUsuario
						.Transportista.CODIGO = .Transportista_PK
					endif
				endif
			Catch to loError
				.Transportista_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Transportista para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCodnombrefantasia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Codnombrefantasia" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Codnombrefantasia_PK' )
						.Codnombrefantasia_PK = lvValorSugeridoDefinidoPorElUsuario
						.Codnombrefantasia.CODIGO = .Codnombrefantasia_PK
					endif
				endif
			Catch to loError
				.Codnombrefantasia_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Nombre de fantas�a para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoExcluidopercepcionganancias() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Excluidopercepcionganancias" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Excluidopercepcionganancias' )
						.Excluidopercepcionganancias = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Excluido para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es l�gico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoExcluidopercepcioniva() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Excluidopercepcioniva" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Excluidopercepcioniva' )
						.Excluidopercepcioniva = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Excluido para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es l�gico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipoconvenio() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Tipoconvenio" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipoconvenio' )
						.Tipoconvenio = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Convenio para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipodocumento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Tipodocumento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipodocumento' )
						.Tipodocumento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo/n�mero documento para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWTipodocumento()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWTipodocumento() as void
		with this
			.Tipodocumento = iif(goParametros.Nucleo.DatosGenerales.Pais=3,"03","05")
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNumero() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Numero" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numero' )
						.Numero = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo N�mero para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMovil() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Movil" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Movil' )
						.Movil = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tel�fono m�vil para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSitfiscaluruguay() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Sitfiscaluruguay" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Sitfiscaluruguay' )
						.Sitfiscaluruguay = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Situaci�n del cliente para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWSitfiscaluruguay()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWSitfiscaluruguay() as void
		with this
			.Sitfiscaluruguay = 2
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoListadeprecio() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Listadeprecio" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Listadeprecio_PK' )
						.Listadeprecio_PK = lvValorSugeridoDefinidoPorElUsuario
						.Listadeprecio.CODIGO = .Listadeprecio_PK
					endif
				endif
			Catch to loError
				.Listadeprecio_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Lista de precio para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocli() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Tipocli" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipocli_PK' )
						.Tipocli_PK = lvValorSugeridoDefinidoPorElUsuario
						.Tipocli.CODIGO = .Tipocli_PK
					endif
				endif
			Catch to loError
				.Tipocli_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVigenciahastagan() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Vigenciahastagan" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vigenciahastagan' )
						.Vigenciahastagan = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vigencia hasta para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoVigenciahastaiva() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Vigenciahastaiva" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Vigenciahastaiva' )
						.Vigenciahastaiva = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Vigencia hasta para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNroiibb() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Nroiibb" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Nroiibb' )
						.Nroiibb = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo N�mero para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCuit() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Cuit" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cuit' )
						.Cuit = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo CUIT para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNrodocumento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Nrodocumento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Nrodocumento' )
						.Nrodocumento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo/n�mero documento para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPiso() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Piso" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Piso' )
						.Piso = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Piso para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFax() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Fax" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fax' )
						.Fax = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fax para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSexo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Sexo" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Sexo' )
						.Sexo = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Sexo para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSituacionganancias() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Situacionganancias" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Situacionganancias' )
						.Situacionganancias = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Situaci�n para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoRut() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Rut" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Rut' )
						.Rut = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo R.U.T. para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCategcli() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Categcli" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Categcli_PK' )
						.Categcli_PK = lvValorSugeridoDefinidoPorElUsuario
						.Categcli.CODIGO = .Categcli_PK
					endif
				endif
			Catch to loError
				.Categcli_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Categor�a para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPercepcioniva() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Percepcioniva" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Percepcioniva_PK' )
						.Percepcioniva_PK = lvValorSugeridoDefinidoPorElUsuario
						.Percepcioniva.CODIGO = .Percepcioniva_PK
					endif
				endif
			Catch to loError
				.Percepcioniva_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo C�digo para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDescuentopreferente() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Descuentopreferente" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Descuentopreferente_PK' )
						.Descuentopreferente_PK = lvValorSugeridoDefinidoPorElUsuario
						.Descuentopreferente.CODIGO = .Descuentopreferente_PK
					endif
				endif
			Catch to loError
				.Descuentopreferente_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descuento para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechanacimiento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Fechanacimiento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechanacimiento' )
						.Fechanacimiento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de nacimiento para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPaginaweb() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Paginaweb" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Paginaweb' )
						.Paginaweb = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Sitio web para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDepartamento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Departamento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Departamento' )
						.Departamento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Departamento para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTopectacte() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Topectacte" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Topectacte' )
						.Topectacte = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo L�mite de cr�dito para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCodigosiprib() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Codigosiprib" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Codigosiprib_PK' )
						.Codigosiprib_PK = lvValorSugeridoDefinidoPorElUsuario
						.Codigosiprib.CODIGO = .Codigosiprib_PK
					endif
				endif
			Catch to loError
				.Codigosiprib_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo IIBB Santa Fe SIPRIB para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPercepcionganancias() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Percepcionganancias" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Percepcionganancias_PK' )
						.Percepcionganancias_PK = lvValorSugeridoDefinidoPorElUsuario
						.Percepcionganancias.CODIGO = .Percepcionganancias_PK
					endif
				endif
			Catch to loError
				.Percepcionganancias_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo C�digo para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPrimernombre() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Primernombre" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Primernombre' )
						.Primernombre = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Primer nombre para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSujetovinculado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Sujetovinculado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Sujetovinculado' )
						.Sujetovinculado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Sujeto vinculado para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es l�gico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoLocalidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Localidad" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Localidad' )
						.Localidad = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Localidad para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadocivil() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Estadocivil" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadocivil' )
						.Estadocivil = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Estado civil para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCondiciondepago() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Condiciondepago" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Condiciondepago_PK' )
						.Condiciondepago_PK = lvValorSugeridoDefinidoPorElUsuario
						.Condiciondepago.CODIGO = .Condiciondepago_PK
					endif
				endif
			Catch to loError
				.Condiciondepago_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Condici�n de pago para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSegundonombre() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Segundonombre" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Segundonombre' )
						.Segundonombre = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Segundo nombre para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTasaceroporcen() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Tasaceroporcen" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tasaceroporcen' )
						.Tasaceroporcen = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo IIBB Mendoza con certificado tasa cero para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCodigopostal() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Codigopostal" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Codigopostal' )
						.Codigopostal = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo C�digo postal para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoHijos() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Hijos" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Hijos' )
						.Hijos = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad de hijos para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es num�rico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoApellido() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Apellido" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Apellido' )
						.Apellido = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Apellido para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTasaceroaplica() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Tasaceroaplica" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tasaceroaplica' )
						.Tasaceroaplica = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Aplica para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es l�gico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoProvincia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Provincia" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Provincia_PK' )
						.Provincia_PK = lvValorSugeridoDefinidoPorElUsuario
						.Provincia.CODIGO = .Provincia_PK
					endif
				endif
			Catch to loError
				.Provincia_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Provincia para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoNombre() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Nombre" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Nombre' )
						.Nombre = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Denominaci�n o raz�n social para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPais() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Pais" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Pais_PK' )
						.Pais_PK = lvValorSugeridoDefinidoPorElUsuario
						.Pais.CODIGO = .Pais_PK
					endif
				endif
			Catch to loError
				.Pais_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pa�s para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEmail() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CLIENTE", "", "Email" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Email' )
						.Email = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Email para la entidad Clientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	function Cuit_DespuesDeAsignar() as void
		this.DespuesDeAsignarCUIT()                                                                         
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
	function ValidarDominio_Fechalargacalendario( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechalargacalendario( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		this.oCompDatosAdicionalesSIPRIB = null
		this.oDesactivador = null
		use in select( 'c_CLIENTE' )
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Recomendadopor_PK = []
			.Sitfiscaluruguay = 0
		endwith
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributosCombinacion() as object
		local loColRetorno as object
		
		loColRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		return loColRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oDesactivador_Access() as object
		if !this.ldestroy and ( !vartype( this.oDesactivador ) = 'O' or isnull( this.oDesactivador ) )
			this.oDesactivador = desactivadorfactory( this )
		endif
		return this.oDesactivador
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerDetalleaInsertar() as detalle of detalle.prg
		return this.Percepciones
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributoDetalleaInsertar() as detalle of detalle.prg
		return 'Percepciones'
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

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCamposSegunEquivalencia( taEst ) as Integer
		local loTransformacionLince as object, loColMatcheos as object, lnI as integer, lcCadena as string, lnPos as integer, lcFrameWork as string 
		lcCadena = ''
		loTransformacionLince = _screen.zoo.instanciarentidad('DISENOTRANSFORMACIONLINCE' )
		loTransformacionLince.entiDAD = this.cNombre
		lcFrameWork = "'FECTRANS','ESTTRANS','FALTAFW','HALTAFW','FMODIFW','HMODIFW','FECIMPO','HORAIMPO','FECEXPO','HORAEXPO','UALTAFW','UMODIFW','SALTAFW','SMODIFW','BDALTAFW','BDMODIFW','VALTAFW','VMODIFW','ZADSFW','BLOQREG','TIMESTAMP'"
		if loTransformacionLince.EstablecerSegunEntidad( loTransformacionLince.Entidad )
			loColMatcheos = loTransformacionLince.ObtenerColeccionMatcheos()
			for lnI = 1 to loColMatcheos.count
				lnPos = ASCAN(taEst,loColMatcheos.item(lnI).campoOrganic,1)
				if lnPos != 0
					taest(lnpos) = ''
				endif
			endfor 
			for lnI = 1 to alen( taest,1)
				if !empty(taEst(lnI,1)) and !inlist( upper( taEst(lnI,1) ),&lcFramework)
					lcCadena = lcCadena + taEst(lnI,1) + ' with curseek.' + taEst(lnI,1) + ', '
				endif
			endfor 
			lcCadena = substr( lcCadena,1, len( lcCadena ) - 2 )
		endif
		loTransformacionLince.release()
		
		return lcCadena 
	endfunc 

	*--------------------------------------------------------------------------------------------------------
	protect function InformarWebHook()
		if this.lWHIngresar and this.lNuevo
			goServicios.WebHook.Enviar( this, 'INGRESAR')
		else
			if this.lWHModificar and this.lEdicion
				goServicios.WebHook.Enviar( this, 'MODIFICAR')
			endif
		endif
	endfunc

enddefine