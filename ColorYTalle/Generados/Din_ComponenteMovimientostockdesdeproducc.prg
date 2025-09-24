
define class Din_ComponenteMOVIMIENTOSTOCKDESDEPRODUCC as Componente of Componente.prg
	oMOVIMIENTOSTOCKDESDEPRODUCC = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oMOVIMIENTOSTOCKDESDEPRODUCC_Access()
		if !this.ldestroy and !vartype( this.oMOVIMIENTOSTOCKDESDEPRODUCC ) = 'O'
			this.oMOVIMIENTOSTOCKDESDEPRODUCC= _screen.zoo.InstanciarEntidad( 'MOVIMIENTOSTOCKDESDEPRODUCC' )
			this.enlazar( 'oMOVIMIENTOSTOCKDESDEPRODUCC.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oMOVIMIENTOSTOCKDESDEPRODUCC.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oMOVIMIENTOSTOCKDESDEPRODUCC
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oMOVIMIENTOSTOCKDESDEPRODUCC' ) = 'O' and !isnull( This.oMOVIMIENTOSTOCKDESDEPRODUCC )
			this.oMOVIMIENTOSTOCKDESDEPRODUCC.Release()
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