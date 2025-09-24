
define class Din_ComponenteCUENTABANCARIALIQUIDACIONMENSUAL as ComponenteCuentaBancariaBase of ComponenteCuentaBancariaBase.prg
	oLIQUIDACIONMENSUAL = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oLIQUIDACIONMENSUAL_Access()
		if !this.ldestroy and !vartype( this.oLIQUIDACIONMENSUAL ) = 'O'
			this.oLIQUIDACIONMENSUAL= _screen.zoo.InstanciarEntidad( 'LIQUIDACIONMENSUAL' )
			this.enlazar( 'oLIQUIDACIONMENSUAL.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oLIQUIDACIONMENSUAL.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oLIQUIDACIONMENSUAL
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oLIQUIDACIONMENSUAL' ) = 'O' and !isnull( This.oLIQUIDACIONMENSUAL )
			this.oLIQUIDACIONMENSUAL.Release()
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