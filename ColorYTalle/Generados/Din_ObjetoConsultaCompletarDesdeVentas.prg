
define class Din_ObjetoConsultaCompletarDesdeVentas as Custom

*------------------------------------------------------------------------------------
	Function ObtenerSelectVtasCompletarDesdeVentas() as string
		return ' Select detalle.FART as Articulo, detalle.CCOLOR as Color, detalle.TALLE as talle, sum(detalle.fcant*cabecera.signomov) as Cantidad '
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerGroupVtasCompletarDesdeVentas() as string
		return ' Group by detalle.FART ,detalle.CCOLOR , detalle.TALLE '
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerInnerJoinARTCompletarDesdeVentas( tcbase as String ) as string
		return " inner join [" + _screen.zoo.app.nombreProducto + "_" + tcbase + "].[ZooLogic].[ART] as articulo on detalle.FART=articulo.ARTCOD " 
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerInnerJoinsCompletarDesdeVentas( tcSuc as String ) as string
		return " inner join [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].[ART] as ART on (ART.ARTCOD=sub1.articulo or sub1.articulo='')  inner join [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].[COL] as COL on (COL.COLCOD=sub1.color or sub1.color='')  inner join [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].[TALLE] as TALLE on (TALLE.CODIGO=sub1.talle or sub1.talle='') "
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerSelectStockCompletarDesdeVentas( tcBase ) as string
		return " Select c.COART as Articulo, c.COCOL as Color, c.TALLE, c.COCANT as cantidad from [" + _screen.zoo.app.nombreProducto + "_" + tcbase + "].[ZooLogic].[COMB] as c"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerWhereCompletarDesdeVentas() as String
		local lcRetorno
		lcRetorno = '"detalle.FART between [" + .f_ARTICULO_Desde_PK + "] and [" + .f_ARTICULO_Hasta_PK + "]"' + ;
			'+" and detalle.cColor between [" + .f_COLOR_Desde_PK + "] and [" + .f_COLOR_Hasta_PK + "]"' + ;
			'+" and detalle.Talle between [" + .f_TALLE_Desde_PK + "] and [" + .f_TALLE_Hasta_PK + "]"' + ;
			'+" and articulo.ARTFAB between [" + .f_ARTICULO_PROVEEDOR_Desde_PK + "] and [" + .f_ARTICULO_PROVEEDOR_Hasta_PK + "]"' + ;
			'+" and articulo.UniMed between [" + .f_ARTICULO_UNIDADDEMEDIDA_Desde_PK + "] and [" + .f_ARTICULO_UNIDADDEMEDIDA_Hasta_PK + "]"' + ;
			'+" and articulo.Mat between [" + .f_ARTICULO_MATERIAL_Desde_PK + "] and [" + .f_ARTICULO_MATERIAL_Hasta_PK + "]"' + ;
			'+" and articulo.ATEMPORADA between [" + .f_ARTICULO_TEMPORADA_Desde_PK + "] and [" + .f_ARTICULO_TEMPORADA_Hasta_PK + "]"' + ;
			'+" and articulo.Ano between " + transform(.f_ARTICULO_ANO_Desde) + " and " + transform(.f_ARTICULO_ANO_Hasta)' + ;
			'+" and articulo.ARTNARBA between [" + .f_ARTICULO_NOMENCLADOR_Desde_PK + "] and [" + .f_ARTICULO_NOMENCLADOR_Hasta_PK + "]"' + ;
			'+" and articulo.Familia between [" + .f_ARTICULO_FAMILIA_Desde_PK + "] and [" + .f_ARTICULO_FAMILIA_Hasta_PK + "]"' + ;
			'+" and articulo.Linea between [" + .f_ARTICULO_LINEA_Desde_PK + "] and [" + .f_ARTICULO_LINEA_Hasta_PK + "]"' + ;
			'+" and articulo.Grupo between [" + .f_ARTICULO_GRUPO_Desde_PK + "] and [" + .f_ARTICULO_GRUPO_Hasta_PK + "]"' + ;
			'+" and articulo.CateArti between [" + .f_ARTICULO_CATEGORIADEARTICULO_Desde_PK + "] and [" + .f_ARTICULO_CATEGORIADEARTICULO_Hasta_PK + "]"' + ;
			'+" and articulo.TipoArti between [" + .f_ARTICULO_TIPODEARTICULO_Desde_PK + "] and [" + .f_ARTICULO_TIPODEARTICULO_Hasta_PK + "]"' + ;
			'+" and articulo.PalCol between [" + .f_ARTICULO_PALETADECOLORES_Desde_PK + "] and [" + .f_ARTICULO_PALETADECOLORES_Hasta_PK + "]"' + ;
			'+" and articulo.Curtall between [" + .f_ARTICULO_CURVADETALLES_Desde_PK + "] and [" + .f_ARTICULO_CURVADETALLES_Hasta_PK + "]"' + ;
			'+" and detalle.prunconimp between " + transform(.f_PRECIOCONIMPUESTOS_Desde) + " and " + transform(.f_PRECIOCONIMPUESTOS_Hasta)' + ;
			'+" and articulo.FMODIFW between [" + dtos(.f_ARTICULO_FECHAMODIFICACIONFW_Desde) + "] and [" + dtos(.f_ARTICULO_FECHAMODIFICACIONFW_Hasta) + "]"' + ;
			'+" and articulo.FALTAFW between [" + dtos(.f_ARTICULO_FECHAALTAFW_Desde) + "] and [" + dtos(.f_ARTICULO_FECHAALTAFW_Hasta) + "]"' + ;
			'+" and articulo.ClasifArt between [" + .f_ARTICULO_CLASIFICACION_Desde_PK + "] and [" + .f_ARTICULO_CLASIFICACION_Hasta_PK + "]"' + ;
			'+" and cabecera.FPerson between [" + .f_CLIENTE_Desde_PK + "] and [" + .f_CLIENTE_Hasta_PK + "]"'
		return lcRetorno
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerFiltroDeComprobantes() as String
		return "(1,3,4,2,5,6,27,28,29,33,35,36,47,48,49,54,55,56,51,52,53)"
	endfunc
*------------------------------------------------------------------------------------
	Function ObtenerTablasComprobantes() as String
		local loTablas as Object
		loTablas = _screen.zoo.crearobjeto( 'ZooColeccion' ) 
		loTablas.Agregar('COMPROBANTEV,COMPROBANTEVDET')
		loTablas.Agregar('PEDCOMPRA,PEDCOMPRADET')
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
		return " (select TALLE.CODIGO from [" + _screen.zoo.app.nombreProducto + "_" + tcSuc + "].[ZooLogic].TALLE) as sub2  on sub2.CODIGO = sub1.talle_pk where sub2.CODIGO is null and sub1.talle_pk != ''"
	endfunc

enddefine