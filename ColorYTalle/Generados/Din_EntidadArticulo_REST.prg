
define class Din_EntidadArticulo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Articulo"
	cClaseResponse = this.cNamespaceDTOs + ".ArticuloResponse"
	cClaseModelo = "ArticuloModelo"
	cEntidad = "Articulo"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ArticuloModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ArticuloModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ArticuloListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ArticuloListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ArticuloModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcionadicional", toEntidad, "Descripcionadicional" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comportamiento", toEntidad, "Comportamiento" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nopermitedevoluciones", toEntidad, "Nopermitedevoluciones" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Restringirdescuentos", toEntidad, "Restringirdescuentos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Requiereccosto", toEntidad, "Requiereccosto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nopublicarenecommerce", toEntidad, "Nopublicarenecommerce" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solopromoykit", toEntidad, "Solopromoykit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Unidaddemedida", toEntidad, "Unidaddemedida_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Temporada", toEntidad, "Temporada_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ano", toEntidad, "Ano" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Familia", toEntidad, "Familia_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Material", toEntidad, "Material_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Linea", toEntidad, "Linea_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Grupo", toEntidad, "Grupo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Categoriadearticulo", toEntidad, "Categoriadearticulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodearticulo", toEntidad, "Tipodearticulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivaventas", toEntidad, "Condicionivaventas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeivaventas", toEntidad, "Porcentajeivaventas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivacompras", toEntidad, "Condicionivacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeivacompras", toEntidad, "Porcentajeivacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeimpuestointerno", toEntidad, "Porcentajeimpuestointerno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nomenclador", toEntidad, "Nomenclador_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Percepcionivarg5329", toEntidad, "Percepcionivarg5329" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Paletadecolores", toEntidad, "Paletadecolores_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Curvadetalles", toEntidad, "Curvadetalles_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Nocomercializable", toEntidad, "Nocomercializable" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Restringirarticulo", toEntidad, "Restringirarticulo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importado", toEntidad, "Importado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imprimedespacho", toEntidad, "Imprimedespacho" )
			this.SetearDetalleParticipantesdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descecommerce", toEntidad, "Descecommerce" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descecommercehtml", toEntidad, "Descecommercehtml" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Peso", toEntidad, "Peso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Largo", toEntidad, "Largo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ancho", toEntidad, "Ancho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Alto", toEntidad, "Alto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Marca", toEntidad, "Marca_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleAgrupublidetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "Agrupublidetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"Agrupublidetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.Agrupublidetalle.LimpiarItem()
			else
				try
					toEntidad.Agrupublidetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.Agrupublidetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigo", toEntidad.Agrupublidetalle.oItem, "Codigo" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleParticipantesDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ParticipantesDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ParticipantesDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ParticipantesDetalle.LimpiarItem()
			else
				try
					toEntidad.ParticipantesDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ParticipantesDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ParticipantesDetalle.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ParticipantesDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ParticipantesDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ParticipantesDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ParticipantesDetalle.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ParticipantesDetalle.oItem, "Cantidad" )
			toEntidad.ParticipantesDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "DescripcionAdicional", toEntidad.DescripcionAdicional)
			this.SetearAtributoInteger( toModeloResponse, "Comportamiento", toEntidad.Comportamiento)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributo( toModeloResponse, "NoPermiteDevoluciones", toEntidad.NoPermiteDevoluciones)
			this.SetearAtributo( toModeloResponse, "RestringirDescuentos", toEntidad.RestringirDescuentos)
			this.SetearAtributoInteger( toModeloResponse, "RequiereCCosto", toEntidad.RequiereCCosto)
			this.SetearAtributo( toModeloResponse, "NoPublicarEnEcommerce", toEntidad.NoPublicarEnEcommerce)
			this.SetearAtributo( toModeloResponse, "SoloPromoYKit", toEntidad.SoloPromoYKit)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "UnidadDeMedida", toEntidad.UnidadDeMedida_PK)
			this.SetearAtributoString( toModeloResponse, "Temporada", toEntidad.Temporada_PK)
			this.SetearAtributoInteger( toModeloResponse, "Ano", toEntidad.Ano)
			this.SetearAtributoString( toModeloResponse, "Familia", toEntidad.Familia_PK)
			this.SetearAtributoString( toModeloResponse, "Material", toEntidad.Material_PK)
			this.SetearAtributoString( toModeloResponse, "Linea", toEntidad.Linea_PK)
			this.SetearAtributoString( toModeloResponse, "Grupo", toEntidad.Grupo_PK)
			this.SetearAtributoString( toModeloResponse, "CategoriaDeArticulo", toEntidad.CategoriaDeArticulo_PK)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributoString( toModeloResponse, "TipodeArticulo", toEntidad.TipodeArticulo_PK)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaVentas", toEntidad.CondicionIvaVentas)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeIvaVentas", toEntidad.PorcentajeIvaVentas)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaCompras", toEntidad.CondicionIvaCompras)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeIvaCompras", toEntidad.PorcentajeIvaCompras)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeImpuestoInterno", toEntidad.PorcentajeImpuestoInterno)
			this.SetearAtributoString( toModeloResponse, "Nomenclador", toEntidad.Nomenclador_PK)
			this.SetearAtributoInteger( toModeloResponse, "PercepcionIvaRG5329", toEntidad.PercepcionIvaRG5329)
			this.SetearAtributoString( toModeloResponse, "Paletadecolores", toEntidad.Paletadecolores_PK)
			this.SetearAtributoString( toModeloResponse, "Curvadetalles", toEntidad.Curvadetalles_PK)
			this.SetearAtributoDateTime( toModeloResponse, "NoComercializable", toEntidad.NoComercializable)
			this.SetearAtributoDateTime( toModeloResponse, "RestringirArticulo", toEntidad.RestringirArticulo)
			this.SetearAtributo( toModeloResponse, "Importado", toEntidad.Importado)
			this.SetearAtributo( toModeloResponse, "ImprimeDespacho", toEntidad.ImprimeDespacho)
			this.CargarColeccionModeloParticipantesDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "DescEcommerce", toEntidad.DescEcommerce)
			this.SetearAtributo( toModeloResponse, "DescEcommerceHTML", toEntidad.DescEcommerceHTML)
			this.SetearAtributoDecimal( toModeloResponse, "Peso", toEntidad.Peso)
			this.SetearAtributoDecimal( toModeloResponse, "Largo", toEntidad.Largo)
			this.SetearAtributoDecimal( toModeloResponse, "Ancho", toEntidad.Ancho)
			this.SetearAtributoDecimal( toModeloResponse, "Alto", toEntidad.Alto)
			this.SetearAtributoString( toModeloResponse, "Marca", toEntidad.Marca_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloAgrupublidetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "Agrupublidetalle" ) 
		with toEntidad
			for lnI = 1 to .Agrupublidetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemAgrupapublic" )
				this.SetearAtributoString( loItem, "Codigo", .Agrupublidetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Agrupamiento", .Agrupublidetalle.Item(lnI).Agrupamiento_PK)
				this.SetearAtributoString( loItem, "AgrupamientoDetalle", .Agrupublidetalle.Item(lnI).AgrupamientoDetalle)
				this.SetearAtributoInteger( loItem, "NroItem", .Agrupublidetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloParticipantesDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ParticipantesDetalle" ) 
		with toEntidad
			for lnI = 1 to .ParticipantesDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemParticipantes" )
				this.SetearAtributoString( loItem, "Codigo", .ParticipantesDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Articulo", .ParticipantesDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ParticipantesDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ParticipantesDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ParticipantesDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ParticipantesDetalle.Item(lnI).Talle_PK)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ParticipantesDetalle.Item(lnI).Cantidad)
				this.SetearAtributoInteger( loItem, "NroItem", .ParticipantesDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipoagrupamientopublicaciones", "TIPAGRUPUB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "ARTDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcionadicional", "ARTDESADIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comportamiento", "ASTOCK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), AOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nopermitedevoluciones", "ARTNODEVO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Restringirdescuentos", "ARTSINDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Requiereccosto", "REQCCOSTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nopublicarenecommerce", "PUBECOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Solopromoykit", "PROMOYKIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "ARTFAB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Unidaddemedida", "UNIMED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Temporada", "ATEMPORADA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ano", "ANO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Familia", "FAMILIA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Material", "MAT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Linea", "LINEA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Grupo", "GRUPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Categoriadearticulo", "CATEARTI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLASIFART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodearticulo", "TIPOARTI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "ARIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivaventas", "ARTCONIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeivaventas", "ARTPORIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivacompras", "ARTIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeivacompras", "ANX2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeimpuestointerno", "IMPINTERNO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nomenclador", "ARTNARBA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Percepcionivarg5329", "ARTPERCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Paletadecolores", "PALCOL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Curvadetalles", "CURTALL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nocomercializable", "NOCOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Restringirarticulo", "ARTREST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importado", "IMPORTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imprimedespacho", "ESIMPDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descecommerce", "CONVERT( VARCHAR(MAX), DESECO)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descecommercehtml", "CONVERT( VARCHAR(MAX), DESECOHTML)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Peso", "ARTPESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Largo", "ARTLARGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ancho", "ARTANCHO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Alto", "ARTALTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Marca", "MARCA")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdes LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artdesadic LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artfab LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unimed LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Atemporada LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Familia LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mat LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Linea LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Grupo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Catearti LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasifart LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipoarti LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artnarba LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Palcol LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Curtall LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Deseco LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Desecohtml LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marca LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine