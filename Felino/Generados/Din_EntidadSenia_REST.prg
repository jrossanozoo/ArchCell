
define class Din_EntidadSenia_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Senia"
	cClaseResponse = this.cNamespaceDTOs + ".SeniaResponse"
	cClaseModelo = "SeniaModelo"
	cEntidad = "Senia"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeniaModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeniaModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "SeniaListarRequest"
			case tcOperacion == "Anular"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
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
				lcRetorno = this.cNamespaceDTOs + "." + "SeniaListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "SeniaModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letraorigen", toEntidad, "Letraorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventaorigen", toEntidad, "Puntodeventaorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroorigen", toEntidad, "Numeroorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripciontipocomprobanteorigen", toEntidad, "Descripciontipocomprobanteorigen" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaorigen", toEntidad, "Fechaorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cserieorigen", toEntidad, "Cserieorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cversionorigen", toEntidad, "Cversionorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cbasededatosorigen", toEntidad, "Cbasededatosorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechavencimiento", toEntidad, "Fechavencimiento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Precio", toEntidad, "Precio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Moneda", toEntidad, "Moneda_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letraafectante", toEntidad, "Letraafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventaafectante", toEntidad, "Puntodeventaafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroafectante", toEntidad, "Numeroafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descripciontipocomprobanteafectante", toEntidad, "Descripciontipocomprobanteafectante" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaafectante", toEntidad, "Fechaafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cserieafectante", toEntidad, "Cserieafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cversionafectante", toEntidad, "Cversionafectante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cbasededatosafectante", toEntidad, "Cbasededatosafectante" )
			this.SetearDetalleArticulosdetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleArticulosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "ArticulosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"ArticulosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.ArticulosDetalle.LimpiarItem()
			else
				try
					toEntidad.ArticulosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.ArticulosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Articulo", toEntidad.ArticulosDetalle.oItem, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Articulodetalle", toEntidad.ArticulosDetalle.oItem, "ArticuloDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Color", toEntidad.ArticulosDetalle.oItem, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Colordetalle", toEntidad.ArticulosDetalle.oItem, "ColorDetalle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Talle", toEntidad.ArticulosDetalle.oItem, "Talle" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descuento", toEntidad.ArticulosDetalle.oItem, "Descuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Cantidad", toEntidad.ArticulosDetalle.oItem, "Cantidad" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodescuento", toEntidad.ArticulosDetalle.oItem, "MontoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Precio", toEntidad.ArticulosDetalle.oItem, "Precio" )
			this.SetearAtributoModeloEnEntidad( loItem, "Monto", toEntidad.ArticulosDetalle.oItem, "Monto" )
			toEntidad.ArticulosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "LetraOrigen", toEntidad.LetraOrigen)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaOrigen", toEntidad.PuntoDeVentaOrigen)
			this.SetearAtributoInteger( toModeloResponse, "NumeroOrigen", toEntidad.NumeroOrigen)
			this.SetearAtributoString( toModeloResponse, "DescripcionTipoComprobanteOrigen", toEntidad.DescripcionTipoComprobanteOrigen)
			this.SetearAtributoDateTime( toModeloResponse, "FechaOrigen", toEntidad.FechaOrigen)
			this.SetearAtributoString( toModeloResponse, "cSerieOrigen", toEntidad.cSerieOrigen)
			this.SetearAtributoString( toModeloResponse, "cVersionOrigen", toEntidad.cVersionOrigen)
			this.SetearAtributoString( toModeloResponse, "cBaseDeDatosOrigen", toEntidad.cBaseDeDatosOrigen)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoDateTime( toModeloResponse, "FechaVencimiento", toEntidad.FechaVencimiento)
			this.SetearAtributoDecimal( toModeloResponse, "Precio", toEntidad.Precio)
			this.SetearAtributoString( toModeloResponse, "Moneda", toEntidad.Moneda_PK)
			this.SetearAtributoString( toModeloResponse, "LetraAfectante", toEntidad.LetraAfectante)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaAfectante", toEntidad.PuntoDeVentaAfectante)
			this.SetearAtributoInteger( toModeloResponse, "NumeroAfectante", toEntidad.NumeroAfectante)
			this.SetearAtributoString( toModeloResponse, "DescripcionTipoComprobanteAfectante", toEntidad.DescripcionTipoComprobanteAfectante)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAfectante", toEntidad.FechaAfectante)
			this.SetearAtributoString( toModeloResponse, "cSerieAfectante", toEntidad.cSerieAfectante)
			this.SetearAtributoString( toModeloResponse, "cVersionAfectante", toEntidad.cVersionAfectante)
			this.SetearAtributoString( toModeloResponse, "cBaseDeDatosAfectante", toEntidad.cBaseDeDatosAfectante)
			this.CargarColeccionModeloArticulosDetalle( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloArticulosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "ArticulosDetalle" ) 
		with toEntidad
			for lnI = 1 to .ArticulosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemSenias" )
				this.SetearAtributoString( loItem, "Articulo", .ArticulosDetalle.Item(lnI).Articulo_PK)
				this.SetearAtributoString( loItem, "Codigo", .ArticulosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "ArticuloDetalle", .ArticulosDetalle.Item(lnI).ArticuloDetalle)
				this.SetearAtributoString( loItem, "Color", .ArticulosDetalle.Item(lnI).Color_PK)
				this.SetearAtributoString( loItem, "ColorDetalle", .ArticulosDetalle.Item(lnI).ColorDetalle)
				this.SetearAtributoString( loItem, "Talle", .ArticulosDetalle.Item(lnI).Talle)
				this.SetearAtributoDecimal( loItem, "Descuento", .ArticulosDetalle.Item(lnI).Descuento)
				this.SetearAtributoDecimal( loItem, "Cantidad", .ArticulosDetalle.Item(lnI).Cantidad)
				this.SetearAtributoDecimal( loItem, "MontoDescuento", .ArticulosDetalle.Item(lnI).MontoDescuento)
				this.SetearAtributoDecimal( loItem, "Precio", .ArticulosDetalle.Item(lnI).Precio)
				this.SetearAtributoDecimal( loItem, "Monto", .ArticulosDetalle.Item(lnI).Monto)
				this.SetearAtributoInteger( loItem, "NroItem", .ArticulosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letraorigen", "FLETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventaorigen", "FPTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroorigen", "FNUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaorigen", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cserieorigen", "CSERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cversionorigen", "CVERSION")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cbasededatosorigen", "CBASEDEDAT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechavencimiento", "FECHAVENCI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Precio", "FPRECIO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Moneda", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letraafectante", "FLETRAA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventaafectante", "FPTOVENA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroafectante", "FNUMCOMPA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaafectante", "FECHAA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cserieafectante", "CSERIEA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cversionafectante", "CVERSIONA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cbasededatosafectante", "CBDEDATA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cserie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cversion LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbasededat LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fletraa LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cseriea LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cversiona LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cbdedata LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine