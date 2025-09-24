
define class Din_ComponenteSTOCKPRODUCCION as Componente of Componente.prg
	oSTOCKINVENTARIO = NULL
	oEntidad = NULL
	
	*--------------------------------------------------------------------------------------------------------
	Function Inicializar() as void
		dodefault()

		with this
			.oCombinacion = _screen.zoo.crearobjeto( 'zooColeccion' )
			.oCombinacion.Add( 'Insumo_Pk' )
			.oCombinacion.Add( 'Color_Pk' )
			.oCombinacion.Add( 'Talle_Pk' )
			.oCombinacion.Add( 'Inventario_Pk' )
			.oCombinacion.Add( 'Partida' )
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function oEntidad_Access()
		if !this.ldestroy and !vartype( this.oEntidad ) = 'O'
			this.oEntidad= _screen.zoo.InstanciarEntidad( 'Stockinventario' )
			this.enlazar( 'oEntidad.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oEntidad.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oEntidad
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function oSTOCKINVENTARIO_Access()
		if !this.ldestroy and !vartype( this.oSTOCKINVENTARIO ) = 'O'
			this.oSTOCKINVENTARIO= _screen.zoo.InstanciarEntidad( 'STOCKINVENTARIO' )
			this.enlazar( 'oSTOCKINVENTARIO.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oSTOCKINVENTARIO.EventoObtenerInformacion', 'inyectarInformacion' )
		endif
		Return this.oSTOCKINVENTARIO
	EndFunc


	*--------------------------------------------------------------------------------------------------------
	function Destroy() as void

		this.lDestroy = .t.

		if type( 'This.oSTOCKINVENTARIO' ) = 'O' and !isnull( This.oSTOCKINVENTARIO )
			this.oSTOCKINVENTARIO.Release()
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