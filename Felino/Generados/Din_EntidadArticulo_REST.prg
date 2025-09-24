
define class Din_EntidadArticulo_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Articulo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcionadicional", toEntidad, "Descripcionadicional" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Comportamiento", toEntidad, "Comportamiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Requiereccosto", toEntidad, "Requiereccosto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Solopromoykit", toEntidad, "Solopromoykit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Proveedor", toEntidad, "Proveedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Unidad", toEntidad, "Unidad_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Material", toEntidad, "Material_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Unidaddemedida", toEntidad, "Unidaddemedida" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estacion", toEntidad, "Estacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Anio", toEntidad, "Anio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nomenclador", toEntidad, "Nomenclador_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Esoferta", toEntidad, "Esoferta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Restringirdescuentos", toEntidad, "Restringirdescuentos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imagen", toEntidad, "Imagen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivaventas", toEntidad, "Condicionivaventas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeivaventas", toEntidad, "Porcentajeivaventas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Condicionivacompras", toEntidad, "Condicionivacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeivacompras", toEntidad, "Porcentajeivacompras" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Porcentajeimpuestointerno", toEntidad, "Porcentajeimpuestointerno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Percepcionivarg5329", toEntidad, "Percepcionivarg5329" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Nocomercializable", toEntidad, "Nocomercializable" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Importado", toEntidad, "Importado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imprimedespacho", toEntidad, "Imprimedespacho" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Restringirarticulo", toEntidad, "Restringirarticulo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Peso", toEntidad, "Peso" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Largo", toEntidad, "Largo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ancho", toEntidad, "Ancho" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Alto", toEntidad, "Alto" )
			this.SetearDetalleParticipantesdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descecommerce", toEntidad, "Descecommerce" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descecommercehtml", toEntidad, "Descecommercehtml" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Marca", toEntidad, "Marca_PK" )
		endwith
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
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ParticipantesDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ParticipantesDetalle.oItem, "Cantidad" )
			toEntidad.ParticipantesDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoString( toModeloResponse, "DescripcionAdicional", toEntidad.DescripcionAdicional)
			this.SetearAtributoInteger( toModeloResponse, "Comportamiento", toEntidad.Comportamiento)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "RequiereCCosto", toEntidad.RequiereCCosto)
			this.SetearAtributo( toModeloResponse, "SoloPromoYKit", toEntidad.SoloPromoYKit)
			this.SetearAtributoString( toModeloResponse, "Proveedor", toEntidad.Proveedor_PK)
			this.SetearAtributoString( toModeloResponse, "Unidad", toEntidad.Unidad_PK)
			this.SetearAtributoString( toModeloResponse, "Material", toEntidad.Material_PK)
			this.SetearAtributoString( toModeloResponse, "UnidadDeMedida", toEntidad.UnidadDeMedida)
			this.SetearAtributoInteger( toModeloResponse, "Estacion", toEntidad.Estacion)
			this.SetearAtributoString( toModeloResponse, "Anio", toEntidad.Anio)
			this.SetearAtributoString( toModeloResponse, "Nomenclador", toEntidad.Nomenclador_PK)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributoInteger( toModeloResponse, "EsOferta", toEntidad.EsOferta)
			this.SetearAtributo( toModeloResponse, "RestringirDescuentos", toEntidad.RestringirDescuentos)
			this.SetearAtributoString( toModeloResponse, "Imagen", toEntidad.Imagen)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaVentas", toEntidad.CondicionIvaVentas)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeIvaVentas", toEntidad.PorcentajeIvaVentas)
			this.SetearAtributoInteger( toModeloResponse, "CondicionIvaCompras", toEntidad.CondicionIvaCompras)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeIvaCompras", toEntidad.PorcentajeIvaCompras)
			this.SetearAtributoDecimal( toModeloResponse, "PorcentajeImpuestoInterno", toEntidad.PorcentajeImpuestoInterno)
			this.SetearAtributoInteger( toModeloResponse, "PercepcionIvaRG5329", toEntidad.PercepcionIvaRG5329)
			this.SetearAtributoDateTime( toModeloResponse, "NoComercializable", toEntidad.NoComercializable)
			this.SetearAtributo( toModeloResponse, "Importado", toEntidad.Importado)
			this.SetearAtributo( toModeloResponse, "ImprimeDespacho", toEntidad.ImprimeDespacho)
			this.SetearAtributoDateTime( toModeloResponse, "RestringirArticulo", toEntidad.RestringirArticulo)
			this.SetearAtributoDecimal( toModeloResponse, "Peso", toEntidad.Peso)
			this.SetearAtributoDecimal( toModeloResponse, "Largo", toEntidad.Largo)
			this.SetearAtributoDecimal( toModeloResponse, "Ancho", toEntidad.Ancho)
			this.SetearAtributoDecimal( toModeloResponse, "Alto", toEntidad.Alto)
			this.CargarColeccionModeloParticipantesDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "DescEcommerce", toEntidad.DescEcommerce)
			this.SetearAtributo( toModeloResponse, "DescEcommerceHTML", toEntidad.DescEcommerceHTML)
			this.SetearAtributoString( toModeloResponse, "Marca", toEntidad.Marca_PK)
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
				this.SetearAtributoString( loItem, "Talle", .ParticipantesDetalle.Item(lnI).Talle)
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
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "ARTDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcionadicional", "ARTDESADIC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Comportamiento", "ASTOCK")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), AOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Requiereccosto", "REQCCOSTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Solopromoykit", "PROMOYKIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Proveedor", "ARTFAB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Unidad", "ARTUNI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Material", "AMATE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Unidaddemedida", "UNIMED")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estacion", "AESTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Anio", "AANO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nomenclador", "ARTNARBA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLASIFART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Esoferta", "AOFERTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Restringirdescuentos", "ARTSINDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imagen", "ARIMAGEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivaventas", "ARTCONIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeivaventas", "ARTPORIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Condicionivacompras", "ARTIVA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeivacompras", "ANX2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Porcentajeimpuestointerno", "IMPINTERNO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Percepcionivarg5329", "ARTPERCEP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nocomercializable", "NOCOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Importado", "IMPORTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imprimedespacho", "ESIMPDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Restringirarticulo", "ARTREST")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Peso", "ARTPESO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Largo", "ARTLARGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ancho", "ARTANCHO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Alto", "ARTALTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descecommerce", "CONVERT( VARCHAR(MAX), DESECO)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descecommercehtml", "CONVERT( VARCHAR(MAX), DESECOHTML)")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artuni LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Amate LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Unimed LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Aano LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Artnarba LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clasifart LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Arimagen LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Deseco LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Desecohtml LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marca LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine