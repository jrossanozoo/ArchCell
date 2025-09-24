
define class Din_ComponenteTIPODECOMPROBANTEDECOMPRA as Componente of Componente.prg
	oTIPODECOMPROBANTEDECOMPRA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oTIPODECOMPROBANTEDECOMPRA_Access()
		if !this.ldestroy and !vartype( this.oTIPODECOMPROBANTEDECOMPRA ) = 'O'
			this.oTIPODECOMPROBANTEDECOMPRA= _screen.zoo.InstanciarEntidad( 'TIPODECOMPROBANTEDECOMPRA' )
			this.enlazar( 'oTIPODECOMPROBANTEDECOMPRA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oTIPODECOMPROBANTEDECOMPRA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oTIPODECOMPROBANTEDECOMPRA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oTIPODECOMPROBANTEDECOMPRA' ) = 'O' and !isnull( This.oTIPODECOMPROBANTEDECOMPRA )
			this.oTIPODECOMPROBANTEDECOMPRA.Release()
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