
define class Din_ItemCOMPROBANTESECOMMERCEDetalleoperaciones as ItemActivo of ItemActivo.prg

	cNombre = 'COMPROBANTESECOMMERCE'
	NROITEM = 0
	lHabilitarNROITEM = .T.
	cAtributoPK = 'Numero'
	Numero = 0
	lHabilitarNumero = .T.
	NumeroOperacion = []
	lHabilitarNumeroOperacion = .T.
	Cantidad = 0
	lHabilitarCantidad = .T.
	Monto = 0
	lHabilitarMonto = .T.
	ClienteDescripcion = []
	lHabilitarClienteDescripcion = .T.
	Cliente_PK = []
	Cliente = null
	lHabilitarCliente_PK = .T.
	ClienteDragon_PK = []
	ClienteDragon = null
	lHabilitarClienteDragon_PK = .T.
	Envio = []
	lHabilitarEnvio = .T.
	FullEnvios = .F.
	lHabilitarFullEnvios = .T.
	Cancelada = .F.
	lHabilitarCancelada = .T.
	TipoComprobante = []
	lHabilitarTipoComprobante = .T.
	ClienteNombre = []
	lHabilitarClienteNombre = .T.
	Pagado = .F.
	lHabilitarPagado = .T.
	Operacion_PK = []
	Operacion = null
	lHabilitarOperacion_PK = .T.
	FaltaArt = .F.
	lHabilitarFaltaArt = .T.
	Plataforma = []
	lHabilitarPlataforma = .T.
	Buzon = []
	lHabilitarBuzon = .T.
	BaseDeDatos = []
	lHabilitarBaseDeDatos = .T.
	NumeroComprobante = []
	lHabilitarNumeroComprobante = .T.
	UtilizaStockOtraBase = .F.
	lHabilitarUtilizaStockOtraBase = .T.
	BDOrigenStock = []
	lHabilitarBDOrigenStock = .T.
	CbteTentativoParaCancelacion = []
	lHabilitarCbteTentativoParaCancelacion = .T.
	ComprobanteAfectado = []
	lHabilitarComprobanteAfectado = .T.
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarNROITEM = .T.
		this.lHabilitarNumero = .T.
		this.lHabilitarNumeroOperacion = .T.
		this.lHabilitarCantidad = .T.
		this.lHabilitarMonto = .T.
		this.lHabilitarClienteDescripcion = .T.
		this.lHabilitarCliente_PK = .T.
		this.lHabilitarClienteDragon_PK = .T.
		this.lHabilitarEnvio = .T.
		this.lHabilitarFullEnvios = .T.
		this.lHabilitarCancelada = .T.
		this.lHabilitarTipoComprobante = .T.
		this.lHabilitarClienteNombre = .T.
		this.lHabilitarPagado = .T.
		this.lHabilitarOperacion_PK = .T.
		this.lHabilitarFaltaArt = .T.
		this.lHabilitarPlataforma = .T.
		this.lHabilitarBuzon = .T.
		this.lHabilitarBaseDeDatos = .T.
		this.lHabilitarNumeroComprobante = .T.
		this.lHabilitarUtilizaStockOtraBase = .T.
		this.lHabilitarBDOrigenStock = .T.
		this.lHabilitarCbteTentativoParaCancelacion = .T.
		this.lHabilitarComprobanteAfectado = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'COMPROBANTESECOMMERCE', 'Detalleoperaciones')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Cliente.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Cliente )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Cliente_PK = lxVal

		if this.Validar_Cliente( lxVal, lxValOld )
			if ( this.lHabilitarCliente_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
				This.Setear_Cliente( lxVal )
				this.EventoDespuesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cliente_Pk', This )
					Endif
				EndIf
			else
				this.Cliente_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Cliente)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedragon_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedragon_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.Clientedragon.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.Clientedragon )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Clientedragon_PK = lxVal

		if this.Validar_Clientedragon( lxVal, lxValOld )
			if ( this.lHabilitarClientedragon_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Clientedragon_Pk', lxValOld, lxVal  )
				This.Setear_Clientedragon( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedragon_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedragon_Pk', This )
					Endif
				EndIf
			else
				this.Clientedragon_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Clientedragon)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Operacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Operacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Operacion_PK = lxVal

		if this.Validar_Operacion( lxVal, lxValOld )
			if ( this.lHabilitarOperacion_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Operacion_Pk', lxValOld, lxVal  )
				This.Setear_Operacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Operacion_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Plataforma ) 
				this.Plataforma = This.operacion.Ecommerce_pk
			endif
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Operacion_Pk', This )
					Endif
				EndIf
			else
				this.Operacion_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Operacion)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedragon( txVal as variant ) as void

		this.Clientedragon.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Operacion( txVal as variant ) as void

		this.Operacion.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedragon( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Clientedragon.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Operacion( txVal as variant, txValOld as variant ) as Boolean

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
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Nroitem)" )
				endif 
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerooperacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerooperacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerooperacion( lxVal )
				if ( this.lHabilitarNumerooperacion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Numerooperacion', lxValOld, lxVal  )
					this.Setear_Numerooperacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerooperacion', lxValOld, lxVal  )
					 This.Numerooperacion_DespuesDeAsignar()
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerooperacion', This )
						Endif
					EndIf
				else
					this.Numerooperacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Numerooperacion)" )
				endif 
			EndIf
		Else
			This.Setear_Numerooperacion( lxVal ) 
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
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cantidad', This )
						Endif
					EndIf
				else
					this.Cantidad = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Cantidad)" )
				endif 
			EndIf
		Else
			This.Setear_Cantidad( lxVal ) 
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
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Monto', This )
						Endif
					EndIf
				else
					this.Monto = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Monto)" )
				endif 
			EndIf
		Else
			This.Setear_Monto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedescripcion( lxVal )
				if ( this.lHabilitarClientedescripcion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
					this.Setear_Clientedescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Clientedescripcion', This )
						Endif
					EndIf
				else
					this.Clientedescripcion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Clientedescripcion)" )
				endif 
			EndIf
		Else
			This.Setear_Clientedescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Envio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Envio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Envio( lxVal )
				if ( this.lHabilitarEnvio or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Envio', lxValOld, lxVal  )
					this.Setear_Envio( lxVal )
				this.EventoDespuesDeSetear( This, 'Envio', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Envio', This )
						Endif
					EndIf
				else
					this.Envio = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Envio)" )
				endif 
			EndIf
		Else
			This.Setear_Envio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fullenvios_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fullenvios
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fullenvios( lxVal )
				if ( this.lHabilitarFullenvios or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Fullenvios', lxValOld, lxVal  )
					this.Setear_Fullenvios( lxVal )
				this.EventoDespuesDeSetear( This, 'Fullenvios', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Fullenvios', This )
						Endif
					EndIf
				else
					this.Fullenvios = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Fullenvios)" )
				endif 
			EndIf
		Else
			This.Setear_Fullenvios( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cancelada_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cancelada
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cancelada( lxVal )
				if ( this.lHabilitarCancelada or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Cancelada', lxValOld, lxVal  )
					this.Setear_Cancelada( lxVal )
				this.EventoDespuesDeSetear( This, 'Cancelada', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cancelada', This )
						Endif
					EndIf
				else
					this.Cancelada = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Cancelada)" )
				endif 
			EndIf
		Else
			This.Setear_Cancelada( lxVal ) 
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
				if ( this.lHabilitarTipocomprobante or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Tipocomprobante', lxValOld, lxVal  )
					this.Setear_Tipocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipocomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Tipocomprobante', This )
						Endif
					EndIf
				else
					this.Tipocomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Tipocomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Tipocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientenombre_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientenombre
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientenombre( lxVal )
				if ( this.lHabilitarClientenombre or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Clientenombre', lxValOld, lxVal  )
					this.Setear_Clientenombre( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientenombre', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Clientenombre', This )
						Endif
					EndIf
				else
					this.Clientenombre = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Clientenombre)" )
				endif 
			EndIf
		Else
			This.Setear_Clientenombre( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Pagado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Pagado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Pagado( lxVal )
				if ( this.lHabilitarPagado or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Pagado', lxValOld, lxVal  )
					this.Setear_Pagado( lxVal )
				this.EventoDespuesDeSetear( This, 'Pagado', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Pagado', This )
						Endif
					EndIf
				else
					this.Pagado = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Pagado)" )
				endif 
			EndIf
		Else
			This.Setear_Pagado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Faltaart_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Faltaart
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Faltaart( lxVal )
				if ( this.lHabilitarFaltaart or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Faltaart', lxValOld, lxVal  )
					this.Setear_Faltaart( lxVal )
				this.EventoDespuesDeSetear( This, 'Faltaart', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Faltaart', This )
						Endif
					EndIf
				else
					this.Faltaart = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Faltaart)" )
				endif 
			EndIf
		Else
			This.Setear_Faltaart( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plataforma_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plataforma
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Plataforma( lxVal )
				if ( this.lHabilitarPlataforma or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Plataforma', lxValOld, lxVal  )
					this.Setear_Plataforma( lxVal )
				this.EventoDespuesDeSetear( This, 'Plataforma', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Plataforma', This )
						Endif
					EndIf
				else
					this.Plataforma = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Plataforma)" )
				endif 
			EndIf
		Else
			This.Setear_Plataforma( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Buzon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Buzon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Buzon( lxVal )
				if ( this.lHabilitarBuzon or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Buzon', lxValOld, lxVal  )
					this.Setear_Buzon( lxVal )
				this.EventoDespuesDeSetear( This, 'Buzon', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Buzon', This )
						Endif
					EndIf
				else
					this.Buzon = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Buzon)" )
				endif 
			EndIf
		Else
			This.Setear_Buzon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatos( lxVal )
				if ( this.lHabilitarBasededatos or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Basededatos', lxValOld, lxVal  )
					this.Setear_Basededatos( lxVal )
				this.EventoDespuesDeSetear( This, 'Basededatos', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Basededatos', This )
						Endif
					EndIf
				else
					this.Basededatos = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Basededatos)" )
				endif 
			EndIf
		Else
			This.Setear_Basededatos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerocomprobante( lxVal )
				if ( this.lHabilitarNumerocomprobante or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Numerocomprobante', lxValOld, lxVal  )
					this.Setear_Numerocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerocomprobante', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Numerocomprobante', This )
						Endif
					EndIf
				else
					this.Numerocomprobante = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Numerocomprobante)" )
				endif 
			EndIf
		Else
			This.Setear_Numerocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Utilizastockotrabase_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Utilizastockotrabase
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Utilizastockotrabase( lxVal )
				if ( this.lHabilitarUtilizastockotrabase or this.lEstaSeteandoValorSugerido or lxValOld == lxVal)
					this.EventoAntesDeSetear( This, 'Utilizastockotrabase', lxValOld, lxVal  )
					this.Setear_Utilizastockotrabase( lxVal )
				this.EventoDespuesDeSetear( This, 'Utilizastockotrabase', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Utilizastockotrabase', This )
						Endif
					EndIf
				else
					this.Utilizastockotrabase = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Utilizastockotrabase)" )
				endif 
			EndIf
		Else
			This.Setear_Utilizastockotrabase( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Bdorigenstock_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Bdorigenstock
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Bdorigenstock( lxVal )
				if ( this.lHabilitarBdorigenstock or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Bdorigenstock', lxValOld, lxVal  )
					this.Setear_Bdorigenstock( lxVal )
				this.EventoDespuesDeSetear( This, 'Bdorigenstock', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Bdorigenstock', This )
						Endif
					EndIf
				else
					this.Bdorigenstock = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Bdorigenstock)" )
				endif 
			EndIf
		Else
			This.Setear_Bdorigenstock( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cbtetentativoparacancelacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cbtetentativoparacancelacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cbtetentativoparacancelacion( lxVal )
				if ( this.lHabilitarCbtetentativoparacancelacion or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Cbtetentativoparacancelacion', lxValOld, lxVal  )
					this.Setear_Cbtetentativoparacancelacion( lxVal )
				this.EventoDespuesDeSetear( This, 'Cbtetentativoparacancelacion', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Cbtetentativoparacancelacion', This )
						Endif
					EndIf
				else
					this.Cbtetentativoparacancelacion = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Cbtetentativoparacancelacion)" )
				endif 
			EndIf
		Else
			This.Setear_Cbtetentativoparacancelacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobanteafectado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobanteafectado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobanteafectado( lxVal )
				if ( this.lHabilitarComprobanteafectado or this.lEstaSeteandoValorSugerido or alltrim( lxValOld ) == alltrim( lxVal ))
					this.EventoAntesDeSetear( This, 'Comprobanteafectado', lxValOld, lxVal  )
					this.Setear_Comprobanteafectado( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobanteafectado', lxValOld, lxVal  )
					If lxValOld != lxVal
						If This.PuedeEjecutarHaCambiado()
							this.HaCambiado( 'Comprobanteafectado', This )
						Endif
					EndIf
				else
					this.Comprobanteafectado = lxValOld
					goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Herramienta de generación de comprobantes ecommerce - Atributo: Comprobanteafectado)" )
				endif 
			EndIf
		Else
			This.Setear_Comprobanteafectado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerooperacion( txVal as variant ) as void

		this.Numerooperacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cantidad( txVal as variant ) as void

		this.Cantidad = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Envio( txVal as variant ) as void

		this.Envio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fullenvios( txVal as variant ) as void

		this.Fullenvios = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cancelada( txVal as variant ) as void

		this.Cancelada = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipocomprobante( txVal as variant ) as void

		this.Tipocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientenombre( txVal as variant ) as void

		this.Clientenombre = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Pagado( txVal as variant ) as void

		this.Pagado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Faltaart( txVal as variant ) as void

		this.Faltaart = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plataforma( txVal as variant ) as void

		this.Plataforma = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Buzon( txVal as variant ) as void

		this.Buzon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatos( txVal as variant ) as void

		this.Basededatos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerocomprobante( txVal as variant ) as void

		this.Numerocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Utilizastockotrabase( txVal as variant ) as void

		this.Utilizastockotrabase = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Bdorigenstock( txVal as variant ) as void

		this.Bdorigenstock = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cbtetentativoparacancelacion( txVal as variant ) as void

		this.Cbtetentativoparacancelacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobanteafectado( txVal as variant ) as void

		this.Comprobanteafectado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerooperacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cantidad( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Envio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fullenvios( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cancelada( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientenombre( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Pagado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Faltaart( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plataforma( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Buzon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Utilizastockotrabase( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Bdorigenstock( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cbtetentativoparacancelacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobanteafectado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )
					this.Cliente = _Screen.zoo.instanciarentidad( 'Clienteecommerce' )
					this.Cliente.lEsSubEntidad = .t.
					this.enlazar( 'Cliente.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cliente.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cliente.CODIGO # this.Cliente_PK
						this.Cliente.CODIGO = this.Cliente_PK
					endif
				endif
			endif
		endif
		return this.Cliente
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedragon_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Clientedragon ) = 'O' or isnull( this.Clientedragon ) )
					this.Clientedragon = _Screen.zoo.instanciarentidad( 'Cliente' )
					this.Clientedragon.lEsSubEntidad = .t.
					this.enlazar( 'Clientedragon.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Clientedragon.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Clientedragon.CODIGO # this.Clientedragon_PK
						this.Clientedragon.CODIGO = this.Clientedragon_PK
					endif
				endif
			endif
		endif
		return this.Clientedragon
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Operacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Operacion ) = 'O' or isnull( this.Operacion ) )
					this.Operacion = _Screen.zoo.instanciarentidad( 'Operacionecommerce' )
					this.Operacion.lEsSubEntidad = .t.
					this.enlazar( 'Operacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Operacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Operacion.CODIGO # this.Operacion_PK
						this.Operacion.CODIGO = this.Operacion_PK
					endif
				endif
			endif
		endif
		return this.Operacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Numero = 0
				.Numerooperacion = []
				.Cantidad = 0
				.Monto = 0
				.Clientedescripcion = []
				.Cliente_PK = []
				.Clientedragon_PK = []
				.Envio = []
				.Fullenvios = .F.
				.Cancelada = .F.
				.Tipocomprobante = []
				.Clientenombre = []
				.Pagado = .F.
				.Operacion_PK = []
				.Plataforma = []
				.Buzon = []
				.Basededatos = []
				.Numerocomprobante = []
				.Utilizastockotrabase = .F.
				.Bdorigenstock = []
				.Comprobanteafectado = []
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
	Function ValorSugeridoNumerooperacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Numerooperacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Numerooperacion' )
						.Numerooperacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Operación para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoClientedragon() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Clientedragon" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Clientedragon_PK' )
						.Clientedragon_PK = lvValorSugeridoDefinidoPorElUsuario
						.Clientedragon.CODIGO = .Clientedragon_PK
					endif
				endif
			Catch to loError
				.Clientedragon_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cliente para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFullenvios() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Fullenvios" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fullenvios' )
						.Fullenvios = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Logística tercerizada para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoTipocomprobante() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Tipocomprobante" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Tipocomprobante' )
						.Tipocomprobante = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Acción para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPagado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Pagado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Pagado' )
						.Pagado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Pagado para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBuzon() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Buzon" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Buzon' )
						.Buzon = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Buzón para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBasededatos() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "COMPROBANTESECOMMERCE", "Detalleoperaciones", "Basededatos" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Basededatos' )
						.Basededatos = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Base de datos para el detalle Detalle comprobantes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
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
	function Numerooperacion_DespuesDeAsignar() as void
		this.CompletarDatosOperacion()                                                                      
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
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
			.Faltaart = .F.
			.Cbtetentativoparacancelacion = []
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

		if  empty( this.Numerooperacion ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarNROITEM = tlHabilitar
		this.lHabilitarNumero = tlHabilitar
		this.lHabilitarNumeroOperacion = tlHabilitar
		this.lHabilitarCantidad = tlHabilitar
		this.lHabilitarMonto = tlHabilitar
		this.lHabilitarClienteDescripcion = tlHabilitar
		this.lHabilitarCliente_PK = tlHabilitar
		this.lHabilitarClienteDragon_PK = tlHabilitar
		this.lHabilitarEnvio = tlHabilitar
		this.lHabilitarFullEnvios = tlHabilitar
		this.lHabilitarCancelada = tlHabilitar
		this.lHabilitarTipoComprobante = tlHabilitar
		this.lHabilitarClienteNombre = tlHabilitar
		this.lHabilitarPagado = tlHabilitar
		this.lHabilitarOperacion_PK = tlHabilitar
		this.lHabilitarFaltaArt = tlHabilitar
		this.lHabilitarPlataforma = tlHabilitar
		this.lHabilitarBuzon = tlHabilitar
		this.lHabilitarBaseDeDatos = tlHabilitar
		this.lHabilitarNumeroComprobante = tlHabilitar
		this.lHabilitarUtilizaStockOtraBase = tlHabilitar
		this.lHabilitarBDOrigenStock = tlHabilitar
		this.lHabilitarCbteTentativoParaCancelacion = tlHabilitar
		this.lHabilitarComprobanteAfectado = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMOPERACIONESECOM]
	endfunc

enddefine