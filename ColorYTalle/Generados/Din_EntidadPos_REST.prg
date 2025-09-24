
define class Din_EntidadPos_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Pos"
	cClaseResponse = this.cNamespaceDTOs + ".PosResponse"
	cClaseModelo = "PosModelo"
	cEntidad = "Pos"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PosModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "PosModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "PosListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "PosListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "PosModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeroterminal", toEntidad, "Numeroterminal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Marca", toEntidad, "Marca" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modelo", toEntidad, "Modelo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Contactosoportetecnico", toEntidad, "Contactosoportetecnico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefonosoportetecnico", toEntidad, "Telefonosoportetecnico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Integrado", toEntidad, "Integrado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Prestador", toEntidad, "Prestador" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pagoelectronico", toEntidad, "Pagoelectronico" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puerto", toEntidad, "Puerto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Paquete", toEntidad, "Paquete" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiempomensaje", toEntidad, "Tiempomensaje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiempochequeo", toEntidad, "Tiempochequeo" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Timeoutrecepcion", toEntidad, "Timeoutrecepcion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Shopping", toEntidad, "Shopping" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Empresa", toEntidad, "Empresa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Caja", toEntidad, "Caja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Imprimesolooriginal", toEntidad, "Imprimesolooriginal" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomercio", toEntidad, "Numerocomercio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombrecomercio", toEntidad, "Nombrecomercio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuitcomercio", toEntidad, "Cuitcomercio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Permitetransaccionesoffline", toEntidad, "Permitetransaccionesoffline" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiempodeespera", toEntidad, "Tiempodeespera" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiempoporreintento", toEntidad, "Tiempoporreintento" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idcliente", toEntidad, "Idcliente" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuariomp", toEntidad, "Usuariomp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idsecreto", toEntidad, "Idsecreto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Bloquearcierrecajaoffline", toEntidad, "Bloquearcierrecajaoffline" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idpuestoqr", toEntidad, "Idpuestoqr" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Localmp", toEntidad, "Localmp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idstoreqr", toEntidad, "Idstoreqr" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cajamp", toEntidad, "Cajamp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Leyenda", toEntidad, "Leyenda" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Enviaventassitef", toEntidad, "Enviaventassitef" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Direccionip", toEntidad, "Direccionip" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puertofiserv", toEntidad, "Puertofiserv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Empresafiserv", toEntidad, "Empresafiserv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Terminalfiserv", toEntidad, "Terminalfiserv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutacertificado", toEntidad, "Rutacertificado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dispositivofiserv", toEntidad, "Dispositivofiserv" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idcloverdisp", toEntidad, "Idcloverdisp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ipcloverdisp", toEntidad, "Ipcloverdisp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puertocloverdisp", toEntidad, "Puertocloverdisp" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Modeloclover", toEntidad, "Modeloclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serialclover", toEntidad, "Serialclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Usuariosmartlapos", toEntidad, "Usuariosmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Passsmartlapos", toEntidad, "Passsmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Guidbilleterasantafe", toEntidad, "Guidbilleterasantafe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Frasebilleterasantafe", toEntidad, "Frasebilleterasantafe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cajabilleterasantafe", toEntidad, "Cajabilleterasantafe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Sucursalbilleterasantafe", toEntidad, "Sucursalbilleterasantafe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Urlbilleterasantafe", toEntidad, "Urlbilleterasantafe" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cryptoapikey", toEntidad, "Cryptoapikey" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailgocuotas", toEntidad, "Mailgocuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clavegocuotas", toEntidad, "Clavegocuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiempodeesperaposnet", toEntidad, "Tiempodeesperaposnet" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Rutaarchivoiniposnet", toEntidad, "Rutaarchivoiniposnet" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Preguntatarjetaqr", toEntidad, "Preguntatarjetaqr" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearDetalleTarjetaslaposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetallePlaneslaposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleDispositivomovilpointdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleSerialpointdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleTarjetasfiservdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleTerminalessmartlaposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleTarjetassmartlaposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetallePlanessmartlaposdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetalleTarjetasposnetdetalle( toEntidad, toModeloEnRequest )
			this.SetearDetallePlanesposnetdetalle( toEntidad, toModeloEnRequest )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleTarjetasLaPosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "TarjetasLaPosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"TarjetasLaPosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.TarjetasLaPosDetalle.LimpiarItem()
			else
				try
					toEntidad.TarjetasLaPosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.TarjetasLaPosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoequivalencia", toEntidad.TarjetasLaPosDetalle.oItem, "CodigoEquivalencia" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.TarjetasLaPosDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.TarjetasLaPosDetalle.oItem, "Operadora_PK" )
			this.SetearAtributoModeloEnEntidad( loItem, "Numerocomercio", toEntidad.TarjetasLaPosDetalle.oItem, "NumeroComercio" )
			toEntidad.TarjetasLaPosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePlanesLaPosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PlanesLaPosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PlanesLaPosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PlanesLaPosDetalle.LimpiarItem()
			else
				try
					toEntidad.PlanesLaPosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PlanesLaPosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoplan", toEntidad.PlanesLaPosDetalle.oItem, "CodigoPlan" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.PlanesLaPosDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.PlanesLaPosDetalle.oItem, "Operadora_PK" )
			toEntidad.PlanesLaPosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleDispositivoMovilPointDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "DispositivoMovilPointDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"DispositivoMovilPointDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.DispositivoMovilPointDetalle.LimpiarItem()
			else
				try
					toEntidad.DispositivoMovilPointDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.DispositivoMovilPointDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Dispositivomovil", toEntidad.DispositivoMovilPointDetalle.oItem, "DispositivoMovil" )
			this.SetearAtributoModeloEnEntidad( loItem, "Disponible", toEntidad.DispositivoMovilPointDetalle.oItem, "Disponible" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sugerido", toEntidad.DispositivoMovilPointDetalle.oItem, "Sugerido" )
			this.SetearAtributoModeloEnEntidad( loItem, "Vinculacionpdv", toEntidad.DispositivoMovilPointDetalle.oItem, "VinculacionPDV" )
			toEntidad.DispositivoMovilPointDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleSerialPointDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "SerialPointDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"SerialPointDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.SerialPointDetalle.LimpiarItem()
			else
				try
					toEntidad.SerialPointDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.SerialPointDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Serial", toEntidad.SerialPointDetalle.oItem, "Serial" )
			toEntidad.SerialPointDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleTarjetasFiServDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "TarjetasFiServDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"TarjetasFiServDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.TarjetasFiServDetalle.LimpiarItem()
			else
				try
					toEntidad.TarjetasFiServDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.TarjetasFiServDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoequivalencia", toEntidad.TarjetasFiServDetalle.oItem, "CodigoEquivalencia" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.TarjetasFiServDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.TarjetasFiServDetalle.oItem, "Operadora_PK" )
			toEntidad.TarjetasFiServDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleTerminalesSmartLaposDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "TerminalesSmartLaposDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"TerminalesSmartLaposDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.TerminalesSmartLaposDetalle.LimpiarItem()
			else
				try
					toEntidad.TerminalesSmartLaposDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.TerminalesSmartLaposDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Terminal", toEntidad.TerminalesSmartLaposDetalle.oItem, "Terminal" )
			this.SetearAtributoModeloEnEntidad( loItem, "Disponible", toEntidad.TerminalesSmartLaposDetalle.oItem, "Disponible" )
			this.SetearAtributoModeloEnEntidad( loItem, "Sugerido", toEntidad.TerminalesSmartLaposDetalle.oItem, "Sugerido" )
			toEntidad.TerminalesSmartLaposDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleTarjetasSmartLaposDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "TarjetasSmartLaposDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"TarjetasSmartLaposDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.TarjetasSmartLaposDetalle.LimpiarItem()
			else
				try
					toEntidad.TarjetasSmartLaposDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.TarjetasSmartLaposDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoequivalencia", toEntidad.TarjetasSmartLaposDetalle.oItem, "CodigoEquivalencia" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.TarjetasSmartLaposDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.TarjetasSmartLaposDetalle.oItem, "Operadora_PK" )
			toEntidad.TarjetasSmartLaposDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePlanesSmartLaPosDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PlanesSmartLaPosDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PlanesSmartLaPosDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PlanesSmartLaPosDetalle.LimpiarItem()
			else
				try
					toEntidad.PlanesSmartLaPosDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PlanesSmartLaPosDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoplan", toEntidad.PlanesSmartLaPosDetalle.oItem, "CodigoPlan" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.PlanesSmartLaPosDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.PlanesSmartLaPosDetalle.oItem, "Operadora_PK" )
			toEntidad.PlanesSmartLaPosDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetalleTarjetasPosnetDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "TarjetasPosnetDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"TarjetasPosnetDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.TarjetasPosnetDetalle.LimpiarItem()
			else
				try
					toEntidad.TarjetasPosnetDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.TarjetasPosnetDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoequivalencia", toEntidad.TarjetasPosnetDetalle.oItem, "CodigoEquivalencia" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.TarjetasPosnetDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.TarjetasPosnetDetalle.oItem, "Operadora_PK" )
			toEntidad.TarjetasPosnetDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function SetearDetallePlanesPosnetDetalle( toEntidad as Object, toModeloEnRequest as Object ) as Void
		local lnI as Integer, loItem as Object, lnCantidad as Integer, loDetalle as Object 
		local loError as Exception
		loDetalle = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest, "PlanesPosnetDetalle" )
		lnCantidad = _Screen.DotNetBridge.ObtenerValorPropiedad( loDetalle, "Count" )
		for lnI = 1 to lnCantidad 
			loItem = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloEnRequest,"PlanesPosnetDetalle[" + transform( lnI -1 ) + "]" )
			lnNroItem = _Screen.DotNetBridge.ObtenerValorPropiedad( loItem ,"NroItem" )
			if isnull( lnNroItem )
				toEntidad.PlanesPosnetDetalle.LimpiarItem()
			else
				try
					toEntidad.PlanesPosnetDetalle.CargarItem( lnNroItem )
				Catch To loError
					toEntidad.PlanesPosnetDetalle.LimpiarItem()
				endtry 
			endif
			this.SetearAtributoModeloEnEntidad( loItem, "Codigoplan", toEntidad.PlanesPosnetDetalle.oItem, "CodigoPlan" )
			this.SetearAtributoModeloEnEntidad( loItem, "Descripcion", toEntidad.PlanesPosnetDetalle.oItem, "Descripcion" )
			this.SetearAtributoModeloEnEntidad( loItem, "Operadora", toEntidad.PlanesPosnetDetalle.oItem, "Operadora_PK" )
			toEntidad.PlanesPosnetDetalle.Actualizar()
			
		endfor
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoString( toModeloResponse, "Descripcion", toEntidad.Descripcion)
			this.SetearAtributoInteger( toModeloResponse, "NumeroTerminal", toEntidad.NumeroTerminal)
			this.SetearAtributoString( toModeloResponse, "Marca", toEntidad.Marca)
			this.SetearAtributoString( toModeloResponse, "Modelo", toEntidad.Modelo)
			this.SetearAtributoString( toModeloResponse, "ContactoSoporteTecnico", toEntidad.ContactoSoporteTecnico)
			this.SetearAtributoString( toModeloResponse, "TelefonoSoporteTecnico", toEntidad.TelefonoSoporteTecnico)
			this.SetearAtributo( toModeloResponse, "Integrado", toEntidad.Integrado)
			this.SetearAtributoString( toModeloResponse, "Prestador", toEntidad.Prestador)
			this.SetearAtributo( toModeloResponse, "PagoElectronico", toEntidad.PagoElectronico)
			this.SetearAtributoString( toModeloResponse, "Puerto", toEntidad.Puerto)
			this.SetearAtributoLong( toModeloResponse, "Paquete", toEntidad.Paquete)
			this.SetearAtributoLong( toModeloResponse, "TiempoMensaje", toEntidad.TiempoMensaje)
			this.SetearAtributoLong( toModeloResponse, "TiempoChequeo", toEntidad.TiempoChequeo)
			this.SetearAtributoLong( toModeloResponse, "TimeOutRecepcion", toEntidad.TimeOutRecepcion)
			this.SetearAtributoLong( toModeloResponse, "Shopping", toEntidad.Shopping)
			this.SetearAtributoLong( toModeloResponse, "Empresa", toEntidad.Empresa)
			this.SetearAtributoInteger( toModeloResponse, "Caja", toEntidad.Caja)
			this.SetearAtributo( toModeloResponse, "ImprimeSoloOriginal", toEntidad.ImprimeSoloOriginal)
			this.SetearAtributoLong( toModeloResponse, "NumeroComercio", toEntidad.NumeroComercio)
			this.SetearAtributoString( toModeloResponse, "NombreComercio", toEntidad.NombreComercio)
			this.SetearAtributoString( toModeloResponse, "CuitComercio", toEntidad.CuitComercio)
			this.SetearAtributo( toModeloResponse, "PermiteTransaccionesOffLine", toEntidad.PermiteTransaccionesOffLine)
			this.SetearAtributoInteger( toModeloResponse, "TiempoDeEspera", toEntidad.TiempoDeEspera)
			this.SetearAtributoInteger( toModeloResponse, "TiempoPorReintento", toEntidad.TiempoPorReintento)
			this.SetearAtributoString( toModeloResponse, "IdCliente", toEntidad.IdCliente)
			this.SetearAtributoString( toModeloResponse, "UsuarioMP", toEntidad.UsuarioMP)
			this.SetearAtributoString( toModeloResponse, "IdSecreto", toEntidad.IdSecreto)
			this.SetearAtributo( toModeloResponse, "BloquearCierreCajaOffline", toEntidad.BloquearCierreCajaOffline)
			this.SetearAtributoString( toModeloResponse, "IdPuestoQR", toEntidad.IdPuestoQR)
			this.SetearAtributoString( toModeloResponse, "LocalMP", toEntidad.LocalMP)
			this.SetearAtributoString( toModeloResponse, "IdStoreQR", toEntidad.IdStoreQR)
			this.SetearAtributoString( toModeloResponse, "CajaMP", toEntidad.CajaMP)
			this.SetearAtributoString( toModeloResponse, "Leyenda", toEntidad.Leyenda)
			this.SetearAtributo( toModeloResponse, "EnviaVentasSiTef", toEntidad.EnviaVentasSiTef)
			this.SetearAtributoString( toModeloResponse, "DireccionIP", toEntidad.DireccionIP)
			this.SetearAtributoString( toModeloResponse, "PuertoFiserv", toEntidad.PuertoFiserv)
			this.SetearAtributoString( toModeloResponse, "EmpresaFiServ", toEntidad.EmpresaFiServ)
			this.SetearAtributoString( toModeloResponse, "TerminalFiServ", toEntidad.TerminalFiServ)
			this.SetearAtributoString( toModeloResponse, "RutaCertificado", toEntidad.RutaCertificado)
			this.SetearAtributoString( toModeloResponse, "DispositivoFiServ", toEntidad.DispositivoFiServ)
			this.SetearAtributoString( toModeloResponse, "IDCloverDisp", toEntidad.IDCloverDisp)
			this.SetearAtributoString( toModeloResponse, "IPCloverDisp", toEntidad.IPCloverDisp)
			this.SetearAtributoString( toModeloResponse, "PuertoCloverDisp", toEntidad.PuertoCloverDisp)
			this.SetearAtributoString( toModeloResponse, "ModeloClover", toEntidad.ModeloClover)
			this.SetearAtributoString( toModeloResponse, "SerialClover", toEntidad.SerialClover)
			this.SetearAtributoString( toModeloResponse, "UsuarioSmartLapos", toEntidad.UsuarioSmartLapos)
			this.SetearAtributoString( toModeloResponse, "PassSmartLapos", toEntidad.PassSmartLapos)
			this.SetearAtributoString( toModeloResponse, "GuidBilleteraSantaFe", toEntidad.GuidBilleteraSantaFe)
			this.SetearAtributoString( toModeloResponse, "FraseBilleteraSantaFe", toEntidad.FraseBilleteraSantaFe)
			this.SetearAtributoString( toModeloResponse, "CajaBilleteraSantaFe", toEntidad.CajaBilleteraSantaFe)
			this.SetearAtributoString( toModeloResponse, "SucursalBilleteraSantaFe", toEntidad.SucursalBilleteraSantaFe)
			this.SetearAtributoString( toModeloResponse, "UrlBilleteraSantaFe", toEntidad.UrlBilleteraSantaFe)
			this.SetearAtributoString( toModeloResponse, "CryptoApiKey", toEntidad.CryptoApiKey)
			this.SetearAtributoString( toModeloResponse, "MailGoCuotas", toEntidad.MailGoCuotas)
			this.SetearAtributoString( toModeloResponse, "ClaveGoCuotas", toEntidad.ClaveGoCuotas)
			this.SetearAtributoInteger( toModeloResponse, "TiempoDeEsperaPosnet", toEntidad.TiempoDeEsperaPosnet)
			this.SetearAtributoString( toModeloResponse, "RutaArchivoINiPosnet", toEntidad.RutaArchivoINiPosnet)
			this.SetearAtributoInteger( toModeloResponse, "PreguntaTarjetaQR", toEntidad.PreguntaTarjetaQR)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.CargarColeccionModeloTarjetasLaPosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloPlanesLaPosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloDispositivoMovilPointDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloSerialPointDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloTarjetasFiServDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloTerminalesSmartLaposDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloTarjetasSmartLaposDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloPlanesSmartLaPosDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloTarjetasPosnetDetalle( toModeloResponse, toEntidad )
			this.CargarColeccionModeloPlanesPosnetDetalle( toModeloResponse, toEntidad )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloTarjetasLaPosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "TarjetasLaPosDetalle" ) 
		with toEntidad
			for lnI = 1 to .TarjetasLaPosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTarjetaslapos" )
				this.SetearAtributoString( loItem, "Codigo", .TarjetasLaPosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoEquivalencia", .TarjetasLaPosDetalle.Item(lnI).CodigoEquivalencia)
				this.SetearAtributoString( loItem, "Descripcion", .TarjetasLaPosDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .TarjetasLaPosDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoLong( loItem, "NumeroComercio", .TarjetasLaPosDetalle.Item(lnI).NumeroComercio)
				this.SetearAtributoInteger( loItem, "NroItem", .TarjetasLaPosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPlanesLaPosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PlanesLaPosDetalle" ) 
		with toEntidad
			for lnI = 1 to .PlanesLaPosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPlaneslapos" )
				this.SetearAtributoString( loItem, "Codigo", .PlanesLaPosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoPlan", .PlanesLaPosDetalle.Item(lnI).CodigoPlan)
				this.SetearAtributoString( loItem, "Descripcion", .PlanesLaPosDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .PlanesLaPosDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .PlanesLaPosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloDispositivoMovilPointDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "DispositivoMovilPointDetalle" ) 
		with toEntidad
			for lnI = 1 to .DispositivoMovilPointDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemDispmovilpoint" )
				this.SetearAtributoString( loItem, "Codigo", .DispositivoMovilPointDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "DispositivoMovil", .DispositivoMovilPointDetalle.Item(lnI).DispositivoMovil)
				this.SetearAtributo( loItem, "Disponible", .DispositivoMovilPointDetalle.Item(lnI).Disponible)
				this.SetearAtributo( loItem, "Sugerido", .DispositivoMovilPointDetalle.Item(lnI).Sugerido)
				this.SetearAtributo( loItem, "VinculacionPDV", .DispositivoMovilPointDetalle.Item(lnI).VinculacionPDV)
				this.SetearAtributoInteger( loItem, "NroItem", .DispositivoMovilPointDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloSerialPointDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "SerialPointDetalle" ) 
		with toEntidad
			for lnI = 1 to .SerialPointDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemSerialpoint" )
				this.SetearAtributoString( loItem, "Codigo", .SerialPointDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Serial", .SerialPointDetalle.Item(lnI).Serial)
				this.SetearAtributoInteger( loItem, "NroItem", .SerialPointDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloTarjetasFiServDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "TarjetasFiServDetalle" ) 
		with toEntidad
			for lnI = 1 to .TarjetasFiServDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTarjetasfiserv" )
				this.SetearAtributoString( loItem, "Codigo", .TarjetasFiServDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoEquivalencia", .TarjetasFiServDetalle.Item(lnI).CodigoEquivalencia)
				this.SetearAtributoString( loItem, "Descripcion", .TarjetasFiServDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .TarjetasFiServDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .TarjetasFiServDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloTerminalesSmartLaposDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "TerminalesSmartLaposDetalle" ) 
		with toEntidad
			for lnI = 1 to .TerminalesSmartLaposDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTerminaleslapos" )
				this.SetearAtributoString( loItem, "Codigo", .TerminalesSmartLaposDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "Terminal", .TerminalesSmartLaposDetalle.Item(lnI).Terminal)
				this.SetearAtributo( loItem, "Disponible", .TerminalesSmartLaposDetalle.Item(lnI).Disponible)
				this.SetearAtributo( loItem, "Sugerido", .TerminalesSmartLaposDetalle.Item(lnI).Sugerido)
				this.SetearAtributoInteger( loItem, "NroItem", .TerminalesSmartLaposDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloTarjetasSmartLaposDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "TarjetasSmartLaposDetalle" ) 
		with toEntidad
			for lnI = 1 to .TarjetasSmartLaposDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTarjetassmartlapos" )
				this.SetearAtributoString( loItem, "Codigo", .TarjetasSmartLaposDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoEquivalencia", .TarjetasSmartLaposDetalle.Item(lnI).CodigoEquivalencia)
				this.SetearAtributoString( loItem, "Descripcion", .TarjetasSmartLaposDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .TarjetasSmartLaposDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .TarjetasSmartLaposDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPlanesSmartLaPosDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PlanesSmartLaPosDetalle" ) 
		with toEntidad
			for lnI = 1 to .PlanesSmartLaPosDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPlanessmartlapos" )
				this.SetearAtributoString( loItem, "Codigo", .PlanesSmartLaPosDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoPlan", .PlanesSmartLaPosDetalle.Item(lnI).CodigoPlan)
				this.SetearAtributoString( loItem, "Descripcion", .PlanesSmartLaPosDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .PlanesSmartLaPosDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .PlanesSmartLaPosDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloTarjetasPosnetDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "TarjetasPosnetDetalle" ) 
		with toEntidad
			for lnI = 1 to .TarjetasPosnetDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemTarjetasposnet" )
				this.SetearAtributoString( loItem, "Codigo", .TarjetasPosnetDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoEquivalencia", .TarjetasPosnetDetalle.Item(lnI).CodigoEquivalencia)
				this.SetearAtributoString( loItem, "Descripcion", .TarjetasPosnetDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .TarjetasPosnetDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .TarjetasPosnetDetalle.Item(lnI).NroItem )
				_Screen.DotNetBridge.InvocarMetodo( loColeccionModelo, "Add", loItem) 
			endfor
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarColeccionModeloPlanesPosnetDetalle( toModeloResponse as Object, toEntidad as Object ) as Void
		local lnI as Integer, loColeccionModelo as Object
		loColeccionModelo = _Screen.DotNetBridge.ObtenerValorPropiedad( toModeloResponse, "PlanesPosnetDetalle" ) 
		with toEntidad
			for lnI = 1 to .PlanesPosnetDetalle.Count
				loItem = _Screen.DotNetBridge.CrearObjeto( this.cNamespaceDTOs + ".ItemPlanesposnet" )
				this.SetearAtributoString( loItem, "Codigo", .PlanesPosnetDetalle.Item(lnI).Codigo)
				this.SetearAtributoString( loItem, "CodigoPlan", .PlanesPosnetDetalle.Item(lnI).CodigoPlan)
				this.SetearAtributoString( loItem, "Descripcion", .PlanesPosnetDetalle.Item(lnI).Descripcion)
				this.SetearAtributoString( loItem, "Operadora", .PlanesPosnetDetalle.Item(lnI).Operadora_PK)
				this.SetearAtributoInteger( loItem, "NroItem", .PlanesPosnetDetalle.Item(lnI).NroItem )
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
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeroterminal", "NROTERMI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Marca", "MARCA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modelo", "MODELO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Contactosoportetecnico", "CONTACTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefonosoportetecnico", "TELSOPORTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Integrado", "INTEGRADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Prestador", "PRESTADOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pagoelectronico", "PAGOELEC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puerto", "PUERTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Paquete", "TPAQUETE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiempomensaje", "TMENSAJE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiempochequeo", "TCHEQUEO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Timeoutrecepcion", "TIMEOUTREC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Shopping", "CODSHOP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Empresa", "CODEMPRE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Caja", "NROCAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Imprimesolooriginal", "IMPORIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomercio", "NUMCOMER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombrecomercio", "NOMCOMER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuitcomercio", "CUITCOMER")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Permitetransaccionesoffline", "PERMITEOFF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiempodeespera", "TIEMPOESP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiempoporreintento", "TIEMPOREIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idcliente", "IDCLIENTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuariomp", "USUARIOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idsecreto", "IDSECRETO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Bloquearcierrecajaoffline", "BLOQCIEOFF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idpuestoqr", "PUESTOQR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Localmp", "LOCALMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idstoreqr", "STOREQR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cajamp", "CAJAMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Leyenda", "LEYENDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Enviaventassitef", "ENVSITEF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Direccionip", "FISERVIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puertofiserv", "FISERVPORT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Empresafiserv", "FISERVEMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Terminalfiserv", "FISERVTERM")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutacertificado", "FISERVCERT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dispositivofiserv", "DISPFISERV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idcloverdisp", "CLOVERID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ipcloverdisp", "CLOVERIP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puertocloverdisp", "CLOVERPORT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Modeloclover", "CLOVERMOD")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serialclover", "SERIALCLOV")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Usuariosmartlapos", "IDSMARTL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Passsmartlapos", "PASSSMARTL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Guidbilleterasantafe", "GUIDSTAFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Frasebilleterasantafe", "FRASESTAFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cajabilleterasantafe", "CAJASTAFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Sucursalbilleterasantafe", "SUCSTAFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Urlbilleterasantafe", "URLSTAFE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cryptoapikey", "CRYPTOKEY")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailgocuotas", "MAILGOCUOT")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clavegocuotas", "CLAVEGOCUO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiempodeesperaposnet", "TIMEESPPOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Rutaarchivoiniposnet", "RUTAINI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Preguntatarjetaqr", "PREGTARQR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
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
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Marca LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Modelo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Contacto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Telsoporte LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Prestador LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Puerto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nomcomer LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cuitcomer LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idcliente LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Usuariomp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idsecreto LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Puestoqr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Localmp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Storeqr LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cajamp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Leyenda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fiservip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fiservport LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fiservemp LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fiservterm LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Fiservcert LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Dispfiserv LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cloverid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cloverip LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cloverport LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clovermod LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serialclov LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idsmartl LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Passsmartl LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Guidstafe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Frasestafe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cajastafe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Sucstafe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Urlstafe LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Cryptokey LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mailgocuot LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clavegocuo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Rutaini LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine