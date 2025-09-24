
define class Din_ObjetoGTIN as Custom

	*---------------------------------------------------------------------------------------------------
	function ObtenerAtributoClaveForanea() as zoocoleccion OF zoocoleccion.prg
		local loColeccionAtributoClave as zoocoleccion OF zoocoleccion.prg

		loColeccionAtributoClave = _screen.zoo.crearobjeto("ZooColeccion")
		loColeccionAtributoClave.Agregar( "PROVEEDOR", "PROVEEDOR" )
		loColeccionAtributoClave.Agregar( "TEMPORADA", "TEMPORADA" )
		loColeccionAtributoClave.Agregar( "FAMILIA", "FAMILIA" )
		loColeccionAtributoClave.Agregar( "MATERIAL", "MATERIAL" )
		loColeccionAtributoClave.Agregar( "LINEA", "LINEA" )
		loColeccionAtributoClave.Agregar( "GRUPO", "GRUPO" )
		loColeccionAtributoClave.Agregar( "CATEGORIADEARTICULO", "CATEGORIADEARTICULO" )
		loColeccionAtributoClave.Agregar( "CLASIFICACIONARTICULO", "CLASIFICACION" )
		loColeccionAtributoClave.Agregar( "TIPODEARTICULO", "TIPODEARTICULO" )
		loColeccionAtributoClave.Agregar( "ARTICULO", "ARTICULO" )
		loColeccionAtributoClave.Agregar( "COLOR", "COLOR" )
		loColeccionAtributoClave.Agregar( "TALLE", "TALLE" )

		return loColeccionAtributoClave
	endfunc
	*---------------------------------------------------------------------------------------------------
	function ObtenerAtributoEnItemFacturacion() as zoocoleccion OF zoocoleccion.prg
		local loColeccionAtributoClave as zoocoleccion OF zoocoleccion.prg

		loColeccionAtributoClave = _screen.zoo.crearobjeto("ZooColeccion")
		loColeccionAtributoClave.Agregar( "Articulo.PROVEEDOR_PK", "PROVEEDOR" )
		loColeccionAtributoClave.Agregar( "Articulo.TEMPORADA_PK", "TEMPORADA" )
		loColeccionAtributoClave.Agregar( "Articulo.FAMILIA_PK", "FAMILIA" )
		loColeccionAtributoClave.Agregar( "Articulo.MATERIAL_PK", "MATERIAL" )
		loColeccionAtributoClave.Agregar( "Articulo.LINEA_PK", "LINEA" )
		loColeccionAtributoClave.Agregar( "Articulo.GRUPO_PK", "GRUPO" )
		loColeccionAtributoClave.Agregar( "Articulo.CATEGORIADEARTICULO_PK", "CATEGORIADEARTICULO" )
		loColeccionAtributoClave.Agregar( "Articulo.CLASIFICACION_PK", "CLASIFICACION" )
		loColeccionAtributoClave.Agregar( "Articulo.TIPODEARTICULO_PK", "TIPODEARTICULO" )
		loColeccionAtributoClave.Agregar( "ARTICULO_PK", "ARTICULO" )
		loColeccionAtributoClave.Agregar( "COLOR_PK", "COLOR" )
		loColeccionAtributoClave.Agregar( "TALLE_PK", "TALLE" )

		return loColeccionAtributoClave
	endfunc

enddefine