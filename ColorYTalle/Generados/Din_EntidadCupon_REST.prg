
define class Din_EntidadCupon_REST as ServicioRestOperacionesEntidad of ServicioRestOperacionesEntidad.prg

	cNamespaceDTOs = "ZooLogicSA.OrganicServiciosREST.Colorytalle.Generados.DTO.Cupon"
	cClaseResponse = this.cNamespaceDTOs + ".CuponResponse"
	cClaseModelo = "CuponModelo"
	cEntidad = "Cupon"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponModelo"
			case tcOperacion == "Eliminar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Modificar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponModelo"
			case tcOperacion == "Mostrar"
				lcRetorno = "ZooLogicSA.OrganicServiciosREST.DTO.Base.MostrarBase"
			case tcOperacion == "Listar"
				lcRetorno = this.cNamespaceDTOs + "." + "CuponListarRequest"
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
				lcRetorno = this.cNamespaceDTOs + "." + "CuponListarResponse"
			otherwise
				lcRetorno = this.cNamespaceDTOs + "." + "CuponModelo"
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
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventa", toEntidad, "Puntodeventa" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerointerno", toEntidad, "Numerointerno" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ticketicard", toEntidad, "Ticketicard" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Observacion", toEntidad, "Observacion" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocomprobante", toEntidad, "Tipocomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letracomprobante", toEntidad, "Letracomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventacomprobante", toEntidad, "Puntodeventacomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomprobante", toEntidad, "Numerocomprobante" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacomprobante", toEntidad, "Fechacomprobante" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatos", toEntidad, "Basededatos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serieorigen", toEntidad, "Serieorigen" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cliente", toEntidad, "Cliente_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipocupon", toEntidad, "Tipocupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocupon", toEntidad, "Numerocupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Lote", toEntidad, "Lote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizacionpos", toEntidad, "Autorizacionpos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Esretiroefectivo", toEntidad, "Esretiroefectivo" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacupon", toEntidad, "Fechacupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horacupon", toEntidad, "Horacupon" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Monto", toEntidad, "Monto" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idpagoclover", toEntidad, "Idpagoclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idordenclover", toEntidad, "Idordenclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Externalidclover", toEntidad, "Externalidclover" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Idsmartlapos", toEntidad, "Idsmartlapos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Mailgocuotas", toEntidad, "Mailgocuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerodecuponafectado", toEntidad, "Numerodecuponafectado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Loteafectado", toEntidad, "Loteafectado" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechadecuponafectado", toEntidad, "Fechadecuponafectado" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocierredelote", toEntidad, "Numerocierredelote" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechacierredelote", toEntidad, "Fechacierredelote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horacierredelote", toEntidad, "Horacierredelote" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nombretitular", toEntidad, "Nombretitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipodocumentotitular", toEntidad, "Tipodocumentotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Nrodocumentotitular", toEntidad, "Nrodocumentotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Telefonotitular", toEntidad, "Telefonotitular" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tiponotadecredito", toEntidad, "Tiponotadecredito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letranotadecredito", toEntidad, "Letranotadecredito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventanotadecredito", toEntidad, "Puntodeventanotadecredito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numeronotadecredito", toEntidad, "Numeronotadecredito" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechanotadecredito", toEntidad, "Fechanotadecredito" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Letracanje", toEntidad, "Letracanje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Puntodeventacanje", toEntidad, "Puntodeventacanje" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerodecanje", toEntidad, "Numerodecanje" )
			this.SetearAtributoModeloDateTimeEnEntidad( toModeloEnRequest, "Fechabaja", toEntidad, "Fechabaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Horabaja", toEntidad, "Horabaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Basededatosbaja", toEntidad, "Basededatosbaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Seriebaja", toEntidad, "Seriebaja" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Valor", toEntidad, "Valor_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Tipotarjeta", toEntidad, "Tipotarjeta" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Cuotas", toEntidad, "Cuotas" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Ultimosdigitos", toEntidad, "Ultimosdigitos" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Simbolomonetario", toEntidad, "Simbolomonetario_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizaciontelefonica", toEntidad, "Autorizaciontelefonica" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Autorizaciontelefonicaoffline", toEntidad, "Autorizaciontelefonicaoffline" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Numerocomercio", toEntidad, "Numerocomercio" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Pos", toEntidad, "Pos_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Entidadfinanciera", toEntidad, "Entidadfinanciera_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Clasedetarjeta", toEntidad, "Clasedetarjeta_PK" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Codigoplan", toEntidad, "Codigoplan" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Serial", toEntidad, "Serial" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Dispositivomovil", toEntidad, "Dispositivomovil" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Referenciaexterna", toEntidad, "Referenciaexterna" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Qrtransactionidposnet", toEntidad, "Qrtransactionidposnet" )
			this.SetearAtributoModeloEnEntidad( toModeloEnRequest, "Qrtranfdebinidposnet", toEntidad, "Qrtranfdebinidposnet" )
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function CargarModeloResponse( toModeloResponse as Object, toEntidad as Object ) as Void
		with toModeloResponse
			this.CargarAtributosFW(toModeloResponse, toEntidad )
			this.SetearAtributoString( toModeloResponse, "Codigo", toEntidad.Codigo)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVenta", toEntidad.PuntoDeVenta)
			this.SetearAtributoInteger( toModeloResponse, "NumeroInterno", toEntidad.NumeroInterno)
			this.SetearAtributo( toModeloResponse, "TicketICard", toEntidad.TicketICard)
			this.SetearAtributo( toModeloResponse, "Observacion", toEntidad.Observacion)
			this.SetearAtributoInteger( toModeloResponse, "TipoComprobante", toEntidad.TipoComprobante)
			this.SetearAtributoString( toModeloResponse, "LetraComprobante", toEntidad.LetraComprobante)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaComprobante", toEntidad.PuntoDeVentaComprobante)
			this.SetearAtributoInteger( toModeloResponse, "NumeroComprobante", toEntidad.NumeroComprobante)
			this.SetearAtributoDateTime( toModeloResponse, "FechaComprobante", toEntidad.FechaComprobante)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatos", toEntidad.BaseDeDatos)
			this.SetearAtributoString( toModeloResponse, "SerieOrigen", toEntidad.SerieOrigen)
			this.SetearAtributoString( toModeloResponse, "Cliente", toEntidad.Cliente_PK)
			this.SetearAtributoString( toModeloResponse, "TipoCupon", toEntidad.TipoCupon)
			this.SetearAtributoLong( toModeloResponse, "NumeroCupon", toEntidad.NumeroCupon)
			this.SetearAtributoInteger( toModeloResponse, "Lote", toEntidad.Lote)
			this.SetearAtributo( toModeloResponse, "AutorizacionPOS", toEntidad.AutorizacionPOS)
			this.SetearAtributo( toModeloResponse, "EsRetiroEfectivo", toEntidad.EsRetiroEfectivo)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCupon", toEntidad.FechaCupon)
			this.SetearAtributoString( toModeloResponse, "HoraCupon", toEntidad.HoraCupon)
			this.SetearAtributoDecimal( toModeloResponse, "Monto", toEntidad.Monto)
			this.SetearAtributoString( toModeloResponse, "IdPagoClover", toEntidad.IdPagoClover)
			this.SetearAtributoString( toModeloResponse, "IdOrdenClover", toEntidad.IdOrdenClover)
			this.SetearAtributoString( toModeloResponse, "ExternalIdClover", toEntidad.ExternalIdClover)
			this.SetearAtributoString( toModeloResponse, "IdSmartLaPos", toEntidad.IdSmartLaPos)
			this.SetearAtributoString( toModeloResponse, "mailGoCuotas", toEntidad.mailGoCuotas)
			this.SetearAtributoLong( toModeloResponse, "NumeroDeCuponAfectado", toEntidad.NumeroDeCuponAfectado)
			this.SetearAtributoInteger( toModeloResponse, "LoteAfectado", toEntidad.LoteAfectado)
			this.SetearAtributoDateTime( toModeloResponse, "FechaDeCuponAfectado", toEntidad.FechaDeCuponAfectado)
			this.SetearAtributoInteger( toModeloResponse, "NumeroCierreDeLote", toEntidad.NumeroCierreDeLote)
			this.SetearAtributoDateTime( toModeloResponse, "FechaCierreDeLote", toEntidad.FechaCierreDeLote)
			this.SetearAtributoString( toModeloResponse, "HoraCierreDeLote", toEntidad.HoraCierreDeLote)
			this.SetearAtributoString( toModeloResponse, "NombreTitular", toEntidad.NombreTitular)
			this.SetearAtributoString( toModeloResponse, "TipoDocumentoTitular", toEntidad.TipoDocumentoTitular)
			this.SetearAtributoString( toModeloResponse, "NroDocumentoTitular", toEntidad.NroDocumentoTitular)
			this.SetearAtributoString( toModeloResponse, "TelefonoTitular", toEntidad.TelefonoTitular)
			this.SetearAtributoInteger( toModeloResponse, "TipoNotadeCredito", toEntidad.TipoNotadeCredito)
			this.SetearAtributoString( toModeloResponse, "LetraNotadeCredito", toEntidad.LetraNotadeCredito)
			this.SetearAtributoInteger( toModeloResponse, "PuntodeVentaNotadeCredito", toEntidad.PuntodeVentaNotadeCredito)
			this.SetearAtributoInteger( toModeloResponse, "NumeroNotadeCredito", toEntidad.NumeroNotadeCredito)
			this.SetearAtributoDateTime( toModeloResponse, "FechaNotadeCredito", toEntidad.FechaNotadeCredito)
			this.SetearAtributoString( toModeloResponse, "LetraCanje", toEntidad.LetraCanje)
			this.SetearAtributoInteger( toModeloResponse, "PuntoDeVentaCanje", toEntidad.PuntoDeVentaCanje)
			this.SetearAtributoInteger( toModeloResponse, "NumeroDeCanje", toEntidad.NumeroDeCanje)
			this.SetearAtributoDateTime( toModeloResponse, "FechaBaja", toEntidad.FechaBaja)
			this.SetearAtributoString( toModeloResponse, "HoraBaja", toEntidad.HoraBaja)
			this.SetearAtributoString( toModeloResponse, "BaseDeDatosBaja", toEntidad.BaseDeDatosBaja)
			this.SetearAtributoString( toModeloResponse, "SerieBaja", toEntidad.SerieBaja)
			this.SetearAtributoString( toModeloResponse, "Valor", toEntidad.Valor_PK)
			this.SetearAtributoString( toModeloResponse, "TipoTarjeta", toEntidad.TipoTarjeta)
			this.SetearAtributoInteger( toModeloResponse, "Cuotas", toEntidad.Cuotas)
			this.SetearAtributoString( toModeloResponse, "UltimosDigitos", toEntidad.UltimosDigitos)
			this.SetearAtributoString( toModeloResponse, "SimboloMonetario", toEntidad.SimboloMonetario_PK)
			this.SetearAtributoString( toModeloResponse, "AutorizacionTelefonica", toEntidad.AutorizacionTelefonica)
			this.SetearAtributoInteger( toModeloResponse, "AutorizacionTelefonicaOffLine", toEntidad.AutorizacionTelefonicaOffLine)
			this.SetearAtributoString( toModeloResponse, "NumeroComercio", toEntidad.NumeroComercio)
			this.SetearAtributoString( toModeloResponse, "POS", toEntidad.POS_PK)
			this.SetearAtributoString( toModeloResponse, "EntidadFinanciera", toEntidad.EntidadFinanciera_PK)
			this.SetearAtributoString( toModeloResponse, "ClaseDeTarjeta", toEntidad.ClaseDeTarjeta_PK)
			this.SetearAtributoString( toModeloResponse, "CodigoPlan", toEntidad.CodigoPlan)
			this.SetearAtributoString( toModeloResponse, "Serial", toEntidad.Serial)
			this.SetearAtributoString( toModeloResponse, "DispositivoMovil", toEntidad.DispositivoMovil)
			this.SetearAtributoString( toModeloResponse, "ReferenciaExterna", toEntidad.ReferenciaExterna)
			this.SetearAtributoString( toModeloResponse, "QRTransactionIDPosnet", toEntidad.QRTransactionIDPosnet)
			this.SetearAtributoString( toModeloResponse, "QRTranfDebinIDPosnet", toEntidad.QRTranfDebinIDPosnet)
		endwith
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerFiltroSegunModeloRequest( toModeloRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcFiltro = "1=1"
		
		lcFiltro = this.AgregarCondicionesFWAFiltro( lcFiltro, toModeloRequest )
		
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventa", "PTOVENTA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerointerno", "NROINTERNO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ticketicard", "CONVERT( VARCHAR(MAX), TXTICARD)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Observacion", "CONVERT( VARCHAR(MAX), OBS)")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocomprobante", "COMPTIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letracomprobante", "LETRA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventacomprobante", "PTOVEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomprobante", "NUMCOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacomprobante", "FECHACOMP")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatos", "BASEDATOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serieorigen", "SERIE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cliente", "CODCLI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipocupon", "TIPO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocupon", "NUMERO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Lote", "LOTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Autorizacionpos", "AUTORIZADO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Esretiroefectivo", "ESRETIROEF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacupon", "FECHA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horacupon", "HORA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Monto", "MONTO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idpagoclover", "IDPAGO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idordenclover", "IDORDEN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Externalidclover", "EXTID")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Idsmartlapos", "IDLAPOS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Mailgocuotas", "MAILGC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerodecuponafectado", "NUMAFDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Loteafectado", "LOTAFDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechadecuponafectado", "FECAFDO")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocierredelote", "NROCL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechacierredelote", "FCIELOTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horacierredelote", "HCIELOTE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nombretitular", "NOMTITULAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipodocumentotitular", "TIPDOCTITU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Nrodocumentotitular", "NRODOCTITU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Telefonotitular", "TELTITU")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tiponotadecredito", "TIPONC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letranotadecredito", "LETRANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventanotadecredito", "PVENTANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numeronotadecredito", "NUMERONC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechanotadecredito", "FECHANC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Letracanje", "LETRAC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Puntodeventacanje", "PTOVENC")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerodecanje", "NCANJE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Fechabaja", "FBAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Horabaja", "HBAJA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Basededatosbaja", "BASEDATOSB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Seriebaja", "SERIEB")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Valor", "VALOR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Tipotarjeta", "TIPOTARJ")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Cuotas", "CUOTAS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Ultimosdigitos", "ULTDIG")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Simbolomonetario", "MONEDA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Autorizaciontelefonica", "AUTTEL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Autorizaciontelefonicaoffline", "AUTOFFLINE")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Numerocomercio", "NROCOMERCI")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Pos", "POS")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Entidadfinanciera", "ENTFIN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Clasedetarjeta", "CLATAR")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Codigoplan", "CODPLAN")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Serial", "SERIAL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Dispositivomovil", "MOVIL")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Referenciaexterna", "REFEXTERNA")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Qrtransactionidposnet", "QRIDTRANF")
		lcFiltro = this.AgregarCondicionAFiltro( lcFiltro, toModeloRequest, "Qrtranfdebinidposnet", "QRIDDEB")
		return lcFiltro 
	endfunc
	
	*-----------------------------------------------------------------------------------------
	protected function ObtenerBusquedaSegunModeloRequest( toRequest as Object ) as String
		local lcCampos as String, lcFiltro as String, loModeloRequest as Object, lcOrden as String, lcXml as String, lnI as Integer, lcOrderBy
		
		lcRetorno = ""
		lcExpresionBusqueda = _screen.DotNetBridge.ObtenerValorPropiedad( toRequest, "ExpresionBusqueda" )
		
		if !isnull( lcExpresionBusqueda )
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Txticard LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Obs LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letra LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basedatos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serie LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codcli LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipo LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hora LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idpago LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idorden LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Extid LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Idlapos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Mailgc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hcielote LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nomtitular LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipdoctitu LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nrodoctitu LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Teltitu LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letranc LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Letrac LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Hbaja LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Basedatosb LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serieb LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Valor LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Tipotarj LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Ultdig LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Moneda LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Auttel LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Nrocomerci LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Pos LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Entfin LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Clatar LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Codplan LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Serial LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Movil LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Refexterna LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Qridtranf LIKE '%" + lcExpresionBusqueda + "%'"
			lcRetorno = iif( !empty( lcRetorno ), lcRetorno + " OR ", "" ) + "Qriddeb LIKE '%" + lcExpresionBusqueda + "%'"
		endif
	
		return lcRetorno 
	endfunc
	

enddefine