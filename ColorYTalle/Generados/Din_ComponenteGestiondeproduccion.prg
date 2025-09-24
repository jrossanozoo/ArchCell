
define class Din_ComponenteGESTIONDEPRODUCCION as Componente of Componente.prg
	oGESTIONDEPRODUCCION = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oGESTIONDEPRODUCCION_Access()
		if !this.ldestroy and !vartype( this.oGESTIONDEPRODUCCION ) = 'O'
			this.oGESTIONDEPRODUCCION= _screen.zoo.InstanciarEntidad( 'GESTIONDEPRODUCCION' )
			this.enlazar( 'oGESTIONDEPRODUCCION.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oGESTIONDEPRODUCCION.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oGESTIONDEPRODUCCION
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oGESTIONDEPRODUCCION' ) = 'O' and !isnull( This.oGESTIONDEPRODUCCION )
			this.oGESTIONDEPRODUCCION.Release()
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