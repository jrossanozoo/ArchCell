
define class Din_ItemPROCESARNCPENDIENTEPROMOBANCOCuponespendientes as ItemActivo of ItemActivo.prg

	cNombre = 'PROCESARNCPENDIENTEPROMOBANCO'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	IdAjuste = []
	IdCupon = []
	IdFactura = []
	LetraFactura = []
	PuntoDeVentaFactura = 0
	NumeroFactura = 0
	ComprobanteOrigen = []
	Fecha = ctod( '  /  /    ' )
	Caja = 0
	NotaDeCredito = []
	IdCliente = []
	ClienteDescripcion = []
	MontoAjuste = 0
	FactTipo = 0
	Vendedor = []
	Seleccion = .F.
	TipoNotaDeCredito = 0
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'PROCESARNCPENDIENTEPROMOBANCO', 'Cuponespendientes')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
	function Idajuste_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idajuste
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idajuste( lxVal )
				this.EventoAntesDeSetear( This, 'Idajuste', lxValOld, lxVal  )
				this.Setear_Idajuste( lxVal )
				this.EventoDespuesDeSetear( This, 'Idajuste', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idajuste', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idajuste( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idcupon_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idcupon
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idcupon( lxVal )
				this.EventoAntesDeSetear( This, 'Idcupon', lxValOld, lxVal  )
				this.Setear_Idcupon( lxVal )
				this.EventoDespuesDeSetear( This, 'Idcupon', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idcupon', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idcupon( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idfactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idfactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idfactura( lxVal )
				this.EventoAntesDeSetear( This, 'Idfactura', lxValOld, lxVal  )
				this.Setear_Idfactura( lxVal )
				this.EventoDespuesDeSetear( This, 'Idfactura', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idfactura', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idfactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Letrafactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Letrafactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Letrafactura( lxVal )
				this.EventoAntesDeSetear( This, 'Letrafactura', lxValOld, lxVal  )
				this.Setear_Letrafactura( lxVal )
				this.EventoDespuesDeSetear( This, 'Letrafactura', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Letrafactura', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Letrafactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Puntodeventafactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Puntodeventafactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Puntodeventafactura( lxVal )
				this.EventoAntesDeSetear( This, 'Puntodeventafactura', lxValOld, lxVal  )
				this.Setear_Puntodeventafactura( lxVal )
				this.EventoDespuesDeSetear( This, 'Puntodeventafactura', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Puntodeventafactura', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Puntodeventafactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerofactura_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerofactura
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerofactura( lxVal )
				this.EventoAntesDeSetear( This, 'Numerofactura', lxValOld, lxVal  )
				this.Setear_Numerofactura( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerofactura', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerofactura', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerofactura( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobanteorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobanteorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobanteorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Comprobanteorigen', lxValOld, lxVal  )
				this.Setear_Comprobanteorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobanteorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comprobanteorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comprobanteorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				this.Setear_Fecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fecha', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Caja_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Caja
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Caja( lxVal )
				this.EventoAntesDeSetear( This, 'Caja', lxValOld, lxVal  )
				this.Setear_Caja( lxVal )
				this.EventoDespuesDeSetear( This, 'Caja', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Caja', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Caja( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Notadecredito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Notadecredito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Notadecredito( lxVal )
				this.EventoAntesDeSetear( This, 'Notadecredito', lxValOld, lxVal  )
				this.Setear_Notadecredito( lxVal )
				this.EventoDespuesDeSetear( This, 'Notadecredito', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Notadecredito', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Notadecredito( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idcliente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idcliente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Idcliente( lxVal )
				this.EventoAntesDeSetear( This, 'Idcliente', lxValOld, lxVal  )
				this.Setear_Idcliente( lxVal )
				this.EventoDespuesDeSetear( This, 'Idcliente', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Idcliente', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Idcliente( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
				this.Setear_Clientedescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Clientedescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Montoajuste_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montoajuste
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montoajuste( lxVal )
				this.EventoAntesDeSetear( This, 'Montoajuste', lxValOld, lxVal  )
				this.Setear_Montoajuste( lxVal )
				this.EventoDespuesDeSetear( This, 'Montoajuste', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montoajuste', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montoajuste( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Facttipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Facttipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Facttipo( lxVal )
				this.EventoAntesDeSetear( This, 'Facttipo', lxValOld, lxVal  )
				this.Setear_Facttipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Facttipo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Facttipo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Facttipo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vendedor( lxVal )
				this.EventoAntesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				this.Setear_Vendedor( lxVal )
				this.EventoDespuesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Vendedor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Vendedor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seleccion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seleccion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seleccion( lxVal )
				this.EventoAntesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
				this.Setear_Seleccion( lxVal )
				this.EventoDespuesDeSetear( This, 'Seleccion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Seleccion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Seleccion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tiponotadecredito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tiponotadecredito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tiponotadecredito( lxVal )
				this.EventoAntesDeSetear( This, 'Tiponotadecredito', lxValOld, lxVal  )
				this.Setear_Tiponotadecredito( lxVal )
				this.EventoDespuesDeSetear( This, 'Tiponotadecredito', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tiponotadecredito', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tiponotadecredito( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idajuste( txVal as variant ) as void

		this.Idajuste = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idcupon( txVal as variant ) as void

		this.Idcupon = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idfactura( txVal as variant ) as void

		this.Idfactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Letrafactura( txVal as variant ) as void

		this.Letrafactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Puntodeventafactura( txVal as variant ) as void

		this.Puntodeventafactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerofactura( txVal as variant ) as void

		this.Numerofactura = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobanteorigen( txVal as variant ) as void

		this.Comprobanteorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Caja( txVal as variant ) as void

		this.Caja = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Notadecredito( txVal as variant ) as void

		this.Notadecredito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idcliente( txVal as variant ) as void

		this.Idcliente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montoajuste( txVal as variant ) as void

		this.Montoajuste = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Facttipo( txVal as variant ) as void

		this.Facttipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccion( txVal as variant ) as void

		this.Seleccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tiponotadecredito( txVal as variant ) as void

		this.Tiponotadecredito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idajuste( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idcupon( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idfactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Letrafactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Puntodeventafactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerofactura( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobanteorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Caja( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Notadecredito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idcliente( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montoajuste( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Facttipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tiponotadecredito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Codigo = []
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
	Function ValorSugeridoSeleccion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "PROCESARNCPENDIENTEPROMOBANCO", "Cuponespendientes", "Seleccion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Seleccion' )
						.Seleccion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionado para el detalle Cupones pendientes." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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
	function ValidarDominio_Fecha( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fecha( txVal )
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
			.Idajuste = []
			.Idcupon = []
			.Idfactura = []
			.Letrafactura = []
			.Puntodeventafactura = 0
			.Numerofactura = 0
			.Comprobanteorigen = []
			.Fecha = ctod( '  /  /    ' )
			.Caja = 0
			.Notadecredito = []
			.Idcliente = []
			.Clientedescripcion = []
			.Montoajuste = 0
			.Facttipo = 0
			.Vendedor = []
			.Seleccion = .F.
			.Tiponotadecredito = 0
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

		if  empty( this.Codigo ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMNCPENDIENTEPROMOB]
	endfunc

enddefine