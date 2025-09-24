
define class Din_ComponenteAJUSTEDECUPONES as Componente of Componente.prg
	oAJUSTEDECUPON = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oAJUSTEDECUPON_Access()
		if !this.ldestroy and !vartype( this.oAJUSTEDECUPON ) = 'O'
			this.oAJUSTEDECUPON= _screen.zoo.InstanciarEntidad( 'AJUSTEDECUPON' )
			this.enlazar( 'oAJUSTEDECUPON.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oAJUSTEDECUPON.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oAJUSTEDECUPON
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oAJUSTEDECUPON' ) = 'O' and !isnull( This.oAJUSTEDECUPON )
			this.oAJUSTEDECUPON.Release()
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