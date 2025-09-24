
define class Din_ItemGESTIONCHCUSTODIADetallechcustodia as ItemActivo of ItemActivo.prg

	cNombre = 'GESTIONCHCUSTODIA'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	Registro = []
	NumeroInterno = []
	EntidadFinanciera_PK = []
	EntidadFinanciera = null
	EntidadFinancieraDescripcion = []
	Numero = 0
	FechaEmision = ctod( '  /  /    ' )
	FechaPago = ctod( '  /  /    ' )
	CUITLibrador = []
	Cliente_PK = []
	Cliente = null
	ClienteDescripcion = []
	Monto = 0
	Seleccion = .F.
	Estado = []
	IDCheque_PK = []
	IDCheque = null
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'GESTIONCHCUSTODIA', 'Detallechcustodia')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
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
		dodefault( lxVal )

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
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
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
		If lxValOld != lxVal or empty( this.Clientedescripcion ) 
			this.Clientedescripcion = This.Cliente.Nombre
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Idcheque_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Idcheque_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 38, padr( lxVal, 38 ), lxVal )
		this.Idcheque_PK = lxVal

		if this.Validar_Idcheque( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Idcheque_Pk', lxValOld, lxVal  )
			This.Setear_Idcheque( lxVal )
			this.EventoDespuesDeSetear( This, 'Idcheque_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Idcheque_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadfinanciera( txVal as variant ) as void

		this.Entidadfinanciera.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Idcheque( txVal as variant ) as void

		this.Idcheque.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadfinanciera( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Idcheque( txVal as variant, txValOld as variant ) as Boolean

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
	function Registro_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Registro
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Registro( lxVal )
				this.EventoAntesDeSetear( This, 'Registro', lxValOld, lxVal  )
				this.Setear_Registro( lxVal )
				this.EventoDespuesDeSetear( This, 'Registro', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Registro', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Registro( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numerointerno_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Numerointerno
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Numerointerno( lxVal )
				this.EventoAntesDeSetear( This, 'Numerointerno', lxValOld, lxVal  )
				this.Setear_Numerointerno( lxVal )
				this.EventoDespuesDeSetear( This, 'Numerointerno', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Numerointerno', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Numerointerno( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Entidadfinancieradescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Entidadfinancieradescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Entidadfinancieradescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Entidadfinancieradescripcion', lxValOld, lxVal  )
				this.Setear_Entidadfinancieradescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Entidadfinancieradescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Entidadfinancieradescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Entidadfinancieradescripcion( lxVal ) 
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
	function Fechapago_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechapago
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechapago( lxVal )
				this.ValidarDominio_Fechacalendario( lxVal )
				this.EventoAntesDeSetear( This, 'Fechapago', lxValOld, lxVal  )
				this.Setear_Fechapago( lxVal )
				this.EventoDespuesDeSetear( This, 'Fechapago', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fechapago', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fechapago( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuitlibrador_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuitlibrador
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuitlibrador( lxVal )
				this.EventoAntesDeSetear( This, 'Cuitlibrador', lxValOld, lxVal  )
				this.Setear_Cuitlibrador( lxVal )
				this.EventoDespuesDeSetear( This, 'Cuitlibrador', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cuitlibrador', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cuitlibrador( lxVal ) 
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
	function Estado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estado( lxVal )
				this.EventoAntesDeSetear( This, 'Estado', lxValOld, lxVal  )
				this.Setear_Estado( lxVal )
				this.EventoDespuesDeSetear( This, 'Estado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Estado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Estado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Registro( txVal as variant ) as void

		this.Registro = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numerointerno( txVal as variant ) as void

		this.Numerointerno = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Entidadfinancieradescripcion( txVal as variant ) as void

		this.Entidadfinancieradescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Numero( txVal as variant ) as void

		this.Numero = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaemision( txVal as variant ) as void

		this.Fechaemision = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechapago( txVal as variant ) as void

		this.Fechapago = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuitlibrador( txVal as variant ) as void

		this.Cuitlibrador = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Monto( txVal as variant ) as void

		this.Monto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seleccion( txVal as variant ) as void

		this.Seleccion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estado( txVal as variant ) as void

		this.Estado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Registro( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numerointerno( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Entidadfinancieradescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Numero( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaemision( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechapago( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuitlibrador( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Monto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seleccion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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
	function Idcheque_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Idcheque ) = 'O' or isnull( this.Idcheque ) )
					this.Idcheque = _Screen.zoo.instanciarentidad( 'Cheque' )
					this.Idcheque.lEsSubEntidad = .t.
					this.enlazar( 'Idcheque.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Idcheque.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Idcheque.CODIGO # this.Idcheque_PK
						this.Idcheque.CODIGO = this.Idcheque_PK
					endif
				endif
			endif
		endif
		return this.Idcheque
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
				.Registro = []
				.Numerointerno = []
				.Estado = []
				.Idcheque_PK = []
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
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "GESTIONCHCUSTODIA", "Detallechcustodia", "Seleccion" )
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
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Seleccionada para el detalle Cheques en custodia." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
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
			.Entidadfinanciera_PK = []
			.Entidadfinancieradescripcion = []
			.Numero = 0
			.Fechaemision = ctod( '  /  /    ' )
			.Fechapago = ctod( '  /  /    ' )
			.Cuitlibrador = []
			.Cliente_PK = []
			.Clientedescripcion = []
			.Monto = 0
			.Seleccion = .F.
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

		if  empty( this.Numerointerno ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCHCUSTODIA]
	endfunc

enddefine