
define class Din_ItemFACTURAELECTRONICADECREDITOImpuestoscomprobante as ItemActivo of ItemActivo.prg

	cNombre = 'FACTURAELECTRONICADECREDITO'
	MontoBase = 0
	Minimo = 0
	Porcentaje = 0
	CertificadoSIRE = []
	MinimoNoImponible = 0
	Monto = 0
	NroItem = 0
	CodSeguridadSIRE = []
	BaseDeCalculo = []
	RegimenImpositivo = []
	TipoImpuesto = []
	CodigoInterno = []
	CodigoImpuesto = []
	Descripcion = []
	Jurisdiccion_PK = []
	Jurisdiccion = null
	cAtributoPK = 'Codigo'
	Codigo = []
	RG5329Porcentaje = 0
	RG5329AplicaPorArticulo = .F.
	oCompEnBaseA = null
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'FACTURAELECTRONICADECREDITO', 'Impuestoscomprobante')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
			this.EventoAntesDeSetear( This, 'Jurisdiccion_Pk', lxValOld, lxVal  )
			This.Setear_Jurisdiccion( lxVal )
			this.EventoDespuesDeSetear( This, 'Jurisdiccion_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Jurisdiccion_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Jurisdiccion( txVal as variant ) as void

		this.Jurisdiccion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Jurisdiccion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
	function Minimo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Minimo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Minimo( lxVal )
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
	function Tipoimpuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipoimpuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipoimpuesto( lxVal )
				this.EventoAntesDeSetear( This, 'Tipoimpuesto', lxValOld, lxVal  )
				this.Setear_Tipoimpuesto( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipoimpuesto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipoimpuesto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipoimpuesto( lxVal ) 
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
	function Codigoimpuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoimpuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoimpuesto( lxVal )
				this.EventoAntesDeSetear( This, 'Codigoimpuesto', lxValOld, lxVal  )
				this.Setear_Codigoimpuesto( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoimpuesto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigoimpuesto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigoimpuesto( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Descripcion', lxValOld, lxVal  )
				this.Setear_Descripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Descripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descripcion( lxVal ) 
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
	function Setear_Montobase( txVal as variant ) as void

		this.Montobase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimo( txVal as variant ) as void

		this.Minimo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentaje( txVal as variant ) as void

		this.Porcentaje = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Certificadosire( txVal as variant ) as void

		this.Certificadosire = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Minimonoimponible( txVal as variant ) as void

		this.Minimonoimponible = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codseguridadsire( txVal as variant ) as void

		this.Codseguridadsire = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basedecalculo( txVal as variant ) as void

		this.Basedecalculo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Regimenimpositivo( txVal as variant ) as void

		this.Regimenimpositivo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipoimpuesto( txVal as variant ) as void

		this.Tipoimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigointerno( txVal as variant ) as void

		this.Codigointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoimpuesto( txVal as variant ) as void

		this.Codigoimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
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
	function Validar_Montobase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentaje( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Certificadosire( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Minimonoimponible( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codseguridadsire( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basedecalculo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Regimenimpositivo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipoimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

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
	function oCompEnBaseA_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompEnBaseA ) = 'O' or isnull( this.oCompEnBaseA ) )
			this.oCompEnBaseA = _Screen.zoo.InstanciarComponente( 'ComponenteEnBaseA' )
		this.oCompEnBaseA.Inicializar()
		this.enlazar( 'oCompEnBaseA.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompEnBaseA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompEnBaseA
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.cComprobante + " " + This.Letra + " " + transform( This.PuntoDeVenta, "@LZ 9999" ) + "-" + transform( This.Numero, "@LZ 99999999" ) ) )
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

				.Montobase = 0
				.Minimo = 0
				.Porcentaje = 0
				.Certificadosire = []
				.Minimonoimponible = 0
				.Monto = 0
				.Codseguridadsire = []
				.Basedecalculo = []
				.Regimenimpositivo = []
				.Tipoimpuesto = []
				.Codigointerno = []
				.Codigoimpuesto = []
				.Descripcion = []
				.Jurisdiccion_PK = []
				.Codigo = []
				.Rg5329porcentaje = 0
				.Rg5329aplicaporarticulo = .F.
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
	function ValidarSiCambioElValorDelAtributo( tcAtributo as String, txValOld as variant, txVal as variant ) as Boolean
		local llRetorno as Boolean
		llRetorno = dodefault( tcAtributo, txValOld, txVal )
		if pemstatus( this, 'NroItem', 5 ) and this.NroItem > 0 and pemstatus( this, 'oDetalle', 5 ) and type( 'this.oDetalle' ) = 'O'
			local lcCondicion as String
			lcCondicion = 'this.oDetalle.Item[ this.NroItem ].' + tcAtributo + ' != txVal'
			llRetorno = llRetorno and ( &lcCondicion )
		endif
		return llRetorno
	endfunc

	*-----------------------------------------------------------------------------------------
	function EventoCambioParticipantePromocion() as Void
		*
	endfunc
	*-----------------------------------------------------------------------------------------
	function EventoActualizarEmail() as Void
		*
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMIMPUESTOVENTAS]
	endfunc

enddefine