
define class Din_ComponenteDATOSADICIONALESSIRE as Componente of Componente.prg
	oDATOSADICIONALESSIRE = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oDATOSADICIONALESSIRE_Access()
		if !this.ldestroy and !vartype( this.oDATOSADICIONALESSIRE ) = 'O'
			this.oDATOSADICIONALESSIRE= _screen.zoo.InstanciarEntidad( 'DATOSADICIONALESSIRE' )
			this.enlazar( 'oDATOSADICIONALESSIRE.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oDATOSADICIONALESSIRE.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oDATOSADICIONALESSIRE
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oDATOSADICIONALESSIRE' ) = 'O' and !isnull( This.oDATOSADICIONALESSIRE )
			this.oDATOSADICIONALESSIRE.Release()
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