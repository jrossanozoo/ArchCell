
define class Din_ItemCANCELACIONDECOMPRAFacturadetalle as ItemARTICULOSCOMPRA of ItemARTICULOSCOMPRA.prg

	cNombre = 'CANCELACIONDECOMPRA'
	Afe_Letra = []
	Afe_Numero = 0
	Afe_PuntoDeVenta = 0
	MontoProrrateoTotal = 0
	MontoProrrateoRecargoConImpuestos = 0
	Afe_timeStamp = 0
	Articulo_CondicionIvaCompras = 0
	Articulo_PorcentajeIvaCompras = 0
	afe_CantidadOriginal = 0
	MontoPorcentajeDescuentoConImpuesto = 0
	afe_SaldoActual = 0
	MontoProrrateoPercepciones = 0
	afe_SaldoOriginal = 0
	MontoProrrateoRecargoSinImpuestos = 0
	MontoProrrateoDescuentoConImpuestos = 0
	AjustePorRedondeoSinImpuestos = 0
	AjustePorRedondeoConImpuestos = 0
	Comportamiento = 0
	Bruto = 0
	PercepcionIvaRG5329 = 0
	MontoDescuentoSinImpuestos = 0
	Afe_NumInt = 0
	MontoProrrateoDescuentoSinImpuestos = 0
	MontoPorcentajeDescuentoSinImpuesto = 0
	Afe_Cantidad = 0
	MontoDescuentoConImpuestos = 0
	Afe_Saldo = 0
	PorcentajeCFI = 0
	Oferta = 0
	PrecioConImpuestos = 0
	PorcentajeDTO1 = 0
	NroItem = 0
	PrecioDeLista = 0
	MontoIVA = 0
	Neto = 0
	Kit = 0
	Impuestos = 0
	MontoCFI = 0
	PrecioSinImpuestos = 0
	MontoDTO1 = 0
	PorcentajeIVA = 0
	CodigoOrigen = 0
	PrecioUnitario = 0
	Afe_NroItem = 0
	idItem = 0
	Afe_TipoComprobante = 0
	idOrigen = 0
	TipoListaDePrecio = 0
	FueAutorizadoDevolucion = .F.
	EsLibre = .F.
	UsarPrecioDeLista = .F.
	NoProcesarStock = .F.
	Material_PK = []
	Material = null
	Afe_Codigo = []
	CodigoDeBarras = []
	IdItemArticulos = []
	Articulo_PK = []
	Articulo = null
	Unidad_PK = []
	Unidad = null
	Equivalencia_PK = []
	Equivalencia = null
	cAtributoPK = 'Codigo'
	Codigo = []
	ArticuloDetalle = []
	Color_PK = []
	Color = null
	ColorDetalle = []
	Talle = []
	MontoProrrateoIVA = 0
	IDSeniaCancelada = []
	Cantidad = 0
	Precio = 0
	Descuento = 0
	MontoDescuento = 0
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFueautorizadodevolucion()','Fueautorizadodevolucion')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWUsarpreciodelista()','Usarpreciodelista')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CANCELACIONDECOMPRA', 'Facturadetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Material_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Material_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Material_PK = lxVal

		if this.Validar_Material( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Material_Pk', lxValOld, lxVal  )
			This.Setear_Material( lxVal )
			this.EventoDespuesDeSetear( This, 'Material_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Material_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 13, padr( lxVal, 13 ), lxVal )
		this.Articulo_PK = lxVal

		if this.Validar_Articulo( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
			This.Setear_Articulo( lxVal )
			this.EventoDespuesDeSetear( This, 'Articulo_Pk', lxValOld, lxVal  )
			This.Articulo_PK_DespuesDeAsignar()
			If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
				this.TotalizarSumarizado()
			EndIf
			If lxValOld != lxVal or empty( this.Comportamiento ) 
				this.Comportamiento = This.Articulo.Comportamiento
			endif
			If lxValOld != lxVal or empty( this.Percepcionivarg5329 ) 
				this.Percepcionivarg5329 = This.Articulo.PercepcionIvaRG5329
			endif
			If lxValOld != lxVal or empty( this.Material_PK ) 
				this.Material_Pk = This.Articulo.Material_PK
			endif
			If lxValOld != lxVal or empty( this.Articulodetalle ) 
				this.Articulodetalle = This.Articulo.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Articulo_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Unidad_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Unidad_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Unidad.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Unidad )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 3, padr( lxVal, 3 ), lxVal )
		this.Unidad_PK = lxVal

		if this.Validar_Unidad( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Unidad_Pk', lxValOld, lxVal  )
			This.Setear_Unidad( lxVal )
			this.EventoDespuesDeSetear( This, 'Unidad_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Unidad_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Equivalencia_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Equivalencia_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 14, padr( lxVal, 14 ), lxVal )
		this.Equivalencia_PK = lxVal

		if this.Validar_Equivalencia( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
			This.Setear_Equivalencia( lxVal )
			this.EventoDespuesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Equivalencia_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Color_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Color_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 2, padr( lxVal, 2 ), lxVal )
		this.Color_PK = lxVal

		if this.Validar_Color( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
			This.Setear_Color( lxVal )
			this.EventoDespuesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Color_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Material( txVal as variant ) as void

		this.Material.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo( txVal as variant ) as void

		this.Articulo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Unidad( txVal as variant ) as void

		this.Unidad.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Equivalencia( txVal as variant ) as void

		this.Equivalencia.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Color( txVal as variant ) as void

		this.Color.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Material( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaArticuloTipoKit() 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Unidad( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Equivalencia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_letra_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_letra
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_letra( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_letra', lxValOld, lxVal  )
				this.Setear_Afe_letra( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_letra', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_letra', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_letra( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_numero_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_numero
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_numero( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_numero', lxValOld, lxVal  )
				this.Setear_Afe_numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_numero', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_numero', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_puntodeventa_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_puntodeventa
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_puntodeventa( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_puntodeventa', lxValOld, lxVal  )
				this.Setear_Afe_puntodeventa( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_puntodeventa', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_puntodeventa', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_puntodeventa( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateototal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateototal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateototal( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateototal', lxValOld, lxVal  )
				this.Setear_Montoprorrateototal( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateototal', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateototal', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateototal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateorecargoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateorecargoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateorecargoconimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateorecargoconimpuestos', lxValOld, lxVal  )
				this.Setear_Montoprorrateorecargoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateorecargoconimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateorecargoconimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateorecargoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_timestamp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_timestamp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_timestamp( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_timestamp', lxValOld, lxVal  )
				this.Setear_Afe_timestamp( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_timestamp', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_timestamp', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_timestamp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_condicionivacompras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_condicionivacompras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulo_condicionivacompras( lxVal )
				this.EventoAntesDeSetear( This, 'Articulo_condicionivacompras', lxValOld, lxVal  )
				this.Setear_Articulo_condicionivacompras( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_condicionivacompras', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_condicionivacompras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Articulo_condicionivacompras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_porcentajeivacompras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_porcentajeivacompras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulo_porcentajeivacompras( lxVal )
				this.EventoAntesDeSetear( This, 'Articulo_porcentajeivacompras', lxValOld, lxVal  )
				this.Setear_Articulo_porcentajeivacompras( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_porcentajeivacompras', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_porcentajeivacompras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Articulo_porcentajeivacompras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_cantidadoriginal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_cantidadoriginal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_cantidadoriginal( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_cantidadoriginal', lxValOld, lxVal  )
				this.Setear_Afe_cantidadoriginal( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_cantidadoriginal', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_cantidadoriginal', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_cantidadoriginal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoporcentajedescuentoconimpuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoporcentajedescuentoconimpuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoporcentajedescuentoconimpuesto( lxVal )
				this.EventoAntesDeSetear( This, 'Montoporcentajedescuentoconimpuesto', lxValOld, lxVal  )
				this.Setear_Montoporcentajedescuentoconimpuesto( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoporcentajedescuentoconimpuesto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Montoporcentajedescuentoconimpuesto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoporcentajedescuentoconimpuesto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoporcentajedescuentoconimpuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_saldoactual_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_saldoactual
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_saldoactual( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_saldoactual', lxValOld, lxVal  )
				this.Setear_Afe_saldoactual( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldoactual', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_saldoactual', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_saldoactual( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateopercepciones_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateopercepciones
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateopercepciones( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateopercepciones', lxValOld, lxVal  )
				this.Setear_Montoprorrateopercepciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateopercepciones', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateopercepciones', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateopercepciones( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_saldooriginal_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_saldooriginal
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_saldooriginal( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_saldooriginal', lxValOld, lxVal  )
				this.Setear_Afe_saldooriginal( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldooriginal', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_saldooriginal', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_saldooriginal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateorecargosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateorecargosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateorecargosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateorecargosinimpuestos', lxValOld, lxVal  )
				this.Setear_Montoprorrateorecargosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateorecargosinimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateorecargosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateorecargosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateodescuentoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateodescuentoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateodescuentoconimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateodescuentoconimpuestos', lxValOld, lxVal  )
				this.Setear_Montoprorrateodescuentoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateodescuentoconimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateodescuentoconimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateodescuentoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ajusteporredondeosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ajusteporredondeosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ajusteporredondeosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Ajusteporredondeosinimpuestos', lxValOld, lxVal  )
				this.Setear_Ajusteporredondeosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Ajusteporredondeosinimpuestos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Ajusteporredondeosinimpuestos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ajusteporredondeosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ajusteporredondeosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ajusteporredondeoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ajusteporredondeoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ajusteporredondeoconimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Ajusteporredondeoconimpuestos', lxValOld, lxVal  )
				this.Setear_Ajusteporredondeoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Ajusteporredondeoconimpuestos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Ajusteporredondeoconimpuestos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Ajusteporredondeoconimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Ajusteporredondeoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comportamiento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comportamiento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comportamiento( lxVal )
				this.EventoAntesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
				this.Setear_Comportamiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comportamiento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comportamiento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bruto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bruto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bruto( lxVal )
				this.EventoAntesDeSetear( This, 'Bruto', lxValOld, lxVal  )
				this.Setear_Bruto( lxVal )
				this.EventoDespuesDeSetear( This, 'Bruto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Bruto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Bruto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Bruto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Percepcionivarg5329_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Percepcionivarg5329
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Percepcionivarg5329( lxVal )
				this.EventoAntesDeSetear( This, 'Percepcionivarg5329', lxValOld, lxVal  )
				this.Setear_Percepcionivarg5329( lxVal )
				this.EventoDespuesDeSetear( This, 'Percepcionivarg5329', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Percepcionivarg5329', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Percepcionivarg5329( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montodescuentosinimpuestos', lxValOld, lxVal  )
				this.Setear_Montodescuentosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuentosinimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodescuentosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_numint_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_numint
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_numint( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_numint', lxValOld, lxVal  )
				this.Setear_Afe_numint( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_numint', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_numint', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_numint( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateodescuentosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateodescuentosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateodescuentosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateodescuentosinimpuestos', lxValOld, lxVal  )
				this.Setear_Montoprorrateodescuentosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateodescuentosinimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateodescuentosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateodescuentosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoporcentajedescuentosinimpuesto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoporcentajedescuentosinimpuesto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoporcentajedescuentosinimpuesto( lxVal )
				this.EventoAntesDeSetear( This, 'Montoporcentajedescuentosinimpuesto', lxValOld, lxVal  )
				this.Setear_Montoporcentajedescuentosinimpuesto( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoporcentajedescuentosinimpuesto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoporcentajedescuentosinimpuesto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoporcentajedescuentosinimpuesto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_cantidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_cantidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_cantidad( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_cantidad', lxValOld, lxVal  )
				this.Setear_Afe_cantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_cantidad', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_cantidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuentoconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuentoconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuentoconimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Montodescuentoconimpuestos', lxValOld, lxVal  )
				this.Setear_Montodescuentoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuentoconimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodescuentoconimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_saldo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_saldo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_saldo( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_saldo', lxValOld, lxVal  )
				this.Setear_Afe_saldo( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldo', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Afe_saldo', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_saldo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_saldo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajecfi_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajecfi
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajecfi( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajecfi', lxValOld, lxVal  )
				this.Setear_Porcentajecfi( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajecfi', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajecfi', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajecfi( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Oferta_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Oferta
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Oferta( lxVal )
				this.EventoAntesDeSetear( This, 'Oferta', lxValOld, lxVal  )
				this.Setear_Oferta( lxVal )
				this.EventoDespuesDeSetear( This, 'Oferta', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Oferta', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Oferta( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Precioconimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Precioconimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Precioconimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Precioconimpuestos', lxValOld, lxVal  )
				this.Setear_Precioconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Precioconimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Precioconimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Precioconimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajedto1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajedto1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajedto1( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajedto1', lxValOld, lxVal  )
				this.Setear_Porcentajedto1( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajedto1', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajedto1', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajedto1( lxVal ) 
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
	function Preciodelista_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciodelista
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciodelista( lxVal )
				this.EventoAntesDeSetear( This, 'Preciodelista', lxValOld, lxVal  )
				this.Setear_Preciodelista( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciodelista', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Preciodelista', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Preciodelista( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoiva( lxVal )
				this.EventoAntesDeSetear( This, 'Montoiva', lxValOld, lxVal  )
				this.Setear_Montoiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoiva', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoiva', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Neto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Neto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Neto( lxVal )
				this.EventoAntesDeSetear( This, 'Neto', lxValOld, lxVal  )
				this.Setear_Neto( lxVal )
				this.EventoDespuesDeSetear( This, 'Neto', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Neto', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Neto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Neto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Kit_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Kit
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Kit( lxVal )
				this.EventoAntesDeSetear( This, 'Kit', lxValOld, lxVal  )
				this.Setear_Kit( lxVal )
				this.EventoDespuesDeSetear( This, 'Kit', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Kit', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Kit( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Impuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Impuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Impuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Impuestos', lxValOld, lxVal  )
				this.Setear_Impuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Impuestos', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Impuestos', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Impuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Impuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montocfi_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montocfi
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montocfi( lxVal )
				this.EventoAntesDeSetear( This, 'Montocfi', lxValOld, lxVal  )
				this.Setear_Montocfi( lxVal )
				this.EventoDespuesDeSetear( This, 'Montocfi', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montocfi', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montocfi( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preciosinimpuestos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciosinimpuestos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciosinimpuestos( lxVal )
				this.EventoAntesDeSetear( This, 'Preciosinimpuestos', lxValOld, lxVal  )
				this.Setear_Preciosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciosinimpuestos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Preciosinimpuestos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Preciosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodto1_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodto1
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodto1( lxVal )
				this.EventoAntesDeSetear( This, 'Montodto1', lxValOld, lxVal  )
				this.Setear_Montodto1( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodto1', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodto1', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodto1( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Porcentajeiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Porcentajeiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Porcentajeiva( lxVal )
				this.EventoAntesDeSetear( This, 'Porcentajeiva', lxValOld, lxVal  )
				this.Setear_Porcentajeiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajeiva', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Porcentajeiva', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Porcentajeiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigoorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Codigoorigen', lxValOld, lxVal  )
				this.Setear_Codigoorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigoorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigoorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preciounitario_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciounitario
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciounitario( lxVal )
				this.EventoAntesDeSetear( This, 'Preciounitario', lxValOld, lxVal  )
				this.Setear_Preciounitario( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciounitario', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Preciounitario', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Preciounitario( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_nroitem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_nroitem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_nroitem( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_nroitem', lxValOld, lxVal  )
				this.Setear_Afe_nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_nroitem', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_nroitem', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditem( lxVal )
				this.EventoAntesDeSetear( This, 'Iditem', lxValOld, lxVal  )
				this.Setear_Iditem( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditem', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditem', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_tipocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_tipocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_tipocomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_tipocomprobante', lxValOld, lxVal  )
				this.Setear_Afe_tipocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_tipocomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_tipocomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_tipocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Idorigen', lxValOld, lxVal  )
				this.Setear_Idorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Idorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipolistadeprecio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipolistadeprecio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipolistadeprecio( lxVal )
				this.EventoAntesDeSetear( This, 'Tipolistadeprecio', lxValOld, lxVal  )
				this.Setear_Tipolistadeprecio( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipolistadeprecio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipolistadeprecio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipolistadeprecio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fueautorizadodevolucion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fueautorizadodevolucion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fueautorizadodevolucion( lxVal )
				this.EventoAntesDeSetear( This, 'Fueautorizadodevolucion', lxValOld, lxVal  )
				this.Setear_Fueautorizadodevolucion( lxVal )
				this.EventoDespuesDeSetear( This, 'Fueautorizadodevolucion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fueautorizadodevolucion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fueautorizadodevolucion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Eslibre_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Eslibre
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Eslibre( lxVal )
				this.EventoAntesDeSetear( This, 'Eslibre', lxValOld, lxVal  )
				this.Setear_Eslibre( lxVal )
				this.EventoDespuesDeSetear( This, 'Eslibre', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Eslibre', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Eslibre( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usarpreciodelista_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usarpreciodelista
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usarpreciodelista( lxVal )
				this.EventoAntesDeSetear( This, 'Usarpreciodelista', lxValOld, lxVal  )
				this.Setear_Usarpreciodelista( lxVal )
				this.EventoDespuesDeSetear( This, 'Usarpreciodelista', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Usarpreciodelista', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Usarpreciodelista( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Noprocesarstock_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Noprocesarstock
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Noprocesarstock( lxVal )
				this.EventoAntesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
				this.Setear_Noprocesarstock( lxVal )
				this.EventoDespuesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Noprocesarstock', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Noprocesarstock( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_codigo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_codigo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_codigo( lxVal )
				this.EventoAntesDeSetear( This, 'Afe_codigo', lxValOld, lxVal  )
				this.Setear_Afe_codigo( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_codigo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Afe_codigo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Afe_codigo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigodebarras_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigodebarras
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigodebarras( lxVal )
				this.EventoAntesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
				this.Setear_Codigodebarras( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigodebarras', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigodebarras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemarticulos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemarticulos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemarticulos( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
				this.Setear_Iditemarticulos( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemarticulos', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemarticulos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
				this.Setear_Articulodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Articulodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Colordetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Colordetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Colordetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
				this.Setear_Colordetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Colordetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Colordetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Talle( lxVal )
				this.EventoAntesDeSetear( This, 'Talle', lxValOld, lxVal  )
				this.Setear_Talle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Talle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Talle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateoiva_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateoiva
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateoiva( lxVal )
				this.EventoAntesDeSetear( This, 'Montoprorrateoiva', lxValOld, lxVal  )
				this.Setear_Montoprorrateoiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateoiva', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoprorrateoiva', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoprorrateoiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idseniacancelada_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idseniacancelada
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idseniacancelada( lxVal )
				this.EventoAntesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
				this.Setear_Idseniacancelada( lxVal )
				this.EventoDespuesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idseniacancelada', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idseniacancelada( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cantidad_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cantidad
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cantidad( lxVal )
				this.EventoAntesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
				this.Setear_Cantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Cantidad', lxValOld, lxVal  )
				If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
					this.AcumularSumarizado( .t., 'Cantidad', lxVal, lxValOld)
				EndIf
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cantidad', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Precio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Precio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Precio( lxVal )
				this.ValidarDominio_Preciononegativoparametrofoco( lxVal )
				this.EventoAntesDeSetear( This, 'Precio', lxValOld, lxVal  )
				this.Setear_Precio( lxVal )
				this.EventoDespuesDeSetear( This, 'Precio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Precio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Precio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descuento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descuento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descuento( lxVal )
				this.EventoAntesDeSetear( This, 'Descuento', lxValOld, lxVal  )
				this.Setear_Descuento( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Descuento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Descuento( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montodescuento_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montodescuento
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montodescuento( lxVal )
				this.EventoAntesDeSetear( This, 'Montodescuento', lxValOld, lxVal  )
				this.Setear_Montodescuento( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuento', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montodescuento', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montodescuento( lxVal ) 
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
	function Setear_Afe_letra( txVal as variant ) as void

		this.Afe_letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_numero( txVal as variant ) as void

		this.Afe_numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_puntodeventa( txVal as variant ) as void

		this.Afe_puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateototal( txVal as variant ) as void

		this.Montoprorrateototal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateorecargoconimpuestos( txVal as variant ) as void

		this.Montoprorrateorecargoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_timestamp( txVal as variant ) as void

		this.Afe_timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_condicionivacompras( txVal as variant ) as void

		this.Articulo_condicionivacompras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_porcentajeivacompras( txVal as variant ) as void

		this.Articulo_porcentajeivacompras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_cantidadoriginal( txVal as variant ) as void

		this.Afe_cantidadoriginal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoporcentajedescuentoconimpuesto( txVal as variant ) as void

		this.Montoporcentajedescuentoconimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldoactual( txVal as variant ) as void

		this.Afe_saldoactual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateopercepciones( txVal as variant ) as void

		this.Montoprorrateopercepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldooriginal( txVal as variant ) as void

		this.Afe_saldooriginal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateorecargosinimpuestos( txVal as variant ) as void

		this.Montoprorrateorecargosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateodescuentoconimpuestos( txVal as variant ) as void

		this.Montoprorrateodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajusteporredondeosinimpuestos( txVal as variant ) as void

		this.Ajusteporredondeosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajusteporredondeoconimpuestos( txVal as variant ) as void

		this.Ajusteporredondeoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comportamiento( txVal as variant ) as void

		this.Comportamiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bruto( txVal as variant ) as void

		this.Bruto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepcionivarg5329( txVal as variant ) as void

		this.Percepcionivarg5329 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos( txVal as variant ) as void

		this.Montodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_numint( txVal as variant ) as void

		this.Afe_numint = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateodescuentosinimpuestos( txVal as variant ) as void

		this.Montoprorrateodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoporcentajedescuentosinimpuesto( txVal as variant ) as void

		this.Montoporcentajedescuentosinimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_cantidad( txVal as variant ) as void

		this.Afe_cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos( txVal as variant ) as void

		this.Montodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldo( txVal as variant ) as void

		this.Afe_saldo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajecfi( txVal as variant ) as void

		this.Porcentajecfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Oferta( txVal as variant ) as void

		this.Oferta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precioconimpuestos( txVal as variant ) as void

		this.Precioconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedto1( txVal as variant ) as void

		this.Porcentajedto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciodelista( txVal as variant ) as void

		this.Preciodelista = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoiva( txVal as variant ) as void

		this.Montoiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Neto( txVal as variant ) as void

		this.Neto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Kit( txVal as variant ) as void

		this.Kit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impuestos( txVal as variant ) as void

		this.Impuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocfi( txVal as variant ) as void

		this.Montocfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinimpuestos( txVal as variant ) as void

		this.Preciosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodto1( txVal as variant ) as void

		this.Montodto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajeiva( txVal as variant ) as void

		this.Porcentajeiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoorigen( txVal as variant ) as void

		this.Codigoorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciounitario( txVal as variant ) as void

		this.Preciounitario = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_nroitem( txVal as variant ) as void

		this.Afe_nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditem( txVal as variant ) as void

		this.Iditem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_tipocomprobante( txVal as variant ) as void

		this.Afe_tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idorigen( txVal as variant ) as void

		this.Idorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipolistadeprecio( txVal as variant ) as void

		this.Tipolistadeprecio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fueautorizadodevolucion( txVal as variant ) as void

		this.Fueautorizadodevolucion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Eslibre( txVal as variant ) as void

		this.Eslibre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usarpreciodelista( txVal as variant ) as void

		this.Usarpreciodelista = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Noprocesarstock( txVal as variant ) as void

		this.Noprocesarstock = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_codigo( txVal as variant ) as void

		this.Afe_codigo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigodebarras( txVal as variant ) as void

		this.Codigodebarras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemarticulos( txVal as variant ) as void

		this.Iditemarticulos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulodetalle( txVal as variant ) as void

		this.Articulodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colordetalle( txVal as variant ) as void

		this.Colordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talle( txVal as variant ) as void

		this.Talle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateoiva( txVal as variant ) as void

		this.Montoprorrateoiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idseniacancelada( txVal as variant ) as void

		this.Idseniacancelada = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precio( txVal as variant ) as void

		this.Precio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descuento( txVal as variant ) as void

		this.Descuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuento( txVal as variant ) as void

		this.Montodescuento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateototal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateorecargoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_condicionivacompras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_porcentajeivacompras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_cantidadoriginal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoporcentajedescuentoconimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldoactual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateopercepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldooriginal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateorecargosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajusteporredondeosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajusteporredondeoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comportamiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bruto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepcionivarg5329( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_numint( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoporcentajedescuentosinimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajecfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Oferta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precioconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciodelista( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Neto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Kit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajeiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciounitario( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipolistadeprecio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fueautorizadodevolucion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Eslibre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usarpreciodelista( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Noprocesarstock( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_codigo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigodebarras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemarticulos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateoiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idseniacancelada( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Material_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Material ) = 'O' or isnull( this.Material ) )
					this.Material = _Screen.zoo.instanciarentidad( 'Material' )
					this.Material.lEsSubEntidad = .t.
					this.enlazar( 'Material.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Material.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Material.CODIGO # this.Material_PK
						this.Material.CODIGO = this.Material_PK
					endif
				endif
			endif
		endif
		return this.Material
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
	function Unidad_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Unidad ) = 'O' or isnull( this.Unidad ) )
					this.Unidad = _Screen.zoo.instanciarentidad( 'Unidaddemedida' )
					this.Unidad.lEsSubEntidad = .t.
					this.enlazar( 'Unidad.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Unidad.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Unidad.CODIGO # this.Unidad_PK
						this.Unidad.CODIGO = this.Unidad_PK
					endif
				endif
			endif
		endif
		return this.Unidad
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Equivalencia_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Equivalencia ) = 'O' or isnull( this.Equivalencia ) )
					this.Equivalencia = _Screen.zoo.instanciarentidad( 'Equivalencia' )
					this.Equivalencia.lEsSubEntidad = .t.
					this.enlazar( 'Equivalencia.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Equivalencia.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Equivalencia.CODIGO # this.Equivalencia_PK
						this.Equivalencia.CODIGO = this.Equivalencia_PK
					endif
				endif
			endif
		endif
		return this.Equivalencia
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

				.Afe_letra = []
				.Afe_numero = 0
				.Afe_puntodeventa = 0
				.Montoprorrateototal = 0
				.Montoprorrateorecargoconimpuestos = 0
				.Afe_timestamp = 0
				.Articulo_condicionivacompras = 0
				.Articulo_porcentajeivacompras = 0
				.Afe_cantidadoriginal = 0
				.Montoporcentajedescuentoconimpuesto = 0
				.Afe_saldoactual = 0
				.Montoprorrateopercepciones = 0
				.Afe_saldooriginal = 0
				.Montoprorrateorecargosinimpuestos = 0
				.Montoprorrateodescuentoconimpuestos = 0
				.Ajusteporredondeosinimpuestos = 0
				.Ajusteporredondeoconimpuestos = 0
				.Comportamiento = 0
				.Bruto = 0
				.Percepcionivarg5329 = 0
				.Montodescuentosinimpuestos = 0
				.Afe_numint = 0
				.Montoprorrateodescuentosinimpuestos = 0
				.Montoporcentajedescuentosinimpuesto = 0
				.Afe_cantidad = 0
				.Montodescuentoconimpuestos = 0
				.Afe_saldo = 0
				.Porcentajecfi = 0
				.Oferta = 0
				.Precioconimpuestos = 0
				.Porcentajedto1 = 0
				.Preciodelista = 0
				.Montoiva = 0
				.Neto = 0
				.Kit = 0
				.Impuestos = 0
				.Montocfi = 0
				.Preciosinimpuestos = 0
				.Montodto1 = 0
				.Porcentajeiva = 0
				.Codigoorigen = 0
				.Preciounitario = 0
				.Afe_nroitem = 0
				.Iditem = 0
				.Afe_tipocomprobante = 0
				.Idorigen = 0
				.Tipolistadeprecio = 0
				.Usarpreciodelista = .F.
				.Noprocesarstock = .F.
				.Material_PK = []
				.Afe_codigo = []
				.Iditemarticulos = []
				.Articulo_PK = []
				.Unidad_PK = []
				.Equivalencia_PK = []
				.Codigo = []
				.Articulodetalle = []
				.Color_PK = []
				.Colordetalle = []
				.Talle = []
				.Montoprorrateoiva = 0
				.Idseniacancelada = []
				.Cantidad = 0
				.Precio = 0
				.Descuento = 0
				.Montodescuento = 0
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
	Function ValorSugeridoFWFueautorizadodevolucion() as void
		with this
			.Fueautorizadodevolucion = .T.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFueautorizadodevolucion() as void
		with this
			.ValorSugeridoFWFueautorizadodevolucion()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWUsarpreciodelista() as void
		with this
			.Usarpreciodelista = .T.
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoUsarpreciodelista() as void
		with this
			.ValorSugeridoFWUsarpreciodelista()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoArticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Articulo" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoArticulodetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Articulodetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Articulodetalle' )
						.Articulodetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Color" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoColordetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Colordetalle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Colordetalle' )
						.Colordetalle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Detalle para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Talle" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Talle' )
						.Talle = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCantidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Cantidad" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Cantidad' )
						.Cantidad = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPrecio() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Precio" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Precio' )
						.Precio = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Precio para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Descuento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Descuento' )
						.Descuento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoMontodescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CANCELACIONDECOMPRA", "Facturadetalle", "Montodescuento" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Montodescuento' )
						.Montodescuento = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto desc. para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
	function Articulo_PK_DespuesDeAsignar() as void
		this.AsignarCondicionYPorcentajeDeIva()                                                             
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Preciononegativoparametrofoco( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Preciononegativoparametrofoco( txVal )
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
			.Fueautorizadodevolucion = .F.
			.Eslibre = .F.
			.Codigodebarras = []
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

		if  empty( this.Articulo_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMARTICULOSCANCOMPRA]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidaArticuloTipoKit() as void
		if this.Articulo.Comportamiento = 4
			goServicios.Errores.LevantarExcepcion( 'No se pueden ingresar artículos de tipo kit.' )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.ARTICULO_PK) and dodefault()
		return llRetorno
	endfunc

enddefine