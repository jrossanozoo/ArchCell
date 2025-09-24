
define class Mock_COLABORADORATRIBUTOSFW as MockBase of MockBase.prg

	cClase = 'COLABORADORATRIBUTOSFW'

	
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init() as void                                                                                                                                                                                                                                   
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenercolumnasfw() as string                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenercolumnasfw', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervaloresfw() as string                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenervaloresfw', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenervaloresfwsubentidadesfaltantes() as string                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenervaloresfwsubentidadesfaltantes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertextoaccionesdesistema() as string                                                                                                                                                                                              
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertextoaccionesdesistema', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenertextoaccionesdesistemaparasubentidadesfaltantes() as string                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenertextoaccionesdesistemaparasubentidadesfaltantes', lcParametros )
	EndFunc


enddefine