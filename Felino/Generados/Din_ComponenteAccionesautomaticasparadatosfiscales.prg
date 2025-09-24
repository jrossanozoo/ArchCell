
define class Din_ComponenteACCIONESAUTOMATICASPARADATOSFISCALES as Componente of Componente.prg
	oACCIONESAUTOMATICAS = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oACCIONESAUTOMATICAS_Access()
		if !this.ldestroy and !vartype( this.oACCIONESAUTOMATICAS ) = 'O'
			this.oACCIONESAUTOMATICAS= _screen.zoo.InstanciarEntidad( 'ACCIONESAUTOMATICAS' )
			this.enlazar( 'oACCIONESAUTOMATICAS.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oACCIONESAUTOMATICAS.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oACCIONESAUTOMATICAS
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oACCIONESAUTOMATICAS' ) = 'O' and !isnull( This.oACCIONESAUTOMATICAS )
			this.oACCIONESAUTOMATICAS.Release()
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