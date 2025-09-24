
define class Din_ComponenteSTOCK as Componente of Componente.prg
	oSTOCKCOMBINACION = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
			.oCombinacion = _screen.zoo.crearobjeto( 'zooColeccion' )
			.oCombinacion.Add( 'Articulo_Pk' )
			.oCombinacion.Add( 'Color_Pk' )
			.oCombinacion.Add( 'Talle' )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'stockcombinacion' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oSTOCKCOMBINACION_Access()
		if !this.ldestroy and !vartype( this.oSTOCKCOMBINACION ) = 'O'
			this.oSTOCKCOMBINACION= _screen.zoo.InstanciarEntidad( 'STOCKCOMBINACION' )
			this.enlazar( 'oSTOCKCOMBINACION.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oSTOCKCOMBINACION.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oSTOCKCOMBINACION
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oSTOCKCOMBINACION' ) = 'O' and !isnull( This.oSTOCKCOMBINACION )
			this.oSTOCKCOMBINACION.Release()
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