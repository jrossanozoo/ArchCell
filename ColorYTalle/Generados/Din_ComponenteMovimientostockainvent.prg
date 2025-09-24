
define class Din_ComponenteMOVIMIENTOSTOCKAINVENT as Componente of Componente.prg
	oMOVIMIENTOSTOCKAINVENT = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oMOVIMIENTOSTOCKAINVENT_Access()
		if !this.ldestroy and !vartype( this.oMOVIMIENTOSTOCKAINVENT ) = 'O'
			this.oMOVIMIENTOSTOCKAINVENT= _screen.zoo.InstanciarEntidad( 'MOVIMIENTOSTOCKAINVENT' )
			this.enlazar( 'oMOVIMIENTOSTOCKAINVENT.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oMOVIMIENTOSTOCKAINVENT.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oMOVIMIENTOSTOCKAINVENT
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oMOVIMIENTOSTOCKAINVENT' ) = 'O' and !isnull( This.oMOVIMIENTOSTOCKAINVENT )
			this.oMOVIMIENTOSTOCKAINVENT.Release()
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