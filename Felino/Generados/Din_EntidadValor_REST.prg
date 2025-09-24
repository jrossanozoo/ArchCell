
define class Din_EntidadValor_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Felino.Generados.DTO.Valor"
	cClaseResponse = this.cNamespaceDTOs + ".ValorResponse"
	cClaseModelo = "ValorModelo"
	cEntidad = "Valor"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ValorModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "ValorModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "ValorListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "ValorListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "ValorModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipo", toEntidad, "Tipo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Simbolomonetario", toEntidad, "Simbolomonetario_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Grupo", toEntidad, "Grupo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasificacion", toEntidad, "Clasificacion_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Visualizarencaja", toEntidad, "Visualizarencaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuit", toEntidad, "Cuit" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Permitevuelto", toEntidad, "Permitevuelto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Caja", toEntidad, "Caja_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Personalizarcomprobante", toEntidad, "Personalizarcomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Arrastrasaldo", toEntidad, "Arrastrasaldo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Descuento", toEntidad, "Descuento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Noaplicarenrecibos", toEntidad, "Noaplicarenrecibos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Arqueoportotales", toEntidad, "Arqueoportotales" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bloqueamodificaciondescripcion", toEntidad, "Bloqueamodificaciondescripcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Permitemodificarfecha", toEntidad, "Permitemodificarfecha" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modoredondeo", toEntidad, "Modoredondeo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Redondeo", toEntidad, "Redondeo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Direccion", toEntidad, "Direccion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localidad", toEntidad, "Localidad" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigopostal", toEntidad, "Codigopostal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefono", toEntidad, "Telefono" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Fax", toEntidad, "Fax" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Operadoratarjeta", toEntidad, "Operadoratarjeta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipotarjeta", toEntidad, "Tipotarjeta" )
			this.SetearDetalleDetalleplanes( toEntidad, toModeloEnRequest )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Chequeelectronico", toEntidad, "Chequeelectronico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Equivcfepson", toEntidad, "Equivcfepson" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Equivcfibm", toEntidad, "Equivcfibm" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Facturaelectronica", toEntidad, "Facturaelectronica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pidecotizacion", toEntidad, "Pidecotizacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Prestador", toEntidad, "Prestador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipotarjetapoint", toEntidad, "Tipotarjetapoint" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuentabancaria", toEntidad, "Cuentabancaria_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Habilitarretiroefectivo", toEntidad, "Habilitarretiroefectivo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Montomaximoderetiro", toEntidad, "Montomaximoderetiro" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valorpararetirodeefectivo", toEntidad, "Valorpararetirodeefectivo_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valordeacreditacion", toEntidad, "Valordeacreditacion_PK" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDetallePlanes( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DetallePlanes" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DetallePlanes[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DetallePlanes.LimpiarItem()
			else
				try
					toEntidad.DetallePlanes.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DetallePlanes.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Cuotas", toEntidad.DetallePlanes.oItem, "Cuotas" )
			this.SetearAtributoModeloEnEntidad( loItem, "Montodesde", toEntidad.DetallePlanes.oItem, "MontoDesde" )
			this.SetearAtributoModeloEnEntidad( loItem, "Tipodemonto", toEntidad.DetallePlanes.oItem, "TipoDeMonto" )
			this.SetearAtributoModeloEnEntidad( loItem, "Recargo", toEntidad.DetallePlanes.oItem, "Recargo" )
			toEntidad.DetallePlanes.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "Tipo", toEntidad.Tipo)
			this.SetearAtributoString( toModeloResponse, "SimboloMonetario", toEntidad.SimboloMonetario_PK)
			this.SetearAtributoString( toModeloResponse, "Grupo", toEntidad.Grupo_PK)
			this.SetearAtributoString( toModeloResponse, "Clasificacion", toEntidad.Clasificacion_PK)
			this.SetearAtributo( toModeloResponse, "VisualizarEnCaja", toEntidad.VisualizarEnCaja)
			this.SetearAtributoString( toModeloResponse, "Cuit", toEntidad.Cuit)
			this.SetearAtributo( toModeloResponse, "PermiteVuelto", toEntidad.PermiteVuelto)
			this.SetearAtributoInteger( toModeloResponse, "Caja", toEntidad.Caja_PK)
			this.SetearAtributo( toModeloResponse, "PersonalizarComprobante", toEntidad.PersonalizarComprobante)
			this.SetearAtributo( toModeloResponse, "ArrastraSaldo", toEntidad.ArrastraSaldo)
			this.SetearAtributoDecimal( toModeloResponse, "Descuento", toEntidad.Descuento)
			this.SetearAtributo( toModeloResponse, "NoAplicarEnRecibos", toEntidad.NoAplicarEnRecibos)
			this.SetearAtributo( toModeloResponse, "ArqueoPorTotales", toEntidad.ArqueoPorTotales)
			this.SetearAtributo( toModeloResponse, "BloqueaModificacionDescripcion", toEntidad.BloqueaModificacionDescripcion)
			this.SetearAtributo( toModeloResponse, "PermiteModificarFecha", toEntidad.PermiteModificarFecha)
			this.SetearAtributoInteger( toModeloResponse, "ModoRedondeo", toEntidad.ModoRedondeo)
			this.SetearAtributoString( toModeloResponse, "Redondeo", toEntidad.Redondeo_PK)
			this.SetearAtributoString( toModeloResponse, "Direccion", toEntidad.Direccion)
			this.SetearAtributoString( toModeloResponse, "Localidad", toEntidad.Localidad)
			this.SetearAtributoString( toModeloResponse, "CodigoPostal", toEntidad.CodigoPostal)
			this.SetearAtributoString( toModeloResponse, "Telefono", toEntidad.Telefono)
			this.SetearAtributoString( toModeloResponse, "Fax", toEntidad.Fax)
			this.SetearAtributoString( toModeloResponse, "OperadoraTarjeta", toEntidad.OperadoraTarjeta_PK)
			this.SetearAtributoString( toModeloResponse, "TipoTarjeta", toEntidad.TipoTarjeta)
			this.CargarColeccionModeloDetallePlanes( toModeloResponse, toEntidad )
			this.SetearAtributo( toModeloResponse, "ChequeElectronico", toEntidad.ChequeElectronico)
			this.SetearAtributoInteger( toModeloResponse, "EquivCfEpson", toEntidad.EquivCfEpson)
			this.SetearAtributoInteger( toModeloResponse, "EquivCfIBM", toEntidad.EquivCfIBM)
			this.SetearAtributoString( toModeloResponse, "Facturaelectronica", toEntidad.Facturaelectronica)
			this.SetearAtributo( toModeloResponse, "PideCotizacion", toEntidad.PideCotizacion)
			this.SetearAtributoString( toModeloResponse, "Prestador", toEntidad.Prestador)
			this.SetearAtributoString( toModeloResponse, "TipoTarjetaPoint", toEntidad.TipoTarjetaPoint)
			this.SetearAtributoString( toModeloResponse, "CuentaBancaria", toEntidad.CuentaBancaria_PK)
			this.SetearAtributo( toModeloResponse, "HabilitarRetiroEfectivo", toEntidad.HabilitarRetiroEfectivo)
			this.SetearAtributoDecimal( toModeloResponse, "MontoMaximoDeRetiro", toEntidad.MontoMaximoDeRetiro)
			this.SetearAtributoString( toModeloResponse, "ValorParaRetiroDeEfectivo", toEntidad.ValorParaRetiroDeEfectivo_PK)
			this.SetearAtributoString( toModeloResponse, "ValorDeAcreditacion", toEntidad.ValorDeAcreditacion_PK)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDetallePlanes( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DetallePlanes" ) 
		with toEntidad
			for lnI = 1 to .DetallePlanes.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPlandecuota" )
				this.SetearAtributoString( loItem, "Codigo", .DetallePlanes.Item(lnI).Codigo)
				this.SetearAtributoInteger( loItem, "Cuotas", .DetallePlanes.Item(lnI).Cuotas)
				this.SetearAtributoDecimal( loItem, "MontoDesde", .DetallePlanes.Item(lnI).MontoDesde)
				this.SetearAtributoString( loItem, "TipoDeMonto", .DetallePlanes.Item(lnI).TipoDeMonto)
				this.SetearAtributoDecimal( loItem, "Recargo", .DetallePlanes.Item(lnI).Recargo)
				this.SetearAtributoInteger( loItem, "NroItem", .DetallePlanes.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descripcion", "CLNOM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), CLOBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipo", "CLCFI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Simbolomonetario", "CLSMONET")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Grupo", "CLGRUP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasificacion", "CLCLAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Visualizarencaja", "CLVISUALIZ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuit", "CLCUIT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Permitevuelto", "PERVUELTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Caja", "IDCAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Personalizarcomprobante", "PERSOCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Arrastrasaldo", "NOARRASTRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Descuento", "CLDESCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Noaplicarenrecibos", "NOAPLIRC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Arqueoportotales", "ARQTOT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bloqueamodificaciondescripcion", "BLOMODDES")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Permitemodificarfecha", "MODIFECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modoredondeo", "MODOREDON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Redondeo", "REDONDEO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Direccion", "CLDIR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localidad", "CLLOC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigopostal", "CLCP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefono", "CLTLF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fax", "CLFAX")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Operadoratarjeta", "OPETAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipotarjeta", "TIPOTARJ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Chequeelectronico", "ELECTRO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Equivcfepson", "EQEPSON")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Equivcfibm", "EQIBM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Facturaelectronica", "FACTELEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pidecotizacion", "COTIZAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Prestador", "PRESTADOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuentabancaria", "CTABANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Habilitarretiroefectivo", "RETIRAEFEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Montomaximoderetiro", "MNTOMAXRET")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valorpararetirodeefectivo", "VALORRETEF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valordeacreditacion", "VALORACRED")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clnom LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clobs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clsmonet LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clgrup LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clclas LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcuit LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Redondeo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cldir LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clloc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clcp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cltlf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clfax LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Opetar LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipotarj LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Factelec LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prestador LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ctabanc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valorretef LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valoracred LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine