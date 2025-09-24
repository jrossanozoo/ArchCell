
define class Din_ObjetoGTIN as Custom

	*---------------------------------------------------------------------------------------------------
	function ObtenerAtributoClaveForanea() as zoocoleccion OF zoocoleccion.prg
		local loColeccionAtributoClave as zoocoleccion OF zoocoleccion.prg

		loColeccionAtributoClave = _screen.zoo.crearobjeto("ZooColeccion")
		loColeccionAtributoClave.Agregar( "ARTICULO", "ARTICULO" )
		loColeccionAtributoClave.Agregar( "COLOR", "COLOR" )
		loColeccionAtributoClave.Agregar( "", "TALLE" )

		return loColeccionAtributoClave
	endfunc
	*---------------------------------------------------------------------------------------------------
	function ObtenerAtributoEnItemFacturacion() as zoocoleccion OF zoocoleccion.prg
		local loColeccionAtributoClave as zoocoleccion OF zoocoleccion.prg

		loColeccionAtributoClave = _screen.zoo.crearobjeto("ZooColeccion")
		loColeccionAtributoClave.Agregar( "ARTICULO_PK", "ARTICULO" )
		loColeccionAtributoClave.Agregar( "COLOR_PK", "COLOR" )
		loColeccionAtributoClave.Agregar( "TALLE", "TALLE" )

		return loColeccionAtributoClave
	endfunc

enddefine