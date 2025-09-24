
define class Mock_COMPORTAMIENTONOHAYSTOCK as MockBase of MockBase.prg

	cClase = 'COMPORTAMIENTONOHAYSTOCK'

	
	oInformacion = null                                                                                                                                                                                                                                       
	oMensajeriaEntidad = null                                                                                                                                                                                                                                 
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( tomensajeria ) as void                                                                                                                                                                                                                     
	EndFunc

	*-----------------------------------------------------------------------------------------
	function ejecutar() as void                                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Ejecutar', lcParametros )
	EndFunc


enddefine