
define class Din_ItemASIENTOTIPOAsientotipodetalle as ItemActivo of ItemActivo.prg

	cNombre = 'ASIENTOTIPO'
	NROITEM = 0
	cAtributoPK = 'Codigo'
	Codigo = []
	HabilitaDebe = []
	HabilitaHaber = []
	CodigoConcepto = []
	Concepto = []
	PlanDeCuentasDebe_PK = []
	PlanDeCuentasDebe = null
	lHabilitarPlanDeCuentasDebe_PK = .T.
	PlanDeCuentasDebeDetalle = []
	PlanDeCuentasHaber_PK = []
	PlanDeCuentasHaber = null
	lHabilitarPlanDeCuentasHaber_PK = .T.
	PlanDeCuentasHaberDetalle = []
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
		this.lHabilitarPlanDeCuentasDebe_PK = .T.
		this.lHabilitarPlanDeCuentasHaber_PK = .T.
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'ASIENTOTIPO', 'Asientotipodetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentasdebe_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentasdebe_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.Plandecuentasdebe_PK = lxVal

		if this.Validar_Plandecuentasdebe( lxVal, lxValOld )
			if ( this.lHabilitarPlandecuentasdebe_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Plandecuentasdebe_Pk', lxValOld, lxVal  )
				This.Setear_Plandecuentasdebe( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentasdebe_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Plandecuentasdebe_Pk', This )
					Endif
				EndIf
			else
				this.Plandecuentasdebe_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asiento tipo - Atributo: Plandecuentasdebe)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentashaber_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentashaber_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.Plandecuentashaber_PK = lxVal

		if this.Validar_Plandecuentashaber( lxVal, lxValOld )
			if ( this.lHabilitarPlandecuentashaber_PK or this.lEstaSeteandoValorSugerido or lxValOld == lxVal )
				this.EventoAntesDeSetear( This, 'Plandecuentashaber_Pk', lxValOld, lxVal  )
				This.Setear_Plandecuentashaber( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentashaber_Pk', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Plandecuentashaber_Pk', This )
					Endif
				EndIf
			else
				this.Plandecuentashaber_PK = lxValOld
				goServicios.Errores.LevantarExcepcion( "No se puede cambiar este valor (Entidad: Asiento tipo - Atributo: Plandecuentashaber)" )
			endif 
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentasdebe( txVal as variant ) as void

		this.Plandecuentasdebe.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentashaber( txVal as variant ) as void

		this.Plandecuentashaber.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentasdebe( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentashaber( txVal as variant, txValOld as variant ) as Boolean

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
	function Habilitadebe_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Habilitadebe
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Habilitadebe( lxVal )
				this.EventoAntesDeSetear( This, 'Habilitadebe', lxValOld, lxVal  )
				this.Setear_Habilitadebe( lxVal )
				this.EventoDespuesDeSetear( This, 'Habilitadebe', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Habilitadebe', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Habilitadebe( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Habilitahaber_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Habilitahaber
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Habilitahaber( lxVal )
				this.EventoAntesDeSetear( This, 'Habilitahaber', lxValOld, lxVal  )
				this.Setear_Habilitahaber( lxVal )
				this.EventoDespuesDeSetear( This, 'Habilitahaber', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Habilitahaber', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Habilitahaber( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigoconcepto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigoconcepto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigoconcepto( lxVal )
				this.EventoAntesDeSetear( This, 'Codigoconcepto', lxValOld, lxVal  )
				this.Setear_Codigoconcepto( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigoconcepto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigoconcepto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigoconcepto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Concepto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Concepto( lxVal )
				this.EventoAntesDeSetear( This, 'Concepto', lxValOld, lxVal  )
				this.Setear_Concepto( lxVal )
				this.EventoDespuesDeSetear( This, 'Concepto', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Concepto', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Concepto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentasdebedetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentasdebedetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Plandecuentasdebedetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Plandecuentasdebedetalle', lxValOld, lxVal  )
				this.Setear_Plandecuentasdebedetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentasdebedetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Plandecuentasdebedetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Plandecuentasdebedetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentashaberdetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentashaberdetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Plandecuentashaberdetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Plandecuentashaberdetalle', lxValOld, lxVal  )
				this.Setear_Plandecuentashaberdetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Plandecuentashaberdetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Plandecuentashaberdetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Plandecuentashaberdetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Habilitadebe( txVal as variant ) as void

		this.Habilitadebe = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Habilitahaber( txVal as variant ) as void

		this.Habilitahaber = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigoconcepto( txVal as variant ) as void

		this.Codigoconcepto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Concepto( txVal as variant ) as void

		this.Concepto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentasdebedetalle( txVal as variant ) as void

		this.Plandecuentasdebedetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentashaberdetalle( txVal as variant ) as void

		this.Plandecuentashaberdetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Habilitadebe( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Habilitahaber( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigoconcepto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Concepto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentasdebedetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentashaberdetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentasdebe_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Plandecuentasdebe ) = 'O' or isnull( this.Plandecuentasdebe ) )
					this.Plandecuentasdebe = _Screen.zoo.instanciarentidad( 'Plandecuentas' )
					this.Plandecuentasdebe.lEsSubEntidad = .t.
					this.enlazar( 'Plandecuentasdebe.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Plandecuentasdebe.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Plandecuentasdebe.CODIGO # this.Plandecuentasdebe_PK
						this.Plandecuentasdebe.CODIGO = this.Plandecuentasdebe_PK
					endif
				endif
			endif
		endif
		return this.Plandecuentasdebe
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentashaber_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Plandecuentashaber ) = 'O' or isnull( this.Plandecuentashaber ) )
					this.Plandecuentashaber = _Screen.zoo.instanciarentidad( 'Plandecuentas' )
					this.Plandecuentashaber.lEsSubEntidad = .t.
					this.enlazar( 'Plandecuentashaber.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Plandecuentashaber.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Plandecuentashaber.CODIGO # this.Plandecuentashaber_PK
						this.Plandecuentashaber.CODIGO = this.Plandecuentashaber_PK
					endif
				endif
			endif
		endif
		return this.Plandecuentashaber
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
				.Habilitadebe = []
				.Habilitahaber = []
				.Codigoconcepto = []
				.Concepto = []
				.Plandecuentasdebe_PK = []
				.Plandecuentasdebedetalle = []
				.Plandecuentashaber_PK = []
				.Plandecuentashaberdetalle = []
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
	Function ValorSugeridoPlandecuentasdebe() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTOTIPO", "Asientotipodetalle", "Plandecuentasdebe" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Plandecuentasdebe_PK' )
						.Plandecuentasdebe_PK = lvValorSugeridoDefinidoPorElUsuario
						.Plandecuentasdebe.CODIGO = .Plandecuentasdebe_PK
					endif
				endif
			Catch to loError
				.Plandecuentasdebe_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta debe para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPlandecuentashaber() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "ASIENTOTIPO", "Asientotipodetalle", "Plandecuentashaber" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Plandecuentashaber_PK' )
						.Plandecuentashaber_PK = lvValorSugeridoDefinidoPorElUsuario
						.Plandecuentashaber.CODIGO = .Plandecuentashaber_PK
					endif
				endif
			Catch to loError
				.Plandecuentashaber_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta haber para el detalle ." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
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
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.Concepto ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
		this.lHabilitarPlanDeCuentasDebe_PK = tlHabilitar
		this.lHabilitarPlanDeCuentasHaber_PK = tlHabilitar
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMASIENTOTIPO]
	endfunc

enddefine