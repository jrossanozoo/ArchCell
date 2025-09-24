
define class Din_AUTOCOMPLETARDO as ZooSession of ZooSession.Prg
	nCantidadDeRegistrosEnTOP = 0 
	*--------------------------------------------------------------------------------------------------------
	function Init() as Boolean

		DoDefault()
		this.nCantidadDeRegistrosEnTOP = goRegistry.Nucleo.RegistrosUtilizadosPorAutocompletar

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function obtenerDatos( tcTabla as string, tcCampo as string, tcFiltro as string ) as string

		Local lcXml As string, lcCursor As String, lnCantReg as integer

		lnCantReg = This.nCantidadDeRegistrosEnTOP
		lcCursor = sys( 2015 )
		if !used ( alltrim( tcTabla ) )
			use ( addbs( goDatos.oAccesoDatos.cRutaTablas ) + 'DBF\' + tcTabla ) in 0
		endif

		Select Top ( lnCantReg ) &tcCampo From &tcTabla Where &tcFiltro order By &tcCampo into Cursor &lcCursor

		lcXml = this.CursorAXml( lcCursor )
		use in select( lcCursor )
		use in select ( tcTabla )
		Return lcXml 

	Endfunc

enddefine