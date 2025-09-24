
define class Mock_VALIDADORCOMPROBANTEELECTRONICOEXPORTACION as MockBase of MockBase.prg

	cClase = 'VALIDADORCOMPROBANTEELECTRONICOEXPORTACION'

	
	oEntidad = null                                                                                                                                                                                                                                           
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( toentidad as entidad of entidad.prg ) as void                                                                                                                                                                                              
	EndFunc

	*-----------------------------------------------------------------------------------------
	function validar()                                                                                                                                                                                                                                        
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validar', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function validarcotizacion() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Validarcotizacion', lcParametros )
	EndFunc


enddefine