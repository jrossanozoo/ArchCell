
define class Din_ComponenteFINALDEPRODUCCION as Componente of Componente.prg
	oFINALDEPRODUCCION = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oFINALDEPRODUCCION_Access()
		if !this.ldestroy and !vartype( this.oFINALDEPRODUCCION ) = 'O'
			this.oFINALDEPRODUCCION= _screen.zoo.InstanciarEntidad( 'FINALDEPRODUCCION' )
			this.enlazar( 'oFINALDEPRODUCCION.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oFINALDEPRODUCCION.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oFINALDEPRODUCCION
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oFINALDEPRODUCCION' ) = 'O' and !isnull( This.oFINALDEPRODUCCION )
			this.oFINALDEPRODUCCION.Release()
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