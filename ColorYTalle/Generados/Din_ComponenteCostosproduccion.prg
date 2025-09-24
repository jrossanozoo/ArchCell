
define class Din_ComponenteCOSTOSPRODUCCION as Componente of Componente.prg
	oCOSTODEINSUMO = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCOSTODEINSUMO_Access()
		if !this.ldestroy and !vartype( this.oCOSTODEINSUMO ) = 'O'
			this.oCOSTODEINSUMO= _screen.zoo.InstanciarEntidad( 'COSTODEINSUMO' )
			this.enlazar( 'oCOSTODEINSUMO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCOSTODEINSUMO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCOSTODEINSUMO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCOSTODEINSUMO' ) = 'O' and !isnull( This.oCOSTODEINSUMO )
			this.oCOSTODEINSUMO.Release()
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