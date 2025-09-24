
define class Din_ItemSENIAArticulosdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'SENIA'
	PrecioSinImpuestos = 0
	lHabilitarPrecioSinImpuestos = .T.
	PrecioUnitario = 0
	lHabilitarPrecioUnitario = .T.
	MontoDescuentoSinImpuestos = 0
	lHabilitarMontoDescuentoSinImpuestos = .T.
	PrecioSinImpuestosSinRedondear = 0
	lHabilitarPrecioSinImpuestosSinRedondear = .T.
	Articulo_CondicionIvaVentas = 0
	lHabilitarArticulo_CondicionIvaVentas = .T.
	PrecioConImpuestosSinRedondear = 0
	lHabilitarPrecioConImpuestosSinRedondear = .T.
	PrecioSinRedondear = 0
	lHabilitarPrecioSinRedondear = .T.
	Articulo_PorcentajeIvaVentas = 0
	lHabilitarArticulo_PorcentajeIvaVentas = .T.
	PrecioConImpuestos = 0
	lHabilitarPrecioConImpuestos = .T.
	MontoDescuentoConImpuestos = 0
	lHabilitarMontoDescuentoConImpuestos = .T.
	MontoCFI = 0
	lHabilitarMontoCFI = .T.
	Comportamiento = 0
	lHabilitarComportamiento = .T.
	MontoPorcentajeDescuentoConImpuesto = 0
	lHabilitarMontoPorcentajeDescuentoConImpuesto = .T.
	PorcentajeDTO1 = 0
	lHabilitarPorcentajeDTO1 = .T.
	MontoDTO1 = 0
	lHabilitarMontoDTO1 = .T.
	PorcentajeCFI = 0
	lHabilitarPorcentajeCFI = .T.
	NroItem = 0
	lHabilitarNroItem = .T.
	TasaImpuestoInterno = 0
	lHabilitarTasaImpuestoInterno = .T.
	NoProcesarStock = .F.
	lHabilitarNoProcesarStock = .T.
	CodigoMotivoDescuento_PK = []
	CodigoMotivoDescuento = null
	lHabilitarCodigoMotivoDescuento_PK = .T.
	cAtributoPK = 'Codigo'
	Codigo = []
	lHabilitarCodigo = .T.
	Articulo_PK = []
	Articulo = null
	lHabilitarArticulo_PK = .T.
	CodigoMotivoDevolucion_PK = []
	CodigoMotivoDevolucion = null
	lHabilitarCodigoMotivoDevolucion_PK = .T.
	ArticuloDetalle = []
	lHabilitarArticuloDetalle = .T.
	Color_PK = []
	Color = null
	lHabilitarColor_PK = .T.
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
	oCompstock = null
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarPrecioSinImpuestos = .T.
		this.lHabilitarPrecioUnitario = .T.
		this.lHabilitarMontoDescuentoSinImpuestos = .T.
		this.lHabilitarPrecioSinImpuestosSinRedondear = .T.
		this.lHabilitarArticulo_CondicionIvaVentas = .T.
		this.lHabilitarPrecioConImpuestosSinRedondear = .T.
		this.lHabilitarPrecioSinRedondear = .T.
		this.lHabilitarArticulo_PorcentajeIvaVentas = .T.
		this.lHabilitarPrecioConImpuestos = .T.
		this.lHabilitarMontoDescuentoConImpuestos = .T.
		this.lHabilitarMontoCFI = .T.
		this.lHabilitarComportamiento = .T.
		this.lHabilitarMontoPorcentajeDescuentoConImpuesto = .T.
		this.lHabilitarPorcentajeDTO1 = .T.
		this.lHabilitarMontoDTO1 = .T.
		this.lHabilitarPorcentajeCFI = .T.
		this.lHabilitarNroItem = .T.
		this.lHabilitarTasaImpuestoInterno = .T.
		this.lHabilitarNoProcesarStock = .T.
		this.lHabilitarCodigoMotivoDescuento_PK = .T.
		this.lHabilitarCodigo = .T.
		this.lHabilitarArticulo_PK = .T.
		this.lHabilitarCodigoMotivoDevolucion_PK = .T.
		this.lHabilitarArticuloDetalle = .T.
		this.lHabilitarColor_PK = .T.
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'SENIA', 'Articulosdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Codigomotivodescuento)" )
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Articulo)" )
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Codigomotivodevolucion)" )
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Color)" )
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
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Talle)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigomotivodescuento( txVal as variant ) as void

		this.Codigomotivodescuento.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo( txVal as variant ) as void

		this.Articulo.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigomotivodevolucion( txVal as variant ) as void

		this.Codigomotivodevolucion.CODIGO = txVal
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
	function Validar_Codigomotivodescuento( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.ValidaArticuloTipoKit() 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigomotivodevolucion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Color( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Talle( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Preciosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinimpuestos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Preciounitario)" )
				endif 
			EndIf
		Else
			This.Setear_Preciounitario( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montodescuentosinimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montodescuentosinimpuestos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Preciosinimpuestossinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinimpuestossinredondear( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Articulo_condicionivaventas)" )
				endif 
			EndIf
		Else
			This.Setear_Articulo_condicionivaventas( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Precioconimpuestossinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Precioconimpuestossinredondear( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Preciosinredondear)" )
				endif 
			EndIf
		Else
			This.Setear_Preciosinredondear( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Articulo_porcentajeivaventas)" )
				endif 
			EndIf
		Else
			This.Setear_Articulo_porcentajeivaventas( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Precioconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Precioconimpuestos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montodescuentoconimpuestos)" )
				endif 
			EndIf
		Else
			This.Setear_Montodescuentoconimpuestos( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montocfi)" )
				endif 
			EndIf
		Else
			This.Setear_Montocfi( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Comportamiento)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montoporcentajedescuentoconimpuesto)" )
				endif 
			EndIf
		Else
			This.Setear_Montoporcentajedescuentoconimpuesto( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Porcentajedto1)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajedto1( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montodto1)" )
				endif 
			EndIf
		Else
			This.Setear_Montodto1( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Porcentajecfi)" )
				endif 
			EndIf
		Else
			This.Setear_Porcentajecfi( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Tasaimpuestointerno)" )
				endif 
			EndIf
		Else
			This.Setear_Tasaimpuestointerno( lxVal ) 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Noprocesarstock)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Articulodetalle)" )
				endif 
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Colordetalle)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Talledetalle)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Cantidad)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Precio)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Descuento)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Montodescuento)" )
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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Seña - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinimpuestos( txVal as variant ) as void

		this.Preciosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciounitario( txVal as variant ) as void

		this.Preciounitario = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentosinimpuestos( txVal as variant ) as void

		this.Montodescuentosinimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinimpuestossinredondear( txVal as variant ) as void

		this.Preciosinimpuestossinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_condicionivaventas( txVal as variant ) as void

		this.Articulo_condicionivaventas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precioconimpuestossinredondear( txVal as variant ) as void

		this.Precioconimpuestossinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Preciosinredondear( txVal as variant ) as void

		this.Preciosinredondear = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Articulo_porcentajeivaventas( txVal as variant ) as void

		this.Articulo_porcentajeivaventas = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Precioconimpuestos( txVal as variant ) as void

		this.Precioconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodescuentoconimpuestos( txVal as variant ) as void

		this.Montodescuentoconimpuestos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montocfi( txVal as variant ) as void

		this.Montocfi = txVal
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
	function Setear_Porcentajedto1( txVal as variant ) as void

		this.Porcentajedto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montodto1( txVal as variant ) as void

		this.Montodto1 = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Porcentajecfi( txVal as variant ) as void

		this.Porcentajecfi = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tasaimpuestointerno( txVal as variant ) as void

		this.Tasaimpuestointerno = txVal
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
	function Validar_Preciosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciounitario( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentosinimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinimpuestossinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_condicionivaventas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precioconimpuestossinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Preciosinredondear( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Articulo_porcentajeivaventas( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Precioconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodescuentoconimpuestos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montocfi( txVal as variant ) as Boolean

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
	function Validar_Porcentajedto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montodto1( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Porcentajecfi( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tasaimpuestointerno( txVal as variant ) as Boolean

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
	function DescripcionFW_Access() as variant
		If This.lDestroy
		Else
			this.DescripcionFW = alltrim( transform( This.ObtenerNombre() ) )
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

				.Preciosinimpuestos = 0
				.Preciounitario = 0
				.Montodescuentosinimpuestos = 0
				.Preciosinimpuestossinredondear = 0
				.Articulo_condicionivaventas = 0
				.Precioconimpuestossinredondear = 0
				.Preciosinredondear = 0
				.Articulo_porcentajeivaventas = 0
				.Precioconimpuestos = 0
				.Montodescuentoconimpuestos = 0
				.Montocfi = 0
				.Comportamiento = 0
				.Montoporcentajedescuentoconimpuesto = 0
				.Porcentajedto1 = 0
				.Montodto1 = 0
				.Porcentajecfi = 0
				.Tasaimpuestointerno = 0
				.Noprocesarstock = .F.
				.Codigomotivodescuento_PK = []
				.Codigo = []
				.Articulo_PK = []
				.Codigomotivodevolucion_PK = []
				.Articulodetalle = []
				.Color_PK = []
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
	Function ValorSugeridoArticulo() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Articulo" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Artículo para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Articulodetalle" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción del artículo para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Color" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Color para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Colordetalle" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción del color para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Talle" )
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
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Talle para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Cantidad" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cantidad para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Descuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo % Descuento para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SENIA", "Articulosdetalle", "Montodescuento" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Monto de descuento para el detalle Artículos señados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
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
		this.oCompstock = null
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
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
		this.lHabilitarPrecioSinImpuestos = tlHabilitar
		this.lHabilitarPrecioUnitario = tlHabilitar
		this.lHabilitarMontoDescuentoSinImpuestos = tlHabilitar
		this.lHabilitarPrecioSinImpuestosSinRedondear = tlHabilitar
		this.lHabilitarArticulo_CondicionIvaVentas = tlHabilitar
		this.lHabilitarPrecioConImpuestosSinRedondear = tlHabilitar
		this.lHabilitarPrecioSinRedondear = tlHabilitar
		this.lHabilitarArticulo_PorcentajeIvaVentas = tlHabilitar
		this.lHabilitarPrecioConImpuestos = tlHabilitar
		this.lHabilitarMontoDescuentoConImpuestos = tlHabilitar
		this.lHabilitarMontoCFI = tlHabilitar
		this.lHabilitarComportamiento = tlHabilitar
		this.lHabilitarMontoPorcentajeDescuentoConImpuesto = tlHabilitar
		this.lHabilitarPorcentajeDTO1 = tlHabilitar
		this.lHabilitarMontoDTO1 = tlHabilitar
		this.lHabilitarPorcentajeCFI = tlHabilitar
		this.lHabilitarNroItem = tlHabilitar
		this.lHabilitarTasaImpuestoInterno = tlHabilitar
		this.lHabilitarNoProcesarStock = tlHabilitar
		this.lHabilitarCodigoMotivoDescuento_PK = tlHabilitar
		this.lHabilitarCodigo = tlHabilitar
		this.lHabilitarArticulo_PK = tlHabilitar
		this.lHabilitarCodigoMotivoDevolucion_PK = tlHabilitar
		this.lHabilitarArticuloDetalle = tlHabilitar
		this.lHabilitarColor_PK = tlHabilitar
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
		return [ITEMSENIAS]
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