
define class Din_ObjetoConsultaCompletarDesdeVentas as Custom

*------------------------------------------------------------------------------------
	Function ObtenerSelectVtasCompletarDesdeVentas() as string
		return ' Select detalle.FART as Articulo, detalle.FCOLO as Color, detalle.FTALL as talle, sum(detalle.fcant*cabecera.signomov) as Cantidad '
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerGroupVtasCompletarDesdeVentas() as string
		return ' Group by detalle.FART ,detalle.FCOLO , detalle.FTALL '
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerInnerJoinARTCompletarDesdeVentas( tcbase as String ) as string
		return " inner join [" + _screen.zoo.app.nombreProducto + "_" + tcbase + "].[ZooLogic].[ART] as articulo on detalle.FART=articulo.ARTCOD " 
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerInnerJoinsCompletarDesdeVentas( tcSuc as String ) as string
		return " inner join [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].[ART] as ART on (ART.ARTCOD=sub1.articulo or sub1.articulo='')  inner join [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].[COL] as COL on (COL.COLCOD=sub1.color or sub1.color='') "
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerSelectStockCompletarDesdeVentas( tcBase ) as string
		return " Select c.COART as Articulo, c.COCOL as Color, c.COTLL, c.COCANT as cantidad from [" + _screen.zoo.app.nombreProducto + "_" + tcbase + "].[ZooLogic].[COMB] as c"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerWhereCompletarDesdeVentas() as String
		local lcRetorno
		lcRetorno = '"detalle.FART between [" + .f_ARTICULO_Desde + "] and [" + .f_ARTICULO_Hasta + "]"' + ;
			'+" and detalle.FCOLO between [" + .f_COLOR_Desde + "] and [" + .f_COLOR_Hasta + "]"' + ;
			'+" and detalle.FTALL between [" + .f_TALLE_Desde + "] and [" + .f_TALLE_Hasta + "]"' + ;
			'+" and articulo.ARTFAB between [" + .f_ARTICULO_PROVEEDOR_Desde + "] and [" + .f_ARTICULO_PROVEEDOR_Hasta + "]"' + ;
			'+" and articulo.ARTUNI between [" + .f_ARTICULO_UNIDAD_Desde + "] and [" + .f_ARTICULO_UNIDAD_Hasta + "]"' + ;
			'+" and articulo.AMATE between [" + .f_ARTICULO_MATERIAL_Desde + "] and [" + .f_ARTICULO_MATERIAL_Hasta + "]"' + ;
			'+" and articulo.AANO between [" + .f_ARTICULO_ANIO_Desde + "] and [" + .f_ARTICULO_ANIO_Hasta + "]"' + ;
			'+" and articulo.ARTNARBA between [" + .f_ARTICULO_NOMENCLADOR_Desde + "] and [" + .f_ARTICULO_NOMENCLADOR_Hasta + "]"' + ;
			'+" and detalle.prunconimp between " + transform(.f_PRECIOCONIMPUESTOS_Desde) + " and " + transform(.f_PRECIOCONIMPUESTOS_Hasta)' + ;
			'+" and articulo.FMODIFW between [" + dtos(.f_ARTICULO_FECHAMODIFICACIONFW_Desde) + "] and [" + dtos(.f_ARTICULO_FECHAMODIFICACIONFW_Hasta) + "]"' + ;
			'+" and articulo.FALTAFW between [" + dtos(.f_ARTICULO_FECHAALTAFW_Desde) + "] and [" + dtos(.f_ARTICULO_FECHAALTAFW_Hasta) + "]"' + ;
			'+" and articulo.CLASIFART between [" + .f_ARTICULO_CLASIFICACION_Desde + "] and [" + .f_ARTICULO_CLASIFICACION_Hasta + "]"' + ;
			'+" and cabecera.FPerson between [" + .f_CLIENTE_Desde_PK + "] and [" + .f_CLIENTE_Hasta_PK + "]"'
		return lcRetorno
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerFiltroDeComprobantes() as String
		return "(1,2,3,4,5,6,27,28,29,33,35,36,47,48,49,54,55,56,51,52,53)"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerTablasComprobantes() as String
		local loTablas as Object
		loTablas = _screen.zoo.crearobjeto( 'ZooColeccion' ) 
		loTablas.Agregar('COMPROBANTEV,COMPROBANTEVDET')
		return loTablas 
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerSelectDiferenciasArticulo( tcSuc as String ) as String
		return " (select ART.ARTCOD from [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].ART) as sub2  on sub2.ARTCOD = sub1.articulo_pk where sub2.ARTCOD is null and sub1.articulo_pk != ''"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerSelectDiferenciasColor( tcSuc as String ) as String
		return " (select COL.COLCOD from [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].COL) as sub2  on sub2.COLCOD = sub1.color_pk where sub2.COLCOD is null and sub1.color_pk != ''"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerSelectDiferenciasTalle( tcSuc as String ) as String
		return ''
	endfunc

enddefine