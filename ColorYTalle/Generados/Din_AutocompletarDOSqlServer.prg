
define class Din_AUTOCOMPLETARDOSqlServer as ZooSession of ZooSession.Prg
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
		lcXml = goDatos.EjecutarSql( "Select Top " + transform( lnCantReg ) + " " + alltrim( tcCampo ) + " From " + goServicios.Datos.ObtenerEsquema( tcTabla ) + "." + alltrim( tcTabla ) + " Where " ;
		+ alltrim( tcFiltro ) + " order By " + alltrim( tcCampo ) )
		Return lcXml 

	Endfunc

enddefine