
define class Din_EntidadImpresiondeetiqueta_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Impresiondeetiqueta"
	cClaseResponse = this.cNamespaceDTOs + ".ImpresiondeetiquetaResponse"
	cClaseModelo = "ImpresiondeetiquetaModelo"
	cEntidad = "Impresiondeetiqueta"
	lPermiteModificacion = .f.

	*-----------------------------------------------------------------------------------------
	protected function ObtenerClavePrimariaEnModeloRequest( toModeloRequest as Object ) as Variant
		return _Screen.Dotnetbridge.ObtenerValorPropiedad( toModeloRequest, "Numero" )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimaria( toEntidad as Object, txValor as Variant ) as Void
		toEntidad.Numero = txValor 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearClavePrimariaPorId( toEntidad as Object, tcId as String ) as Void
		toEntidad.Numero = val( tcId )
	endfunc
	
	*-----------------------------------------------------------------------------------------
	function ObtenerClaseRequest( tcOperacion as String ) as String
		local lcRetorno as String
		do case
			case tcOperacion == "Nuevo"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpresiondeetiquetaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpresiondeetiquetaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ImpresiondeetiquetaListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ImpresiondeetiquetaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ImpresiondeetiquetaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numero", toEntidad, "Numero" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripcion", toEntidad, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Hora", toEntidad, "Hora" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serie", toEntidad, "Serie" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuario", toEntidad, "Usuario" )
			this.SetearDetalleEtiquetadetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleETIQUETADETALLE( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ETIQUETADETALLE" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ETIQUETADETALLE[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ETIQUETADETALLE.LimpiarItem()
			else
				try
					toEntidad.ETIQUETADETALLE.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ETIQUETADETALLE.LimpiarItem()
				endtry 
			endif
			if goParametros.Felino.CodigosDeBarras.HabilitarLectura
				if toEntidad.ETIQUETADETALLE.oItem.lUtilizaLecturaDeCodigoDeBarras != goParametros.Felino.CodigosDeBarras.HabilitarLectura
					toEntidad.ETIQUETADETALLE.oItem.lUtilizaLecturaDeCodigoDeBarras = goParametros.Felino.CodigosDeBarras.HabilitarLectura
				endif
				try
					this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ETIQUETADETALLE.oItem, "CodigoDeBarras" )
				catch to loError
					try
						this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ETIQUETADETALLE.oItem, "Articulo_PK" )
					catch
						goServicios.Errores.LevantarExcepcion( loError )
					endtry
				endtry
			else
				this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ETIQUETADETALLE.oItem, "Articulo_PK" )
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ETIQUETADETALLE.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ETIQUETADETALLE.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ETIQUETADETALLE.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ETIQUETADETALLE.oItem, "Talle_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talledetalle", toEntidad.ETIQUETADETALLE.oItem, "TalleDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ETIQUETADETALLE.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Nota", toEntidad.ETIQUETADETALLE.oItem, "Nota" )
			toEntidad.ETIQUETADETALLE.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoLong( toModeloResponse, "Numero", toEntidad.Numero)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoString( toModeloResponse, "Hora", toEntidad.Hora)
			this.SetearAtributoString( toModeloResponse, "Serie", toEntidad.Serie)
			this.SetearAtributoString( toModeloResponse, "Usuario", toEntidad.Usuario)
			this.CargarColeccionModeloETIQUETADETALLE( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloETIQUETADETALLE( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ETIQUETADETALLE" ) 
		with toEntidad
			for lnI = 1 to .ETIQUETADETALLE.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemImpetiqueta" )
				this.SetearAtributoString( loItem, "Articulo", .ETIQUETADETALLE.Item(lnI).Articulo_PK)
				this.SetearAtributoLong( loItem, "Numero", .ETIQUETADETALLE.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ETIQUETADETALLE.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ETIQUETADETALLE.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ETIQUETADETALLE.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ETIQUETADETALLE.Item(lnI).Talle_PK)
				this.SetearAtributoString( loItem, "TalleDetalle", .ETIQUETADETALLE.Item(lnI).TalleDetalle)
				this.SetearAtributoLong( loItem, "Cantidad", .ETIQUETADETALLE.Item(lnI).Cantidad)
				this.SetearAtributoString( loItem, "Nota", .ETIQUETADETALLE.Item(lnI).Nota)
				this.SetearAtributoInteger( loItem, "NroItem", .ETIQUETADETALLE.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "DESCRI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Hora", "DHORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serie", "SERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuario", "DUSUARIO")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Descri LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dhora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dusuario LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine