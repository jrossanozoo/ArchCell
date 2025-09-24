
define class Din_ComponenteARQUEODECAJA as Componente of Componente.prg
	oARQUEODECAJA = NULL
	oCOMPROBANTEDECAJA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oARQUEODECAJA_Access()
		if !this.ldestroy and !vartype( this.oARQUEODECAJA ) = 'O'
			this.oARQUEODECAJA= _screen.zoo.InstanciarEntidad( 'ARQUEODECAJA' )
			this.enlazar( 'oARQUEODECAJA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oARQUEODECAJA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oARQUEODECAJA
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oCOMPROBANTEDECAJA_Access()
		if !this.ldestroy and !vartype( this.oCOMPROBANTEDECAJA ) = 'O'
			this.oCOMPROBANTEDECAJA= _screen.zoo.InstanciarEntidad( 'COMPROBANTEDECAJA' )
			this.enlazar( 'oCOMPROBANTEDECAJA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOMPROBANTEDECAJA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOMPROBANTEDECAJA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oARQUEODECAJA' ) = 'O' and !isnull( This.oARQUEODECAJA )
			this.oARQUEODECAJA.Release()
		endif
		if type( 'This.oCOMPROBANTEDECAJA' ) = 'O' and !isnull( This.oCOMPROBANTEDECAJA )
			this.oCOMPROBANTEDECAJA.Release()
		endif

		dodefault()
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Grabar() as ZooColeccion of ZooColeccion.prg

		Local loColeccion as ZooColeccion of ZooColeccion.Prg
		loColeccion = dodefault()
		Return loColeccion
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function Recibir( toEntidad as object, tcAtributoDetalle as string, tcCursorDetalle as string, tcCursorCabecera as string ) as void
		dodefault( toEntidad, tcAtributoDetalle, tcCursorDetalle, tcCursorCabecera )
	endfunc


enddefine