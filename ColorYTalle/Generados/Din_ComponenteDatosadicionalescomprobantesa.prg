
define class Din_ComponenteDATOSADICIONALESCOMPROBANTESA as Componente of Componente.prg
	oDATOSADICIONALESCOMPROBANTESA = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oDATOSADICIONALESCOMPROBANTESA_Access()
		if !this.ldestroy and !vartype( this.oDATOSADICIONALESCOMPROBANTESA ) = 'O'
			this.oDATOSADICIONALESCOMPROBANTESA= _screen.zoo.InstanciarEntidad( 'DATOSADICIONALESCOMPROBANTESA' )
			this.enlazar( 'oDATOSADICIONALESCOMPROBANTESA.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oDATOSADICIONALESCOMPROBANTESA.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oDATOSADICIONALESCOMPROBANTESA
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oDATOSADICIONALESCOMPROBANTESA' ) = 'O' and !isnull( This.oDATOSADICIONALESCOMPROBANTESA )
			this.oDATOSADICIONALESCOMPROBANTESA.Release()
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