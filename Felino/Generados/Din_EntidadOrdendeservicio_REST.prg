
define class Din_EntidadOrdendeservicio_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Ordendeservicio"
	cClaseResponse = this.cNamespaceDTOs + ".OrdendeservicioResponse"
	cClaseModelo = "OrdendeservicioModelo"
	cEntidad = "Ordendeservicio"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeservicioModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeservicioModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeservicioListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeservicioListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "OrdendeservicioModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipoagrupamientopublicaciones", toEntidad, "Tipoagrupamientopublicaciones" )
			this.SetearDetalleAgrupublidetalle( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigo", toEntidad, "Codigo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodeorden", toEntidad, "Tipodeorden_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Estado", toEntidad, "Estado_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valor", toEntidad, "Valor" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fecha", toEntidad, "Fecha" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaentrega", toEntidad, "Fechaentrega" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Presupuesto", toEntidad, "Presupuesto_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursal", toEntidad, "Sucursal_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosaltafw", toEntidad, "Basededatosaltafw" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idglobalcliente", toEntidad, "Idglobalcliente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrofactura", toEntidad, "Nrofactura" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechafactura", toEntidad, "Fechafactura" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Vendedor", toEntidad, "Vendedor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Articulo", toEntidad, "Articulo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Color", toEntidad, "Color_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Talle", toEntidad, "Talle" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaadicional1", toEntidad, "Fechaadicional1" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaadicional2", toEntidad, "Fechaadicional2" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechaadicional3", toEntidad, "Fechaadicional3" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadadicional1", toEntidad, "Entidadadicional1_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadadicional2", toEntidad, "Entidadadicional2_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadadicional3", toEntidad, "Entidadadicional3_PK" )
			this.SetearDetalleDetallecodigodeservicio( toEntidad, toModeloEnRequest )
			this.SetearDetalleDetalleinteracciones( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Obs", toEntidad, "Obs" )
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
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamiento", toEntidad.Agrupublidetalle.oItem, "Agrupamiento_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Agrupamientodetalle", toEntidad.Agrupublidetalle.oItem, "AgrupamientoDetalle" )
			toEntidad.Agrupublidetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleCodigoDeServicio( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleCodigoDeServicio" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleCodigoDeServicio[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleCodigoDeServicio.LimpiarItem()
			else
				try
					toEntidad.DetalleCodigoDeServicio.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleCodigoDeServicio.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoserv", toEntidad.DetalleCodigoDeServicio.oItem, "CodigoServ_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.DetalleCodigoDeServicio.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Nota", toEntidad.DetalleCodigoDeServicio.oItem, "Nota" )
			toEntidad.DetalleCodigoDeServicio.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetalleInteracciones( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetalleInteracciones" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetalleInteracciones[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetalleInteracciones.LimpiarItem()
			else
				try
					toEntidad.DetalleInteracciones.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetalleInteracciones.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloDateTimeEnEntidad( loItem, "Fecha", toEntidad.DetalleInteracciones.oItem, "Fecha" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numero", toEntidad.DetalleInteracciones.oItem, "Numero" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descri", toEntidad.DetalleInteracciones.oItem, "Descri" )
			this.SetearAtributoModeloEnEntidad( loItem, "Vendedor", toEntidad.DetalleInteracciones.oItem, "Vendedor" )
			this.SetearAtributoModeloEnEntidad( loItem, "Estado", toEntidad.DetalleInteracciones.oItem, "Estado" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodescuento", toEntidad.DetalleInteracciones.oItem, "TipoDescuento" )
			this.SetearAtributoModeloEnEntidad( loItem, "Valor", toEntidad.DetalleInteracciones.oItem, "Valor" )
			toEntidad.DetalleInteracciones.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoInteger( toModeloResponse, "tipoagrupamientopublicaciones", toEntidad.tipoagrupamientopublicaciones)
			this.CargarColeccionModeloAgrupublidetalle( toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "TipoDeOrden", toEntidad.TipoDeOrden_PK)
			this.SetearAtributoString( toModeloResponse, "Estado", toEntidad.Estado_PK)
			this.SetearAtributoDecimal( toModeloResponse, "Valor", toEntidad.Valor)
			this.SetearAtributoDateTime( toModeloResponse, "Fecha", toEntidad.Fecha)
			this.SetearAtributoDateTime( toModeloResponse, "FechaEntrega", toEntidad.FechaEntrega)
			this.SetearAtributoString( toModeloResponse, "Presupuesto", toEntidad.Presupuesto_PK)
			this.SetearAtributoString( toModeloResponse, "Sucursal", toEntidad.Sucursal_PK)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosAltaFW", toEntidad.BaseDeDatosAltaFW)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoString( toModeloResponse, "IdGlobalCliente", toEntidad.IdGlobalCliente)
			this.SetearAtributoString( toModeloResponse, "NroFactura", toEntidad.NroFactura)
			this.SetearAtributoDateTime( toModeloResponse, "FechaFactura", toEntidad.FechaFactura)
			this.SetearAtributoString( toModeloResponse, "Vendedor", toEntidad.Vendedor_PK)
			this.SetearAtributoString( toModeloResponse, "Articulo", toEntidad.Articulo_PK)
			this.SetearAtributoString( toModeloResponse, "Color", toEntidad.Color_PK)
			this.SetearAtributoString( toModeloResponse, "Talle", toEntidad.Talle)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAdicional1", toEntidad.FechaAdicional1)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAdicional2", toEntidad.FechaAdicional2)
			this.SetearAtributoDateTime( toModeloResponse, "FechaAdicional3", toEntidad.FechaAdicional3)
			this.SetearAtributoString( toModeloResponse, "EntidadAdicional1", toEntidad.EntidadAdicional1_PK)
			this.SetearAtributoString( toModeloResponse, "EntidadAdicional2", toEntidad.EntidadAdicional2_PK)
			this.SetearAtributoString( toModeloResponse, "EntidadAdicional3", toEntidad.EntidadAdicional3_PK)
			this.CargarColeccionModeloDetalleCodigoDeServicio( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDetalleInteracciones( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "Obs", toEntidad.Obs)
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
	protected function CargarColeccionModeloDetalleCodigoDeServicio( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleCodigoDeServicio" ) 
		with toEntidad
			for lnI = 1 to .DetalleCodigoDeServicio.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemCodserv" )
				this.SetearAtributoString( loItem, "CodigoServ", .DetalleCodigoDeServicio.Item(lnI).CodigoServ_PK)
				this.SetearAtributoString( loItem, "Descripcion", .DetalleCodigoDeServicio.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Nota", .DetalleCodigoDeServicio.Item(lnI).Nota)
				this.SetearAtributoString( loItem, "Codigo", .DetalleCodigoDeServicio.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleCodigoDeServicio.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetalleInteracciones( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetalleInteracciones" ) 
		with toEntidad
			for lnI = 1 to .DetalleInteracciones.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemInteraccion" )
				this.SetearAtributoDatetime( loItem, "Fecha", .DetalleInteracciones.Item(lnI).Fecha)
				this.SetearAtributoString( loItem, "Numero", .DetalleInteracciones.Item(lnI).Numero)
				this.SetearAtributoString( loItem, "Descri", .DetalleInteracciones.Item(lnI).Descri)
				this.SetearAtributoString( loItem, "Vendedor", .DetalleInteracciones.Item(lnI).Vendedor)
				this.SetearAtributoString( loItem, "Estado", .DetalleInteracciones.Item(lnI).Estado)
				this.SetearAtributoString( loItem, "TipoDescuento", .DetalleInteracciones.Item(lnI).TipoDescuento)
				this.SetearAtributoLong( loItem, "Valor", .DetalleInteracciones.Item(lnI).Valor)
				this.SetearAtributoString( loItem, "Codigo", .DetalleInteracciones.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "NroItem", .DetalleInteracciones.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodeorden", "TIPOORDEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Estado", "ESTADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valor", "VALOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fecha", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaentrega", "FECHAENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Presupuesto", "NROPRESUP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursal", "SUCURSAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosaltafw", "BDALTAFW")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idglobalcliente", "IDCENT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrofactura", "NROFAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechafactura", "FECHAFAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Vendedor", "VENDEDOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Articulo", "OSART")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Color", "OSCOLOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Talle", "OSTALLE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaadicional1", "FECADIC1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaadicional2", "FECADIC2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechaadicional3", "FECADIC3")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidadadicional1", "ENTADIC1")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidadadicional2", "ENTADIC2")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidadadicional3", "ENTADIC3")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipoorden LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Estado LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nropresup LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucursal LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Bdaltafw LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idcent LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nrofac LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Vendedor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Osart LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Oscolor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ostalle LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entadic1 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entadic2 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entadic3 LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine