
define class Mock_COLABORADORAJUSTEDECOMPROBANTE as MockBase of MockBase.prg

	cClase = 'COLABORADORAJUSTEDECOMPROBANTE'

	
	oEntidad = null                                                                                                                                                                                                                                           
	oMaximos = null                                                                                                                                                                                                                                           
	
	*-----------------------------------------------------------------------------------------
	function Release() as Void
		dodefault()
		release this
	endfunc

	*-----------------------------------------------------------------------------------------
	function init( toentidad as object ) as boolean                                                                                                                                                                                                           
	EndFunc

	*-----------------------------------------------------------------------------------------
	function destroy() as void                                                                                                                                                                                                                                
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Destroy', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function obtenermontosmaximosparaajustes() as object                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenermontosmaximosparaajustes', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function aplicarajustecomprobante() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Aplicarajustecomprobante', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function generarrecargo() as void                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generarrecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	protected function generardescuento() as void                                                                                                                                                                                                             
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Generardescuento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function nohayconfiguradosajustesmaximos() as boolean                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Nohayconfiguradosajustesmaximos', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayajustedescuentoconfigurado() as boolean                                                                                                                                                                                                       
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayajustedescuentoconfigurado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayajusterecargoconfigurado() as boolean                                                                                                                                                                                                         
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayajusterecargoconfigurado', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenermontodescuento() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenermontodescuento', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function obtenermontorecargo() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Obtenermontorecargo', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function escambio() as boolean                                                                                                                                                                                                                            
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Escambio', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function haydescuentosinajuste() as boolean                                                                                                                                                                                                               
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Haydescuentosinajuste', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayrecargosinajuste() as boolean                                                                                                                                                                                                                 
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayrecargosinajuste', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function quitarajuste() as void                                                                                                                                                                                                                           
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Quitarajuste', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function quitarcodigoajuste() as void                                                                                                                                                                                                                     
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Quitarcodigoajuste', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function haydescuentoajuste() as boolean                                                                                                                                                                                                                  
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Haydescuentoajuste', lcParametros )
	EndFunc

	*-----------------------------------------------------------------------------------------
	function hayrecargoajuste() as boolean                                                                                                                                                                                                                    
		local lcParametros as string, lcParam as string, lni as integer, lnParametros as integer

		lnParametros = pcount()

		lcParametros = ''

		return this.ObtenerResultado( 'Hayrecargoajuste', lcParametros )
	EndFunc


enddefine