
define class Din_ItemSELECHEQUEAINSERTARDetallechequesainsertar as ItemActivo of ItemActivo.prg

	cNombre = 'SELECHEQUEAINSERTAR'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	CodigoValor = []
	Moneda = []
	Cliente_PK = []
	Cliente = null
	ClienteDetalle = []
	Numero = 0
	EntidadFinanciera_PK = []
	EntidadFinanciera = null
	EntidadFinancieraDetalle = []
	NumeroInt = 0
	CodigoTributarioLibrador = []
	FechaDePago = ctod( '  /  /    ' )
	FechaEmision = ctod( '  /  /    ' )
	Monto = 0
	Seleccionado = .F.
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
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechadepago()','Fechadepago')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWFechaemision()','Fechaemision')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'SELECHEQUEAINSERTAR', 'Detallechequesainsertar')
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
			this.EventoAntesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
			This.Setear_Cliente( lxVal )
			this.EventoDespuesDeSetear( This, 'Cliente_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Cliente_Pk', This )
				Endif
			EndIf
		endif
		If lxValOld != lxVal or empty( this.Clientedetalle ) 
			this.Clientedetalle = This.Cliente.Nombre
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadfinanciera_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadfinanciera_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Entidadfinanciera_PK = lxVal

		if this.Validar_Entidadfinanciera( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Entidadfinanciera_Pk', lxValOld, lxVal  )
			This.Setear_Entidadfinanciera( lxVal )
			this.EventoDespuesDeSetear( This, 'Entidadfinanciera_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Entidadfinanciera_Pk', This )
				Endif
			EndIf
		endif
		If lxValOld != lxVal or empty( this.Entidadfinancieradetalle ) 
			this.Entidadfinancieradetalle = This.EntidadFinanciera.Descripcion
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadfinanciera( txVal as variant ) as void

		this.Entidadfinanciera.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld ) and This.Cliente.oDesactivador.ValidarEstadoActivacion( txVal, txValOld, this.lnuevo, this.ledicion) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadfinanciera( txVal as variant, txValOld as variant ) as Boolean

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
	function Codigovalor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigovalor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigovalor( lxVal )
				this.EventoAntesDeSetear( This, 'Codigovalor', lxValOld, lxVal  )
				this.Setear_Codigovalor( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigovalor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigovalor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigovalor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Moneda_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Moneda
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Moneda( lxVal )
				this.EventoAntesDeSetear( This, 'Moneda', lxValOld, lxVal  )
				this.Setear_Moneda( lxVal )
				this.EventoDespuesDeSetear( This, 'Moneda', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Moneda', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Moneda( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Clientedetalle', lxValOld, lxVal  )
				this.Setear_Clientedetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Clientedetalle( lxVal ) 
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
				this.EventoAntesDeSetear( This, 'Numero', lxValOld, lxVal  )
				this.Setear_Numero( lxVal )
				this.EventoDespuesDeSetear( This, 'Numero', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numero', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numero( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadfinancieradetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadfinancieradetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entidadfinancieradetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Entidadfinancieradetalle', lxValOld, lxVal  )
				this.Setear_Entidadfinancieradetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Entidadfinancieradetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Entidadfinancieradetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Entidadfinancieradetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numeroint_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numeroint
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numeroint( lxVal )
				this.EventoAntesDeSetear( This, 'Numeroint', lxValOld, lxVal  )
				this.Setear_Numeroint( lxVal )
				this.EventoDespuesDeSetear( This, 'Numeroint', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numeroint', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numeroint( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigotributariolibrador_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigotributariolibrador
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigotributariolibrador( lxVal )
				this.EventoAntesDeSetear( This, 'Codigotributariolibrador', lxValOld, lxVal  )
				this.Setear_Codigotributariolibrador( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigotributariolibrador', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigotributariolibrador', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigotributariolibrador( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechadepago_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechadepago
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechadepago( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.EventoAntesDeSetear( This, 'Fechadepago', lxValOld, lxVal  )
				this.Setear_Fechadepago( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechadepago', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechadepago', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechadepago( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaemision_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaemision
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaemision( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.EventoAntesDeSetear( This, 'Fechaemision', lxValOld, lxVal  )
				this.Setear_Fechaemision( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechaemision', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechaemision', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechaemision( lxVal ) 
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
	function Seleccionado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seleccionado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seleccionado( lxVal )
				this.EventoAntesDeSetear( This, 'Seleccionado', lxValOld, lxVal  )
				this.Setear_Seleccionado( lxVal )
				this.EventoDespuesDeSetear( This, 'Seleccionado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Seleccionado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Seleccionado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigovalor( txVal as variant ) as void

		this.Codigovalor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Moneda( txVal as variant ) as void

		this.Moneda = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedetalle( txVal as variant ) as void

		this.Clientedetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadfinancieradetalle( txVal as variant ) as void

		this.Entidadfinancieradetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numeroint( txVal as variant ) as void

		this.Numeroint = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigotributariolibrador( txVal as variant ) as void

		this.Codigotributariolibrador = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechadepago( txVal as variant ) as void

		this.Fechadepago = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaemision( txVal as variant ) as void

		this.Fechaemision = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccionado( txVal as variant ) as void

		this.Seleccionado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigovalor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Moneda( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadfinancieradetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numeroint( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigotributariolibrador( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechadepago( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaemision( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccionado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cliente ) = 'O' or isnull( this.Cliente ) )
					this.Cliente = _Screen.zoo.instanciarentidad( 'Cliente' )
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
	function Entidadfinanciera_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Entidadfinanciera ) = 'O' or isnull( this.Entidadfinanciera ) )
					this.Entidadfinanciera = _Screen.zoo.instanciarentidad( 'Entidadfinanciera' )
					this.Entidadfinanciera.lEsSubEntidad = .t.
					this.enlazar( 'Entidadfinanciera.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Entidadfinanciera.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Entidadfinanciera.CODIGO # this.Entidadfinanciera_PK
						this.Entidadfinanciera.CODIGO = this.Entidadfinanciera_PK
					endif
				endif
			endif
		endif
		return this.Entidadfinanciera
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
	Function ValorSugeridoMoneda() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECHEQUEAINSERTAR", "Detallechequesainsertar", "Moneda" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Moneda' )
						.Moneda = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Moneda para el detalle Cheques filtrados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechadepago() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECHEQUEAINSERTAR", "Detallechequesainsertar", "Fechadepago" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "D"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Fechadepago' )
						.Fechadepago = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Fecha de pago para el detalle Cheques filtrados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es fecha." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			else
				.ValorSugeridoFWFechadepago()
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechadepago() as void
		with this
			.Fechadepago = golibrerias.obtenerfecha() + 1
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWFechaemision() as void
		with this
			.Fechaemision = golibrerias.obtenerfecha()
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFechaemision() as void
		with this
			.ValorSugeridoFWFechaemision()
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoSeleccionado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "SELECHEQUEAINSERTAR", "Detallechequesainsertar", "Seleccionado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Seleccionado' )
						.Seleccionado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionado para el detalle Cheques filtrados." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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
	function ValidarDominio_Fechacalendario( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fechacalendario( txVal )
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
			.Codigovalor = []
			.Moneda = []
			.Cliente_PK = []
			.Clientedetalle = []
			.Numero = 0
			.Entidadfinanciera_PK = []
			.Entidadfinancieradetalle = []
			.Numeroint = 0
			.Codigotributariolibrador = []
			.Fechadepago = ctod( '  /  /    ' )
			.Fechaemision = ctod( '  /  /    ' )
			.Monto = 0
			.Seleccionado = .F.
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

		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMSELECHEQUEAINSERTAR]
	endfunc

enddefine