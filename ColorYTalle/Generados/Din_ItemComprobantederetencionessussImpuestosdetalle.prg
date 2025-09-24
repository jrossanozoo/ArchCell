
define class Din_ItemCOMPROBANTEDERETENCIONESSUSSImpuestosdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'COMPROBANTEDERETENCIONESSUSS'
	EscalaMontoFijo = 0
	Minimo = 0
	EscalaPorcentaje = 0
	EscalaSobreExcedente = 0
	RegimenImpositivo = []
	RegimenImpositivoDescripcion = []
	ConvenioMultilateral = []
	BaseDeCalculo = []
	CodSeguridadSIRE = []
	NROITEM = 0
	MontoComprobanteOrigen = 0
	MinimoNoImp = 0
	esRG1575AR = .F.
	esRG2616AR = .F.
	AcumuladoComprobantes = 0
	AcumuladoPagos = 0
	PorcentajeDeConvenio = 0
	PorcentajeDeBase = 0
	CertificadoSIRE = []
	MontoBase = 0
	AcumuladoRetenciones = 0
	Escala = .F.
	cAtributoPK = 'Codigo'
	Codigo = []
	CodImp_PK = []
	CodImp = null
	CodImpDetalle = []
	Jurisdiccion = []
	JurisdiccionDescripcion = []
	Resolucion = []
	MinimoNoImponible = 0
	Porcentaje = 0
	Monto = 0
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'COMPROBANTEDERETENCIONESSUSS', 'Impuestosdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codimp_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codimp_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Codimp_PK = lxVal

		if this.Validar_Codimp( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Codimp_Pk', lxValOld, lxVal  )
			This.Setear_Codimp( lxVal )
			this.EventoDespuesDeSetear( This, 'Codimp_Pk', lxValOld, lxVal  )
			If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
				this.TotalizarSumarizado()
			EndIf
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Codimp_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codimp( txVal as variant ) as void

		this.Codimp.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codimp( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escalamontofijo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Escalamontofijo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Escalamontofijo( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Escalamontofijo', lxValOld, lxVal  )
				this.Setear_Escalamontofijo( lxVal )
				this.EventoDespuesDeSetear( This, 'Escalamontofijo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Escalamontofijo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Escalamontofijo( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Minimo', lxValOld, lxVal  )
				this.Setear_Minimo( lxVal )
				this.EventoDespuesDeSetear( This, 'Minimo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Minimo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Minimo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escalaporcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Escalaporcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Escalaporcentaje( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Escalaporcentaje', lxValOld, lxVal  )
				this.Setear_Escalaporcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Escalaporcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Escalaporcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Escalaporcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Escalasobreexcedente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Escalasobreexcedente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Escalasobreexcedente( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Escalasobreexcedente', lxValOld, lxVal  )
				this.Setear_Escalasobreexcedente( lxVal )
				this.EventoDespuesDeSetear( This, 'Escalasobreexcedente', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Escalasobreexcedente', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Escalasobreexcedente( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Regimenimpositivo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Regimenimpositivo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Regimenimpositivo( lxVal )
				this.EventoAntesDeSetear( This, 'Regimenimpositivo', lxValOld, lxVal  )
				this.Setear_Regimenimpositivo( lxVal )
				this.EventoDespuesDeSetear( This, 'Regimenimpositivo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Regimenimpositivo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Regimenimpositivo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Regimenimpositivodescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Regimenimpositivodescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Regimenimpositivodescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Regimenimpositivodescripcion', lxValOld, lxVal  )
				this.Setear_Regimenimpositivodescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Regimenimpositivodescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Regimenimpositivodescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Regimenimpositivodescripcion( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Conveniomultilateral', lxValOld, lxVal  )
				this.Setear_Conveniomultilateral( lxVal )
				this.EventoDespuesDeSetear( This, 'Conveniomultilateral', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Conveniomultilateral', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Conveniomultilateral( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Basedecalculo', lxValOld, lxVal  )
				this.Setear_Basedecalculo( lxVal )
				this.EventoDespuesDeSetear( This, 'Basedecalculo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Basedecalculo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Basedecalculo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codseguridadsire_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codseguridadsire
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codseguridadsire( lxVal )
				this.EventoAntesDeSetear( This, 'Codseguridadsire', lxValOld, lxVal  )
				this.Setear_Codseguridadsire( lxVal )
				this.EventoDespuesDeSetear( This, 'Codseguridadsire', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codseguridadsire', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codseguridadsire( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nroitem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nroitem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nroitem( lxVal )
				this.EventoAntesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				this.Setear_Nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nroitem', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montocomprobanteorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montocomprobanteorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montocomprobanteorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Montocomprobanteorigen', lxValOld, lxVal  )
				this.Setear_Montocomprobanteorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Montocomprobanteorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montocomprobanteorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montocomprobanteorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Minimonoimp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Minimonoimp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Minimonoimp( lxVal )
				this.EventoAntesDeSetear( This, 'Minimonoimp', lxValOld, lxVal  )
				this.Setear_Minimonoimp( lxVal )
				this.EventoDespuesDeSetear( This, 'Minimonoimp', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Minimonoimp', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Minimonoimp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Esrg1575ar_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esrg1575ar
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esrg1575ar( lxVal )
				this.EventoAntesDeSetear( This, 'Esrg1575ar', lxValOld, lxVal  )
				this.Setear_Esrg1575ar( lxVal )
				this.EventoDespuesDeSetear( This, 'Esrg1575ar', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esrg1575ar', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esrg1575ar( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Esrg2616ar_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Esrg2616ar
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Esrg2616ar( lxVal )
				this.EventoAntesDeSetear( This, 'Esrg2616ar', lxValOld, lxVal  )
				this.Setear_Esrg2616ar( lxVal )
				this.EventoDespuesDeSetear( This, 'Esrg2616ar', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Esrg2616ar', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Esrg2616ar( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumuladocomprobantes_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Acumuladocomprobantes
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Acumuladocomprobantes( lxVal )
				this.EventoAntesDeSetear( This, 'Acumuladocomprobantes', lxValOld, lxVal  )
				this.Setear_Acumuladocomprobantes( lxVal )
				this.EventoDespuesDeSetear( This, 'Acumuladocomprobantes', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Acumuladocomprobantes', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Acumuladocomprobantes( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumuladopagos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Acumuladopagos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Acumuladopagos( lxVal )
				this.EventoAntesDeSetear( This, 'Acumuladopagos', lxValOld, lxVal  )
				this.Setear_Acumuladopagos( lxVal )
				this.EventoDespuesDeSetear( This, 'Acumuladopagos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Acumuladopagos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Acumuladopagos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedeconvenio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedeconvenio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedeconvenio( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajedeconvenio', lxValOld, lxVal  )
				this.Setear_Porcentajedeconvenio( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajedeconvenio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajedeconvenio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajedeconvenio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedebase_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedebase
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedebase( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajedebase', lxValOld, lxVal  )
				this.Setear_Porcentajedebase( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajedebase', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajedebase', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajedebase( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Certificadosire_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Certificadosire
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Certificadosire( lxVal )
				this.EventoAntesDeSetear( This, 'Certificadosire', lxValOld, lxVal  )
				this.Setear_Certificadosire( lxVal )
				this.EventoDespuesDeSetear( This, 'Certificadosire', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Certificadosire', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Certificadosire( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montobase_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montobase
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montobase( lxVal )
				this.EventoAntesDeSetear( This, 'Montobase', lxValOld, lxVal  )
				this.Setear_Montobase( lxVal )
				this.EventoDespuesDeSetear( This, 'Montobase', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montobase', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montobase( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Acumuladoretenciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Acumuladoretenciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Acumuladoretenciones( lxVal )
				this.EventoAntesDeSetear( This, 'Acumuladoretenciones', lxValOld, lxVal  )
				this.Setear_Acumuladoretenciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Acumuladoretenciones', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Acumuladoretenciones', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Acumuladoretenciones( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Escala', lxValOld, lxVal  )
				this.Setear_Escala( lxVal )
				this.EventoDespuesDeSetear( This, 'Escala', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Escala', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Escala( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codimpdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codimpdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codimpdetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Codimpdetalle', lxValOld, lxVal  )
				this.Setear_Codimpdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Codimpdetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codimpdetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codimpdetalle( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Jurisdiccion', lxValOld, lxVal  )
				this.Setear_Jurisdiccion( lxVal )
				this.EventoDespuesDeSetear( This, 'Jurisdiccion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Jurisdiccion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Jurisdiccion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Jurisdicciondescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Jurisdicciondescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Jurisdicciondescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Jurisdicciondescripcion', lxValOld, lxVal  )
				this.Setear_Jurisdicciondescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Jurisdicciondescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Jurisdicciondescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Jurisdicciondescripcion( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Resolucion', lxValOld, lxVal  )
				this.Setear_Resolucion( lxVal )
				this.EventoDespuesDeSetear( This, 'Resolucion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Resolucion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Resolucion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Minimonoimponible_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Minimonoimponible
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Minimonoimponible( lxVal )
				this.EventoAntesDeSetear( This, 'Minimonoimponible', lxValOld, lxVal  )
				this.Setear_Minimonoimponible( lxVal )
				this.EventoDespuesDeSetear( This, 'Minimonoimponible', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Minimonoimponible', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Minimonoimponible( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Porcentaje', lxValOld, lxVal  )
				this.Setear_Porcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentaje( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Monto', lxValOld, lxVal  )
				this.Setear_Monto( lxVal )
				this.EventoDespuesDeSetear( This, 'Monto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Monto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Monto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escalamontofijo( txVal as variant ) as void

		this.Escalamontofijo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimo( txVal as variant ) as void

		this.Minimo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escalaporcentaje( txVal as variant ) as void

		this.Escalaporcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escalasobreexcedente( txVal as variant ) as void

		this.Escalasobreexcedente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimenimpositivo( txVal as variant ) as void

		this.Regimenimpositivo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimenimpositivodescripcion( txVal as variant ) as void

		this.Regimenimpositivodescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conveniomultilateral( txVal as variant ) as void

		this.Conveniomultilateral = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basedecalculo( txVal as variant ) as void

		this.Basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codseguridadsire( txVal as variant ) as void

		this.Codseguridadsire = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocomprobanteorigen( txVal as variant ) as void

		this.Montocomprobanteorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimonoimp( txVal as variant ) as void

		this.Minimonoimp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Esrg1575ar( txVal as variant ) as void

		this.Esrg1575ar = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Esrg2616ar( txVal as variant ) as void

		this.Esrg2616ar = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Acumuladocomprobantes( txVal as variant ) as void

		this.Acumuladocomprobantes = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Acumuladopagos( txVal as variant ) as void

		this.Acumuladopagos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedeconvenio( txVal as variant ) as void

		this.Porcentajedeconvenio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedebase( txVal as variant ) as void

		this.Porcentajedebase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Certificadosire( txVal as variant ) as void

		this.Certificadosire = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montobase( txVal as variant ) as void

		this.Montobase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Acumuladoretenciones( txVal as variant ) as void

		this.Acumuladoretenciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escala( txVal as variant ) as void

		this.Escala = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codimpdetalle( txVal as variant ) as void

		this.Codimpdetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdiccion( txVal as variant ) as void

		this.Jurisdiccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdicciondescripcion( txVal as variant ) as void

		this.Jurisdicciondescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Resolucion( txVal as variant ) as void

		this.Resolucion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimonoimponible( txVal as variant ) as void

		this.Minimonoimponible = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentaje( txVal as variant ) as void

		this.Porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escalamontofijo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escalaporcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escalasobreexcedente( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimenimpositivo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimenimpositivodescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conveniomultilateral( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codseguridadsire( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocomprobanteorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimonoimp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Esrg1575ar( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Esrg2616ar( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Acumuladocomprobantes( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Acumuladopagos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedeconvenio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedebase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Certificadosire( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montobase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Acumuladoretenciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escala( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codimpdetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdiccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdicciondescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Resolucion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimonoimponible( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codimp_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codimp ) = 'O' or isnull( this.Codimp ) )
					this.Codimp = _Screen.zoo.instanciarentidad( 'Impuesto' )
					this.Codimp.lEsSubEntidad = .t.
					this.enlazar( 'Codimp.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codimp.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codimp.CODIGO # this.Codimp_PK
						this.Codimp.CODIGO = this.Codimp_PK
					endif
				endif
			endif
		endif
		return this.Codimp
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Escalamontofijo = 0
				.Minimo = 0
				.Escalaporcentaje = 0
				.Escalasobreexcedente = 0
				.Regimenimpositivo = []
				.Regimenimpositivodescripcion = []
				.Conveniomultilateral = []
				.Basedecalculo = []
				.Codseguridadsire = []
				.Montocomprobanteorigen = 0
				.Minimonoimp = 0
				.Esrg1575ar = .F.
				.Esrg2616ar = .F.
				.Acumuladocomprobantes = 0
				.Acumuladopagos = 0
				.Porcentajedeconvenio = 0
				.Porcentajedebase = 0
				.Certificadosire = []
				.Montobase = 0
				.Acumuladoretenciones = 0
				.Escala = .F.
				.Codigo = []
				.Codimp_PK = []
				.Codimpdetalle = []
				.Jurisdiccion = []
				.Jurisdicciondescripcion = []
				.Resolucion = []
				.Minimonoimponible = 0
				.Porcentaje = 0
				.Monto = 0
				.LimpiarAtributosVirtuales()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
				endif
				if tlForzar
					.CambioSumarizado()
				endif
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
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
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCodimp() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDERETENCIONESSUSS", "Impuestosdetalle", "Codimp" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Codimp_PK' )
						.Codimp_PK = lvValorSugeridoDefinidoPorElUsuario
						.Codimp.CODIGO = .Codimp_PK
					endif
				endif
			Catch to loError
				.Codimp_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Impuesto para el detalle Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoJurisdicciondescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDERETENCIONESSUSS", "Impuestosdetalle", "Jurisdicciondescripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Jurisdicciondescripcion' )
						.Jurisdicciondescripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Jurisdicción para el detalle Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoResolucion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDERETENCIONESSUSS", "Impuestosdetalle", "Resolucion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Resolución para el detalle Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTEDERETENCIONESSUSS", "Impuestosdetalle", "Monto" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto para el detalle Impuestos." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		
		Return llRetorno
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
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.Codimp_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCDRIMPUESTOS]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.CODIMP_PK) and dodefault()
		return llRetorno
	endfunc

enddefine