
define class Din_EntidadModelodeproduccion_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Modelodeproduccion"
	cClaseResponse = this.cNamespaceDTOs + ".ModelodeproduccionResponse"
	cClaseModelo = "ModelodeproduccionModelo"
	cEntidad = "Modelodeproduccion"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Codigo" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Codigo = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Codigo = tcId
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ModelodeproduccionModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModelodeproduccionModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModelodeproduccionListarRequest"
			case "Accion" $ tcOperacion
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			otherwise
				goServicios.Errores.LevantarExcepcionTexto( tcOperacion + " no implementada.")
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseResponse( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ModelodeproduccionListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ModelodeproduccionModelo"
		endcase
		return lcRetorno
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerCursorIds( toEntidad as Object, tcFiltro as String, tcOrderBy as String, tnCantidad as Integer, tnPagina as Integer ) as String
		return toEntidad.oAd.ObtenerIdentificadoresPaginado( tcOrderBy, tcFiltro, tnCantidad, tnPagina )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearEntidadConDatosModelo( toEntidad as Object, toModeloEnRequest as Object ) as Void
		with toEntidad
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Productofinal", toEntidad, "Productofinal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Curvadeproduccion", toEntidad, "Curvadeproduccion_PK" )
			this.SetearDetalleModeloprocesos( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
			this.SetearDetalleModeloinsumos( toEntidad, toModeloEnRequest )
			this.SetearDetalleModelosalidas( toEntidad, toModeloEnRequest )
			this.SetearDetalleModelomaquinas( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModeloProcesos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModeloProcesos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModeloProcesos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModeloProcesos.LimpiarItem()
			else
				try
					toEntidad.ModeloProcesos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModeloProcesos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.ModeloProcesos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Procesodetalle", toEntidad.ModeloProcesos.oItem, "ProcesoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Orden", toEntidad.ModeloProcesos.oItem, "Orden" )
			this.SetearAtributoModeloEnEntidad( loItem, "Taller", toEntidad.ModeloProcesos.oItem, "Taller_PK" )
			toEntidad.ModeloProcesos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModeloInsumos( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModeloInsumos" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModeloInsumos[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModeloInsumos.LimpiarItem()
			else
				try
					toEntidad.ModeloInsumos.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModeloInsumos.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.ModeloInsumos.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.ModeloInsumos.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.ModeloInsumos.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.ModeloInsumos.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallemdetalle", toEntidad.ModeloInsumos.oItem, "TalleMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumo", toEntidad.ModeloInsumos.oItem, "Insumo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Insumodetalle", toEntidad.ModeloInsumos.oItem, "InsumoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ModeloInsumos.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ModeloInsumos.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ModeloInsumos.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.ModeloInsumos.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidaddemedida", toEntidad.ModeloInsumos.oItem, "UnidadDeMedida_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ModeloInsumos.oItem, "Cantidad" )
			toEntidad.ModeloInsumos.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModeloSalidas( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModeloSalidas" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModeloSalidas[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModeloSalidas.LimpiarItem()
			else
				try
					toEntidad.ModeloSalidas.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModeloSalidas.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.ModeloSalidas.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colorm", toEntidad.ModeloSalidas.oItem, "ColorM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colormdetalle", toEntidad.ModeloSalidas.oItem, "ColorMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallem", toEntidad.ModeloSalidas.oItem, "TalleM_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tallemdetalle", toEntidad.ModeloSalidas.oItem, "TalleMDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaborado", toEntidad.ModeloSalidas.oItem, "Semielaborado_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Semielaboradodetalle", toEntidad.ModeloSalidas.oItem, "SemielaboradoDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ModeloSalidas.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ModeloSalidas.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ModeloSalidas.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.ModeloSalidas.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ModeloSalidas.oItem, "Cantidad" )
			toEntidad.ModeloSalidas.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleModeloMaquinas( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ModeloMaquinas" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ModeloMaquinas[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ModeloMaquinas.LimpiarItem()
			else
				try
					toEntidad.ModeloMaquinas.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ModeloMaquinas.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Proceso", toEntidad.ModeloMaquinas.oItem, "Proceso_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Maquina", toEntidad.ModeloMaquinas.oItem, "Maquina_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Maquinadetalle", toEntidad.ModeloMaquinas.oItem, "MaquinaDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipomaquinaria", toEntidad.ModeloMaquinas.oItem, "TipoMaquinaria" )
			this.SetearAtributoModeloEnEntidad( loItem, "Unidaddetiempo", toEntidad.ModeloMaquinas.oItem, "UnidadDeTiempo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tiempo", toEntidad.ModeloMaquinas.oItem, "Tiempo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Desperdicio", toEntidad.ModeloMaquinas.oItem, "Desperdicio" )
			toEntidad.ModeloMaquinas.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "ProductoFinal", toEntidad.ProductoFinal_PK)
			this.SetearAtributoString( toModeloResponse, "CurvaDeProduccion", toEntidad.CurvaDeProduccion_PK)
			this.CargarColeccionModeloModeloProcesos( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
			this.CargarColeccionModeloModeloInsumos( toModeloResponse, toEntidad )
			this.CargarColeccionModeloModeloSalidas( toModeloResponse, toEntidad )
			this.CargarColeccionModeloModeloMaquinas( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModeloProcesos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModeloProcesos" ) 
		with toEntidad
			for lnI = 1 to .ModeloProcesos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModeloproceso" )
				this.SetearAtributoString( loItem, "Codigo", .ModeloProcesos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .ModeloProcesos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ProcesoDetalle", .ModeloProcesos.Item(lnI).ProcesoDetalle)
				this.SetearAtributoInteger( loItem, "Orden", .ModeloProcesos.Item(lnI).Orden)
				this.SetearAtributoString( loItem, "Taller", .ModeloProcesos.Item(lnI).Taller_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .ModeloProcesos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModeloInsumos( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModeloInsumos" ) 
		with toEntidad
			for lnI = 1 to .ModeloInsumos.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModeloinsumo" )
				this.SetearAtributoString( loItem, "Codigo", .ModeloInsumos.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .ModeloInsumos.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ColorM", .ModeloInsumos.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .ModeloInsumos.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .ModeloInsumos.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "TalleMDetalle", .ModeloInsumos.Item(lnI).TalleMDetalle)
				this.SetearAtributoString( loItem, "Insumo", .ModeloInsumos.Item(lnI).Insumo_PK)
				this.SetearAtributoString( loItem, "InsumoDetalle", .ModeloInsumos.Item(lnI).InsumoDetalle)
				this.SetearAtributoString( loItem, "Color", .ModeloInsumos.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ModeloInsumos.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ModeloInsumos.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .ModeloInsumos.Item(lnI).TalleDetalle)
				this.SetearAtributoString( loItem, "UnidadDeMedida", .ModeloInsumos.Item(lnI).UnidadDeMedida_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ModeloInsumos.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .ModeloInsumos.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModeloSalidas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModeloSalidas" ) 
		with toEntidad
			for lnI = 1 to .ModeloSalidas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModelosalida" )
				this.SetearAtributoString( loItem, "Codigo", .ModeloSalidas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .ModeloSalidas.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "ColorM", .ModeloSalidas.Item(lnI).ColorM_PK)
				this.SetearAtributoString( loItem, "ColorMDetalle", .ModeloSalidas.Item(lnI).ColorMDetalle)
				this.SetearAtributoString( loItem, "TalleM", .ModeloSalidas.Item(lnI).TalleM_PK)
				this.SetearAtributoString( loItem, "TalleMDetalle", .ModeloSalidas.Item(lnI).TalleMDetalle)
				this.SetearAtributoString( loItem, "Semielaborado", .ModeloSalidas.Item(lnI).Semielaborado_PK)
				this.SetearAtributoString( loItem, "SemielaboradoDetalle", .ModeloSalidas.Item(lnI).SemielaboradoDetalle)
				this.SetearAtributoString( loItem, "Color", .ModeloSalidas.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ModeloSalidas.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ModeloSalidas.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .ModeloSalidas.Item(lnI).TalleDetalle)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ModeloSalidas.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .ModeloSalidas.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloModeloMaquinas( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ModeloMaquinas" ) 
		with toEntidad
			for lnI = 1 to .ModeloMaquinas.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemModelomaquina" )
				this.SetearAtributoString( loItem, "Codigo", .ModeloMaquinas.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Proceso", .ModeloMaquinas.Item(lnI).Proceso_PK)
				this.SetearAtributoString( loItem, "Maquina", .ModeloMaquinas.Item(lnI).Maquina_PK)
				this.SetearAtributoString( loItem, "MaquinaDetalle", .ModeloMaquinas.Item(lnI).MaquinaDetalle)
				this.SetearAtributoInteger( loItem, "TipoMaquinaria", .ModeloMaquinas.Item(lnI).TipoMaquinaria)
				this.SetearAtributoInteger( loItem, "UnidadDeTiempo", .ModeloMaquinas.Item(lnI).UnidadDeTiempo)
				this.SetearAtributoDecimal( loItem, "Tiempo", .ModeloMaquinas.Item(lnI).Tiempo)
				this.SetearAtributoDecimal( loItem, "Desperdicio", .ModeloMaquinas.Item(lnI).Desperdicio)
				this.SetearAtributoInteger( loItem, "NroItem", .ModeloMaquinas.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Productofinal", "PRODUCTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Curvadeproduccion", "CURVAPROD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Obs", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codigo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descrip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Producto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Curvaprod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine