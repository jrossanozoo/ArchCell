
define class Din_ItemFACTURAELECTRONICADECREDITOPromoarticulosdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'FACTURAELECTRONICADECREDITO'
	idItemValor = []
	AtributoCabecera = []
	idItemPromo = []
	idItemArticulo = []
	NROITEM = 0
	MontoBeneficio = 0
	cAtributoPK = 'Codigo'
	Codigo = []
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
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'FACTURAELECTRONICADECREDITO', 'Promoarticulosdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemvalor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemvalor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemvalor( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemvalor', lxValOld, lxVal  )
				this.Setear_Iditemvalor( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemvalor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemvalor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemvalor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Atributocabecera_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Atributocabecera
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Atributocabecera( lxVal )
				this.EventoAntesDeSetear( This, 'Atributocabecera', lxValOld, lxVal  )
				this.Setear_Atributocabecera( lxVal )
				this.EventoDespuesDeSetear( This, 'Atributocabecera', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Atributocabecera', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Atributocabecera( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditempromo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditempromo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditempromo( lxVal )
				this.EventoAntesDeSetear( This, 'Iditempromo', lxValOld, lxVal  )
				this.Setear_Iditempromo( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditempromo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditempromo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditempromo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Iditemarticulo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Iditemarticulo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Iditemarticulo( lxVal )
				this.EventoAntesDeSetear( This, 'Iditemarticulo', lxValOld, lxVal  )
				this.Setear_Iditemarticulo( lxVal )
				this.EventoDespuesDeSetear( This, 'Iditemarticulo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Iditemarticulo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Iditemarticulo( lxVal ) 
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
	function Montobeneficio_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Montobeneficio
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Montobeneficio( lxVal )
				this.EventoAntesDeSetear( This, 'Montobeneficio', lxValOld, lxVal  )
				this.Setear_Montobeneficio( lxVal )
				this.EventoDespuesDeSetear( This, 'Montobeneficio', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Montobeneficio', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Montobeneficio( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemvalor( txVal as variant ) as void

		this.Iditemvalor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Atributocabecera( txVal as variant ) as void

		this.Atributocabecera = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditempromo( txVal as variant ) as void

		this.Iditempromo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Iditemarticulo( txVal as variant ) as void

		this.Iditemarticulo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Montobeneficio( txVal as variant ) as void

		this.Montobeneficio = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemvalor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Atributocabecera( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditempromo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Iditemarticulo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Montobeneficio( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

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

				.Iditemvalor = []
				.Atributocabecera = []
				.Iditempromo = []
				.Iditemarticulo = []
				.Montobeneficio = 0
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
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
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

		if  empty( this.Iditempromo ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMPROMOARTICULOS]
	endfunc

enddefine