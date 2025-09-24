
define class Din_ItemNOTADECREDITOELECTRONICADECREDITOKitsdetalle as ItemKits of ItemKits.prg

	cNombre = 'NOTADECREDITOELECTRONICADECREDITO'
	Afe_PuntoDeVenta = 0
	lHabilitarAfe_PuntoDeVenta = .T.
	Afe_Numero = 0
	lHabilitarAfe_Numero = .T.
	Afe_Letra = []
	lHabilitarAfe_Letra = .T.
	CodigoGTIN = []
	lHabilitarCodigoGTIN = .T.
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	IdItemArticulos = []
	lHabilitarIdItemArticulos = .T.
	CodigoAutorizacionDJCP = []
	lHabilitarCodigoAutorizacionDJCP = .T.
	Afe_Codigo = []
	lHabilitarAfe_Codigo = .T.
	afe_codigo_Aux = []
	lHabilitarafe_codigo_Aux = .T.
	iditemarticulos_Aux = []
	lHabilitariditemarticulos_Aux = .T.
	IdKit = []
	lHabilitarIdKit = .T.
	Unidad_PK = []
	Unidad = null
	lHabilitarUnidad_PK = .T.
	OrdenDeServicio = []
	lHabilitarOrdenDeServicio = .T.
	CodigoDeBarras = []
	lHabilitarCodigoDeBarras = .T.
	PrecioConImpuestosSinRedondear = 0
	lHabilitarPrecioConImpuestosSinRedondear = .T.
	PrecioSinImpuestosSinRedondear = 0
	lHabilitarPrecioSinImpuestosSinRedondear = .T.
	PrecioSinRedondear = 0
	lHabilitarPrecioSinRedondear = .T.
	TipoDeItem = 0
	lHabilitarTipoDeItem = .T.
	AjustePorRedondeoConImpuestos = 0
	lHabilitarAjustePorRedondeoConImpuestos = .T.
	Bruto = 0
	lHabilitarBruto = .T.
	MontoDescuentoSinImpuestos = 0
	lHabilitarMontoDescuentoSinImpuestos = .T.
	MontoDescuentoConImpuestos = 0
	lHabilitarMontoDescuentoConImpuestos = .T.
	MontoProrrateoDescuentoConImpuestos = 0
	lHabilitarMontoProrrateoDescuentoConImpuestos = .T.
	MontoProrrateoPercepciones = 0
	lHabilitarMontoProrrateoPercepciones = .T.
	MontoProrrateoRecargoSinImpuestos = 0
	lHabilitarMontoProrrateoRecargoSinImpuestos = .T.
	PorcentajeDTO1 = 0
	lHabilitarPorcentajeDTO1 = .T.
	MontoPorcentajeDescuentoSinImpuesto = 0
	lHabilitarMontoPorcentajeDescuentoSinImpuesto = .T.
	AjustePorRedondeoSinImpuestos = 0
	lHabilitarAjustePorRedondeoSinImpuestos = .T.
	Stock = 0
	lHabilitarStock = .T.
	MontoDTO1 = 0
	lHabilitarMontoDTO1 = .T.
	Impuestos = 0
	lHabilitarImpuestos = .T.
	Kit = 0
	lHabilitarKit = .T.
	Comportamiento = 0
	lHabilitarComportamiento = .T.
	MontoPorcentajeDescuentoConImpuesto = 0
	lHabilitarMontoPorcentajeDescuentoConImpuesto = .T.
	PercepcionIvaRG5329 = 0
	lHabilitarPercepcionIvaRG5329 = .T.
	afe_SaldoLiquidacion = 0
	lHabilitarafe_SaldoLiquidacion = .T.
	MontoProrrateoDescuentoFinancieroSinImp = 0
	lHabilitarMontoProrrateoDescuentoFinancieroSinImp = .T.
	MontoProrrateoRecargoFinancieroSinImp = 0
	lHabilitarMontoProrrateoRecargoFinancieroSinImp = .T.
	TasaImpuestoInterno = 0
	lHabilitarTasaImpuestoInterno = .T.
	MontoCFI = 0
	lHabilitarMontoCFI = .T.
	MontoImpuestoInterno = 0
	lHabilitarMontoImpuestoInterno = .T.
	TieneRestriccion = 0
	lHabilitarTieneRestriccion = .T.
	MontoProrrateoTotal = 0
	lHabilitarMontoProrrateoTotal = .T.
	MontoProrrateoDescuentoSinImpuestos = 0
	lHabilitarMontoProrrateoDescuentoSinImpuestos = .T.
	MontoProrrateoRecargoConImpuestos = 0
	lHabilitarMontoProrrateoRecargoConImpuestos = .T.
	CodigoOrigen = 0
	lHabilitarCodigoOrigen = .T.
	idOrigen = 0
	lHabilitaridOrigen = .T.
	Afe_NroItem = 0
	lHabilitarAfe_NroItem = .T.
	NroItem = 0
	lHabilitarNroItem = .T.
	Oferta = 0
	lHabilitarOferta = .T.
	idItem = 0
	lHabilitaridItem = .T.
	PorcentajeCFI = 0
	lHabilitarPorcentajeCFI = .T.
	PrecioConImpuestos = 0
	lHabilitarPrecioConImpuestos = .T.
	PorcentajeIVA = 0
	lHabilitarPorcentajeIVA = .T.
	PrecioDeLista = 0
	lHabilitarPrecioDeLista = .T.
	PrecioSinImpuestos = 0
	lHabilitarPrecioSinImpuestos = .T.
	TipoListaDePrecio = 0
	lHabilitarTipoListaDePrecio = .T.
	PrecioUnitario = 0
	lHabilitarPrecioUnitario = .T.
	Neto = 0
	lHabilitarNeto = .T.
	Afe_TipoComprobante = 0
	lHabilitarAfe_TipoComprobante = .T.
	Afe_Cantidad = 0
	lHabilitarAfe_Cantidad = .T.
	MontoIVA = 0
	lHabilitarMontoIVA = .T.
	Afe_timeStamp = 0
	lHabilitarAfe_timeStamp = .T.
	Afe_Saldo = 0
	lHabilitarAfe_Saldo = .T.
	Articulo_PorcentajeIvaVentas = 0
	lHabilitarArticulo_PorcentajeIvaVentas = .T.
	Articulo_CondicionIvaVentas = 0
	lHabilitarArticulo_CondicionIvaVentas = .T.
	afe_SaldoOriginal = 0
	lHabilitarafe_SaldoOriginal = .T.
	afe_SaldoActual = 0
	lHabilitarafe_SaldoActual = .T.
	afe_CantidadOriginal = 0
	lHabilitarafe_CantidadOriginal = .T.
	CargoParticipantes = .F.
	lHabilitarCargoParticipantes = .T.
	EsLibre = .F.
	lHabilitarEsLibre = .T.
	FUEAUTORIZADODEVOLUCION = .F.
	lHabilitarFUEAUTORIZADODEVOLUCION = .T.
	RestringirDescuentos = .F.
	lHabilitarRestringirDescuentos = .T.
	UsarPrecioDeLista = .F.
	lHabilitarUsarPrecioDeLista = .T.
	NoProcesarStock = .F.
	lHabilitarNoProcesarStock = .T.
	NumeroGiftCard_PK = []
	NumeroGiftCard = null
	lHabilitarNumeroGiftCard_PK = .T.
	CodigoMotivoDevolucion_PK = []
	CodigoMotivoDevolucion = null
	lHabilitarCodigoMotivoDevolucion_PK = .T.
	CodigoMotivoDescuento_PK = []
	CodigoMotivoDescuento = null
	lHabilitarCodigoMotivoDescuento_PK = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Equivalencia_PK = []
	Equivalencia = null
	lHabilitarEquivalencia_PK = .T.
	ArticuloDetalle = []
	lHabilitarArticuloDetalle = .T.
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
	IDSeniaCancelada = []
	lHabilitarIDSeniaCancelada = .T.
	MontoProrrateoIVA = 0
	lHabilitarMontoProrrateoIVA = .T.
	MontoProrrateoImpuestoInterno = 0
	lHabilitarMontoProrrateoImpuestoInterno = .T.
	ColorDetalle = []
	lHabilitarColorDetalle = .T.
	TalleDetalle = []
	lHabilitarTalleDetalle = .T.
	Talle_PK = []
	Talle = null
	lHabilitarTalle_PK = .T.
	Cantidad = 0
	lHabilitarCantidad = .T.
	Precio = 0
	lHabilitarPrecio = .T.
	Descuento = 0
	lHabilitarDescuento = .T.
	MontoDescuento = 0
	lHabilitarMontoDescuento = .T.
	Monto = 0
	lHabilitarMonto = .T.
	oCompPrecios = null
	oCompstock = null
	oCompEnBaseA = null
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarAfe_PuntoDeVenta = .T.
		this.lHabilitarAfe_Numero = .T.
		this.lHabilitarAfe_Letra = .T.
		this.lHabilitarCodigoGTIN = .T.
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarIdItemArticulos = .T.
		this.lHabilitarCodigoAutorizacionDJCP = .T.
		this.lHabilitarAfe_Codigo = .T.
		this.lHabilitarafe_codigo_Aux = .T.
		this.lHabilitariditemarticulos_Aux = .T.
		this.lHabilitarIdKit = .T.
		this.lHabilitarUnidad_PK = .T.
		this.lHabilitarOrdenDeServicio = .T.
		this.lHabilitarCodigoDeBarras = .T.
		this.lHabilitarPrecioConImpuestosSinRedondear = .T.
		this.lHabilitarPrecioSinImpuestosSinRedondear = .T.
		this.lHabilitarPrecioSinRedondear = .T.
		this.lHabilitarTipoDeItem = .T.
		this.lHabilitarAjustePorRedondeoConImpuestos = .T.
		this.lHabilitarBruto = .T.
		this.lHabilitarMontoDescuentoSinImpuestos = .T.
		this.lHabilitarMontoDescuentoConImpuestos = .T.
		this.lHabilitarMontoProrrateoDescuentoConImpuestos = .T.
		this.lHabilitarMontoProrrateoPercepciones = .T.
		this.lHabilitarMontoProrrateoRecargoSinImpuestos = .T.
		this.lHabilitarPorcentajeDTO1 = .T.
		this.lHabilitarMontoPorcentajeDescuentoSinImpuesto = .T.
		this.lHabilitarAjustePorRedondeoSinImpuestos = .T.
		this.lHabilitarStock = .T.
		this.lHabilitarMontoDTO1 = .T.
		this.lHabilitarImpuestos = .T.
		this.lHabilitarKit = .T.
		this.lHabilitarComportamiento = .T.
		this.lHabilitarMontoPorcentajeDescuentoConImpuesto = .T.
		this.lHabilitarPercepcionIvaRG5329 = .T.
		this.lHabilitarafe_SaldoLiquidacion = .T.
		this.lHabilitarMontoProrrateoDescuentoFinancieroSinImp = .T.
		this.lHabilitarMontoProrrateoRecargoFinancieroSinImp = .T.
		this.lHabilitarTasaImpuestoInterno = .T.
		this.lHabilitarMontoCFI = .T.
		this.lHabilitarMontoImpuestoInterno = .T.
		this.lHabilitarTieneRestriccion = .T.
		this.lHabilitarMontoProrrateoTotal = .T.
		this.lHabilitarMontoProrrateoDescuentoSinImpuestos = .T.
		this.lHabilitarMontoProrrateoRecargoConImpuestos = .T.
		this.lHabilitarCodigoOrigen = .T.
		this.lHabilitaridOrigen = .T.
		this.lHabilitarAfe_NroItem = .T.
		this.lHabilitarNroItem = .T.
		this.lHabilitarOferta = .T.
		this.lHabilitaridItem = .T.
		this.lHabilitarPorcentajeCFI = .T.
		this.lHabilitarPrecioConImpuestos = .T.
		this.lHabilitarPorcentajeIVA = .T.
		this.lHabilitarPrecioDeLista = .T.
		this.lHabilitarPrecioSinImpuestos = .T.
		this.lHabilitarTipoListaDePrecio = .T.
		this.lHabilitarPrecioUnitario = .T.
		this.lHabilitarNeto = .T.
		this.lHabilitarAfe_TipoComprobante = .T.
		this.lHabilitarAfe_Cantidad = .T.
		this.lHabilitarMontoIVA = .T.
		this.lHabilitarAfe_timeStamp = .T.
		this.lHabilitarAfe_Saldo = .T.
		this.lHabilitarArticulo_PorcentajeIvaVentas = .T.
		this.lHabilitarArticulo_CondicionIvaVentas = .T.
		this.lHabilitarafe_SaldoOriginal = .T.
		this.lHabilitarafe_SaldoActual = .T.
		this.lHabilitarafe_CantidadOriginal = .T.
		this.lHabilitarCargoParticipantes = .T.
		this.lHabilitarEsLibre = .T.
		this.lHabilitarFUEAUTORIZADODEVOLUCION = .T.
		this.lHabilitarRestringirDescuentos = .T.
		this.lHabilitarUsarPrecioDeLista = .T.
		this.lHabilitarNoProcesarStock = .T.
		this.lHabilitarNumeroGiftCard_PK = .T.
		this.lHabilitarCodigoMotivoDevolucion_PK = .T.
		this.lHabilitarCodigoMotivoDescuento_PK = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarEquivalencia_PK = .T.
		this.lHabilitarArticuloDetalle = .T.
		this.lHabilitarColor_PK = .T.
		this.lHabilitarIDSeniaCancelada = .T.
		this.lHabilitarMontoProrrateoIVA = .T.
		this.lHabilitarMontoProrrateoImpuestoInterno = .T.
		this.lHabilitarColorDetalle = .T.
		this.lHabilitarTalleDetalle = .T.
		this.lHabilitarTalle_PK = .T.
		this.lHabilitarCantidad = .T.
		this.lHabilitarPrecio = .T.
		this.lHabilitarDescuento = .T.
		this.lHabilitarMontoDescuento = .T.
		this.lHabilitarMonto = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIditemarticulos()','Iditemarticulos')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWIdkit()','Idkit')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFueautorizadodevolucion()','Fueautorizadodevolucion')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWUsarpreciodelista()','Usarpreciodelista')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWCantidad()','Cantidad')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'NOTADECREDITOELECTRONICADECREDITO', 'Kitsdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
		this.lKitPermiteColorYTalle = goParametros.Felino.GestionDeVentas.HabilitarColorTalleKits
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
			If lxValOld != lxVal or empty( this.Articulodetalle ) 
				this.Articulodetalle = This.Articulo.Descripcion
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Articulo_Pk', This )
					Endif
				EndIf
			else
				this.Articulo_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Articulo)" )
			endif 
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
			if ( this.lHabilitarUnidad_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Unidad_Pk', lxValOld, lxVal  )
				This.Setear_Unidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Unidad_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Unidad_Pk', This )
					Endif
				EndIf
			else
				this.Unidad_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Unidad)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerogiftcard_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerogiftcard_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Numerogiftcard.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Numerogiftcard )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Numerogiftcard_PK = lxVal

		if this.Validar_Numerogiftcard( lxVal, lxValOld )
			if ( this.lHabilitarNumerogiftcard_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Numerogiftcard_Pk', lxValOld, lxVal  )
				This.Setear_Numerogiftcard( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerogiftcard_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerogiftcard_Pk', This )
					Endif
				EndIf
			else
				this.Numerogiftcard_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Numerogiftcard)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodevolucion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigomotivodevolucion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Codigomotivodevolucion_PK = lxVal

		if this.Validar_Codigomotivodevolucion( lxVal, lxValOld )
			if ( this.lHabilitarCodigomotivodevolucion_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Codigomotivodevolucion_Pk', lxValOld, lxVal  )
				This.Setear_Codigomotivodevolucion( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigomotivodevolucion_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigomotivodevolucion_Pk', This )
					Endif
				EndIf
			else
				this.Codigomotivodevolucion_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigomotivodevolucion)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodescuento_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigomotivodescuento_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Codigomotivodescuento_PK = lxVal

		if this.Validar_Codigomotivodescuento( lxVal, lxValOld )
			if ( this.lHabilitarCodigomotivodescuento_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Codigomotivodescuento_Pk', lxValOld, lxVal  )
				This.Setear_Codigomotivodescuento( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigomotivodescuento_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigomotivodescuento_Pk', This )
					Endif
				EndIf
			else
				this.Codigomotivodescuento_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigomotivodescuento)" )
			endif 
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
		lxVal = iif( len( lxVal ) < 20, padr( lxVal, 20 ), lxVal )
		this.Equivalencia_PK = lxVal

		if this.Validar_Equivalencia( lxVal, lxValOld )
			if ( this.lHabilitarEquivalencia_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
				This.Setear_Equivalencia( lxVal )
				this.EventoDespuesDeSetear( This, 'Equivalencia_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Equivalencia_Pk', This )
					Endif
				EndIf
			else
				this.Equivalencia_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Equivalencia)" )
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
				this.EventoAntesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
				This.Setear_Color( lxVal )
				this.EventoDespuesDeSetear( This, 'Color_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Colordetalle ) 
				this.Colordetalle = This.Color.Descripcion
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Color_Pk', This )
					Endif
				EndIf
			else
				this.Color_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Color)" )
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
				this.EventoAntesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
				This.Setear_Talle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talle_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Talledetalle ) 
				this.Talledetalle = This.Talle.Descripcion
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Talle_Pk', This )
					Endif
				EndIf
			else
				this.Talle_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Talle)" )
			endif 
		endif
		dodefault( lxVal )

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
	function Setear_Numerogiftcard( txVal as variant ) as void

		this.Numerogiftcard.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigomotivodevolucion( txVal as variant ) as void

		this.Codigomotivodevolucion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigomotivodescuento( txVal as variant ) as void

		this.Codigomotivodescuento.CODIGO = txVal
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
	function Setear_Talle( txVal as variant ) as void

		this.Talle.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Unidad( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerogiftcard( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigomotivodevolucion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigomotivodescuento( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Equivalencia( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaColorYTalleConKit( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaColorYTalleConKit( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_puntodeventa_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_puntodeventa
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_puntodeventa( lxVal )
				if ( this.lHabilitarAfe_puntodeventa or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_puntodeventa', lxValOld, lxVal  )
					this.Setear_Afe_puntodeventa( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_puntodeventa', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_puntodeventa', This )
						Endif
					EndIf
				else
					this.Afe_puntodeventa = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_puntodeventa)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_puntodeventa( lxVal ) 
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
				if ( this.lHabilitarAfe_numero or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_numero', lxValOld, lxVal  )
					this.Setear_Afe_numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_numero', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_numero', This )
						Endif
					EndIf
				else
					this.Afe_numero = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_numero)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_letra_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_letra
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_letra( lxVal )
				if ( this.lHabilitarAfe_letra or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Afe_letra', lxValOld, lxVal  )
					this.Setear_Afe_letra( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_letra', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_letra', This )
						Endif
					EndIf
				else
					this.Afe_letra = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_letra)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_letra( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigogtin_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigogtin
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigogtin( lxVal )
				if ( this.lHabilitarCodigogtin or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Codigogtin', lxValOld, lxVal  )
					this.Setear_Codigogtin( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigogtin', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigogtin', This )
						Endif
					EndIf
				else
					this.Codigogtin = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigogtin)" )
				endif 
			EndIf
		Else
			This.Setear_Codigogtin( lxVal ) 
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
				if ( this.lHabilitarIditemarticulos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
					this.Setear_Iditemarticulos( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemarticulos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Iditemarticulos', This )
						Endif
					EndIf
				else
					this.Iditemarticulos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Iditemarticulos)" )
				endif 
			EndIf
		Else
			This.Setear_Iditemarticulos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigoautorizaciondjcp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoautorizaciondjcp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoautorizaciondjcp( lxVal )
				if ( this.lHabilitarCodigoautorizaciondjcp or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Codigoautorizaciondjcp', lxValOld, lxVal  )
					this.Setear_Codigoautorizaciondjcp( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoautorizaciondjcp', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigoautorizaciondjcp', This )
						Endif
					EndIf
				else
					this.Codigoautorizaciondjcp = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigoautorizaciondjcp)" )
				endif 
			EndIf
		Else
			This.Setear_Codigoautorizaciondjcp( lxVal ) 
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
				if ( this.lHabilitarAfe_codigo or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Afe_codigo', lxValOld, lxVal  )
					this.Setear_Afe_codigo( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_codigo', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_codigo', This )
						Endif
					EndIf
				else
					this.Afe_codigo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_codigo)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_codigo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_codigo_aux_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_codigo_aux
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_codigo_aux( lxVal )
				if ( this.lHabilitarAfe_codigo_aux or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Afe_codigo_aux', lxValOld, lxVal  )
					this.Setear_Afe_codigo_aux( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_codigo_aux', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_codigo_aux', This )
						Endif
					EndIf
				else
					this.Afe_codigo_aux = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_codigo_aux)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_codigo_aux( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemarticulos_aux_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemarticulos_aux
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemarticulos_aux( lxVal )
				if ( this.lHabilitarIditemarticulos_aux or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Iditemarticulos_aux', lxValOld, lxVal  )
					this.Setear_Iditemarticulos_aux( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemarticulos_aux', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Iditemarticulos_aux', This )
						Endif
					EndIf
				else
					this.Iditemarticulos_aux = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Iditemarticulos_aux)" )
				endif 
			EndIf
		Else
			This.Setear_Iditemarticulos_aux( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idkit_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idkit
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idkit( lxVal )
				if ( this.lHabilitarIdkit or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Idkit', lxValOld, lxVal  )
					this.Setear_Idkit( lxVal )
				this.EventoDespuesDeSetear( This, 'Idkit', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Idkit', This )
						Endif
					EndIf
				else
					this.Idkit = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Idkit)" )
				endif 
			EndIf
		Else
			This.Setear_Idkit( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Ordendeservicio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Ordendeservicio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Ordendeservicio( lxVal )
				if ( this.lHabilitarOrdendeservicio or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Ordendeservicio', lxValOld, lxVal  )
					this.Setear_Ordendeservicio( lxVal )
				this.EventoDespuesDeSetear( This, 'Ordendeservicio', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Ordendeservicio', This )
						Endif
					EndIf
				else
					this.Ordendeservicio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Ordendeservicio)" )
				endif 
			EndIf
		Else
			This.Setear_Ordendeservicio( lxVal ) 
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
				if ( this.lHabilitarCodigodebarras or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
					this.Setear_Codigodebarras( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigodebarras', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigodebarras', This )
						Endif
					EndIf
				else
					this.Codigodebarras = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigodebarras)" )
				endif 
			EndIf
		Else
			This.Setear_Codigodebarras( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Precioconimpuestossinredondear_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Precioconimpuestossinredondear
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Precioconimpuestossinredondear( lxVal )
				if ( this.lHabilitarPrecioconimpuestossinredondear or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Precioconimpuestossinredondear', lxValOld, lxVal  )
					this.Setear_Precioconimpuestossinredondear( lxVal )
				this.EventoDespuesDeSetear( This, 'Precioconimpuestossinredondear', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Precioconimpuestossinredondear', This )
						Endif
					EndIf
				else
					this.Precioconimpuestossinredondear = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Precioconimpuestossinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Precioconimpuestossinredondear( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preciosinimpuestossinredondear_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciosinimpuestossinredondear
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciosinimpuestossinredondear( lxVal )
				if ( this.lHabilitarPreciosinimpuestossinredondear or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Preciosinimpuestossinredondear', lxValOld, lxVal  )
					this.Setear_Preciosinimpuestossinredondear( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciosinimpuestossinredondear', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Preciosinimpuestossinredondear', This )
						Endif
					EndIf
				else
					this.Preciosinimpuestossinredondear = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Preciosinimpuestossinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinimpuestossinredondear( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Preciosinredondear_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Preciosinredondear
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Preciosinredondear( lxVal )
				if ( this.lHabilitarPreciosinredondear or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Preciosinredondear', lxValOld, lxVal  )
					this.Setear_Preciosinredondear( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciosinredondear', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Preciosinredondear', This )
						Endif
					EndIf
				else
					this.Preciosinredondear = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Preciosinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinredondear( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodeitem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodeitem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodeitem( lxVal )
				if ( this.lHabilitarTipodeitem or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tipodeitem', lxValOld, lxVal  )
					this.Setear_Tipodeitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodeitem', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipodeitem', This )
						Endif
					EndIf
				else
					this.Tipodeitem = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Tipodeitem)" )
				endif 
			EndIf
		Else
			This.Setear_Tipodeitem( lxVal ) 
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
				if ( this.lHabilitarAjusteporredondeoconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Ajusteporredondeoconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Ajusteporredondeoconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Ajusteporredondeoconimpuestos( lxVal ) 
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
				if ( this.lHabilitarBruto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Bruto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Bruto)" )
				endif 
			EndIf
		Else
			This.Setear_Bruto( lxVal ) 
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
				if ( this.lHabilitarMontodescuentosinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montodescuentosinimpuestos', lxValOld, lxVal  )
					this.Setear_Montodescuentosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuentosinimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montodescuentosinimpuestos', This )
						Endif
					EndIf
				else
					this.Montodescuentosinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montodescuentosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos( lxVal ) 
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
				if ( this.lHabilitarMontodescuentoconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montodescuentoconimpuestos', lxValOld, lxVal  )
					this.Setear_Montodescuentoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuentoconimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montodescuentoconimpuestos', This )
						Endif
					EndIf
				else
					this.Montodescuentoconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montodescuentoconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateodescuentoconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateodescuentoconimpuestos', lxValOld, lxVal  )
					this.Setear_Montoprorrateodescuentoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateodescuentoconimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateodescuentoconimpuestos', This )
						Endif
					EndIf
				else
					this.Montoprorrateodescuentoconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateodescuentoconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateodescuentoconimpuestos( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateopercepciones or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateopercepciones', lxValOld, lxVal  )
					this.Setear_Montoprorrateopercepciones( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateopercepciones', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateopercepciones', This )
						Endif
					EndIf
				else
					this.Montoprorrateopercepciones = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateopercepciones)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateopercepciones( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateorecargosinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateorecargosinimpuestos', lxValOld, lxVal  )
					this.Setear_Montoprorrateorecargosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateorecargosinimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateorecargosinimpuestos', This )
						Endif
					EndIf
				else
					this.Montoprorrateorecargosinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateorecargosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateorecargosinimpuestos( lxVal ) 
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
				if ( this.lHabilitarPorcentajedto1 or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Porcentajedto1', lxValOld, lxVal  )
					this.Setear_Porcentajedto1( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajedto1', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Porcentajedto1', This )
						Endif
					EndIf
				else
					this.Porcentajedto1 = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Porcentajedto1)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajedto1( lxVal ) 
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
				if ( this.lHabilitarMontoporcentajedescuentosinimpuesto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoporcentajedescuentosinimpuesto', lxValOld, lxVal  )
					this.Setear_Montoporcentajedescuentosinimpuesto( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoporcentajedescuentosinimpuesto', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoporcentajedescuentosinimpuesto', This )
						Endif
					EndIf
				else
					this.Montoporcentajedescuentosinimpuesto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoporcentajedescuentosinimpuesto)" )
				endif 
			EndIf
		Else
			This.Setear_Montoporcentajedescuentosinimpuesto( lxVal ) 
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
				if ( this.lHabilitarAjusteporredondeosinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Ajusteporredondeosinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Ajusteporredondeosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Ajusteporredondeosinimpuestos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Stock_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Stock
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Stock( lxVal )
				if ( this.lHabilitarStock or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Stock', lxValOld, lxVal  )
					this.Setear_Stock( lxVal )
				this.EventoDespuesDeSetear( This, 'Stock', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Stock', This )
						Endif
					EndIf
				else
					this.Stock = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Stock)" )
				endif 
			EndIf
		Else
			This.Setear_Stock( lxVal ) 
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
				if ( this.lHabilitarMontodto1 or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montodto1', lxValOld, lxVal  )
					this.Setear_Montodto1( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodto1', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montodto1', This )
						Endif
					EndIf
				else
					this.Montodto1 = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montodto1)" )
				endif 
			EndIf
		Else
			This.Setear_Montodto1( lxVal ) 
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
				if ( this.lHabilitarImpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Impuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Impuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Impuestos( lxVal ) 
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
				if ( this.lHabilitarKit or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Kit', lxValOld, lxVal  )
					this.Setear_Kit( lxVal )
				this.EventoDespuesDeSetear( This, 'Kit', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Kit', This )
						Endif
					EndIf
				else
					this.Kit = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Kit)" )
				endif 
			EndIf
		Else
			This.Setear_Kit( lxVal ) 
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
				if ( this.lHabilitarComportamiento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
					this.Setear_Comportamiento( lxVal )
				this.EventoDespuesDeSetear( This, 'Comportamiento', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Comportamiento', This )
						Endif
					EndIf
				else
					this.Comportamiento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Comportamiento)" )
				endif 
			EndIf
		Else
			This.Setear_Comportamiento( lxVal ) 
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
				if ( this.lHabilitarMontoporcentajedescuentoconimpuesto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Montoporcentajedescuentoconimpuesto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoporcentajedescuentoconimpuesto)" )
				endif 
			EndIf
		Else
			This.Setear_Montoporcentajedescuentoconimpuesto( lxVal ) 
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
				if ( this.lHabilitarPercepcionivarg5329 or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Percepcionivarg5329', lxValOld, lxVal  )
					this.Setear_Percepcionivarg5329( lxVal )
				this.EventoDespuesDeSetear( This, 'Percepcionivarg5329', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Percepcionivarg5329', This )
						Endif
					EndIf
				else
					this.Percepcionivarg5329 = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Percepcionivarg5329)" )
				endif 
			EndIf
		Else
			This.Setear_Percepcionivarg5329( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Afe_saldoliquidacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Afe_saldoliquidacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Afe_saldoliquidacion( lxVal )
				if ( this.lHabilitarAfe_saldoliquidacion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_saldoliquidacion', lxValOld, lxVal  )
					this.Setear_Afe_saldoliquidacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldoliquidacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_saldoliquidacion', This )
						Endif
					EndIf
				else
					this.Afe_saldoliquidacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_saldoliquidacion)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_saldoliquidacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateodescuentofinancierosinimp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateodescuentofinancierosinimp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateodescuentofinancierosinimp( lxVal )
				if ( this.lHabilitarMontoprorrateodescuentofinancierosinimp or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateodescuentofinancierosinimp', lxValOld, lxVal  )
					this.Setear_Montoprorrateodescuentofinancierosinimp( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateodescuentofinancierosinimp', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateodescuentofinancierosinimp', This )
						Endif
					EndIf
				else
					this.Montoprorrateodescuentofinancierosinimp = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateodescuentofinancierosinimp)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateodescuentofinancierosinimp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateorecargofinancierosinimp_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateorecargofinancierosinimp
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateorecargofinancierosinimp( lxVal )
				if ( this.lHabilitarMontoprorrateorecargofinancierosinimp or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateorecargofinancierosinimp', lxValOld, lxVal  )
					this.Setear_Montoprorrateorecargofinancierosinimp( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateorecargofinancierosinimp', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateorecargofinancierosinimp', This )
						Endif
					EndIf
				else
					this.Montoprorrateorecargofinancierosinimp = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateorecargofinancierosinimp)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateorecargofinancierosinimp( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tasaimpuestointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tasaimpuestointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tasaimpuestointerno( lxVal )
				if ( this.lHabilitarTasaimpuestointerno or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tasaimpuestointerno', lxValOld, lxVal  )
					this.Setear_Tasaimpuestointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Tasaimpuestointerno', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tasaimpuestointerno', This )
						Endif
					EndIf
				else
					this.Tasaimpuestointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Tasaimpuestointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Tasaimpuestointerno( lxVal ) 
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
				if ( this.lHabilitarMontocfi or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montocfi', lxValOld, lxVal  )
					this.Setear_Montocfi( lxVal )
				this.EventoDespuesDeSetear( This, 'Montocfi', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montocfi', This )
						Endif
					EndIf
				else
					this.Montocfi = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montocfi)" )
				endif 
			EndIf
		Else
			This.Setear_Montocfi( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoimpuestointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoimpuestointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoimpuestointerno( lxVal )
				if ( this.lHabilitarMontoimpuestointerno or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoimpuestointerno', lxValOld, lxVal  )
					this.Setear_Montoimpuestointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoimpuestointerno', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoimpuestointerno', This )
						Endif
					EndIf
				else
					this.Montoimpuestointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoimpuestointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Montoimpuestointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tienerestriccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tienerestriccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tienerestriccion( lxVal )
				if ( this.lHabilitarTienerestriccion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tienerestriccion', lxValOld, lxVal  )
					this.Setear_Tienerestriccion( lxVal )
				this.EventoDespuesDeSetear( This, 'Tienerestriccion', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Tienerestriccion', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tienerestriccion', This )
						Endif
					EndIf
				else
					this.Tienerestriccion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Tienerestriccion)" )
				endif 
			EndIf
		Else
			This.Setear_Tienerestriccion( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateototal or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateototal', lxValOld, lxVal  )
					this.Setear_Montoprorrateototal( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateototal', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateototal', This )
						Endif
					EndIf
				else
					this.Montoprorrateototal = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateototal)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateototal( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateodescuentosinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateodescuentosinimpuestos', lxValOld, lxVal  )
					this.Setear_Montoprorrateodescuentosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateodescuentosinimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateodescuentosinimpuestos', This )
						Endif
					EndIf
				else
					this.Montoprorrateodescuentosinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateodescuentosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateodescuentosinimpuestos( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateorecargoconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateorecargoconimpuestos', lxValOld, lxVal  )
					this.Setear_Montoprorrateorecargoconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateorecargoconimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateorecargoconimpuestos', This )
						Endif
					EndIf
				else
					this.Montoprorrateorecargoconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateorecargoconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateorecargoconimpuestos( lxVal ) 
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
				if ( this.lHabilitarCodigoorigen or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Codigoorigen', lxValOld, lxVal  )
					this.Setear_Codigoorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoorigen', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Codigoorigen', This )
						Endif
					EndIf
				else
					this.Codigoorigen = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Codigoorigen)" )
				endif 
			EndIf
		Else
			This.Setear_Codigoorigen( lxVal ) 
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
				if ( this.lHabilitarIdorigen or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Idorigen', lxValOld, lxVal  )
					this.Setear_Idorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Idorigen', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Idorigen', This )
						Endif
					EndIf
				else
					this.Idorigen = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Idorigen)" )
				endif 
			EndIf
		Else
			This.Setear_Idorigen( lxVal ) 
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
				if ( this.lHabilitarAfe_nroitem or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_nroitem', lxValOld, lxVal  )
					this.Setear_Afe_nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_nroitem', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_nroitem', This )
						Endif
					EndIf
				else
					this.Afe_nroitem = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_nroitem( lxVal ) 
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
				if ( this.lHabilitarNroitem or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
					this.Setear_Nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Nroitem', This )
						Endif
					EndIf
				else
					this.Nroitem = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
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
				if ( this.lHabilitarOferta or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Oferta', lxValOld, lxVal  )
					this.Setear_Oferta( lxVal )
				this.EventoDespuesDeSetear( This, 'Oferta', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Oferta', This )
						Endif
					EndIf
				else
					this.Oferta = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Oferta)" )
				endif 
			EndIf
		Else
			This.Setear_Oferta( lxVal ) 
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
				if ( this.lHabilitarIditem or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Iditem', lxValOld, lxVal  )
					this.Setear_Iditem( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditem', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Iditem', This )
						Endif
					EndIf
				else
					this.Iditem = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Iditem)" )
				endif 
			EndIf
		Else
			This.Setear_Iditem( lxVal ) 
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
				if ( this.lHabilitarPorcentajecfi or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Porcentajecfi', lxValOld, lxVal  )
					this.Setear_Porcentajecfi( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajecfi', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Porcentajecfi', This )
						Endif
					EndIf
				else
					this.Porcentajecfi = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Porcentajecfi)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajecfi( lxVal ) 
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
				if ( this.lHabilitarPrecioconimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Precioconimpuestos', lxValOld, lxVal  )
					this.Setear_Precioconimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Precioconimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Precioconimpuestos', This )
						Endif
					EndIf
				else
					this.Precioconimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Precioconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Precioconimpuestos( lxVal ) 
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
				if ( this.lHabilitarPorcentajeiva or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Porcentajeiva', lxValOld, lxVal  )
					this.Setear_Porcentajeiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Porcentajeiva', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Porcentajeiva', This )
						Endif
					EndIf
				else
					this.Porcentajeiva = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Porcentajeiva)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajeiva( lxVal ) 
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
				if ( this.lHabilitarPreciodelista or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Preciodelista', lxValOld, lxVal  )
					this.Setear_Preciodelista( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciodelista', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Preciodelista', This )
						Endif
					EndIf
				else
					this.Preciodelista = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Preciodelista)" )
				endif 
			EndIf
		Else
			This.Setear_Preciodelista( lxVal ) 
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
				if ( this.lHabilitarPreciosinimpuestos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Preciosinimpuestos', lxValOld, lxVal  )
					this.Setear_Preciosinimpuestos( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciosinimpuestos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Preciosinimpuestos', This )
						Endif
					EndIf
				else
					this.Preciosinimpuestos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Preciosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinimpuestos( lxVal ) 
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
				if ( this.lHabilitarTipolistadeprecio or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Tipolistadeprecio', lxValOld, lxVal  )
					this.Setear_Tipolistadeprecio( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipolistadeprecio', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipolistadeprecio', This )
						Endif
					EndIf
				else
					this.Tipolistadeprecio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Tipolistadeprecio)" )
				endif 
			EndIf
		Else
			This.Setear_Tipolistadeprecio( lxVal ) 
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
				if ( this.lHabilitarPreciounitario or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Preciounitario', lxValOld, lxVal  )
					this.Setear_Preciounitario( lxVal )
				this.EventoDespuesDeSetear( This, 'Preciounitario', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Preciounitario', This )
						Endif
					EndIf
				else
					this.Preciounitario = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Preciounitario)" )
				endif 
			EndIf
		Else
			This.Setear_Preciounitario( lxVal ) 
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
				if ( this.lHabilitarNeto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Neto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Neto)" )
				endif 
			EndIf
		Else
			This.Setear_Neto( lxVal ) 
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
				if ( this.lHabilitarAfe_tipocomprobante or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_tipocomprobante', lxValOld, lxVal  )
					this.Setear_Afe_tipocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_tipocomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_tipocomprobante', This )
						Endif
					EndIf
				else
					this.Afe_tipocomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_tipocomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_tipocomprobante( lxVal ) 
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
				if ( this.lHabilitarAfe_cantidad or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_cantidad', lxValOld, lxVal  )
					this.Setear_Afe_cantidad( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_cantidad', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_cantidad', This )
						Endif
					EndIf
				else
					this.Afe_cantidad = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_cantidad)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_cantidad( lxVal ) 
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
				if ( this.lHabilitarMontoiva or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoiva', lxValOld, lxVal  )
					this.Setear_Montoiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoiva', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoiva', This )
						Endif
					EndIf
				else
					this.Montoiva = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoiva)" )
				endif 
			EndIf
		Else
			This.Setear_Montoiva( lxVal ) 
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
				if ( this.lHabilitarAfe_timestamp or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_timestamp', lxValOld, lxVal  )
					this.Setear_Afe_timestamp( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_timestamp', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_timestamp', This )
						Endif
					EndIf
				else
					this.Afe_timestamp = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_timestamp)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_timestamp( lxVal ) 
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
				if ( this.lHabilitarAfe_saldo or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Afe_saldo = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_saldo)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_saldo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_porcentajeivaventas_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_porcentajeivaventas
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulo_porcentajeivaventas( lxVal )
				if ( this.lHabilitarArticulo_porcentajeivaventas or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Articulo_porcentajeivaventas', lxValOld, lxVal  )
					this.Setear_Articulo_porcentajeivaventas( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_porcentajeivaventas', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Articulo_porcentajeivaventas', This )
						Endif
					EndIf
				else
					this.Articulo_porcentajeivaventas = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Articulo_porcentajeivaventas)" )
				endif 
			EndIf
		Else
			This.Setear_Articulo_porcentajeivaventas( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Articulo_condicionivaventas_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Articulo_condicionivaventas
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Articulo_condicionivaventas( lxVal )
				if ( this.lHabilitarArticulo_condicionivaventas or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Articulo_condicionivaventas', lxValOld, lxVal  )
					this.Setear_Articulo_condicionivaventas( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulo_condicionivaventas', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Articulo_condicionivaventas', This )
						Endif
					EndIf
				else
					this.Articulo_condicionivaventas = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Articulo_condicionivaventas)" )
				endif 
			EndIf
		Else
			This.Setear_Articulo_condicionivaventas( lxVal ) 
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
				if ( this.lHabilitarAfe_saldooriginal or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_saldooriginal', lxValOld, lxVal  )
					this.Setear_Afe_saldooriginal( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldooriginal', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_saldooriginal', This )
						Endif
					EndIf
				else
					this.Afe_saldooriginal = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_saldooriginal)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_saldooriginal( lxVal ) 
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
				if ( this.lHabilitarAfe_saldoactual or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_saldoactual', lxValOld, lxVal  )
					this.Setear_Afe_saldoactual( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_saldoactual', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_saldoactual', This )
						Endif
					EndIf
				else
					this.Afe_saldoactual = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_saldoactual)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_saldoactual( lxVal ) 
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
				if ( this.lHabilitarAfe_cantidadoriginal or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Afe_cantidadoriginal', lxValOld, lxVal  )
					this.Setear_Afe_cantidadoriginal( lxVal )
				this.EventoDespuesDeSetear( This, 'Afe_cantidadoriginal', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Afe_cantidadoriginal', This )
						Endif
					EndIf
				else
					this.Afe_cantidadoriginal = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Afe_cantidadoriginal)" )
				endif 
			EndIf
		Else
			This.Setear_Afe_cantidadoriginal( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cargoparticipantes_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cargoparticipantes
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cargoparticipantes( lxVal )
				if ( this.lHabilitarCargoparticipantes or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Cargoparticipantes', lxValOld, lxVal  )
					this.Setear_Cargoparticipantes( lxVal )
				this.EventoDespuesDeSetear( This, 'Cargoparticipantes', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cargoparticipantes', This )
						Endif
					EndIf
				else
					this.Cargoparticipantes = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Cargoparticipantes)" )
				endif 
			EndIf
		Else
			This.Setear_Cargoparticipantes( lxVal ) 
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
				if ( this.lHabilitarEslibre or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Eslibre', lxValOld, lxVal  )
					this.Setear_Eslibre( lxVal )
				this.EventoDespuesDeSetear( This, 'Eslibre', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Eslibre', This )
						Endif
					EndIf
				else
					this.Eslibre = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Eslibre)" )
				endif 
			EndIf
		Else
			This.Setear_Eslibre( lxVal ) 
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
				if ( this.lHabilitarFueautorizadodevolucion or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Fueautorizadodevolucion', lxValOld, lxVal  )
					this.Setear_Fueautorizadodevolucion( lxVal )
				this.EventoDespuesDeSetear( This, 'Fueautorizadodevolucion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fueautorizadodevolucion', This )
						Endif
					EndIf
				else
					this.Fueautorizadodevolucion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Fueautorizadodevolucion)" )
				endif 
			EndIf
		Else
			This.Setear_Fueautorizadodevolucion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Restringirdescuentos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Restringirdescuentos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Restringirdescuentos( lxVal )
				if ( this.lHabilitarRestringirdescuentos or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Restringirdescuentos', lxValOld, lxVal  )
					this.Setear_Restringirdescuentos( lxVal )
				this.EventoDespuesDeSetear( This, 'Restringirdescuentos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Restringirdescuentos', This )
						Endif
					EndIf
				else
					this.Restringirdescuentos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Restringirdescuentos)" )
				endif 
			EndIf
		Else
			This.Setear_Restringirdescuentos( lxVal ) 
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
				if ( this.lHabilitarUsarpreciodelista or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Usarpreciodelista', lxValOld, lxVal  )
					this.Setear_Usarpreciodelista( lxVal )
				this.EventoDespuesDeSetear( This, 'Usarpreciodelista', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Usarpreciodelista', This )
						Endif
					EndIf
				else
					this.Usarpreciodelista = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Usarpreciodelista)" )
				endif 
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
				if ( this.lHabilitarNoprocesarstock or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
					this.Setear_Noprocesarstock( lxVal )
				this.EventoDespuesDeSetear( This, 'Noprocesarstock', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Noprocesarstock', This )
						Endif
					EndIf
				else
					this.Noprocesarstock = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Noprocesarstock)" )
				endif 
			EndIf
		Else
			This.Setear_Noprocesarstock( lxVal ) 
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
				if ( this.lHabilitarArticulodetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
					this.Setear_Articulodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Articulodetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Articulodetalle', This )
						Endif
					EndIf
				else
					this.Articulodetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Articulodetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Articulodetalle( lxVal ) 
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
				if ( this.lHabilitarIdseniacancelada or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
					this.Setear_Idseniacancelada( lxVal )
				this.EventoDespuesDeSetear( This, 'Idseniacancelada', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Idseniacancelada', This )
						Endif
					EndIf
				else
					this.Idseniacancelada = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Idseniacancelada)" )
				endif 
			EndIf
		Else
			This.Setear_Idseniacancelada( lxVal ) 
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
				if ( this.lHabilitarMontoprorrateoiva or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateoiva', lxValOld, lxVal  )
					this.Setear_Montoprorrateoiva( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateoiva', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateoiva', This )
						Endif
					EndIf
				else
					this.Montoprorrateoiva = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateoiva)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateoiva( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoprorrateoimpuestointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoprorrateoimpuestointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoprorrateoimpuestointerno( lxVal )
				if ( this.lHabilitarMontoprorrateoimpuestointerno or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montoprorrateoimpuestointerno', lxValOld, lxVal  )
					this.Setear_Montoprorrateoimpuestointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoprorrateoimpuestointerno', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montoprorrateoimpuestointerno', This )
						Endif
					EndIf
				else
					this.Montoprorrateoimpuestointerno = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montoprorrateoimpuestointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Montoprorrateoimpuestointerno( lxVal ) 
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
				if ( this.lHabilitarColordetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
					this.Setear_Colordetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Colordetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Colordetalle', This )
						Endif
					EndIf
				else
					this.Colordetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Colordetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Colordetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Talledetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Talledetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Talledetalle( lxVal )
				if ( this.lHabilitarTalledetalle or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Talledetalle', lxValOld, lxVal  )
					this.Setear_Talledetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Talledetalle', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Talledetalle', This )
						Endif
					EndIf
				else
					this.Talledetalle = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Talledetalle)" )
				endif 
			EndIf
		Else
			This.Setear_Talledetalle( lxVal ) 
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
				if ( this.lHabilitarCantidad or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Cantidad = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Cantidad)" )
				endif 
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
				if ( this.lHabilitarPrecio or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.ValidarDominio_Preciononegativoparametrofoco( lxVal )
					this.EventoAntesDeSetear( This, 'Precio', lxValOld, lxVal  )
					this.Setear_Precio( lxVal )
				this.EventoDespuesDeSetear( This, 'Precio', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Precio', This )
						Endif
					EndIf
				else
					this.Precio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Precio)" )
				endif 
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
				if ( this.lHabilitarDescuento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Descuento', lxValOld, lxVal  )
					this.Setear_Descuento( lxVal )
				this.EventoDespuesDeSetear( This, 'Descuento', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Descuento', This )
						Endif
					EndIf
				else
					this.Descuento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Descuento)" )
				endif 
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
				if ( this.lHabilitarMontodescuento or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Montodescuento', lxValOld, lxVal  )
					this.Setear_Montodescuento( lxVal )
				this.EventoDespuesDeSetear( This, 'Montodescuento', lxValOld, lxVal  )
					If Not (lxVal == lxValOld) And This.PuedeEjecutarCambioSumarizado()
						this.AcumularSumarizado( .t., 'Montodescuento', lxVal, lxValOld)
					EndIf
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Montodescuento', This )
						Endif
					EndIf
				else
					this.Montodescuento = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Montodescuento)" )
				endif 
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
				if ( this.lHabilitarMonto or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
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
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Nota de crédito electrónica MiPyME de venta - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_puntodeventa( txVal as variant ) as void

		this.Afe_puntodeventa = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_numero( txVal as variant ) as void

		this.Afe_numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_letra( txVal as variant ) as void

		this.Afe_letra = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigogtin( txVal as variant ) as void

		this.Codigogtin = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemarticulos( txVal as variant ) as void

		this.Iditemarticulos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoautorizaciondjcp( txVal as variant ) as void

		this.Codigoautorizaciondjcp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_codigo( txVal as variant ) as void

		this.Afe_codigo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_codigo_aux( txVal as variant ) as void

		this.Afe_codigo_aux = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemarticulos_aux( txVal as variant ) as void

		this.Iditemarticulos_aux = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idkit( txVal as variant ) as void

		this.Idkit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ordendeservicio( txVal as variant ) as void

		this.Ordendeservicio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigodebarras( txVal as variant ) as void

		this.Codigodebarras = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precioconimpuestossinredondear( txVal as variant ) as void

		this.Precioconimpuestossinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinimpuestossinredondear( txVal as variant ) as void

		this.Preciosinimpuestossinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinredondear( txVal as variant ) as void

		this.Preciosinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodeitem( txVal as variant ) as void

		this.Tipodeitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajusteporredondeoconimpuestos( txVal as variant ) as void

		this.Ajusteporredondeoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bruto( txVal as variant ) as void

		this.Bruto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos( txVal as variant ) as void

		this.Montodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos( txVal as variant ) as void

		this.Montodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateodescuentoconimpuestos( txVal as variant ) as void

		this.Montoprorrateodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateopercepciones( txVal as variant ) as void

		this.Montoprorrateopercepciones = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateorecargosinimpuestos( txVal as variant ) as void

		this.Montoprorrateorecargosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajedto1( txVal as variant ) as void

		this.Porcentajedto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoporcentajedescuentosinimpuesto( txVal as variant ) as void

		this.Montoporcentajedescuentosinimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Ajusteporredondeosinimpuestos( txVal as variant ) as void

		this.Ajusteporredondeosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Stock( txVal as variant ) as void

		this.Stock = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodto1( txVal as variant ) as void

		this.Montodto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Impuestos( txVal as variant ) as void

		this.Impuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Kit( txVal as variant ) as void

		this.Kit = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comportamiento( txVal as variant ) as void

		this.Comportamiento = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoporcentajedescuentoconimpuesto( txVal as variant ) as void

		this.Montoporcentajedescuentoconimpuesto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Percepcionivarg5329( txVal as variant ) as void

		this.Percepcionivarg5329 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldoliquidacion( txVal as variant ) as void

		this.Afe_saldoliquidacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateodescuentofinancierosinimp( txVal as variant ) as void

		this.Montoprorrateodescuentofinancierosinimp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateorecargofinancierosinimp( txVal as variant ) as void

		this.Montoprorrateorecargofinancierosinimp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tasaimpuestointerno( txVal as variant ) as void

		this.Tasaimpuestointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocfi( txVal as variant ) as void

		this.Montocfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoimpuestointerno( txVal as variant ) as void

		this.Montoimpuestointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tienerestriccion( txVal as variant ) as void

		this.Tienerestriccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateototal( txVal as variant ) as void

		this.Montoprorrateototal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateodescuentosinimpuestos( txVal as variant ) as void

		this.Montoprorrateodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateorecargoconimpuestos( txVal as variant ) as void

		this.Montoprorrateorecargoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoorigen( txVal as variant ) as void

		this.Codigoorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idorigen( txVal as variant ) as void

		this.Idorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_nroitem( txVal as variant ) as void

		this.Afe_nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Oferta( txVal as variant ) as void

		this.Oferta = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditem( txVal as variant ) as void

		this.Iditem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajecfi( txVal as variant ) as void

		this.Porcentajecfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precioconimpuestos( txVal as variant ) as void

		this.Precioconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajeiva( txVal as variant ) as void

		this.Porcentajeiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciodelista( txVal as variant ) as void

		this.Preciodelista = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinimpuestos( txVal as variant ) as void

		this.Preciosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipolistadeprecio( txVal as variant ) as void

		this.Tipolistadeprecio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciounitario( txVal as variant ) as void

		this.Preciounitario = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Neto( txVal as variant ) as void

		this.Neto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_tipocomprobante( txVal as variant ) as void

		this.Afe_tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_cantidad( txVal as variant ) as void

		this.Afe_cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoiva( txVal as variant ) as void

		this.Montoiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_timestamp( txVal as variant ) as void

		this.Afe_timestamp = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldo( txVal as variant ) as void

		this.Afe_saldo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_porcentajeivaventas( txVal as variant ) as void

		this.Articulo_porcentajeivaventas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_condicionivaventas( txVal as variant ) as void

		this.Articulo_condicionivaventas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldooriginal( txVal as variant ) as void

		this.Afe_saldooriginal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_saldoactual( txVal as variant ) as void

		this.Afe_saldoactual = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Afe_cantidadoriginal( txVal as variant ) as void

		this.Afe_cantidadoriginal = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cargoparticipantes( txVal as variant ) as void

		this.Cargoparticipantes = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Eslibre( txVal as variant ) as void

		this.Eslibre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fueautorizadodevolucion( txVal as variant ) as void

		this.Fueautorizadodevolucion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Restringirdescuentos( txVal as variant ) as void

		this.Restringirdescuentos = txVal
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
	function Setear_Articulodetalle( txVal as variant ) as void

		this.Articulodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idseniacancelada( txVal as variant ) as void

		this.Idseniacancelada = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateoiva( txVal as variant ) as void

		this.Montoprorrateoiva = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoprorrateoimpuestointerno( txVal as variant ) as void

		this.Montoprorrateoimpuestointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Colordetalle( txVal as variant ) as void

		this.Colordetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Talledetalle( txVal as variant ) as void

		this.Talledetalle = txVal
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
	function Validar_Afe_puntodeventa( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_letra( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigogtin( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemarticulos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoautorizaciondjcp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_codigo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_codigo_aux( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemarticulos_aux( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idkit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ordendeservicio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigodebarras( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precioconimpuestossinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinimpuestossinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodeitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajusteporredondeoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bruto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateopercepciones( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateorecargosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajedto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoporcentajedescuentosinimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Ajusteporredondeosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Stock( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Impuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Kit( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comportamiento( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoporcentajedescuentoconimpuesto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Percepcionivarg5329( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldoliquidacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateodescuentofinancierosinimp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateorecargofinancierosinimp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tasaimpuestointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoimpuestointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tienerestriccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateototal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateorecargoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Oferta( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajecfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precioconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajeiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciodelista( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipolistadeprecio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciounitario( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Neto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_timestamp( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_porcentajeivaventas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_condicionivaventas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldooriginal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_saldoactual( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Afe_cantidadoriginal( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cargoparticipantes( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Eslibre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fueautorizadodevolucion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Restringirdescuentos( txVal as variant ) as Boolean

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
	function Validar_Articulodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idseniacancelada( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateoiva( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoprorrateoimpuestointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Colordetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talledetalle( txVal as variant ) as Boolean

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
	function Numerogiftcard_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Numerogiftcard ) = 'O' or isnull( this.Numerogiftcard ) )
					this.Numerogiftcard = _Screen.zoo.instanciarentidad( 'Valedecambio' )
					this.Numerogiftcard.lEsSubEntidad = .t.
					this.enlazar( 'Numerogiftcard.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Numerogiftcard.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Numerogiftcard.CODIGO # this.Numerogiftcard_PK
						this.Numerogiftcard.CODIGO = this.Numerogiftcard_PK
					endif
				endif
			endif
		endif
		return this.Numerogiftcard
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodevolucion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codigomotivodevolucion ) = 'O' or isnull( this.Codigomotivodevolucion ) )
					this.Codigomotivodevolucion = _Screen.zoo.instanciarentidad( 'Motivodescuentoydevolucion' )
					this.Codigomotivodevolucion.lEsSubEntidad = .t.
					this.enlazar( 'Codigomotivodevolucion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codigomotivodevolucion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codigomotivodevolucion.CODIGO # this.Codigomotivodevolucion_PK
						this.Codigomotivodevolucion.CODIGO = this.Codigomotivodevolucion_PK
					endif
				endif
			endif
		endif
		return this.Codigomotivodevolucion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigomotivodescuento_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Codigomotivodescuento ) = 'O' or isnull( this.Codigomotivodescuento ) )
					this.Codigomotivodescuento = _Screen.zoo.instanciarentidad( 'Motivodescuentoydevolucion' )
					this.Codigomotivodescuento.lEsSubEntidad = .t.
					this.enlazar( 'Codigomotivodescuento.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Codigomotivodescuento.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Codigomotivodescuento.CODIGO # this.Codigomotivodescuento_PK
						this.Codigomotivodescuento.CODIGO = this.Codigomotivodescuento_PK
					endif
				endif
			endif
		endif
		return this.Codigomotivodescuento
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
	function oCompPrecios_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompPrecios ) = 'O' or isnull( this.oCompPrecios ) )
			this.oCompPrecios = _Screen.zoo.InstanciarComponente( 'ComponentePrecios' )
		this.oCompPrecios.Inicializar()
		this.enlazar( 'oCompPrecios.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompPrecios.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompPrecios
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oCompStock_Access() as variant
		if !this.ldestroy and ( !vartype( this.oCompStock ) = 'O' or isnull( this.oCompStock ) )
			this.oCompStock = _Screen.zoo.InstanciarComponente( 'ComponenteStock' )
		this.oCompStock.Inicializar()
		this.enlazar( 'oCompStock.EventoObtenerLogueo', 'inyectarLogueo' )
		this.enlazar( 'oCompStock.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		return this.oCompStock
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

				.Afe_puntodeventa = 0
				.Afe_numero = 0
				.Afe_letra = []
				.Codigogtin = []
				.Articulo_PK = []
				.Iditemarticulos = []
				.Codigoautorizaciondjcp = []
				.Afe_codigo = []
				.Idkit = []
				.Unidad_PK = []
				.Precioconimpuestossinredondear = 0
				.Preciosinimpuestossinredondear = 0
				.Preciosinredondear = 0
				.Ajusteporredondeoconimpuestos = 0
				.Bruto = 0
				.Montodescuentosinimpuestos = 0
				.Montodescuentoconimpuestos = 0
				.Montoprorrateodescuentoconimpuestos = 0
				.Montoprorrateopercepciones = 0
				.Montoprorrateorecargosinimpuestos = 0
				.Porcentajedto1 = 0
				.Montoporcentajedescuentosinimpuesto = 0
				.Ajusteporredondeosinimpuestos = 0
				.Montodto1 = 0
				.Kit = 0
				.Comportamiento = 0
				.Montoporcentajedescuentoconimpuesto = 0
				.Percepcionivarg5329 = 0
				.Afe_saldoliquidacion = 0
				.Tasaimpuestointerno = 0
				.Montocfi = 0
				.Montoimpuestointerno = 0
				.Tienerestriccion = 0
				.Montoprorrateototal = 0
				.Montoprorrateodescuentosinimpuestos = 0
				.Montoprorrateorecargoconimpuestos = 0
				.Idorigen = 0
				.Afe_nroitem = 0
				.Oferta = 0
				.Iditem = 0
				.Porcentajecfi = 0
				.Precioconimpuestos = 0
				.Porcentajeiva = 0
				.Preciosinimpuestos = 0
				.Tipolistadeprecio = 0
				.Preciounitario = 0
				.Neto = 0
				.Afe_tipocomprobante = 0
				.Afe_cantidad = 0
				.Montoiva = 0
				.Afe_timestamp = 0
				.Afe_saldo = 0
				.Articulo_porcentajeivaventas = 0
				.Articulo_condicionivaventas = 0
				.Restringirdescuentos = .F.
				.Usarpreciodelista = .F.
				.Noprocesarstock = .F.
				.Numerogiftcard_PK = []
				.Codigomotivodevolucion_PK = []
				.Codigomotivodescuento_PK = []
				.Codigo = []
				.Equivalencia_PK = []
				.Articulodetalle = []
				.Color_PK = []
				.Idseniacancelada = []
				.Montoprorrateoiva = 0
				.Montoprorrateoimpuestointerno = 0
				.Colordetalle = []
				.Talledetalle = []
				.Talle_PK = []
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
	Function ValorSugeridoArticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Articulo" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Kit para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIditemarticulos() as void
		with this
			.Iditemarticulos = goServicios.Librerias.ObtenerGuidPk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIditemarticulos() as void
		with this
			.ValorSugeridoFWIditemarticulos()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWIdkit() as void
		with this
			.Idkit = goServicios.Librerias.ObtenerGuidPk()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoIdkit() as void
		with this
			.ValorSugeridoFWIdkit()
		endwith
	endfunc
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
	Function ValorSugeridoArticulodetalle() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Articulodetalle" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción del kit para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Color" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Colordetalle" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción del color para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Talle" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoCantidad() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Cantidad" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWCantidad()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWCantidad() as void
		with this
			.Cantidad = this.CompletarCantidadSegunParametro()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDescuento() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Descuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "NOTADECREDITOELECTRONICADECREDITO", "Kitsdetalle", "Montodescuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de descuento para el detalle Detalle de kits." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
		This.AsignarCondicionYPorcentajeDeIva()
		this.LimpiarColorYTalle()
		this.ProcesarDespuesDeSetearArt() 
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
		this.oCompPrecios = null
		this.oCompstock = null
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		If this.oCompPrecios.ValidarAtributo( txVal, tcAtributo )
		else
			llRetorno = .F.
		endif
		
		If this.oCompstock.ValidarAtributo( txVal, tcAtributo )
		else
			llRetorno = .F.
		endif
		
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( This.ObtenerInformacion() )
		endif
		
		Return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
			.Afe_codigo_aux = []
			.Iditemarticulos_aux = []
			.Ordendeservicio = []
			.Codigodebarras = []
			.Tipodeitem = 0
			.Stock = 0
			.Impuestos = 0
			.Montoprorrateodescuentofinancierosinimp = 0
			.Montoprorrateorecargofinancierosinimp = 0
			.Codigoorigen = 0
			.Preciodelista = 0
			.Afe_saldooriginal = 0
			.Afe_saldoactual = 0
			.Afe_cantidadoriginal = 0
			.Cargoparticipantes = .F.
			.Eslibre = .F.
			.Fueautorizadodevolucion = .F.
		endwith
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributosCombinacion() as object
		local loColRetorno as object
		
		loColRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		return loColRetorno
	endfunc
	*-----------------------------------------------------------------------------------------
	function EventoActualizarEmail() as Void
		*
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
		this.lHabilitarAfe_PuntoDeVenta = tlHabilitar
		this.lHabilitarAfe_Numero = tlHabilitar
		this.lHabilitarAfe_Letra = tlHabilitar
		this.lHabilitarCodigoGTIN = tlHabilitar
		this.lHabilitarArticulo_PK = tlHabilitar
		this.lHabilitarIdItemArticulos = tlHabilitar
		this.lHabilitarCodigoAutorizacionDJCP = tlHabilitar
		this.lHabilitarAfe_Codigo = tlHabilitar
		this.lHabilitarafe_codigo_Aux = tlHabilitar
		this.lHabilitariditemarticulos_Aux = tlHabilitar
		this.lHabilitarIdKit = tlHabilitar
		this.lHabilitarUnidad_PK = tlHabilitar
		this.lHabilitarOrdenDeServicio = tlHabilitar
		this.lHabilitarCodigoDeBarras = tlHabilitar
		this.lHabilitarPrecioConImpuestosSinRedondear = tlHabilitar
		this.lHabilitarPrecioSinImpuestosSinRedondear = tlHabilitar
		this.lHabilitarPrecioSinRedondear = tlHabilitar
		this.lHabilitarTipoDeItem = tlHabilitar
		this.lHabilitarAjustePorRedondeoConImpuestos = tlHabilitar
		this.lHabilitarBruto = tlHabilitar
		this.lHabilitarMontoDescuentoSinImpuestos = tlHabilitar
		this.lHabilitarMontoDescuentoConImpuestos = tlHabilitar
		this.lHabilitarMontoProrrateoDescuentoConImpuestos = tlHabilitar
		this.lHabilitarMontoProrrateoPercepciones = tlHabilitar
		this.lHabilitarMontoProrrateoRecargoSinImpuestos = tlHabilitar
		this.lHabilitarPorcentajeDTO1 = tlHabilitar
		this.lHabilitarMontoPorcentajeDescuentoSinImpuesto = tlHabilitar
		this.lHabilitarAjustePorRedondeoSinImpuestos = tlHabilitar
		this.lHabilitarStock = tlHabilitar
		this.lHabilitarMontoDTO1 = tlHabilitar
		this.lHabilitarImpuestos = tlHabilitar
		this.lHabilitarKit = tlHabilitar
		this.lHabilitarComportamiento = tlHabilitar
		this.lHabilitarMontoPorcentajeDescuentoConImpuesto = tlHabilitar
		this.lHabilitarPercepcionIvaRG5329 = tlHabilitar
		this.lHabilitarafe_SaldoLiquidacion = tlHabilitar
		this.lHabilitarMontoProrrateoDescuentoFinancieroSinImp = tlHabilitar
		this.lHabilitarMontoProrrateoRecargoFinancieroSinImp = tlHabilitar
		this.lHabilitarTasaImpuestoInterno = tlHabilitar
		this.lHabilitarMontoCFI = tlHabilitar
		this.lHabilitarMontoImpuestoInterno = tlHabilitar
		this.lHabilitarTieneRestriccion = tlHabilitar
		this.lHabilitarMontoProrrateoTotal = tlHabilitar
		this.lHabilitarMontoProrrateoDescuentoSinImpuestos = tlHabilitar
		this.lHabilitarMontoProrrateoRecargoConImpuestos = tlHabilitar
		this.lHabilitarCodigoOrigen = tlHabilitar
		this.lHabilitaridOrigen = tlHabilitar
		this.lHabilitarAfe_NroItem = tlHabilitar
		this.lHabilitarNroItem = tlHabilitar
		this.lHabilitarOferta = tlHabilitar
		this.lHabilitaridItem = tlHabilitar
		this.lHabilitarPorcentajeCFI = tlHabilitar
		this.lHabilitarPrecioConImpuestos = tlHabilitar
		this.lHabilitarPorcentajeIVA = tlHabilitar
		this.lHabilitarPrecioDeLista = tlHabilitar
		this.lHabilitarPrecioSinImpuestos = tlHabilitar
		this.lHabilitarTipoListaDePrecio = tlHabilitar
		this.lHabilitarPrecioUnitario = tlHabilitar
		this.lHabilitarNeto = tlHabilitar
		this.lHabilitarAfe_TipoComprobante = tlHabilitar
		this.lHabilitarAfe_Cantidad = tlHabilitar
		this.lHabilitarMontoIVA = tlHabilitar
		this.lHabilitarAfe_timeStamp = tlHabilitar
		this.lHabilitarAfe_Saldo = tlHabilitar
		this.lHabilitarArticulo_PorcentajeIvaVentas = tlHabilitar
		this.lHabilitarArticulo_CondicionIvaVentas = tlHabilitar
		this.lHabilitarafe_SaldoOriginal = tlHabilitar
		this.lHabilitarafe_SaldoActual = tlHabilitar
		this.lHabilitarafe_CantidadOriginal = tlHabilitar
		this.lHabilitarCargoParticipantes = tlHabilitar
		this.lHabilitarEsLibre = tlHabilitar
		this.lHabilitarFUEAUTORIZADODEVOLUCION = tlHabilitar
		this.lHabilitarRestringirDescuentos = tlHabilitar
		this.lHabilitarUsarPrecioDeLista = tlHabilitar
		this.lHabilitarNoProcesarStock = tlHabilitar
		this.lHabilitarNumeroGiftCard_PK = tlHabilitar
		this.lHabilitarCodigoMotivoDevolucion_PK = tlHabilitar
		this.lHabilitarCodigoMotivoDescuento_PK = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarEquivalencia_PK = tlHabilitar
		this.lHabilitarArticuloDetalle = tlHabilitar
		this.lHabilitarColor_PK = tlHabilitar
		this.lHabilitarIDSeniaCancelada = tlHabilitar
		this.lHabilitarMontoProrrateoIVA = tlHabilitar
		this.lHabilitarMontoProrrateoImpuestoInterno = tlHabilitar
		this.lHabilitarColorDetalle = tlHabilitar
		this.lHabilitarTalleDetalle = tlHabilitar
		this.lHabilitarTalle_PK = tlHabilitar
		this.lHabilitarCantidad = tlHabilitar
		this.lHabilitarPrecio = tlHabilitar
		this.lHabilitarDescuento = tlHabilitar
		this.lHabilitarMontoDescuento = tlHabilitar
		this.lHabilitarMonto = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMKITS]
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function LimpiarColorYTalle() as void
		if this.Articulo.Comportamiento = 4 and !this.lKitPermiteColorYTalle
			this.COLOR_pk = ''
			this.TALLE_pk = ''
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidaColorYTalleConKit( txVal ) as void
		if !empty( txVal ) and this.Articulo.Comportamiento = 4 and !this.lKitPermiteColorYTalle
			goServicios.Errores.LevantarExcepcion( 'No se pueden ingresar colores o talles en kits.' )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function PuedeEjecutarCambioSumarizado() as boolean
		local llRetorno as Boolean
		llRetorno = !empty(this.ARTICULO_PK) and dodefault()
		return llRetorno
	endfunc

enddefine