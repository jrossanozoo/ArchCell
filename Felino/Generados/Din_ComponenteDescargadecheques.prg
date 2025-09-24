
define class Din_ComponenteDESCARGADECHEQUES as ComponenteChequesDeTerceros of ComponenteChequesDeTerceros.prg
	oCHEQUE = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oCHEQUE_Access()
		if !this.ldestroy and !vartype( this.oCHEQUE ) = 'O'
			this.oCHEQUE= _screen.zoo.InstanciarEntidad( 'CHEQUE' )
			this.enlazar( 'oCHEQUE.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oCHEQUE.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oCHEQUE
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oCHEQUE' ) = 'O' and !isnull( This.oCHEQUE )
			this.oCHEQUE.Release()
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