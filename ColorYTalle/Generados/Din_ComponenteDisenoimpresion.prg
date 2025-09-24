
define class Din_ComponenteDISENOIMPRESION as Componente of Componente.prg
	oDISENOIMPRESION = NULL
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oDISENOIMPRESION_Access()
		if !this.ldestroy and !vartype( this.oDISENOIMPRESION ) = 'O'
			this.oDISENOIMPRESION= _screen.zoo.InstanciarEntidad( 'DISENOIMPRESION' )
			this.enlazar( 'oDISENOIMPRESION.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oDISENOIMPRESION.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oDISENOIMPRESION
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oDISENOIMPRESION' ) = 'O' and !isnull( This.oDISENOIMPRESION )
			this.oDISENOIMPRESION.Release()
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