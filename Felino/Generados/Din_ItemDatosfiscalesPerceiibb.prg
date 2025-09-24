
define class Din_ItemDATOSFISCALESPerceiibb as ItemActivo of ItemActivo.prg

	cNombre = 'DATOSFISCALES'
	NROITEM = 0
	BLOQUEARREGISTRO = .F.
	cAtributoPK = 'Codigo'
	Codigo = []
	Impuesto_PK = []
	Impuesto = null
	Aplicacion = []
	Tipo_PK = []
	Tipo = null
	Jurisdiccion = []
	Resolucion = []
	RegimenImpositivo = []
	MinimoNoImponible = 0
	MinimoDeRetencion = 0
	codigointerno = []
	Porcentaje = 0
	RG2616Porcentaje = 0
	RG2616Regimen = []
	RG2616Meses = 0
	RG2616MontoMaximoServicios = 0
	RG2616MontoMaximoBienes = 0
	BaseDeCalculo = []
	RG1575Regimen = []
	RG1575Porcentaje = 0
	RG1575BaseDeCalculo = []
	Escala = .F.
	SegunConvenio = .F.
	ConvenioLocal = 0
	ConvenioMultilateral = 0
	ConvenioMultilExtranaJuris = 0
	ConvenioNoInscripto = 0
	IIBBTucCoeficienteCero = 0
	IIBBTucReduccionAlicuota = 0
	Regimen = []
	IIBBTucAlicuotaNoInscriptos = 0
	RG5329Porcentaje = 0
	RG5329AplicaPorArticulo = .F.
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCodigointerno()','Codigointerno')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'DATOSFISCALES', 'Perceiibb')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuesto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Impuesto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Impuesto_PK = lxVal

		if this.Validar_Impuesto( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Impuesto_Pk', lxValOld, lxVal  )
			This.Setear_Impuesto( lxVal )
			this.EventoDespuesDeSetear( This, 'Impuesto_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Impuesto_Pk', This )
				Endif
			EndIf
		endif
		If lxValOld != lxVal or empty( this.Aplicacion ) 
			this.Aplicacion = This.Impuesto.Aplicacion
		endif
		If lxValOld != lxVal or empty( this.Tipo_PK ) 
			this.Tipo_Pk = This.Impuesto.Tipo_PK
		endif
		If lxValOld != lxVal or empty( this.Jurisdiccion ) 
			this.Jurisdiccion = This.Impuesto.Jurisdiccion_pk
		endif
		If lxValOld != lxVal or empty( this.Resolucion ) 
			this.Resolucion = This.Impuesto.Resolucion
		endif
		If lxValOld != lxVal or empty( this.Regimenimpositivo ) 
			this.Regimenimpositivo = This.Impuesto.RegimenImpositivo_pk
		endif
		If lxValOld != lxVal or empty( this.Minimonoimponible ) 
			this.Minimonoimponible = This.Impuesto.Monto
		endif
		If lxValOld != lxVal or empty( this.Minimoderetencion ) 
			this.Minimoderetencion = This.Impuesto.Minimo
		endif
		If lxValOld != lxVal or empty( this.Porcentaje ) 
			this.Porcentaje = This.Impuesto.Porcentaje
		endif
		If lxValOld != lxVal or empty( this.Rg2616porcentaje ) 
			this.Rg2616porcentaje = This.Impuesto.RG2616Porcentaje
		endif
		If lxValOld != lxVal or empty( this.Rg2616regimen ) 
			this.Rg2616regimen = This.Impuesto.RG2616Regimen_pk
		endif
		If lxValOld != lxVal or empty( this.Rg2616meses ) 
			this.Rg2616meses = This.Impuesto.RG2616Meses
		endif
		If lxValOld != lxVal or empty( this.Rg2616montomaximoservicios ) 
			this.Rg2616montomaximoservicios = This.Impuesto.RG2616MontoMaximoServicios
		endif
		If lxValOld != lxVal or empty( this.Rg2616montomaximobienes ) 
			this.Rg2616montomaximobienes = This.Impuesto.RG2616MontoMaximoBienes
		endif
		If lxValOld != lxVal or empty( this.Basedecalculo ) 
			this.Basedecalculo = This.Impuesto.BaseDeCalculo
		endif
		If lxValOld != lxVal or empty( this.Rg1575regimen ) 
			this.Rg1575regimen = This.Impuesto.RG1575Regimen_pk
		endif
		If lxValOld != lxVal or empty( this.Rg1575porcentaje ) 
			this.Rg1575porcentaje = This.Impuesto.RG1575Porcentaje
		endif
		If lxValOld != lxVal or empty( this.Rg1575basedecalculo ) 
			this.Rg1575basedecalculo = This.Impuesto.RG1575BaseDeCalculo
		endif
		If lxValOld != lxVal or empty( this.Escala ) 
			this.Escala = This.Impuesto.Escala
		endif
		If lxValOld != lxVal or empty( this.Segunconvenio ) 
			this.Segunconvenio = This.Impuesto.SegunConvenio
		endif
		If lxValOld != lxVal or empty( this.Conveniolocal ) 
			this.Conveniolocal = This.Impuesto.ConvenioLocal
		endif
		If lxValOld != lxVal or empty( this.Conveniomultilateral ) 
			this.Conveniomultilateral = This.Impuesto.ConvenioMultilateral
		endif
		If lxValOld != lxVal or empty( this.Conveniomultilextranajuris ) 
			this.Conveniomultilextranajuris = This.Impuesto.ConvenioMultilateral
		endif
		If lxValOld != lxVal or empty( this.Convenionoinscripto ) 
			this.Convenionoinscripto = This.Impuesto.ConvenioNoInscripto
		endif
		If lxValOld != lxVal or empty( this.Iibbtuccoeficientecero ) 
			this.Iibbtuccoeficientecero = This.Impuesto.IIBBTucCoeficienteCero
		endif
		If lxValOld != lxVal or empty( this.Iibbtucreduccionalicuota ) 
			this.Iibbtucreduccionalicuota = This.Impuesto.IIBBTucReduccionAlicuota
		endif
		If lxValOld != lxVal or empty( this.Regimen ) 
			this.Regimen = This.Impuesto.Regimen
		endif
		If lxValOld != lxVal or empty( this.Iibbtucalicuotanoinscriptos ) 
			this.Iibbtucalicuotanoinscriptos = This.Impuesto.IIBBTucAlicuotaNoInscriptos
		endif
		If lxValOld != lxVal or empty( this.Rg5329porcentaje ) 
			this.Rg5329porcentaje = This.Impuesto.RG5329Porcentaje
		endif
		If lxValOld != lxVal or empty( this.Rg5329aplicaporarticulo ) 
			this.Rg5329aplicaporarticulo = This.Impuesto.RG5329AplicaPorArticulo
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
			this.EventoAntesDeSetear( This, 'Tipo_Pk', lxValOld, lxVal  )
			This.Setear_Tipo( lxVal )
			this.EventoDespuesDeSetear( This, 'Tipo_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Tipo_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impuesto( txVal as variant ) as void

		this.Impuesto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impuesto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Bloquearregistro_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bloquearregistro
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bloquearregistro( lxVal )
				this.EventoAntesDeSetear( This, 'Bloquearregistro', lxValOld, lxVal  )
				this.Setear_Bloquearregistro( lxVal )
				this.EventoDespuesDeSetear( This, 'Bloquearregistro', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Bloquearregistro', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Bloquearregistro( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Aplicacion', lxValOld, lxVal  )
				this.Setear_Aplicacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Aplicacion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Aplicacion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Aplicacion( lxVal ) 
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
	function Minimoderetencion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Minimoderetencion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Minimoderetencion( lxVal )
				this.EventoAntesDeSetear( This, 'Minimoderetencion', lxValOld, lxVal  )
				this.Setear_Minimoderetencion( lxVal )
				this.EventoDespuesDeSetear( This, 'Minimoderetencion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Minimoderetencion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Minimoderetencion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigointerno( lxVal )
				this.EventoAntesDeSetear( This, 'Codigointerno', lxValOld, lxVal  )
				this.Setear_Codigointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigointerno', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigointerno', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigointerno( lxVal ) 
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
	function Rg2616porcentaje_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616porcentaje
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616porcentaje( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg2616porcentaje', lxValOld, lxVal  )
				this.Setear_Rg2616porcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg2616porcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg2616porcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg2616porcentaje( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Rg2616regimen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg2616regimen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg2616regimen( lxVal )
				this.EventoAntesDeSetear( This, 'Rg2616regimen', lxValOld, lxVal  )
				this.Setear_Rg2616regimen( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg2616regimen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg2616regimen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg2616regimen( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg2616meses', lxValOld, lxVal  )
				this.Setear_Rg2616meses( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg2616meses', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg2616meses', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg2616meses( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg2616montomaximoservicios', lxValOld, lxVal  )
				this.Setear_Rg2616montomaximoservicios( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg2616montomaximoservicios', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg2616montomaximoservicios', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg2616montomaximobienes', lxValOld, lxVal  )
				this.Setear_Rg2616montomaximobienes( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg2616montomaximobienes', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg2616montomaximobienes', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg2616montomaximobienes( lxVal ) 
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
	function Rg1575regimen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Rg1575regimen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Rg1575regimen( lxVal )
				this.EventoAntesDeSetear( This, 'Rg1575regimen', lxValOld, lxVal  )
				this.Setear_Rg1575regimen( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg1575regimen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg1575regimen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg1575regimen( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg1575porcentaje', lxValOld, lxVal  )
				this.Setear_Rg1575porcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg1575porcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg1575porcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg1575porcentaje( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Rg1575basedecalculo', lxValOld, lxVal  )
				this.Setear_Rg1575basedecalculo( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg1575basedecalculo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg1575basedecalculo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg1575basedecalculo( lxVal ) 
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
	function Segunconvenio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Segunconvenio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Segunconvenio( lxVal )
				this.EventoAntesDeSetear( This, 'Segunconvenio', lxValOld, lxVal  )
				this.Setear_Segunconvenio( lxVal )
				this.EventoDespuesDeSetear( This, 'Segunconvenio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Segunconvenio', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Conveniolocal', lxValOld, lxVal  )
				this.Setear_Conveniolocal( lxVal )
				this.EventoDespuesDeSetear( This, 'Conveniolocal', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Conveniolocal', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
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
	function Conveniomultilextranajuris_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conveniomultilextranajuris
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conveniomultilextranajuris( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Conveniomultilextranajuris', lxValOld, lxVal  )
				this.Setear_Conveniomultilextranajuris( lxVal )
				this.EventoDespuesDeSetear( This, 'Conveniomultilextranajuris', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Conveniomultilextranajuris', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Convenionoinscripto', lxValOld, lxVal  )
				this.Setear_Convenionoinscripto( lxVal )
				this.EventoDespuesDeSetear( This, 'Convenionoinscripto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Convenionoinscripto', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Iibbtuccoeficientecero', lxValOld, lxVal  )
				this.Setear_Iibbtuccoeficientecero( lxVal )
				this.EventoDespuesDeSetear( This, 'Iibbtuccoeficientecero', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iibbtuccoeficientecero', This )
					Endif
				EndIf
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Iibbtucreduccionalicuota', lxValOld, lxVal  )
				this.Setear_Iibbtucreduccionalicuota( lxVal )
				this.EventoDespuesDeSetear( This, 'Iibbtucreduccionalicuota', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iibbtucreduccionalicuota', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iibbtucreduccionalicuota( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Regimen', lxValOld, lxVal  )
				this.Setear_Regimen( lxVal )
				this.EventoDespuesDeSetear( This, 'Regimen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Regimen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Regimen( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Iibbtucalicuotanoinscriptos', lxValOld, lxVal  )
				this.Setear_Iibbtucalicuotanoinscriptos( lxVal )
				this.EventoDespuesDeSetear( This, 'Iibbtucalicuotanoinscriptos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iibbtucalicuotanoinscriptos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iibbtucalicuotanoinscriptos( lxVal ) 
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
				this.ValidarDominio_Numericononegativo( lxVal )
				this.EventoAntesDeSetear( This, 'Rg5329porcentaje', lxValOld, lxVal  )
				this.Setear_Rg5329porcentaje( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg5329porcentaje', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg5329porcentaje', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg5329porcentaje( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Rg5329aplicaporarticulo', lxValOld, lxVal  )
				this.Setear_Rg5329aplicaporarticulo( lxVal )
				this.EventoDespuesDeSetear( This, 'Rg5329aplicaporarticulo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Rg5329aplicaporarticulo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Rg5329aplicaporarticulo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bloquearregistro( txVal as variant ) as void

		this.Bloquearregistro = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Aplicacion( txVal as variant ) as void

		this.Aplicacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdiccion( txVal as variant ) as void

		this.Jurisdiccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Resolucion( txVal as variant ) as void

		this.Resolucion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimenimpositivo( txVal as variant ) as void

		this.Regimenimpositivo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimonoimponible( txVal as variant ) as void

		this.Minimonoimponible = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimoderetencion( txVal as variant ) as void

		this.Minimoderetencion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigointerno( txVal as variant ) as void

		this.Codigointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentaje( txVal as variant ) as void

		this.Porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616porcentaje( txVal as variant ) as void

		this.Rg2616porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616regimen( txVal as variant ) as void

		this.Rg2616regimen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg2616meses( txVal as variant ) as void

		this.Rg2616meses = txVal
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
	function Setear_Basedecalculo( txVal as variant ) as void

		this.Basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575regimen( txVal as variant ) as void

		this.Rg1575regimen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575porcentaje( txVal as variant ) as void

		this.Rg1575porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg1575basedecalculo( txVal as variant ) as void

		this.Rg1575basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Escala( txVal as variant ) as void

		this.Escala = txVal
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
	function Setear_Regimen( txVal as variant ) as void

		this.Regimen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iibbtucalicuotanoinscriptos( txVal as variant ) as void

		this.Iibbtucalicuotanoinscriptos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg5329porcentaje( txVal as variant ) as void

		this.Rg5329porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Rg5329aplicaporarticulo( txVal as variant ) as void

		this.Rg5329aplicaporarticulo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bloquearregistro( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Aplicacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdiccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Resolucion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimenimpositivo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimonoimponible( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimoderetencion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616regimen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg2616meses( txVal as variant ) as Boolean

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
	function Validar_Basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575regimen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg1575basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Escala( txVal as variant ) as Boolean

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
	function Validar_Regimen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iibbtucalicuotanoinscriptos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg5329porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Rg5329aplicaporarticulo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuesto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Impuesto ) = 'O' or isnull( this.Impuesto ) )
					this.Impuesto = _Screen.zoo.instanciarentidad( 'Impuesto' )
					this.Impuesto.lEsSubEntidad = .t.
					this.enlazar( 'Impuesto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Impuesto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Impuesto.CODIGO # this.Impuesto_PK
						this.Impuesto.CODIGO = this.Impuesto_PK
					endif
				endif
			endif
		endif
		return this.Impuesto
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
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Bloquearregistro = .F.
				.Codigo = []
				.Impuesto_PK = []
				.Codigointerno = []
				.LimpiarAtributosVirtuales()
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
			If .EsNuevo() or .EsEdicion()
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
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImpuesto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "DATOSFISCALES", "Perceiibb", "Impuesto" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Impuesto_PK' )
						.Impuesto_PK = lvValorSugeridoDefinidoPorElUsuario
						.Impuesto.CODIGO = .Impuesto_PK
					endif
				endif
			Catch to loError
				.Impuesto_PK=[]
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
	Function ValorSugeridoFWCodigointerno() as void
		with this
			.Codigointerno = goServicios.librerias.obtenerguidpk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCodigointerno() as void
		with this
			.ValorSugeridoFWCodigointerno()
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
			.Aplicacion = []
			.Tipo_PK = []
			.Jurisdiccion = []
			.Resolucion = []
			.Regimenimpositivo = []
			.Minimonoimponible = 0
			.Minimoderetencion = 0
			.Porcentaje = 0
			.Rg2616porcentaje = 0
			.Rg2616regimen = []
			.Rg2616meses = 0
			.Rg2616montomaximoservicios = 0
			.Rg2616montomaximobienes = 0
			.Basedecalculo = []
			.Rg1575regimen = []
			.Rg1575porcentaje = 0
			.Rg1575basedecalculo = []
			.Escala = .F.
			.Segunconvenio = .F.
			.Conveniolocal = 0
			.Conveniomultilateral = 0
			.Conveniomultilextranajuris = 0
			.Convenionoinscripto = 0
			.Iibbtuccoeficientecero = 0
			.Iibbtucreduccionalicuota = 0
			.Regimen = []
			.Iibbtucalicuotanoinscriptos = 0
			.Rg5329porcentaje = 0
			.Rg5329aplicaporarticulo = .F.
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

		if  empty( this.Impuesto_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMDATOSFISCALES]
	endfunc

enddefine