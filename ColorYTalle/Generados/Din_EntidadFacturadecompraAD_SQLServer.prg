
define class Din_EntidadFACTURADECOMPRAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FACTURADECOMPRA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( NumInt, 10, 0) + str( TipoComprobante, 2, 0)]
	cExpresionCCPorCampos = [str( #tabla#.NumInt, 10, 0) + str( #tabla#.FACTTIPO, 2, 0)]
	cTagClaveCandidata = '_FDCCC'
	cTagClavePk = '_FDCPK'
	cTablaPrincipal = 'FACCOMPRA'
	cCampoCodigoWH = 'CODIGO'
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		local loError as Exception, loEx as Exception

		dodefault()

		with this
			.cArchivoLogPrueba = SYS(0) + '_' + transform( date() ) + '_' + strtran( time(), ':', '.' ) + '_' + transform( golibrerias.obtenertimestamp() ) + '.txt' 
			.cArchivoLogPrueba = strtran( strtran( strtran( .cArchivoLogPrueba, '/', '-' ), ' ', '' ), '#', '' )
			.ColSentencias = _screen.zoo.crearobjeto('zooColeccion')
				.cUbicacionDB = ''
				.cTipoDB = 'SQLSERVER'
				.cEsquema = 'ZooLogic'
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Destroy() as boolean

		with this
		endwith

		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Insertar() as boolean

		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string
		this.GrabarNumeraciones()

		with this.oEntidad
			local  lxFaccompraFmodifw, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFecimpo, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraBdmodifw, lxFaccompraBdaltafw, lxFaccompraEsttrans, lxFaccompraFhora, lxFaccompraUaltafw, lxFaccompraSmodifw, lxFaccompraUmodifw, lxFaccompraValtafw, lxFaccompraZadsfw, lxFaccompraVmodifw, lxFaccompraDescfw, lxFaccompraSaltafw, lxFaccompraSimbmon, lxFaccompraHoraimpo, lxFaccompraHoraexpo, lxFaccompraHaltafw, lxFaccompraHmodifw, lxFaccompraTotalcant, lxFaccompraTimestamp, lxFaccompraDesmntosi2, lxFaccompraSubtotcisi, lxFaccompraSubtotsisi, lxFaccompraSignomov, lxFaccompraFacttipo, lxFaccompraCondivalp, lxFaccompraDesmntosi1, lxFaccompraSitfiscpro, lxFaccompraRecmntosi, lxFaccompraFsubtot, lxFaccompraFsubton, lxFaccompraRecmntosi1, lxFaccompraDesmntosi, lxFaccompraRecmntosi2, lxFaccompraAnulado, lxFaccompraFcompfis, lxFaccompraDesauto, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraFobs, lxFaccompraFmtdes2, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfch, lxFaccompraFfchfac, lxFaccompraFmtdes3, lxFaccompraDesmntosi3, lxFaccompraImpman, lxFaccompraFletra, lxFaccompraRecpor, lxFaccompraTotdescsi, lxFaccompraFptovenext, lxFaccompraMr, lxFaccompraCotiz, lxFaccompraCondpago, lxFaccompraFnumcomp, lxFaccompraFfchvenc, lxFaccompraRecmnto, lxFaccompraRecmnto1, lxFaccompraFvuelto, lxFaccompraFptoven, lxFaccompraNcai, lxFaccompraRecmnto2, lxFaccompraMoneda, lxFaccompraFperson, lxFaccompraCcosto, lxFaccompraFvtocai, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraCodlista, lxFaccompraNroremito, lxFaccompraTotimpue, lxFaccompraTotrecar, lxFaccompraTotrecarsi, lxFaccompraTotdesc
				lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraFhora =  .Hora			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraAnulado =  .Anulado			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfch =  .Fecha			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFletra =  .Letra			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraMr =  .Recargomonto			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraFnumcomp =  .Numero			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraNroremito =  .Remito			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxFaccompraCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.FACCOMPRA ( "Fmodifw","Faltafw","Fecexpo","Fectrans","Fecimpo","Fd2","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Numint","Bdmodifw","Bdaltafw","Esttrans","Fhora","Ualtafw","Smodifw","Umodifw","Valtafw","Zadsfw","Vmodifw","Descfw","Saltafw","Simbmon","Horaimpo","Horaexpo","Haltafw","Hmodifw","Totalcant","Timestamp","Desmntosi2","Subtotcisi","Subtotsisi","Signomov","Facttipo","Condivalp","Desmntosi1","Sitfiscpro","Recmntosi","Fsubtot","Fsubton","Recmntosi1","Desmntosi","Recmntosi2","Anulado","Fcompfis","Desauto","Idvuelto","Monsis","Fobs","Fmtdes2","Fmtdes1","Fdescu","Fimpuesto","Tcrg1361","Codigo","Ffch","Ffchfac","Fmtdes3","Desmntosi3","Impman","Fletra","Recpor","Totdescsi","Fptovenext","Mr","Cotiz","Condpago","Fnumcomp","Ffchvenc","Recmnto","Recmnto1","Fvuelto","Fptoven","Ncai","Recmnto2","Moneda","Fperson","Ccosto","Fvtocai","Ftotal","Recmonto1","Recmonto2","Disccos","Codlista","Nroremito","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'" >>, <<lxFaccompraIdcaja >>, <<lxFaccompraFpodes1 >>, <<lxFaccompraFpodes2 >>, <<lxFaccompraFpodes >>, <<lxFaccompraFturno >>, <<lxFaccompraNumint >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'" >>, <<lxFaccompraTotalcant >>, <<lxFaccompraTimestamp >>, <<lxFaccompraDesmntosi2 >>, <<lxFaccompraSubtotcisi >>, <<lxFaccompraSubtotsisi >>, <<lxFaccompraSignomov >>, <<lxFaccompraFacttipo >>, <<lxFaccompraCondivalp >>, <<lxFaccompraDesmntosi1 >>, <<lxFaccompraSitfiscpro >>, <<lxFaccompraRecmntosi >>, <<lxFaccompraFsubtot >>, <<lxFaccompraFsubton >>, <<lxFaccompraRecmntosi1 >>, <<lxFaccompraDesmntosi >>, <<lxFaccompraRecmntosi2 >>, <<iif( lxFaccompraAnulado, 1, 0 ) >>, <<iif( lxFaccompraFcompfis, 1, 0 ) >>, <<iif( lxFaccompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'" >>, <<lxFaccompraFmtdes2 >>, <<lxFaccompraFmtdes1 >>, <<lxFaccompraFdescu >>, <<lxFaccompraFimpuesto >>, <<lxFaccompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'" >>, <<lxFaccompraFmtdes3 >>, <<lxFaccompraDesmntosi3 >>, <<iif( lxFaccompraImpman, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'" >>, <<lxFaccompraRecpor >>, <<lxFaccompraTotdescsi >>, <<lxFaccompraFptovenext >>, <<lxFaccompraMr >>, <<lxFaccompraCotiz >>, <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'" >>, <<lxFaccompraFnumcomp >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'" >>, <<lxFaccompraRecmnto >>, <<lxFaccompraRecmnto1 >>, <<lxFaccompraFvuelto >>, <<lxFaccompraFptoven >>, <<lxFaccompraNcai >>, <<lxFaccompraRecmnto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'" >>, <<lxFaccompraFtotal >>, <<lxFaccompraRecmonto1 >>, <<lxFaccompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'" >>, <<lxFaccompraTotimpue >>, <<lxFaccompraTotrecar >>, <<lxFaccompraTotrecarsi >>, <<lxFaccompraTotdesc >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxIdorigen = loItem.Idorigen
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","IdItem","FAMate","afe_Cod","AfeTS","MNTPRECCI","APorcIvaC","ArtPercep","MNTPTOT","ACondIvaC","AfeCANT","AfeSaldo","MNTPRECSI","MNDESSI","AjuCImp","FBruto","MNDESCI","MNPDSI","MNTPDESCI","MNTPDESSI","AfeTipoCom","MNTPPER","AfeNroItem","AjuSImp","NroItem","FNETO","FX2","FmtoIVA","FporCFI","FmtoCFI","FmtoDTO1","FCFITot","COMP","FKIT","iditemOrig","FporDTO1","fporIva","ciditem","FN11","Prunsinimp","FPRUN","prunconimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","CCOSTO","DCCOSTO","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_porcentajeivacompras>>, <<lxPercepcionivarg5329>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_cantidad>>, <<lxAfe_saldo>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_nroitem>>, <<lxAjusteporredondeosinimpuestos>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxIdorigen>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxNroitem = lnContadorNroItem
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("TipoI","codint","NroItem","minoimp","porcen","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<lxNroitem>>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			this.AntesEndTransaction()
			this.VerificarInsercionUnicidadAntesDelCommit( lxValorClavePrimaria )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			this.FinalDeTransaction()
		
			lnI = this.nReintentos
		
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar grabar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar grabar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
			.ActualizarNumeraciones()
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Grabacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
			.ActualizarNumeraciones()
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxFaccompraTimestamp
		endwith

		endfor
		
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarUnicidad() as void
		local lcError as string
		lcError = ''
		If this.ConsultarPorClavePrimaria()
			lcError = this.oEntidad.ReasignarValorSugeridoEnCasoDeConcurrencia()
		else
			If this.ConsultarPorClaveCandidata()
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
			endif
		endif
		if !empty( lcError )
			goServicios.Errores.LevantarExcepcionTexto( lcError )
		endif
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			this.GenerarSentenciasComponentes()
			if .lAnular
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxFaccompraFmodifw, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFecimpo, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraBdmodifw, lxFaccompraBdaltafw, lxFaccompraEsttrans, lxFaccompraFhora, lxFaccompraUaltafw, lxFaccompraSmodifw, lxFaccompraUmodifw, lxFaccompraValtafw, lxFaccompraZadsfw, lxFaccompraVmodifw, lxFaccompraDescfw, lxFaccompraSaltafw, lxFaccompraSimbmon, lxFaccompraHoraimpo, lxFaccompraHoraexpo, lxFaccompraHaltafw, lxFaccompraHmodifw, lxFaccompraTotalcant, lxFaccompraTimestamp, lxFaccompraDesmntosi2, lxFaccompraSubtotcisi, lxFaccompraSubtotsisi, lxFaccompraSignomov, lxFaccompraFacttipo, lxFaccompraCondivalp, lxFaccompraDesmntosi1, lxFaccompraSitfiscpro, lxFaccompraRecmntosi, lxFaccompraFsubtot, lxFaccompraFsubton, lxFaccompraRecmntosi1, lxFaccompraDesmntosi, lxFaccompraRecmntosi2, lxFaccompraAnulado, lxFaccompraFcompfis, lxFaccompraDesauto, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraFobs, lxFaccompraFmtdes2, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfch, lxFaccompraFfchfac, lxFaccompraFmtdes3, lxFaccompraDesmntosi3, lxFaccompraImpman, lxFaccompraFletra, lxFaccompraRecpor, lxFaccompraTotdescsi, lxFaccompraFptovenext, lxFaccompraMr, lxFaccompraCotiz, lxFaccompraCondpago, lxFaccompraFnumcomp, lxFaccompraFfchvenc, lxFaccompraRecmnto, lxFaccompraRecmnto1, lxFaccompraFvuelto, lxFaccompraFptoven, lxFaccompraNcai, lxFaccompraRecmnto2, lxFaccompraMoneda, lxFaccompraFperson, lxFaccompraCcosto, lxFaccompraFvtocai, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraCodlista, lxFaccompraNroremito, lxFaccompraTotimpue, lxFaccompraTotrecar, lxFaccompraTotrecarsi, lxFaccompraTotdesc
				lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraFhora =  .Hora			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraAnulado =  .Anulado			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfch =  .Fecha			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFletra =  .Letra			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraMr =  .Recargomonto			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraFnumcomp =  .Numero			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraNroremito =  .Remito			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		
		if this.oEntidad.VerificarContexto( 'CB' )
		else
			this.ValidarTimestamp()
		endif
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.FACCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'">>,"Idcaja" = <<lxFaccompraIdcaja>>,"Fpodes1" = <<lxFaccompraFpodes1>>,"Fpodes2" = <<lxFaccompraFpodes2>>,"Fpodes" = <<lxFaccompraFpodes>>,"Fturno" = <<lxFaccompraFturno>>,"Numint" = <<lxFaccompraNumint>>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'">>,"Totalcant" = <<lxFaccompraTotalcant>>,"Timestamp" = <<lxFaccompraTimestamp>>,"Desmntosi2" = <<lxFaccompraDesmntosi2>>,"Subtotcisi" = <<lxFaccompraSubtotcisi>>,"Subtotsisi" = <<lxFaccompraSubtotsisi>>,"Signomov" = <<lxFaccompraSignomov>>,"Facttipo" = <<lxFaccompraFacttipo>>,"Condivalp" = <<lxFaccompraCondivalp>>,"Desmntosi1" = <<lxFaccompraDesmntosi1>>,"Sitfiscpro" = <<lxFaccompraSitfiscpro>>,"Recmntosi" = <<lxFaccompraRecmntosi>>,"Fsubtot" = <<lxFaccompraFsubtot>>,"Fsubton" = <<lxFaccompraFsubton>>,"Recmntosi1" = <<lxFaccompraRecmntosi1>>,"Desmntosi" = <<lxFaccompraDesmntosi>>,"Recmntosi2" = <<lxFaccompraRecmntosi2>>,"Anulado" = <<iif( lxFaccompraAnulado, 1, 0 )>>,"Fcompfis" = <<iif( lxFaccompraFcompfis, 1, 0 )>>,"Desauto" = <<iif( lxFaccompraDesauto, 1, 0 )>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'">>,"Fmtdes2" = <<lxFaccompraFmtdes2>>,"Fmtdes1" = <<lxFaccompraFmtdes1>>,"Fdescu" = <<lxFaccompraFdescu>>,"Fimpuesto" = <<lxFaccompraFimpuesto>>,"Tcrg1361" = <<lxFaccompraTcrg1361>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'">>,"Ffchfac" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'">>,"Fmtdes3" = <<lxFaccompraFmtdes3>>,"Desmntosi3" = <<lxFaccompraDesmntosi3>>,"Impman" = <<iif( lxFaccompraImpman, 1, 0 )>>,"Fletra" = <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'">>,"Recpor" = <<lxFaccompraRecpor>>,"Totdescsi" = <<lxFaccompraTotdescsi>>,"Fptovenext" = <<lxFaccompraFptovenext>>,"Mr" = <<lxFaccompraMr>>,"Cotiz" = <<lxFaccompraCotiz>>,"Condpago" = <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'">>,"Fnumcomp" = <<lxFaccompraFnumcomp>>,"Ffchvenc" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'">>,"Recmnto" = <<lxFaccompraRecmnto>>,"Recmnto1" = <<lxFaccompraRecmnto1>>,"Fvuelto" = <<lxFaccompraFvuelto>>,"Fptoven" = <<lxFaccompraFptoven>>,"Ncai" = <<lxFaccompraNcai>>,"Recmnto2" = <<lxFaccompraRecmnto2>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'">>,"Fperson" = <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'">>,"Ccosto" = <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'">>,"Fvtocai" = <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'">>,"Ftotal" = <<lxFaccompraFtotal>>,"Recmonto1" = <<lxFaccompraRecmonto1>>,"Recmonto2" = <<lxFaccompraRecmonto2>>,"Disccos" = <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'">>,"Nroremito" = <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'">>,"Totimpue" = <<lxFaccompraTotimpue>>,"Totrecar" = <<lxFaccompraTotrecar>>,"Totrecarsi" = <<lxFaccompraTotrecarsi>>,"Totdesc" = <<lxFaccompraTotdesc>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.FacCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ValFacComp where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpFacComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpFacc where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxIdorigen = loItem.Idorigen
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","IdItem","FAMate","afe_Cod","AfeTS","MNTPRECCI","APorcIvaC","ArtPercep","MNTPTOT","ACondIvaC","AfeCANT","AfeSaldo","MNTPRECSI","MNDESSI","AjuCImp","FBruto","MNDESCI","MNPDSI","MNTPDESCI","MNTPDESSI","AfeTipoCom","MNTPPER","AfeNroItem","AjuSImp","NroItem","FNETO","FX2","FmtoIVA","FporCFI","FmtoCFI","FmtoDTO1","FCFITot","COMP","FKIT","iditemOrig","FporDTO1","fporIva","ciditem","FN11","Prunsinimp","FPRUN","prunconimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","CCOSTO","DCCOSTO","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_porcentajeivacompras>>, <<lxPercepcionivarg5329>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_cantidad>>, <<lxAfe_saldo>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_nroitem>>, <<lxAjusteporredondeosinimpuestos>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxIdorigen>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxNroitem = lnContadorNroItem
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("TipoI","codint","NroItem","minoimp","porcen","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<lxNroitem>>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
			dodefault()
			this.AntesEndTransaction()
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar actualizar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar actualizar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Modificacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		finally
			this.SetearConexionGlobal()
		EndTry
		this.ActualizarLosNROItemDeLosDetalles()
		this.oEntidad.Timestamp = lxFaccompraTimestamp
		endwith

	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValidarTimestamp() as void
		Local lnTimestamp as integer
		if !this.oEntidad.lEsSubentidad
			lnTimestamp = this.ObtenerTimestampActual()
			if this.oEntidad.Timestamp = lnTimestamp 
			else 
				local loEx as Object
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Message = 'Error al intentar Grabar'
					.Details = 'No se puede grabar, el registro ha cambiado'
					.Grabar()
					.Throw()
				endwith
			endif
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function HayDatos() as boolean
		local llhaydatos as boolean, lcXml as String
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.FACCOMPRA where " + this.ConvertirFuncionesSql( " FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8" ) )
			this.xmlacursor( lcXml, 'c_HayDatos' )
			llHayDatos = reccount( 'c_HayDatos' ) > 0 
			use in select('c_HayDatos')
		return llHayDatos
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClavePrimaria( tlLlenarAtributos as Boolean ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxFaccompraCodigo
			lxFaccompraCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )

			if reccount( 'c_FACTURADECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxFacCompraNumInt As Variant, lxFacCompraFACTTIPO As Variant
			lxFacCompraNumInt = .NumInt
			lxFacCompraFACTTIPO = .TipoComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 And NumInt = <<lxFacCompraNumInt>> and FACTTIPO = <<lxFacCompraFACTTIPO>>
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			if reccount( 'c_FACTURADECOMPRA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxFaccompraCodigo as Variant
		llRetorno = .t.
		lxFaccompraCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.FACCOMPRA where "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8
			endtext
			use in select('c_VerificarExistencia')
			this.oConexion.EjecutarSql( lcSentencia, 'c_VerificarExistencia', set( 'Datasession' ) )

			if c_VerificarExistencia.CantidadDeRegistros = 0
				llRetorno = .f.
			endif
			use in select( 'c_VerificarExistencia' )
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Primero() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .NumInt, 10, 0) + str( .TipoComprobante, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt,FACTTIPO
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Siguiente() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .NumInt, 10, 0) + str( .TipoComprobante, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  str( NumInt, 10, 0) + str( FACTTIPO, 2, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt,FACTTIPO
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Anterior() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .NumInt, 10, 0) + str( .TipoComprobante, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  str( NumInt, 10, 0) + str( FACTTIPO, 2, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt desc,FACTTIPO desc
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Ultimo() As Boolean
		Local llRetorno As Boolean, loError as Exception, loEx as Exception
		llRetorno = .F.
		try
			With This.oEntidad
				local lcOrden as string
				lcOrden =  str( .NumInt, 10, 0) + str( .TipoComprobante, 2, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 order by NumInt desc,FACTTIPO desc
			endtext
			use in select('c_FACTURADECOMPRA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURADECOMPRA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.FacCompraDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio" from ZooLogic.ValFacComp where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpFacComp where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.ImpFacc where cCod = <<"'" + this.FormatearTextoSql( c_FACTURADECOMPRA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			Endwith

		catch To loError
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar navegar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar navegar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			goServicios.Errores.LevantarExcepcion( loError )
		finally
		endTry
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorAtributoSecundario( tcAtributo ) as Boolean
		local lxValor as variant, llRetorno as boolean, lcXml as string , lcNombreCursor as string, lcAtributo as String, lcatributoPK as string
		lcNombreCursor = 'c_' + sys( 2015 )
		llRetorno = .t.
		lcAtributo = upper( tcAtributo )
		with this
			lcCampo = .ObtenerCampoEntidad( lcAtributo )
			lxValor = .oEntidad.&lcAtributo
			lcFiltroCodigo = ''
			if !.oentidad.EsNuevo() and .oEntidad.EsEdicion()
				lcatributoPK = .oEntidad.cAtributoPK
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Faltafw,Fecexpo,Fectrans,Fecimpo,Fd2,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Numi" + ;
"nt,Bdmodifw,Bdaltafw,Esttrans,Fhora,Ualtafw,Smodifw,Umodifw,Valtafw,Zadsfw,Vmodifw,Descfw,Saltafw,Si" + ;
"mbmon,Horaimpo,Horaexpo,Haltafw,Hmodifw,Totalcant,Timestamp,Desmntosi2,Subtotcisi,Subtotsisi,Signomo" + ;
"v,Facttipo,Condivalp,Desmntosi1,Sitfiscpro,Recmntosi,Fsubtot,Fsubton,Recmntosi1,Desmntosi,Recmntosi2" + ;
",Anulado,Fcompfis,Desauto,Idvuelto,Monsis,Fobs,Fmtdes2,Fmtdes1,Fdescu,Fimpuesto,Tcrg1361,Codigo,Ffch" + ;
",Ffchfac,Fmtdes3,Desmntosi3,Impman,Fletra,Recpor,Totdescsi,Fptovenext,Mr,Cotiz,Condpago,Fnumcomp,Ffc" + ;
"hvenc,Recmnto,Recmnto1,Fvuelto,Fptoven,Ncai,Recmnto2,Moneda,Fperson,Ccosto,Fvtocai,Ftotal,Recmonto1," + ;
"Recmonto2,Disccos,Codlista,Nroremito,Totimpue,Totrecar,Totrecarsi,Totdesc" + ;
" from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8 and " + lcFiltro )
			this.xmlacursor( lcXml, lcNombreCursor )
			if reccount( lcNombreCursor ) = 0
				llRetorno = .f.
			endif
			use in select( lcNombreCursor )
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Eliminar() As Boolean
		local loError as Exception, loEx as Exception, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg
		with this.oEntidad
			local  lxFaccompraFmodifw, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFecimpo, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraBdmodifw, lxFaccompraBdaltafw, lxFaccompraEsttrans, lxFaccompraFhora, lxFaccompraUaltafw, lxFaccompraSmodifw, lxFaccompraUmodifw, lxFaccompraValtafw, lxFaccompraZadsfw, lxFaccompraVmodifw, lxFaccompraDescfw, lxFaccompraSaltafw, lxFaccompraSimbmon, lxFaccompraHoraimpo, lxFaccompraHoraexpo, lxFaccompraHaltafw, lxFaccompraHmodifw, lxFaccompraTotalcant, lxFaccompraTimestamp, lxFaccompraDesmntosi2, lxFaccompraSubtotcisi, lxFaccompraSubtotsisi, lxFaccompraSignomov, lxFaccompraFacttipo, lxFaccompraCondivalp, lxFaccompraDesmntosi1, lxFaccompraSitfiscpro, lxFaccompraRecmntosi, lxFaccompraFsubtot, lxFaccompraFsubton, lxFaccompraRecmntosi1, lxFaccompraDesmntosi, lxFaccompraRecmntosi2, lxFaccompraAnulado, lxFaccompraFcompfis, lxFaccompraDesauto, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraFobs, lxFaccompraFmtdes2, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfch, lxFaccompraFfchfac, lxFaccompraFmtdes3, lxFaccompraDesmntosi3, lxFaccompraImpman, lxFaccompraFletra, lxFaccompraRecpor, lxFaccompraTotdescsi, lxFaccompraFptovenext, lxFaccompraMr, lxFaccompraCotiz, lxFaccompraCondpago, lxFaccompraFnumcomp, lxFaccompraFfchvenc, lxFaccompraRecmnto, lxFaccompraRecmnto1, lxFaccompraFvuelto, lxFaccompraFptoven, lxFaccompraNcai, lxFaccompraRecmnto2, lxFaccompraMoneda, lxFaccompraFperson, lxFaccompraCcosto, lxFaccompraFvtocai, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraCodlista, lxFaccompraNroremito, lxFaccompraTotimpue, lxFaccompraTotrecar, lxFaccompraTotrecarsi, lxFaccompraTotdesc
				lxFaccompraFmodifw = ctod( '  /  /    ' )			lxFaccompraFaltafw = ctod( '  /  /    ' )			lxFaccompraFecexpo = ctod( '  /  /    ' )			lxFaccompraFectrans = ctod( '  /  /    ' )			lxFaccompraFecimpo = ctod( '  /  /    ' )			lxFaccompraFd2 = ctod( '  /  /    ' )			lxFaccompraFcuit = []			lxFaccompraIdcaja = 0			lxFaccompraFpodes1 = 0			lxFaccompraFpodes2 = 0			lxFaccompraFpodes = 0			lxFaccompraFturno = 0			lxFaccompraNumint = 0			lxFaccompraBdmodifw = []			lxFaccompraBdaltafw = []			lxFaccompraEsttrans = []			lxFaccompraFhora = []			lxFaccompraUaltafw = []			lxFaccompraSmodifw = []			lxFaccompraUmodifw = []			lxFaccompraValtafw = []			lxFaccompraZadsfw = []			lxFaccompraVmodifw = []			lxFaccompraDescfw = []			lxFaccompraSaltafw = []			lxFaccompraSimbmon = []			lxFaccompraHoraimpo = []			lxFaccompraHoraexpo = []			lxFaccompraHaltafw = []			lxFaccompraHmodifw = []			lxFaccompraTotalcant = 0			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi2 = 0			lxFaccompraSubtotcisi = 0			lxFaccompraSubtotsisi = 0			lxFaccompraSignomov = 0			lxFaccompraFacttipo = 0			lxFaccompraCondivalp = 0			lxFaccompraDesmntosi1 = 0			lxFaccompraSitfiscpro = 0			lxFaccompraRecmntosi = 0			lxFaccompraFsubtot = 0			lxFaccompraFsubton = 0			lxFaccompraRecmntosi1 = 0			lxFaccompraDesmntosi = 0			lxFaccompraRecmntosi2 = 0			lxFaccompraAnulado = .F.			lxFaccompraFcompfis = .F.			lxFaccompraDesauto = .F.			lxFaccompraIdvuelto = []			lxFaccompraMonsis = []			lxFaccompraFobs = []			lxFaccompraFmtdes2 = 0			lxFaccompraFmtdes1 = 0			lxFaccompraFdescu = 0			lxFaccompraFimpuesto = 0			lxFaccompraTcrg1361 = 0			lxFaccompraCodigo = []			lxFaccompraFfch = ctod( '  /  /    ' )			lxFaccompraFfchfac = ctod( '  /  /    ' )			lxFaccompraFmtdes3 = 0			lxFaccompraDesmntosi3 = 0			lxFaccompraImpman = .F.			lxFaccompraFletra = []			lxFaccompraRecpor = 0			lxFaccompraTotdescsi = 0			lxFaccompraFptovenext = 0			lxFaccompraMr = 0			lxFaccompraCotiz = 0			lxFaccompraCondpago = []			lxFaccompraFnumcomp = 0			lxFaccompraFfchvenc = ctod( '  /  /    ' )			lxFaccompraRecmnto = 0			lxFaccompraRecmnto1 = 0			lxFaccompraFvuelto = 0			lxFaccompraFptoven = 0			lxFaccompraNcai = 0			lxFaccompraRecmnto2 = 0			lxFaccompraMoneda = []			lxFaccompraFperson = []			lxFaccompraCcosto = []			lxFaccompraFvtocai = ctod( '  /  /    ' )			lxFaccompraFtotal = 0			lxFaccompraRecmonto1 = 0			lxFaccompraRecmonto2 = 0			lxFaccompraDisccos = []			lxFaccompraCodlista = []			lxFaccompraNroremito = []			lxFaccompraTotimpue = 0			lxFaccompraTotrecar = 0			lxFaccompraTotrecarsi = 0			lxFaccompraTotdesc = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.FacCompraDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ValFacComp where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpFacComp where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpFacc where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.FACCOMPRA where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			.GenerarSentenciasComponentes()
			.EjecutarSentencias( This.ColSentencias )
			this.oConexion.EjecutarSql( 'COMMIT TRANSACTION' )
			.ActualizarNumeraciones()
			lnI = this.nReintentos
		Catch to loError
			this.oConexion.EjecutarSql( 'ROLLBACK TRANSACTION' )
			do case
				case inlist( loError.Errorno, 1, 1103) 
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos necesarios no existen. Consulte con el administrador del sistema.'
				case loError.Errorno = 111
					loError.Message = 'Hubo un problema al intentar eliminar los datos, uno o mas archivos son de solo lectura. Consulte con el administrador del sistema.'
				case loError.Errorno = 1705
					loError.Message = 'Hubo un problema al intentar eliminar los datos, no se tiene acceso a uno o mas archivos. Consulte con el administrador del sistema.'
			endcase
			
			if loError.errorno == 3
				if lnI == 3
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion No exitosa. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
					goServicios.Errores.LevantarExcepcion( loError )
				else
					strtofile( transform( date() ) + ' ' + time() + ' Eliminacion. Intento ' + transform( lni ) + '. Clase ' + this.Class + chr( 13 ) + chr( 10 ), addbs( this.oConexion.oAccesoDatos.cRutaTablas ) + this.cArchivoLogPrueba, 1 )
				endif
			else
				goServicios.Errores.LevantarExcepcion( loError )
			endif
		Finally
			this.SetearConexionGlobal()
		EndTry

		endwith
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function LlenarArrayMemo( tcCampo as String, tcAtributo as String, txValorClavePrimaria as variant ) as void 
		local lcMemos as String, lxCodigo as variant, lcCodigo as string, lnTotalMemos as integer, lcAtributo as string, lcTabla as string, lcValor as string, lnElemento as string, i as integer, lnCortar as integer, lnIndice as Integer

		lcAtributo = alltrim(tcAtributo)
		with this
			lcValor = rtrim( .oEntidad.&lcAtributo )
			lcTabla = 'FACCOMPRA' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'FACCOMPRA', '', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoEntidad( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleCOMPAFEC( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPAFE.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleCOMPAFEC( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'CompAfe', 'COMPAFEC', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleCOMPAFEC( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleCOMPAFEC( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleFacturaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  FACCOMPRADET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'FacCompraDet', 'FacturaDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleFacturaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleFacturaDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleValoresDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  VALFACCOMP.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fechcoti" as "Fechaultcotizacion", "Jjfecha" as "Fechacomp", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Nrodoc" as "Nrodocumento", "Tipcomp" as "Tipodecomprobante", "Letra" as "Letra", "Tipodoc" as "Tipodocumento", "Cotiza" as "Ultimacotizacion", "Jjturno" as "Turno", "Nrocupon" as "Numerocupon", "Nroitem" as "Nroitem", "Jjcotiz" as "Cotiza", "Numcompr" as "Numerodecomprobante", "Pesos" as "Pesosalcambio", "Ptoventa" as "Puntodeventa", "Jjt" as "Tipo", "Signo" as "Signo", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Condpago" as "Condiciondepago", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Jrecmnt" as "Recargomonto", "Jjtotfac" as "Total", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Jrrecsperc" as "Recargosinpercepciones", "Guidcomp" as "Iditemcomponente", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ValFacComp', 'ValoresDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleValoresDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleImpuestosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPFACCOMP.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Ivamngsd" as "Montonogravadosindescuento", "Nroitem" as "Nroitem", "Ivamonng" as "Montonogravado", "Ivamonsd" as "Montodeivasindescuento", "Ivaporcent" as "Porcentajedeiva", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpFacComp', 'ImpuestosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleImpuestosDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPFACC.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Nroitem" as "Nroitem", "Minoimp" as "Minimonoimponible", "Porcen" as "Porcentaje", "Ccod" as "Codigo", "Codimp" as "Codimp", "Descri" as "Codimpdetalle", "Monto" as "Monto", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpFacc', 'ImpuestosComprobante', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleImpuestosComprobante( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'NUMINT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMINT AS NUMINT'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCPRO AS SITUACIONFISCAL'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'TIPOCOMPROBANTERG1361'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TCRG1361 AS TIPOCOMPROBANTERG1361'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'FECHAFACTURA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHFAC AS FECHAFACTURA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'IMPUESTOSMANUALES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPMAN AS IMPUESTOSMANUALES'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'PUNTODEVENTAEXTENDIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVENEXT AS PUNTODEVENTAEXTENDIDO'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'CONDICIONPAGOPREFERENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONPAGOPREFERENTE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'FECHAVENCIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVENC AS FECHAVENCIMIENTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCAI AS CAI'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'PROVEEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS PROVEEDOR'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO2 AS RECARGOMONTO2'
				Case lcAtributo == 'DISTRIBUCIONPORCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DISCCOS AS DISTRIBUCIONPORCENTRODECOSTO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'REMITO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROREMITO AS REMITO'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECAR AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleCOMPAFEC( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPCARACTER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECOMPROB AS TIPOCOMPCARACTER'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS LETRA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEFECHA AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETOTAL AS TOTAL'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEVEND AS VENDEDOR'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPO AS TIPO'
				Case lcAtributo == 'AFECTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECTA AS AFECTA'
				Case lcAtributo == 'INTERVINIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCINTER AS INTERVINIENTE'
				Case lcAtributo == 'NOMBREENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOMINTER AS NOMBREENTIDAD'
				Case lcAtributo == 'CODIGOENTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINTER AS CODIGOENTIDAD'
				Case lcAtributo == 'ORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGEN AS ORIGEN'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleFacturaDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'AFE_NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS AFE_NUMERO'
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAC AS ARTICULO_PORCENTAJEIVACOMPRAS'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'ARTICULO_CONDICIONIVACOMPRAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAC AS ARTICULO_CONDICIONIVACOMPRAS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLO AS COLOR'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'CENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOSTO AS CENTRODECOSTO'
				Case lcAtributo == 'DISTRIBUCIONCENTRODECOSTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DCCOSTO AS DISTRIBUCIONCENTRODECOSTO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCANT AS CANTIDAD'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMONTO AS MONTO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleValoresDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAULTCOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHCOTI AS FECHAULTCOTIZACION'
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFECHA AS FECHACOMP'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONDEPAGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'VALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCO AS VALOR'
				Case lcAtributo == 'VALORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJDE AS VALORDETALLE'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFE AS FECHA'
				Case lcAtributo == 'NUMEROINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROINTERNO AS NUMEROINTERNO'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJM AS MONTO'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECPORC AS RECARGOPORCENTAJE'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNT AS RECARGOMONTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNTSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRRECSPERC AS RECARGOSINPERCEPCIONES'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'NUMEROVALEDECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMBIO AS NUMEROVALEDECAMBIO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleImpuestosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'MONTONOGRAVADOSINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMNGSD AS MONTONOGRAVADOSINDESCUENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTONOGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONNG AS MONTONOGRAVADO'
				Case lcAtributo == 'MONTODEIVASINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONSD AS MONTODEIVASINDESCUENTO'
				Case lcAtributo == 'PORCENTAJEDEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAPORCENT AS PORCENTAJEDEIVA'
				Case lcAtributo == 'MONTODEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONTO AS MONTODEIVA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'CODIMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIMP'
				Case lcAtributo == 'CODIMPDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS CODIMPDETALLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'RG5329PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS RG5329PORCENTAJE'
				Case lcAtributo == 'RG5329APLICAPORARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCE AS RG5329APLICAPORARTICULO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMINT'
				lcCampo = 'NUMINT'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCPRO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTERG1361'
				lcCampo = 'TCRG1361'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAFACTURA'
				lcCampo = 'FFCHFAC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOSMANUALES'
				lcCampo = 'IMPMAN'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTAEXTENDIDO'
				lcCampo = 'FPTOVENEXT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONPAGOPREFERENTE'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTO'
				lcCampo = 'FFCHVENC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'NCAI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDOR'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'FVTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'RECMONTO1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'RECMONTO2'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONPORCENTRODECOSTO'
				lcCampo = 'DISCCOS'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'REMITO'
				lcCampo = 'NROREMITO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOS'
				lcCampo = 'TOTRECAR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleCOMPAFEC( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPCARACTER'
				lcCampo = 'AFECOMPROB'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'AFEFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'AFETOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'AFEVEND'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'AFETIPO'
			Case upper( alltrim( tcAtributo ) ) == 'AFECTA'
				lcCampo = 'AFECTA'
			Case upper( alltrim( tcAtributo ) ) == 'INTERVINIENTE'
				lcCampo = 'DESCINTER'
			Case upper( alltrim( tcAtributo ) ) == 'NOMBREENTIDAD'
				lcCampo = 'NOMINTER'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOENTIDAD'
				lcCampo = 'CODINTER'
			Case upper( alltrim( tcAtributo ) ) == 'ORIGEN'
				lcCampo = 'ORIGEN'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleFacturaDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVACOMPRAS'
				lcCampo = 'APORCIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVACOMPRAS'
				lcCampo = 'ACONDIVAC'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'FCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'CENTRODECOSTO'
				lcCampo = 'CCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'DISTRIBUCIONCENTRODECOSTO'
				lcCampo = 'DCCOSTO'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'FCANT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'FMONTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleValoresDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'VALOR'
				lcCampo = 'JJCO'
			Case upper( alltrim( tcAtributo ) ) == 'VALORDETALLE'
				lcCampo = 'JJDE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'JJFE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROINTERNO'
				lcCampo = 'NROINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'JJM'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'JRECPORC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'JRECMNT'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'JRECMNTSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'JRRECSPERC'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROVALEDECAMBIO'
				lcCampo = 'VALECAMBIO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADOSINDESCUENTO'
				lcCampo = 'IVAMNGSD'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADO'
				lcCampo = 'IVAMONNG'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVASINDESCUENTO'
				lcCampo = 'IVAMONSD'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDEIVA'
				lcCampo = 'IVAPORCENT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVA'
				lcCampo = 'IVAMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMP'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIMPDETALLE'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329PORCENTAJE'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329APLICAPORARTICULO'
				lcCampo = 'ARTPERCE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'FACCOMPRADET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'VALFACCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPFACCOMP'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPFACC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxFaccompraFmodifw, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFecimpo, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraBdmodifw, lxFaccompraBdaltafw, lxFaccompraEsttrans, lxFaccompraFhora, lxFaccompraUaltafw, lxFaccompraSmodifw, lxFaccompraUmodifw, lxFaccompraValtafw, lxFaccompraZadsfw, lxFaccompraVmodifw, lxFaccompraDescfw, lxFaccompraSaltafw, lxFaccompraSimbmon, lxFaccompraHoraimpo, lxFaccompraHoraexpo, lxFaccompraHaltafw, lxFaccompraHmodifw, lxFaccompraTotalcant, lxFaccompraTimestamp, lxFaccompraDesmntosi2, lxFaccompraSubtotcisi, lxFaccompraSubtotsisi, lxFaccompraSignomov, lxFaccompraFacttipo, lxFaccompraCondivalp, lxFaccompraDesmntosi1, lxFaccompraSitfiscpro, lxFaccompraRecmntosi, lxFaccompraFsubtot, lxFaccompraFsubton, lxFaccompraRecmntosi1, lxFaccompraDesmntosi, lxFaccompraRecmntosi2, lxFaccompraAnulado, lxFaccompraFcompfis, lxFaccompraDesauto, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraFobs, lxFaccompraFmtdes2, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfch, lxFaccompraFfchfac, lxFaccompraFmtdes3, lxFaccompraDesmntosi3, lxFaccompraImpman, lxFaccompraFletra, lxFaccompraRecpor, lxFaccompraTotdescsi, lxFaccompraFptovenext, lxFaccompraMr, lxFaccompraCotiz, lxFaccompraCondpago, lxFaccompraFnumcomp, lxFaccompraFfchvenc, lxFaccompraRecmnto, lxFaccompraRecmnto1, lxFaccompraFvuelto, lxFaccompraFptoven, lxFaccompraNcai, lxFaccompraRecmnto2, lxFaccompraMoneda, lxFaccompraFperson, lxFaccompraCcosto, lxFaccompraFvtocai, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraCodlista, lxFaccompraNroremito, lxFaccompraTotimpue, lxFaccompraTotrecar, lxFaccompraTotrecarsi, lxFaccompraTotdesc
				lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraFhora =  .Hora			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraAnulado =  .Anulado			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfch =  .Fecha			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFletra =  .Letra			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraMr =  .Recargomonto			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraFnumcomp =  .Numero			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraNroremito =  .Remito			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.FACCOMPRA ( "Fmodifw","Faltafw","Fecexpo","Fectrans","Fecimpo","Fd2","Fcuit","Idcaja","Fpodes1","Fpodes2","Fpodes","Fturno","Numint","Bdmodifw","Bdaltafw","Esttrans","Fhora","Ualtafw","Smodifw","Umodifw","Valtafw","Zadsfw","Vmodifw","Descfw","Saltafw","Simbmon","Horaimpo","Horaexpo","Haltafw","Hmodifw","Totalcant","Timestamp","Desmntosi2","Subtotcisi","Subtotsisi","Signomov","Facttipo","Condivalp","Desmntosi1","Sitfiscpro","Recmntosi","Fsubtot","Fsubton","Recmntosi1","Desmntosi","Recmntosi2","Anulado","Fcompfis","Desauto","Idvuelto","Monsis","Fobs","Fmtdes2","Fmtdes1","Fdescu","Fimpuesto","Tcrg1361","Codigo","Ffch","Ffchfac","Fmtdes3","Desmntosi3","Impman","Fletra","Recpor","Totdescsi","Fptovenext","Mr","Cotiz","Condpago","Fnumcomp","Ffchvenc","Recmnto","Recmnto1","Fvuelto","Fptoven","Ncai","Recmnto2","Moneda","Fperson","Ccosto","Fvtocai","Ftotal","Recmonto1","Recmonto2","Disccos","Codlista","Nroremito","Totimpue","Totrecar","Totrecarsi","Totdesc" ) values ( <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'" >>, <<lxFaccompraIdcaja >>, <<lxFaccompraFpodes1 >>, <<lxFaccompraFpodes2 >>, <<lxFaccompraFpodes >>, <<lxFaccompraFturno >>, <<lxFaccompraNumint >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'" >>, <<lxFaccompraTotalcant >>, <<lxFaccompraTimestamp >>, <<lxFaccompraDesmntosi2 >>, <<lxFaccompraSubtotcisi >>, <<lxFaccompraSubtotsisi >>, <<lxFaccompraSignomov >>, <<lxFaccompraFacttipo >>, <<lxFaccompraCondivalp >>, <<lxFaccompraDesmntosi1 >>, <<lxFaccompraSitfiscpro >>, <<lxFaccompraRecmntosi >>, <<lxFaccompraFsubtot >>, <<lxFaccompraFsubton >>, <<lxFaccompraRecmntosi1 >>, <<lxFaccompraDesmntosi >>, <<lxFaccompraRecmntosi2 >>, <<iif( lxFaccompraAnulado, 1, 0 ) >>, <<iif( lxFaccompraFcompfis, 1, 0 ) >>, <<iif( lxFaccompraDesauto, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'" >>, <<lxFaccompraFmtdes2 >>, <<lxFaccompraFmtdes1 >>, <<lxFaccompraFdescu >>, <<lxFaccompraFimpuesto >>, <<lxFaccompraTcrg1361 >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'" >>, <<lxFaccompraFmtdes3 >>, <<lxFaccompraDesmntosi3 >>, <<iif( lxFaccompraImpman, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'" >>, <<lxFaccompraRecpor >>, <<lxFaccompraTotdescsi >>, <<lxFaccompraFptovenext >>, <<lxFaccompraMr >>, <<lxFaccompraCotiz >>, <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'" >>, <<lxFaccompraFnumcomp >>, <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'" >>, <<lxFaccompraRecmnto >>, <<lxFaccompraRecmnto1 >>, <<lxFaccompraFvuelto >>, <<lxFaccompraFptoven >>, <<lxFaccompraNcai >>, <<lxFaccompraRecmnto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'" >>, <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'" >>, <<lxFaccompraFtotal >>, <<lxFaccompraRecmonto1 >>, <<lxFaccompraRecmonto2 >>, <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'" >>, <<lxFaccompraTotimpue >>, <<lxFaccompraTotrecar >>, <<lxFaccompraTotrecarsi >>, <<lxFaccompraTotdesc >> )
		endtext
		loColeccion.cTabla = 'FACCOMPRA' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxIdorigen = loItem.Idorigen
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","IdItem","FAMate","afe_Cod","AfeTS","MNTPRECCI","APorcIvaC","ArtPercep","MNTPTOT","ACondIvaC","AfeCANT","AfeSaldo","MNTPRECSI","MNDESSI","AjuCImp","FBruto","MNDESCI","MNPDSI","MNTPDESCI","MNTPDESSI","AfeTipoCom","MNTPPER","AfeNroItem","AjuSImp","NroItem","FNETO","FX2","FmtoIVA","FporCFI","FmtoCFI","FmtoDTO1","FCFITot","COMP","FKIT","iditemOrig","FporDTO1","fporIva","ciditem","FN11","Prunsinimp","FPRUN","prunconimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","CCOSTO","DCCOSTO","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_porcentajeivacompras>>, <<lxPercepcionivarg5329>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_cantidad>>, <<lxAfe_saldo>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_nroitem>>, <<lxAjusteporredondeosinimpuestos>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxIdorigen>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxNroitem = lnContadorNroItem
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("TipoI","codint","NroItem","minoimp","porcen","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<lxNroitem>>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			if .lAnular
				.oAtributosAnulacion = .CrearObjeto( 'zooColeccion' )
				.ObtenerAtributosAnulacion()
				.Limpiar()
				.CargarAtributosAnulacion()
			endif
			local  lxFaccompraFmodifw, lxFaccompraFaltafw, lxFaccompraFecexpo, lxFaccompraFectrans, lxFaccompraFecimpo, lxFaccompraFd2, lxFaccompraFcuit, lxFaccompraIdcaja, lxFaccompraFpodes1, lxFaccompraFpodes2, lxFaccompraFpodes, lxFaccompraFturno, lxFaccompraNumint, lxFaccompraBdmodifw, lxFaccompraBdaltafw, lxFaccompraEsttrans, lxFaccompraFhora, lxFaccompraUaltafw, lxFaccompraSmodifw, lxFaccompraUmodifw, lxFaccompraValtafw, lxFaccompraZadsfw, lxFaccompraVmodifw, lxFaccompraDescfw, lxFaccompraSaltafw, lxFaccompraSimbmon, lxFaccompraHoraimpo, lxFaccompraHoraexpo, lxFaccompraHaltafw, lxFaccompraHmodifw, lxFaccompraTotalcant, lxFaccompraTimestamp, lxFaccompraDesmntosi2, lxFaccompraSubtotcisi, lxFaccompraSubtotsisi, lxFaccompraSignomov, lxFaccompraFacttipo, lxFaccompraCondivalp, lxFaccompraDesmntosi1, lxFaccompraSitfiscpro, lxFaccompraRecmntosi, lxFaccompraFsubtot, lxFaccompraFsubton, lxFaccompraRecmntosi1, lxFaccompraDesmntosi, lxFaccompraRecmntosi2, lxFaccompraAnulado, lxFaccompraFcompfis, lxFaccompraDesauto, lxFaccompraIdvuelto, lxFaccompraMonsis, lxFaccompraFobs, lxFaccompraFmtdes2, lxFaccompraFmtdes1, lxFaccompraFdescu, lxFaccompraFimpuesto, lxFaccompraTcrg1361, lxFaccompraCodigo, lxFaccompraFfch, lxFaccompraFfchfac, lxFaccompraFmtdes3, lxFaccompraDesmntosi3, lxFaccompraImpman, lxFaccompraFletra, lxFaccompraRecpor, lxFaccompraTotdescsi, lxFaccompraFptovenext, lxFaccompraMr, lxFaccompraCotiz, lxFaccompraCondpago, lxFaccompraFnumcomp, lxFaccompraFfchvenc, lxFaccompraRecmnto, lxFaccompraRecmnto1, lxFaccompraFvuelto, lxFaccompraFptoven, lxFaccompraNcai, lxFaccompraRecmnto2, lxFaccompraMoneda, lxFaccompraFperson, lxFaccompraCcosto, lxFaccompraFvtocai, lxFaccompraFtotal, lxFaccompraRecmonto1, lxFaccompraRecmonto2, lxFaccompraDisccos, lxFaccompraCodlista, lxFaccompraNroremito, lxFaccompraTotimpue, lxFaccompraTotrecar, lxFaccompraTotrecarsi, lxFaccompraTotdesc
				lxFaccompraFmodifw =  .Fechamodificacionfw			lxFaccompraFaltafw =  .Fechaaltafw			lxFaccompraFecexpo =  .Fechaexpo			lxFaccompraFectrans =  .Fechatransferencia			lxFaccompraFecimpo =  .Fechaimpo			lxFaccompraFd2 =  .Fechamodificacion			lxFaccompraFcuit =  .Cuit			lxFaccompraIdcaja =  .Caja_PK 			lxFaccompraFpodes1 =  .Porcentajedescuento1			lxFaccompraFpodes2 =  .Porcentajedescuento2			lxFaccompraFpodes =  .Porcentajedescuento			lxFaccompraFturno =  .Turno			lxFaccompraNumint =  .Numint			lxFaccompraBdmodifw =  .Basededatosmodificacionfw			lxFaccompraBdaltafw =  .Basededatosaltafw			lxFaccompraEsttrans =  .Estadotransferencia			lxFaccompraFhora =  .Hora			lxFaccompraUaltafw =  .Usuarioaltafw			lxFaccompraSmodifw =  .Seriemodificacionfw			lxFaccompraUmodifw =  .Usuariomodificacionfw			lxFaccompraValtafw =  .Versionaltafw			lxFaccompraZadsfw =  .Zadsfw			lxFaccompraVmodifw =  .Versionmodificacionfw			lxFaccompraDescfw =  .Descripcionfw			lxFaccompraSaltafw =  .Seriealtafw			lxFaccompraSimbmon =  .Simbolomonetariocomprobante			lxFaccompraHoraimpo =  .Horaimpo			lxFaccompraHoraexpo =  .Horaexpo			lxFaccompraHaltafw =  .Horaaltafw			lxFaccompraHmodifw =  .Horamodificacionfw			lxFaccompraTotalcant =  .Totalcantidad			lxFaccompraTimestamp = goLibrerias.ObtenerTimestamp()			lxFaccompraDesmntosi2 =  .Montodescuentosinimpuestos2			lxFaccompraSubtotcisi =  .Subtotalconimpuestossobreitems			lxFaccompraSubtotsisi =  .Subtotalsinimpuestossobreitems			lxFaccompraSignomov =  .Signodemovimiento			lxFaccompraFacttipo =  .Tipocomprobante			lxFaccompraCondivalp =  .Condicioniva			lxFaccompraDesmntosi1 =  .Montodescuentosinimpuestos1			lxFaccompraSitfiscpro =  .Situacionfiscal_PK 			lxFaccompraRecmntosi =  .Recargomontosinimpuestos			lxFaccompraFsubtot =  .Subtotalbruto			lxFaccompraFsubton =  .Subtotalneto			lxFaccompraRecmntosi1 =  .Recargomontosinimpuestos1			lxFaccompraDesmntosi =  .Montodescuentosinimpuestos			lxFaccompraRecmntosi2 =  .Recargomontosinimpuestos2			lxFaccompraAnulado =  .Anulado			lxFaccompraFcompfis =  .Comprobantefiscal			lxFaccompraDesauto =  .Descuentoautomatico			lxFaccompraIdvuelto =  upper( .IdVuelto_PK ) 			lxFaccompraMonsis =  upper( .MonedaSistema_PK ) 			lxFaccompraFobs =  .Obs			lxFaccompraFmtdes2 =  .Montodescuentoconimpuestos2			lxFaccompraFmtdes1 =  .Montodescuentoconimpuestos1			lxFaccompraFdescu =  .Descuento			lxFaccompraFimpuesto =  .Impuestos			lxFaccompraTcrg1361 =  .Tipocomprobanterg1361			lxFaccompraCodigo =  .Codigo			lxFaccompraFfch =  .Fecha			lxFaccompraFfchfac =  .Fechafactura			lxFaccompraFmtdes3 =  .Montodescuentoconimpuestos3			lxFaccompraDesmntosi3 =  .Montodescuentosinimpuestos3			lxFaccompraImpman =  .Impuestosmanuales			lxFaccompraFletra =  .Letra			lxFaccompraRecpor =  .Recargoporcentaje			lxFaccompraTotdescsi =  .Totaldescuentossinimpuestos			lxFaccompraFptovenext =  .Puntodeventaextendido			lxFaccompraMr =  .Recargomonto			lxFaccompraCotiz =  .Cotizacion			lxFaccompraCondpago =  upper( .CondicionPagoPreferente_PK ) 			lxFaccompraFnumcomp =  .Numero			lxFaccompraFfchvenc =  .Fechavencimiento			lxFaccompraRecmnto =  .Recargomontoconimpuestos			lxFaccompraRecmnto1 =  .Recargomontoconimpuestos1			lxFaccompraFvuelto =  .Vuelto			lxFaccompraFptoven =  .Puntodeventa			lxFaccompraNcai =  .Cai			lxFaccompraRecmnto2 =  .Recargomontoconimpuestos2			lxFaccompraMoneda =  upper( .MonedaComprobante_PK ) 			lxFaccompraFperson =  upper( .Proveedor_PK ) 			lxFaccompraCcosto =  upper( .CentroDeCosto_PK ) 			lxFaccompraFvtocai =  .Fechavtocai			lxFaccompraFtotal =  .Total			lxFaccompraRecmonto1 =  .Recargomonto1			lxFaccompraRecmonto2 =  .Recargomonto2			lxFaccompraDisccos =  upper( .DistribucionPorCentroDeCosto_PK ) 			lxFaccompraCodlista =  upper( .ListaDePrecios_PK ) 			lxFaccompraNroremito =  .Remito			lxFaccompraTotimpue =  .Totalimpuestos			lxFaccompraTotrecar =  .Totalrecargos			lxFaccompraTotrecarsi =  .Totalrecargossinimpuestos			lxFaccompraTotdesc =  .Totaldescuentos
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8]
			text to lcSentencia noshow textmerge
				update ZooLogic.FACCOMPRA set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxFaccompraFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxFaccompraFaltafw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxFaccompraFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxFaccompraFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxFaccompraFd2 ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxFaccompraFcuit ) + "'">>, "Idcaja" = <<lxFaccompraIdcaja>>, "Fpodes1" = <<lxFaccompraFpodes1>>, "Fpodes2" = <<lxFaccompraFpodes2>>, "Fpodes" = <<lxFaccompraFpodes>>, "Fturno" = <<lxFaccompraFturno>>, "Numint" = <<lxFaccompraNumint>>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxFaccompraEsttrans ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxFaccompraFhora ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraSmodifw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxFaccompraValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxFaccompraZadsfw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraVmodifw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxFaccompraDescfw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraSaltafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxFaccompraSimbmon ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxFaccompraHoraexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxFaccompraHaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxFaccompraHmodifw ) + "'">>, "Totalcant" = <<lxFaccompraTotalcant>>, "Timestamp" = <<lxFaccompraTimestamp>>, "Desmntosi2" = <<lxFaccompraDesmntosi2>>, "Subtotcisi" = <<lxFaccompraSubtotcisi>>, "Subtotsisi" = <<lxFaccompraSubtotsisi>>, "Signomov" = <<lxFaccompraSignomov>>, "Facttipo" = <<lxFaccompraFacttipo>>, "Condivalp" = <<lxFaccompraCondivalp>>, "Desmntosi1" = <<lxFaccompraDesmntosi1>>, "Sitfiscpro" = <<lxFaccompraSitfiscpro>>, "Recmntosi" = <<lxFaccompraRecmntosi>>, "Fsubtot" = <<lxFaccompraFsubtot>>, "Fsubton" = <<lxFaccompraFsubton>>, "Recmntosi1" = <<lxFaccompraRecmntosi1>>, "Desmntosi" = <<lxFaccompraDesmntosi>>, "Recmntosi2" = <<lxFaccompraRecmntosi2>>, "Anulado" = <<iif( lxFaccompraAnulado, 1, 0 )>>, "Fcompfis" = <<iif( lxFaccompraFcompfis, 1, 0 )>>, "Desauto" = <<iif( lxFaccompraDesauto, 1, 0 )>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxFaccompraIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxFaccompraMonsis ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxFaccompraFobs ) + "'">>, "Fmtdes2" = <<lxFaccompraFmtdes2>>, "Fmtdes1" = <<lxFaccompraFmtdes1>>, "Fdescu" = <<lxFaccompraFdescu>>, "Fimpuesto" = <<lxFaccompraFimpuesto>>, "Tcrg1361" = <<lxFaccompraTcrg1361>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxFaccompraCodigo ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxFaccompraFfch ) + "'">>, "Ffchfac" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchfac ) + "'">>, "Fmtdes3" = <<lxFaccompraFmtdes3>>, "Desmntosi3" = <<lxFaccompraDesmntosi3>>, "Impman" = <<iif( lxFaccompraImpman, 1, 0 )>>, "Fletra" = <<"'" + this.FormatearTextoSql( lxFaccompraFletra ) + "'">>, "Recpor" = <<lxFaccompraRecpor>>, "Totdescsi" = <<lxFaccompraTotdescsi>>, "Fptovenext" = <<lxFaccompraFptovenext>>, "Mr" = <<lxFaccompraMr>>, "Cotiz" = <<lxFaccompraCotiz>>, "Condpago" = <<"'" + this.FormatearTextoSql( lxFaccompraCondpago ) + "'">>, "Fnumcomp" = <<lxFaccompraFnumcomp>>, "Ffchvenc" = <<"'" + this.ConvertirDateSql( lxFaccompraFfchvenc ) + "'">>, "Recmnto" = <<lxFaccompraRecmnto>>, "Recmnto1" = <<lxFaccompraRecmnto1>>, "Fvuelto" = <<lxFaccompraFvuelto>>, "Fptoven" = <<lxFaccompraFptoven>>, "Ncai" = <<lxFaccompraNcai>>, "Recmnto2" = <<lxFaccompraRecmnto2>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxFaccompraMoneda ) + "'">>, "Fperson" = <<"'" + this.FormatearTextoSql( lxFaccompraFperson ) + "'">>, "Ccosto" = <<"'" + this.FormatearTextoSql( lxFaccompraCcosto ) + "'">>, "Fvtocai" = <<"'" + this.ConvertirDateSql( lxFaccompraFvtocai ) + "'">>, "Ftotal" = <<lxFaccompraFtotal>>, "Recmonto1" = <<lxFaccompraRecmonto1>>, "Recmonto2" = <<lxFaccompraRecmonto2>>, "Disccos" = <<"'" + this.FormatearTextoSql( lxFaccompraDisccos ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxFaccompraCodlista ) + "'">>, "Nroremito" = <<"'" + this.FormatearTextoSql( lxFaccompraNroremito ) + "'">>, "Totimpue" = <<lxFaccompraTotimpue>>, "Totrecar" = <<lxFaccompraTotrecar>>, "Totrecarsi" = <<lxFaccompraTotrecarsi>>, "Totdesc" = <<lxFaccompraTotdesc>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'FACCOMPRA' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.FacCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ValFacComp where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpFacComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpFacc where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_numero = loItem.Afe_numero
					lxAfe_letra = loItem.Afe_letra
					lxIditemarticulos = loItem.Iditemarticulos
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_porcentajeivacompras = loItem.Articulo_porcentajeivacompras
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxArticulo_condicionivacompras = loItem.Articulo_condicionivacompras
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_saldo = loItem.Afe_saldo
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxNroitem = lnContadorNroItem
					lxNeto = loItem.Neto
					lxOferta = loItem.Oferta
					lxMontoiva = loItem.Montoiva
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxComportamiento = loItem.Comportamiento
					lxKit = loItem.Kit
					lxIdorigen = loItem.Idorigen
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxCentrodecosto_PK = loItem.Centrodecosto_PK
					lxDistribucioncentrodecosto_PK = loItem.Distribucioncentrodecosto_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.FacCompraDet("AfePTOVEN","AfeNUMCOM","AfeLETRA","IdItem","FAMate","afe_Cod","AfeTS","MNTPRECCI","APorcIvaC","ArtPercep","MNTPTOT","ACondIvaC","AfeCANT","AfeSaldo","MNTPRECSI","MNDESSI","AjuCImp","FBruto","MNDESCI","MNPDSI","MNTPDESCI","MNTPDESSI","AfeTipoCom","MNTPPER","AfeNroItem","AjuSImp","NroItem","FNETO","FX2","FmtoIVA","FporCFI","FmtoCFI","FmtoDTO1","FCFITot","COMP","FKIT","iditemOrig","FporDTO1","fporIva","ciditem","FN11","Prunsinimp","FPRUN","prunconimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","CCOSTO","DCCOSTO","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_porcentajeivacompras>>, <<lxPercepcionivarg5329>>, <<lxMontoprorrateototal>>, <<lxArticulo_condicionivacompras>>, <<lxAfe_cantidad>>, <<lxAfe_saldo>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxAfe_tipocomprobante>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_nroitem>>, <<lxAjusteporredondeosinimpuestos>>, <<lxNroitem>>, <<lxNeto>>, <<lxOferta>>, <<lxMontoiva>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxComportamiento>>, <<lxKit>>, <<lxIdorigen>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<lxPrecioconimpuestos>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCentrodecosto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxDistribucioncentrodecosto_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxFechacomp = loItem.Fechacomp
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxNrodocumento = loItem.Nrodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxLetra = loItem.Letra
					lxTipodocumento = loItem.Tipodocumento
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxTurno = loItem.Turno
					lxNumerocupon = loItem.Numerocupon
					lxNroitem = lnContadorNroItem
					lxCotiza = loItem.Cotiza
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxPesosalcambio = loItem.Pesosalcambio
					lxPuntodeventa = loItem.Puntodeventa
					lxTipo = loItem.Tipo
					lxSigno = loItem.Signo
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxIditemcomponente = loItem.Iditemcomponente
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ValFacComp("FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<lxUltimacotizacion>>, <<lxTurno>>, <<lxNumerocupon>>, <<lxNroitem>>, <<lxCotiza>>, <<lxNumerodecomprobante>>, <<lxPesosalcambio>>, <<lxPuntodeventa>>, <<lxTipo>>, <<lxSigno>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecargosinpercepciones>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxNroitem = lnContadorNroItem
					lxMontonogravado = loItem.Montonogravado
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacComp("IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo" ) values ( <<lxMontonogravadosindescuento>>, <<lxNroitem>>, <<lxMontonogravado>>, <<lxMontodeivasindescuento>>, <<lxPorcentajedeiva>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxNroitem = lnContadorNroItem
					lxMinimonoimponible = loItem.Minimonoimponible
					lxPorcentaje = loItem.Porcentaje
					lxCodimp_PK = loItem.Codimp_PK
					lxCodimpdetalle = loItem.Codimpdetalle
					lxMonto = loItem.Monto
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ImpFacc("TipoI","codint","NroItem","minoimp","porcen","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<lxNroitem>>, <<lxMinimonoimponible>>, <<lxPorcentaje>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodimp_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodimpdetalle ) + "'">>, <<lxMonto>>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasDelete() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8]
		loColeccion.Agregar( 'delete from ZooLogic.FACCOMPRA where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.FacCompraDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ValFacComp where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpFacComp where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpFacc where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'FACCOMPRA' 
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerObjetoBusqueda() as Void
		return newobject( 'ObjetoBusqueda', '', '', this.oEntidad )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectNuevoEnBaseA() as String
		Local lcAtributos As String, lcWhere As String
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Iditem" as "Iditemarticulos", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Aporcivac" as "Articulo_porcentajeivacompras", "Artpercep" as "Percepcionivarg5329", "Mntptot" as "Montoprorrateototal", "Acondivac" as "Articulo_condicionivacompras", "Afecant" as "Afe_cantidad", "Afesaldo" as "Afe_saldo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Afetipocom" as "Afe_tipocomprobante", "Mntpper" as "Montoprorrateopercepciones", "Afenroitem" as "Afe_nroitem", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Nroitem" as "Nroitem", "Fneto" as "Neto", "Fx2" as "Oferta", "Fmtoiva" as "Montoiva", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Comp" as "Comportamiento", "Fkit" as "Kit", "Iditemorig" as "Idorigen", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Prunconimp" as "Precioconimpuestos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Fart" as "Articulo", "Codigo" as "Codigo", "Funid" as "Unidad", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Seniacance" as "Idseniacancelada", "Mntpiva" as "Montoprorrateoiva", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Ccosto" as "Centrodecosto", "Dccosto" as "Distribucioncentrodecosto", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
		return lcAtributos
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompTipodecomprobantedecompra.lNuevo = .EsNuevo()
			.oCompTipodecomprobantedecompra.lEdicion = .EsEdicion()
			.oCompTipodecomprobantedecompra.lEliminar = .lEliminar
			.oCompTipodecomprobantedecompra.lAnular = .lAnular
			loColSentencias = .oCompTipodecomprobantedecompra.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.oCompEnbasea.lNuevo = .EsNuevo()
			.oCompEnbasea.lEdicion = .EsEdicion()
			.oCompEnbasea.lEliminar = .lEliminar
			.oCompEnbasea.lAnular = .lAnular
			loColSentencias = .oCompEnbasea.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
		with this.oEntidad
			.FacturaDetalle.oItem.oCompStock.lNuevo = .EsNuevo()
			.FacturaDetalle.oItem.oCompStock.lEdicion = .EsEdicion()
			.FacturaDetalle.oItem.oCompStock.lEliminar = .lEliminar
			.FacturaDetalle.oItem.oCompStock.lAnular = .lAnular
			loColSentencias = .FacturaDetalle.oItem.oCompStock.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.FacturaDetalle.oItem.oCompPrecios.lNuevo = .EsNuevo()
			.FacturaDetalle.oItem.oCompPrecios.lEdicion = .EsEdicion()
			.FacturaDetalle.oItem.oCompPrecios.lEliminar = .lEliminar
			.FacturaDetalle.oItem.oCompPrecios.lAnular = .lAnular
			loColSentencias = .FacturaDetalle.oItem.oCompPrecios.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.ValoresDetalle.oItem.oCompCajero.lNuevo = .EsNuevo()
			.ValoresDetalle.oItem.oCompCajero.lEdicion = .EsEdicion()
			.ValoresDetalle.oItem.oCompCajero.lEliminar = .lEliminar
			.ValoresDetalle.oItem.oCompCajero.lAnular = .lAnular
			loColSentencias = .ValoresDetalle.oItem.oCompCajero.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerSentenciaActualizacionTimeStamp() As String
		local lnTimeStamp as integer, lcRetorno as string, lcUpdateRealTime as string
		with this.oEntidad
		
			lnTimeStamp = goLibrerias.ObtenerTimestamp()
			lcUpdateRealTime = ", "+this.obtenercampoentidad("fechamodificacionfw")+" = "+goServicios.Datos.ObtenerFechaFormateada(goServicios.Librerias.ObtenerFecha());
			+ ", "+this.obtenercampoentidad("horamodificacionfw")+" = '"+goServicios.Librerias.ObtenerHora()+"'"
			lcRetorno = [update ZooLogic.FACCOMPRA set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.FACCOMPRA where  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8" )
			this.xmlacursor( lcXml, 'c_CantReg' )
		lnCantReg = c_CantReg.Total
		use in select('c_CantReg')
		return lnCantReg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTimestampActual() as integer
		local lnTimeStamp as integer, lcCursor as string
		lnTimeStamp = 0
		lcCursor = sys(2015)

			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.FACCOMPRA where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8" )
			this.xmlacursor( lcXml, lcCursor )
		if reccount( lcCursor ) > 0
			lnTimeStamp = &lcCursor..Timestamp
		endif
		use in select( lcCursor )

		return lnTimeStamp 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarNumeraciones() as void
		local loError as exception
		dodefault()

		with this.oEntidad
			if .VerificarContexto( 'C' )
			else
				.lCargando = .t.
				try
					if empty( .oNumeraciones.ObtenerServicio('NUMINT') ) and iif( type( '.NUMINT' ) = 'C', int( val( .NUMINT ) ),.NUMINT ) = .oNumeraciones.UltimoNumero( 'NUMINT' )
						.oNumeraciones.Actualizar( 'NUMINT' )
					endif
				catch to loError
					goServicios.Errores.LevantarExcepcion( loError ) 
				finally
					.lCargando = .f.
				endtry
			endif
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function GrabarNumeraciones() as void

		dodefault()

		with this.oEntidad
			.lCargando = .t.
			Try
				If .VerificarContexto( 'C' )
				Else
					.NUMINT = .oNumeraciones.grabar( 'NUMINT' )
				EndIf
			Catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			Finally
				.lCargando = .f.
			EndTry
		endwith
		
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirCabecera( tlLoguear as Boolean ) As Void
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxFacCompraNumInt as variant, lxFacCompraFACTTIPO as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.FACCOMPRA Where  NumInt = ] + transform( &lcCursor..NumInt     ) + [ and FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						if this.oEntidad.cContexto == 'C'
							if curSeek.ANULADO
								Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.FACCOMPRA set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, NumInt = ] + transform( &lcCursor..NumInt )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, SitFiscPro = ] + transform( &lcCursor..SitFiscPro )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, tcrg1361 = ] + transform( &lcCursor..tcrg1361 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FFCHFAC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'"+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, ImpMan = ] + Transform( iif( &lcCursor..ImpMan, 1, 0 ))+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, FPTOVENEXT = ] + transform( &lcCursor..FPTOVENEXT )+ [, MR = ] + transform( &lcCursor..MR )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, CONDPAGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FFCHVENC = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'"+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, NCAI = ] + transform( &lcCursor..NCAI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, CCosto = ] + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'"+ [, FVTOCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, RecMonto1 = ] + transform( &lcCursor..RecMonto1 )+ [, RecMonto2 = ] + transform( &lcCursor..RecMonto2 )+ [, DisCCos = ] + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, NROREMITO = ] + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'"+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, totdesc = ] + transform( &lcCursor..totdesc ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica anulado ).', tlLoguear )
							else
								this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe y no esta anulado.', tlLoguear )
							endif
						else
							this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque ya existe.', tlLoguear )
						endif
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.FACCOMPRA Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FMODIFW, FALTAFW, FECEXPO, FECTRANS, FECIMPO, FD2, fCuit, IdCaja, FPODES1, FPODES2, FPODES, FTurno, NumInt, BDMODIFW, BDALTAFW, ESTTRANS, FHORA, UALTAFW, SMODIFW, UMODIFW, VALTAFW, ZADSFW, VMODIFW, DescFW, SALTAFW, SimbMon, HORAIMPO, HORAEXPO, HALTAFW, HMODIFW, TotalCant, TIMESTAMP, DesMntoSI2, SubTotCISI, SubTotSISI, signomov, FACTTIPO, CondivaLp, DesMntoSI1, SitFiscPro, RecMntoSI, FSubTOT, fSubToN, RecMntoSI1, DesMntoSI, RecMntoSI2, Anulado, FCOMPFIS, DesAuto, idVuelto, MonSis, FObs, FMTDES2, FMTDES1, fDescu, fImpuesto, tcrg1361, CODIGO, FFCH, FFCHFAC, FMTDES3, DesMntoSI3, ImpMan, FLETRA, RecPor, totdescSI, FPTOVENEXT, MR, Cotiz, CONDPAGO, FNUMCOMP, FFCHVENC, RecMnto, RecMnto1, FVuelto, FPTOVEN, NCAI, RecMnto2, Moneda, FPerson, CCosto, FVTOCAI, FTotal, RecMonto1, RecMonto2, DisCCos, CodLista, NROREMITO, totimpue, totrecar, totrecarSI, totdesc
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..NumInt ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..SitFiscPro )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FMTDES2 ) + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..tcrg1361 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHFAC ) + "'" + ',' + transform( &lcCursor..FMTDES3 ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + Transform( iif( &lcCursor..ImpMan, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..totdescSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVENEXT ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CONDPAGO ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVENC ) + "'" + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..FVuelto )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..NCAI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CCosto ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FVTOCAI ) + "'" + ',' + transform( &lcCursor..FTotal )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..RecMonto1 ) + ',' + transform( &lcCursor..RecMonto2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DisCCos ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..NROREMITO ) + "'" + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..totdesc )
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.FACCOMPRA ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					lcCampo = lcCursor + '.' + this.cCampoCodigoWH
					this.AgregarMensajeWebHook( 'INGRESAR', &lcCampo )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.FacCompraDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ValFacComp Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpFacComp Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpFacc Where cCod] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfePTOVEN","AfeNUMCOM","AfeLETRA","IdItem","FAMate","afe_Cod","AfeTS","MNTPRECCI","APorcIvaC","ArtPercep","MNTPTOT","ACondIvaC","AfeCANT","AfeSaldo","MNTPRECSI","MNDESSI","AjuCImp","FBruto","MNDESCI","MNPDSI","MNTPDESCI","MNTPDESSI","AfeTipoCom","MNTPPER","AfeNroItem","AjuSImp","NroItem","FNETO","FX2","FmtoIVA","FporCFI","FmtoCFI","FmtoDTO1","FCFITot","COMP","FKIT","iditemOrig","FporDTO1","fporIva","ciditem","FN11","Prunsinimp","FPRUN","prunconimp","ProcStock","UsarPLista","FART","CODIGO","FUnid","Equiv","FTXT","FCOLO","seniacance","MNTPIVA","FCOTXT","FTALL","CCOSTO","DCCOSTO","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.FacCompraDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_Cod    ) + "'" + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.APorcIvaC  ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.ACondIvaC  ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CCOSTO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DCCOSTO    ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORESCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"FechCoti","JJfecha","IdCaja","JJVen","NroTarjeta","NroDoc","TIPCOMP","Letra","TipoDoc","Cotiza","JJTurno","NroCupon","NroItem","JJCotiz","NumCompr","Pesos","PtoVenta","JJT","Signo","PersComp","CElectro","VisualCaja","CondPago","NroCheque","NroChProp","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","jrecmnt","JJTotFac","jrecmntsi","Montosiste","jrrecsperc","guidComp","permvuelto","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ValFacComp ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CondPago   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOSC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IVAMNGSD","NROITEM","IVAMonNG","IVAMonSD","IVAPorcent","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpFacComp ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOCOMPRA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"TipoI","codint","NroItem","minoimp","porcen","cCod","CodImp","Descri","Monto","ArtPercep","ArtPerce"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpFacc ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + transform( cDetallesExistentes.Monto      ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + Transform( iif( cDetallesExistentes.ArtPerce  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCOMPRA',this.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCOMPRA',this.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA')
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORESCOMPRA',this.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSCOMPRA', this.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número interno: ' + transform( &tcCursor..NumInt     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function AgregarMensajeWebHook( tcEvento as String, tcCodigo as String ) As Void

		if ( alltrim( tcEvento ) = 'MODIFICAR' and this.oEntidad.lWHModificar ) or ( alltrim( tcEvento ) = 'INGRESAR' and this.oEntidad.lWHIngresar )
			goServicios.WebHook.AgregarMensajeALaCola( tcEvento, tcCodigo, this.oEntidad.cNombre )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function EnviarColaWebHook() As Void
		goServicios.WebHook.EnviarColaDeMensajes( this.oEntidad.cNombre )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'FACTURADECOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FACTURADECOMPRA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FACTURADECOMPRA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORESCOMPRA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOSC'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOCOMPRA'
				llRetorno = .T.
		EndCase
		Return llRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	Function ImportarTablaDeTrabajo( toConexion as Object ) As Void
		local llEjecutarRollback as Boolean
		llEjecutarRollback = .F.
		try
			do While this.nCantVeces > 0
				this.nCantVeces = this.nCantVeces - 1

				this.InicializarMensajesConexion()

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_FacCompra')

				if this.oMensajesConexion.Count>0
					goServicios.Errores.LevantarExcepcion( this.ObtenerMensajesConexion() )
				endif

			enddo
		catch to loError
			goServicios.Errores.LevantarExcepcion( loError )
		endtry
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	protected function ValidarDatosAImportar() as boolean
		local lcCursor as String, llRetorno as boolean, lxVar as Variant, llCondicion as boolean
		lcCursor = This.oEntidad.cPrefijoImportar + 'FACTURADECOMPRA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..NumInt ) or isnull( &lcCursor..FACTTIPO )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FACTURADECOMPRA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( NumInt, 10, 0) + str( FACTTIPO, 2, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( NumInt, 10, 0) + str( FACTTIPO, 2, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FFCHFAC   
		* Validar ANTERIORES A 1/1/1753  FFCHVENC  
		* Validar ANTERIORES A 1/1/1753  FVTOCAI   
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_FacCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_FacCompra
Create Table ZooLogic.TablaTrabajo_FacCompra ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fturno" numeric( 1, 0 )  null, 
"numint" numeric( 10, 0 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"fhora" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"vmodifw" char( 13 )  null, 
"descfw" char( 200 )  null, 
"saltafw" char( 7 )  null, 
"simbmon" char( 3 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"haltafw" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi2" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"desmntosi1" numeric( 15, 2 )  null, 
"sitfiscpro" numeric( 2, 0 )  null, 
"recmntosi" numeric( 15, 2 )  null, 
"fsubtot" numeric( 15, 2 )  null, 
"fsubton" numeric( 15, 2 )  null, 
"recmntosi1" numeric( 15, 2 )  null, 
"desmntosi" numeric( 15, 2 )  null, 
"recmntosi2" numeric( 15, 2 )  null, 
"anulado" bit  null, 
"fcompfis" bit  null, 
"desauto" bit  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"fobs" varchar(max)  null, 
"fmtdes2" numeric( 15, 2 )  null, 
"fmtdes1" numeric( 15, 2 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"tcrg1361" numeric( 2, 0 )  null, 
"codigo" char( 38 )  null, 
"ffch" datetime  null, 
"ffchfac" datetime  null, 
"fmtdes3" numeric( 15, 2 )  null, 
"desmntosi3" numeric( 15, 2 )  null, 
"impman" bit  null, 
"fletra" char( 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"totdescsi" numeric( 15, 2 )  null, 
"fptovenext" numeric( 5, 0 )  null, 
"mr" numeric( 15, 2 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"condpago" char( 5 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ffchvenc" datetime  null, 
"recmnto" numeric( 15, 2 )  null, 
"recmnto1" numeric( 15, 2 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"ncai" numeric( 14, 0 )  null, 
"recmnto2" numeric( 15, 2 )  null, 
"moneda" char( 10 )  null, 
"fperson" char( 10 )  null, 
"ccosto" char( 20 )  null, 
"fvtocai" datetime  null, 
"ftotal" numeric( 15, 2 )  null, 
"recmonto1" numeric( 15, 2 )  null, 
"recmonto2" numeric( 15, 2 )  null, 
"disccos" char( 20 )  null, 
"codlista" char( 6 )  null, 
"nroremito" char( 16 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"totrecar" numeric( 15, 2 )  null, 
"totrecarsi" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_FacCompra' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_FacCompra' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURADECOMPRA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('numint','numint')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('sitfiscpro','sitfiscpro')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('tcrg1361','tcrg1361')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ffchfac','ffchfac')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('impman','impman')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('fptovenext','fptovenext')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('condpago','condpago')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ffchvenc','ffchvenc')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('ncai','ncai')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('ccosto','ccosto')
			.AgregarMapeo('fvtocai','fvtocai')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('recmonto1','recmonto1')
			.AgregarMapeo('recmonto2','recmonto2')
			.AgregarMapeo('disccos','disccos')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('nroremito','nroremito')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('totdesc','totdesc')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_FacCompra'
			.ConsultaOrigen = 'select * from ' + lcCursor
			Select( lcCursor )
			Count to This.nCantVeces
			This.nCantVeces = ceiling( This.nCantVeces / This.nCantABorrar )
			if !this.oEntidad.VerificarContexto( 'CB' )
				use in ( lcCursor )
			endif
			.ImportarMasivamente( toConexion )
		endwith
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion( tcTablaTrabajo ) as String
		local lcCadena as String, lcTabla as String, lcEntidad as String, loLogueo as Object, lcDescripcionFW as string
		lcTabla = alltrim( Upper( tcTablaTrabajo ) )
		loLogueo = this.oLogueo.oInfoLog
		lcEntidad = alltrim( Upper( This.oEntidad.ObtenerNombre() ) )
		lcDescripcionFW = "IMPORTACION"
		Text to lcCadena noshow textmerge
			CREATE TRIGGER ZooLogic.DELETE_<<lcTabla>>
				ON ZooLogic.<<lcTabla>>
				AFTER DELETE
			As
			Begin
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.NUMINT = isnull( d.NUMINT, t.NUMINT ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.SITFISCPRO = isnull( d.SITFISCPRO, t.SITFISCPRO ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TCRG1361 = isnull( d.TCRG1361, t.TCRG1361 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FFCHFAC = isnull( d.FFCHFAC, t.FFCHFAC ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.IMPMAN = isnull( d.IMPMAN, t.IMPMAN ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.FPTOVENEXT = isnull( d.FPTOVENEXT, t.FPTOVENEXT ),t.MR = isnull( d.MR, t.MR ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FFCHVENC = isnull( d.FFCHVENC, t.FFCHVENC ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.NCAI = isnull( d.NCAI, t.NCAI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),t.FVTOCAI = isnull( d.FVTOCAI, t.FVTOCAI ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.RECMONTO1 = isnull( d.RECMONTO1, t.RECMONTO1 ),t.RECMONTO2 = isnull( d.RECMONTO2, t.RECMONTO2 ),t.DISCCOS = isnull( d.DISCCOS, t.DISCCOS ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.NROREMITO = isnull( d.NROREMITO, t.NROREMITO ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC )
					from ZooLogic.FACCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.NumInt = d.NumInt
							 and  t.FACTTIPO = d.FACTTIPO
				-- Fin Updates
				insert into ZooLogic.FACCOMPRA(Fmodifw,Faltafw,Fecexpo,Fectrans,Fecimpo,Fd2,Fcuit,Idcaja,Fpodes1,Fpodes2,Fpodes,Fturno,Numint,Bdmodifw,Bdaltafw,Esttrans,Fhora,Ualtafw,Smodifw,Umodifw,Valtafw,Zadsfw,Vmodifw,Descfw,Saltafw,Simbmon,Horaimpo,Horaexpo,Haltafw,Hmodifw,Totalcant,Timestamp,Desmntosi2,Subtotcisi,Subtotsisi,Signomov,Facttipo,Condivalp,Desmntosi1,Sitfiscpro,Recmntosi,Fsubtot,Fsubton,Recmntosi1,Desmntosi,Recmntosi2,Anulado,Fcompfis,Desauto,Idvuelto,Monsis,Fobs,Fmtdes2,Fmtdes1,Fdescu,Fimpuesto,Tcrg1361,Codigo,Ffch,Ffchfac,Fmtdes3,Desmntosi3,Impman,Fletra,Recpor,Totdescsi,Fptovenext,Mr,Cotiz,Condpago,Fnumcomp,Ffchvenc,Recmnto,Recmnto1,Fvuelto,Fptoven,Ncai,Recmnto2,Moneda,Fperson,Ccosto,Fvtocai,Ftotal,Recmonto1,Recmonto2,Disccos,Codlista,Nroremito,Totimpue,Totrecar,Totrecarsi,Totdesc)
					Select isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPODES2,0),isnull( d.FPODES,0),isnull( d.FTURNO,0),isnull( d.NUMINT,0),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.FHORA,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VMODIFW,''),isnull( d.DESCFW,''),isnull( d.SALTAFW,''),isnull( d.SIMBMON,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HMODIFW,''),isnull( d.TOTALCANT,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI2,0),isnull( d.SUBTOTCISI,0),isnull( d.SUBTOTSISI,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.CONDIVALP,0),isnull( d.DESMNTOSI1,0),isnull( d.SITFISCPRO,0),isnull( d.RECMNTOSI,0),isnull( d.FSUBTOT,0),isnull( d.FSUBTON,0),isnull( d.RECMNTOSI1,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTOSI2,0),isnull( d.ANULADO,0),isnull( d.FCOMPFIS,0),isnull( d.DESAUTO,0),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.FOBS,''),isnull( d.FMTDES2,0),isnull( d.FMTDES1,0),isnull( d.FDESCU,0),isnull( d.FIMPUESTO,0),isnull( d.TCRG1361,0),isnull( d.CODIGO,''),isnull( d.FFCH,''),isnull( d.FFCHFAC,''),isnull( d.FMTDES3,0),isnull( d.DESMNTOSI3,0),isnull( d.IMPMAN,0),isnull( d.FLETRA,''),isnull( d.RECPOR,0),isnull( d.TOTDESCSI,0),isnull( d.FPTOVENEXT,0),isnull( d.MR,0),isnull( d.COTIZ,0),isnull( d.CONDPAGO,''),isnull( d.FNUMCOMP,0),isnull( d.FFCHVENC,''),isnull( d.RECMNTO,0),isnull( d.RECMNTO1,0),isnull( d.FVUELTO,0),isnull( d.FPTOVEN,0),isnull( d.NCAI,0),isnull( d.RECMNTO2,0),isnull( d.MONEDA,''),isnull( d.FPERSON,''),isnull( d.CCOSTO,''),isnull( d.FVTOCAI,''),isnull( d.FTOTAL,0),isnull( d.RECMONTO1,0),isnull( d.RECMONTO2,0),isnull( d.DISCCOS,''),isnull( d.CODLISTA,''),isnull( d.NROREMITO,''),isnull( d.TOTIMPUE,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TOTDESC,0)
						From deleted d left join ZooLogic.FACCOMPRA pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.FACCOMPRA cc 
							 on  d.NumInt = cc.NumInt
							 and  d.FACTTIPO = cc.FACTTIPO
						Where pk.CODIGO Is Null 
							 and cc.NumInt Is Null 
							 and cc.FACTTIPO Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.NumInt as Varchar(10) ) + ',  ' + cast( d.FACTTIPO as Varchar(2) ) + '','La clave principal no es la esperada'
					from ZooLogic.FACCOMPRA t inner join deleted d 
							on   t.NumInt = d.NumInt
							 and  t.FACTTIPO = d.FACTTIPO
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO INTERNO ' + cast( d.NumInt as Varchar(10) ) + ',  ' + cast( d.FACTTIPO as Varchar(2) ) + '','La clave principal a importar ya existe'
					from ZooLogic.FACCOMPRA t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.NumInt = h.NumInt
							 and   t.FACTTIPO = h.FACTTIPO
							where   h.NumInt is null 
							 and   h.FACTTIPO is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_FACCOMPRA_CompAfe
ON ZooLogic.TablaTrabajo_FACCOMPRA_CompAfe
AFTER DELETE
As
Begin
Update t Set 
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFECOMPROB = isnull( d.AFECOMPROB, t.AFECOMPROB ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEFECHA = isnull( d.AFEFECHA, t.AFEFECHA ),
t.AFETOTAL = isnull( d.AFETOTAL, t.AFETOTAL ),
t.AFEVEND = isnull( d.AFEVEND, t.AFEVEND ),
t.AFETIPO = isnull( d.AFETIPO, t.AFETIPO ),
t.AFECTA = isnull( d.AFECTA, t.AFECTA ),
t.DESCINTER = isnull( d.DESCINTER, t.DESCINTER ),
t.NOMINTER = isnull( d.NOMINTER, t.NOMINTER ),
t.CODINTER = isnull( d.CODINTER, t.CODINTER ),
t.ORIGEN = isnull( d.ORIGEN, t.ORIGEN )
from ZooLogic.CompAfe t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.CompAfe
( 
"AFETIPOCOM",
"NROITEM",
"CODIGO",
"AFECOMPROB",
"AFELETRA",
"AFEPTOVEN",
"AFENUMCOM",
"AFEFECHA",
"AFETOTAL",
"AFEVEND",
"AFETIPO",
"AFECTA",
"DESCINTER",
"NOMINTER",
"CODINTER",
"ORIGEN"
 )
Select 
d.AFETIPOCOM,
d.NROITEM,
d.CODIGO,
d.AFECOMPROB,
d.AFELETRA,
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFEFECHA,
d.AFETOTAL,
d.AFEVEND,
d.AFETIPO,
d.AFECTA,
d.DESCINTER,
d.NOMINTER,
d.CODINTER,
d.ORIGEN
From deleted d left join ZooLogic.CompAfe pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_FacCompraDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_FACCOMPRA_FacCompraDet
ON ZooLogic.TablaTrabajo_FACCOMPRA_FacCompraDet
AFTER DELETE
As
Begin
Update t Set 
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.APORCIVAC = isnull( d.APORCIVAC, t.APORCIVAC ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.ACONDIVAC = isnull( d.ACONDIVAC, t.ACONDIVAC ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.FART = isnull( d.FART, t.FART ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.CCOSTO = isnull( d.CCOSTO, t.CCOSTO ),
t.DCCOSTO = isnull( d.DCCOSTO, t.DCCOSTO ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.FacCompraDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.FacCompraDet
( 
"AFEPTOVEN",
"AFENUMCOM",
"AFELETRA",
"IDITEM",
"FAMATE",
"AFE_COD",
"AFETS",
"MNTPRECCI",
"APORCIVAC",
"ARTPERCEP",
"MNTPTOT",
"ACONDIVAC",
"AFECANT",
"AFESALDO",
"MNTPRECSI",
"MNDESSI",
"AJUCIMP",
"FBRUTO",
"MNDESCI",
"MNPDSI",
"MNTPDESCI",
"MNTPDESSI",
"AFETIPOCOM",
"MNTPPER",
"AFENROITEM",
"AJUSIMP",
"NROITEM",
"FNETO",
"FX2",
"FMTOIVA",
"FPORCFI",
"FMTOCFI",
"FMTODTO1",
"FCFITOT",
"COMP",
"FKIT",
"IDITEMORIG",
"FPORDTO1",
"FPORIVA",
"CIDITEM",
"FN11",
"PRUNSINIMP",
"FPRUN",
"PRUNCONIMP",
"PROCSTOCK",
"USARPLISTA",
"FART",
"CODIGO",
"FUNID",
"EQUIV",
"FTXT",
"FCOLO",
"SENIACANCE",
"MNTPIVA",
"FCOTXT",
"FTALL",
"CCOSTO",
"DCCOSTO",
"FCANT",
"FPRECIO",
"FCFI",
"MNTDES",
"FMONTO"
 )
Select 
d.AFEPTOVEN,
d.AFENUMCOM,
d.AFELETRA,
d.IDITEM,
d.FAMATE,
d.AFE_COD,
d.AFETS,
d.MNTPRECCI,
d.APORCIVAC,
d.ARTPERCEP,
d.MNTPTOT,
d.ACONDIVAC,
d.AFECANT,
d.AFESALDO,
d.MNTPRECSI,
d.MNDESSI,
d.AJUCIMP,
d.FBRUTO,
d.MNDESCI,
d.MNPDSI,
d.MNTPDESCI,
d.MNTPDESSI,
d.AFETIPOCOM,
d.MNTPPER,
d.AFENROITEM,
d.AJUSIMP,
d.NROITEM,
d.FNETO,
d.FX2,
d.FMTOIVA,
d.FPORCFI,
d.FMTOCFI,
d.FMTODTO1,
d.FCFITOT,
d.COMP,
d.FKIT,
d.IDITEMORIG,
d.FPORDTO1,
d.FPORIVA,
d.CIDITEM,
d.FN11,
d.PRUNSINIMP,
d.FPRUN,
d.PRUNCONIMP,
d.PROCSTOCK,
d.USARPLISTA,
d.FART,
d.CODIGO,
d.FUNID,
d.EQUIV,
d.FTXT,
d.FCOLO,
d.SENIACANCE,
d.MNTPIVA,
d.FCOTXT,
d.FTALL,
d.CCOSTO,
d.DCCOSTO,
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.FacCompraDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ValFacComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_FACCOMPRA_ValFacComp
ON ZooLogic.TablaTrabajo_FACCOMPRA_ValFacComp
AFTER DELETE
As
Begin
Update t Set 
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJT = isnull( d.JJT, t.JJT ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JRECPORC = isnull( d.JRECPORC, t.JRECPORC ),
t.JRECMNT = isnull( d.JRECMNT, t.JRECMNT ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.JRECMNTSI = isnull( d.JRECMNTSI, t.JRECMNTSI ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.JRRECSPERC = isnull( d.JRRECSPERC, t.JRRECSPERC ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.ValFacComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ValFacComp
( 
"FECHCOTI",
"JJFECHA",
"IDCAJA",
"JJVEN",
"NROTARJETA",
"NRODOC",
"TIPCOMP",
"LETRA",
"TIPODOC",
"COTIZA",
"JJTURNO",
"NROCUPON",
"NROITEM",
"JJCOTIZ",
"NUMCOMPR",
"PESOS",
"PTOVENTA",
"JJT",
"SIGNO",
"PERSCOMP",
"CELECTRO",
"VISUALCAJA",
"CONDPAGO",
"NROCHEQUE",
"NROCHPROP",
"JJNUM",
"JJCO",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"JRECPORC",
"JRECMNT",
"JJTOTFAC",
"JRECMNTSI",
"MONTOSISTE",
"JRRECSPERC",
"GUIDCOMP",
"PERMVUELTO",
"VALECAMBIO"
 )
Select 
d.FECHCOTI,
d.JJFECHA,
d.IDCAJA,
d.JJVEN,
d.NROTARJETA,
d.NRODOC,
d.TIPCOMP,
d.LETRA,
d.TIPODOC,
d.COTIZA,
d.JJTURNO,
d.NROCUPON,
d.NROITEM,
d.JJCOTIZ,
d.NUMCOMPR,
d.PESOS,
d.PTOVENTA,
d.JJT,
d.SIGNO,
d.PERSCOMP,
d.CELECTRO,
d.VISUALCAJA,
d.CONDPAGO,
d.NROCHEQUE,
d.NROCHPROP,
d.JJNUM,
d.JJCO,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.JRECPORC,
d.JRECMNT,
d.JJTOTFAC,
d.JRECMNTSI,
d.MONTOSISTE,
d.JRRECSPERC,
d.GUIDCOMP,
d.PERMVUELTO,
d.VALECAMBIO
From deleted d left join ZooLogic.ValFacComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpFacComp( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_FACCOMPRA_ImpFacComp
ON ZooLogic.TablaTrabajo_FACCOMPRA_ImpFacComp
AFTER DELETE
As
Begin
Update t Set 
t.IVAMNGSD = isnull( d.IVAMNGSD, t.IVAMNGSD ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.IVAMONNG = isnull( d.IVAMONNG, t.IVAMONNG ),
t.IVAMONSD = isnull( d.IVAMONSD, t.IVAMONSD ),
t.IVAPORCENT = isnull( d.IVAPORCENT, t.IVAPORCENT ),
t.IVAMONTO = isnull( d.IVAMONTO, t.IVAMONTO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.ImpFacComp t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpFacComp
( 
"IVAMNGSD",
"NROITEM",
"IVAMONNG",
"IVAMONSD",
"IVAPORCENT",
"IVAMONTO",
"CODIGO"
 )
Select 
d.IVAMNGSD,
d.NROITEM,
d.IVAMONNG,
d.IVAMONSD,
d.IVAPORCENT,
d.IVAMONTO,
d.CODIGO
From deleted d left join ZooLogic.ImpFacComp pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpFacc( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_FACCOMPRA_ImpFacc
ON ZooLogic.TablaTrabajo_FACCOMPRA_ImpFacc
AFTER DELETE
As
Begin
Update t Set 
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.ARTPERCE = isnull( d.ARTPERCE, t.ARTPERCE )
from ZooLogic.ImpFacc t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpFacc
( 
"TIPOI",
"CODINT",
"NROITEM",
"MINOIMP",
"PORCEN",
"CCOD",
"CODIMP",
"DESCRI",
"MONTO",
"ARTPERCEP",
"ARTPERCE"
 )
Select 
d.TIPOI,
d.CODINT,
d.NROITEM,
d.MINOIMP,
d.PORCEN,
d.CCOD,
d.CODIMP,
d.DESCRI,
d.MONTO,
d.ARTPERCEP,
d.ARTPERCE
From deleted d left join ZooLogic.ImpFacc pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	protected Function EliminarTablasDeTrabajo( toConexion as Object ) as void
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_FacCompra') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_FacCompra
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FACTURADECOMPRA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_FACTURADECOMPRA.Cuit, [] )
					.Caja_PK =  nvl( c_FACTURADECOMPRA.Caja, 0 )
					.Porcentajedescuento1 = nvl( c_FACTURADECOMPRA.Porcentajedescuento1, 0 )
					.Porcentajedescuento2 = nvl( c_FACTURADECOMPRA.Porcentajedescuento2, 0 )
					.Porcentajedescuento = nvl( c_FACTURADECOMPRA.Porcentajedescuento, 0 )
					.Turno = nvl( c_FACTURADECOMPRA.Turno, 0 )
					.Numint = nvl( c_FACTURADECOMPRA.Numint, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Basededatosmodificacionfw = nvl( c_FACTURADECOMPRA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_FACTURADECOMPRA.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_FACTURADECOMPRA.Estadotransferencia, [] )
					.Hora = nvl( c_FACTURADECOMPRA.Hora, [] )
					.Usuarioaltafw = nvl( c_FACTURADECOMPRA.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_FACTURADECOMPRA.Seriemodificacionfw, [] )
					.Usuariomodificacionfw = nvl( c_FACTURADECOMPRA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_FACTURADECOMPRA.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionmodificacionfw = nvl( c_FACTURADECOMPRA.Versionmodificacionfw, [] )
					.Descripcionfw = nvl( c_FACTURADECOMPRA.Descripcionfw, [] )
					.Seriealtafw = nvl( c_FACTURADECOMPRA.Seriealtafw, [] )
					.Simbolomonetariocomprobante = nvl( c_FACTURADECOMPRA.Simbolomonetariocomprobante, [] )
					.Horaimpo = nvl( c_FACTURADECOMPRA.Horaimpo, [] )
					.Horaexpo = nvl( c_FACTURADECOMPRA.Horaexpo, [] )
					.Horaaltafw = nvl( c_FACTURADECOMPRA.Horaaltafw, [] )
					.Horamodificacionfw = nvl( c_FACTURADECOMPRA.Horamodificacionfw, [] )
					.Totalcantidad = nvl( c_FACTURADECOMPRA.Totalcantidad, 0 )
					.Timestamp = nvl( c_FACTURADECOMPRA.Timestamp, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos2, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_FACTURADECOMPRA.Subtotalconimpuestossobreitems, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_FACTURADECOMPRA.Subtotalsinimpuestossobreitems, 0 )
					.Signodemovimiento = nvl( c_FACTURADECOMPRA.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_FACTURADECOMPRA.Tipocomprobante, 0 )
					.Condicioniva = nvl( c_FACTURADECOMPRA.Condicioniva, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos1, 0 )
					.Situacionfiscal_PK =  nvl( c_FACTURADECOMPRA.Situacionfiscal, 0 )
					.Recargomontosinimpuestos = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos, 0 )
					.Subtotalbruto = nvl( c_FACTURADECOMPRA.Subtotalbruto, 0 )
					.Subtotalneto = nvl( c_FACTURADECOMPRA.Subtotalneto, 0 )
					.Recargomontosinimpuestos1 = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos1, 0 )
					.Montodescuentosinimpuestos = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos, 0 )
					.Recargomontosinimpuestos2 = nvl( c_FACTURADECOMPRA.Recargomontosinimpuestos2, 0 )
					.Anulado = nvl( c_FACTURADECOMPRA.Anulado, .F. )
					.Comprobantefiscal = nvl( c_FACTURADECOMPRA.Comprobantefiscal, .F. )
					.Descuentoautomatico = nvl( c_FACTURADECOMPRA.Descuentoautomatico, .F. )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Idvuelto_PK =  nvl( c_FACTURADECOMPRA.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_FACTURADECOMPRA.Monedasistema, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Montodescuentoconimpuestos2 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos2, 0 )
					.Montodescuentoconimpuestos1 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos1, 0 )
					.Descuento = nvl( c_FACTURADECOMPRA.Descuento, 0 )
					.Impuestos = nvl( c_FACTURADECOMPRA.Impuestos, 0 )
					.Tipocomprobanterg1361 = nvl( c_FACTURADECOMPRA.Tipocomprobanterg1361, 0 )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Codigo = nvl( c_FACTURADECOMPRA.Codigo, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fecha, ctod( '  /  /    ' ) ) )
					.Fechafactura = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechafactura, ctod( '  /  /    ' ) ) )
					.Montodescuentoconimpuestos3 = nvl( c_FACTURADECOMPRA.Montodescuentoconimpuestos3, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_FACTURADECOMPRA.Montodescuentosinimpuestos3, 0 )
					.Impuestosmanuales = nvl( c_FACTURADECOMPRA.Impuestosmanuales, .F. )
					.Letra = nvl( c_FACTURADECOMPRA.Letra, [] )
					.Recargoporcentaje = nvl( c_FACTURADECOMPRA.Recargoporcentaje, 0 )
					.Totaldescuentossinimpuestos = nvl( c_FACTURADECOMPRA.Totaldescuentossinimpuestos, 0 )
					.Puntodeventaextendido = nvl( c_FACTURADECOMPRA.Puntodeventaextendido, 0 )
					.Recargomonto = nvl( c_FACTURADECOMPRA.Recargomonto, 0 )
					.Cotizacion = nvl( c_FACTURADECOMPRA.Cotizacion, 0 )
					.Condicionpagopreferente_PK =  nvl( c_FACTURADECOMPRA.Condicionpagopreferente, [] )
					.Numero = nvl( c_FACTURADECOMPRA.Numero, 0 )
					.Fechavencimiento = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechavencimiento, ctod( '  /  /    ' ) ) )
					.Recargomontoconimpuestos = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos, 0 )
					.Recargomontoconimpuestos1 = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos1, 0 )
					.Vuelto = nvl( c_FACTURADECOMPRA.Vuelto, 0 )
					.Puntodeventa = nvl( c_FACTURADECOMPRA.Puntodeventa, 0 )
					.Cai = nvl( c_FACTURADECOMPRA.Cai, 0 )
					.Recargomontoconimpuestos2 = nvl( c_FACTURADECOMPRA.Recargomontoconimpuestos2, 0 )
					.Monedacomprobante_PK =  nvl( c_FACTURADECOMPRA.Monedacomprobante, [] )
					.Proveedor_PK =  nvl( c_FACTURADECOMPRA.Proveedor, [] )
					.Centrodecosto_PK =  nvl( c_FACTURADECOMPRA.Centrodecosto, [] )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURADECOMPRA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Total = nvl( c_FACTURADECOMPRA.Total, 0 )
					.Recargomonto1 = nvl( c_FACTURADECOMPRA.Recargomonto1, 0 )
					.Recargomonto2 = nvl( c_FACTURADECOMPRA.Recargomonto2, 0 )
					.Distribucionporcentrodecosto_PK =  nvl( c_FACTURADECOMPRA.Distribucionporcentrodecosto, [] )
					.Listadeprecios_PK =  nvl( c_FACTURADECOMPRA.Listadeprecios, [] )
					.Remito = nvl( c_FACTURADECOMPRA.Remito, [] )
					.Totalimpuestos = nvl( c_FACTURADECOMPRA.Totalimpuestos, 0 )
					.Totalrecargos = nvl( c_FACTURADECOMPRA.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_FACTURADECOMPRA.Totalrecargossinimpuestos, 0 )
					.Totaldescuentos = nvl( c_FACTURADECOMPRA.Totaldescuentos, 0 )
				Catch To loError
					goServicios.Errores.LevantarExcepcion( loError )
				Finally
					.lCargando = .f.
				EndTry
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function DespuesBeginTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function AntesEndTransaction() as Void
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function FinalDeTransaction() as Void
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_FACTURADECOMPRA.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.COMPAFEC
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

		loDetalle = this.oEntidad.FacturaDetalle
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

		loDetalle = this.oEntidad.ValoresDetalle
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

		loDetalle = this.oEntidad.ImpuestosDetalle
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

		loDetalle = this.oEntidad.ImpuestosComprobante
		for lnIndex = loDetalle.count to 1 step -1
			if !loDetalle.ValidarExistenciaCamposFijosItemPlano( loDetalle.Item[lnIndex].NroItem )
				loDetalle.Remove( lnIndex )
			endif
		endfor
		
		lnContadorNroItem = 1
		for each loItem in loDetalle foxObject
			loItem.NroItem = lnContadorNroItem
			lnContadorNroItem = lnContadorNroItem + 1
		endfor

	endfunc
	

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdateNuevoEnBaseA() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

		
			loColeccion.agregar( strtran( this.ObtenerSentenciaActualizacionTimeStamp(), chr( 9 ), '' ) )
			for each loItem in this.oEntidad.FacturaDetalle
				lcSentencia = "UPDATE ZooLogic.FacCompraDet"
				lcSentencia = lcSentencia + " Set " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "AFE_SALDO" ) ) + " = " + transform(loItem.afe_saldo) + " where " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "NroItem" ) ) +  "= " + transform( loItem.NroItem ) + " and CODIGO='" + this.oEntidad.codigo + "'"
				lcSentencia = lcSentencia + iif(  '<VENTAS>' $ this.oEntidad.ObtenerFuncionalidades(), " and " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "idItemArticulos" ) ) + "= '" + alltrim( loItem.idItemArticulos ) + "'","")
				loColeccion.agregar( strtran( lcSentencia, chr( 9 ), "" ) )
			endfor
		
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxTipocomprobante = loItem.Tipocomprobante
					lxNroitem = lnContadorNroItem
					lxTipocompcaracter = loItem.Tipocompcaracter
					lxLetra = loItem.Letra
					lxPuntodeventa = loItem.Puntodeventa
					lxNumero = loItem.Numero
					lxFecha = loItem.Fecha
					lxTotal = loItem.Total
					lxVendedor = loItem.Vendedor
					lxTipo = loItem.Tipo
					lxAfecta = loItem.Afecta
					lxInterviniente = loItem.Interviniente
					lxNombreentidad = loItem.Nombreentidad
					lxCodigoentidad = loItem.Codigoentidad
					lxOrigen = loItem.Origen
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.CompAfe("AfeTipoCom","NROITEM","Codigo","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxTipocomprobante>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor
		EndWith
		return loColeccion
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_FACTURADECOMPRA.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.FACCOMPRA' )
		endtext
		this.oConexion.EjecutarSql( lcSentencia, 'c_last_user_update', set( 'Datasession' ) )
		ldRetorno = {^0001-01-01 00:00:00}
		if reccount( 'c_last_user_update' ) > 0 and !isnull( c_last_user_update.last_update )
			ldRetorno = c_last_user_update.last_update
		endif
		return ldRetorno
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerIdentificadoresPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.FACCOMPRA 
								Where   FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "FACCOMPRA", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fpodes2" as "Porcentajedescuento2", "Fpodes" as "Porcentajedescuento", "Fturno" as "Turno", "Numint" as "Numint", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Fhora" as "Hora", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Vmodifw" as "Versionmodificacionfw", "Descfw" as "Descripcionfw", "Saltafw" as "Seriealtafw", "Simbmon" as "Simbolomonetariocomprobante", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Haltafw" as "Horaaltafw", "Hmodifw" as "Horamodificacionfw", "Totalcant" as "Totalcantidad", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Desmntosi1" as "Montodescuentosinimpuestos1", "Sitfiscpro" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Recmntosi1" as "Recargomontosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desauto" as "Descuentoautomatico", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Fobs" as "Obs", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fdescu" as "Descuento", "Fimpuesto" as "Impuestos", "Tcrg1361" as "Tipocomprobanterg1361", "Codigo" as "Codigo", "Ffch" as "Fecha", "Ffchfac" as "Fechafactura", "Fmtdes3" as "Montodescuentoconimpuestos3", "Desmntosi3" as "Montodescuentosinimpuestos3", "Impman" as "Impuestosmanuales", "Fletra" as "Letra", "Recpor" as "Recargoporcentaje", "Totdescsi" as "Totaldescuentossinimpuestos", "Fptovenext" as "Puntodeventaextendido", "Mr" as "Recargomonto", "Cotiz" as "Cotizacion", "Condpago" as "Condicionpagopreferente", "Fnumcomp" as "Numero", "Ffchvenc" as "Fechavencimiento", "Recmnto" as "Recargomontoconimpuestos", "Recmnto1" as "Recargomontoconimpuestos1", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Ncai" as "Cai", "Recmnto2" as "Recargomontoconimpuestos2", "Moneda" as "Monedacomprobante", "Fperson" as "Proveedor", "Ccosto" as "Centrodecosto", "Fvtocai" as "Fechavtocai", "Ftotal" as "Total", "Recmonto1" as "Recargomonto1", "Recmonto2" as "Recargomonto2", "Disccos" as "Distribucionporcentrodecosto", "Codlista" as "Listadeprecios", "Nroremito" as "Remito", "Totimpue" as "Totalimpuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Totdesc" as "Totaldescuentos"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.FACCOMPRA 
								Where   FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSql( lcSQL, lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc

enddefine

define class ObjetoBusqueda as custom
	Tabla = 'FACCOMPRA'
	Filtro = " FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "FacCompra.NumInt"
	FiltroSubEntidad = ''

	*--------------------------------------------------------------------------------------------------------
	function init( toEntidad as object ) as boolean
		with this
			text to .cEstructura noshow 
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="entidad" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tabla" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="15"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="campo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="claveprimaria" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="muestrarelacion" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="permitemodificar" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="esentidad" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="claveforanea" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="valorsugerido" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="obligatorio" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="admitebusqueda" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="160"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="dominio" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="30"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="detalle" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="tipo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributoforaneo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="clavecandidata" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="mascara" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="25"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="ofuncionalidad" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="relaciones" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="filtrobuscador" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="grupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="subgrupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="orden" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="alta" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluiratrib" type="xsd:boolean" use="required"/>
							<xsd:attribute name="excluiratrib" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluirbussubent" type="xsd:boolean" use="required"/>
							<xsd:attribute name="utilizamismarelacion" type="xsd:boolean" use="required"/>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAMODIFICACIONFW                     " tabla="FACCOMPRA      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAALTAFW                             " tabla="FACCOMPRA      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAEXPO                               " tabla="FACCOMPRA      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHATRANSFERENCIA                      " tabla="FACCOMPRA      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAIMPO                               " tabla="FACCOMPRA      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAMODIFICACION                       " tabla="FACCOMPRA      " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CUIT                                    " tabla="FACCOMPRA      " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="proveedor.cuit                                                                                                                                                                                                                                                " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CAJA                                    " tabla="FACCOMPRA      " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                            " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO1                    " tabla="FACCOMPRA      " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 1                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO2                    " tabla="FACCOMPRA      " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje descuento 2                                                                                                                                          " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PORCENTAJEDESCUENTO                     " tabla="FACCOMPRA      " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Porcentaje de descuento                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TURNO                                   " tabla="FACCOMPRA      " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="NUMINT                                  " tabla="FACCOMPRA      " campo="NUMINT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número interno                                                                                                                                                  " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="FACCOMPRA      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="BASEDEDATOSALTAFW                       " tabla="FACCOMPRA      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ESTADOTRANSFERENCIA                     " tabla="FACCOMPRA      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORA                                    " tabla="FACCOMPRA      " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="USUARIOALTAFW                           " tabla="FACCOMPRA      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SERIEMODIFICACIONFW                     " tabla="FACCOMPRA      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="USUARIOMODIFICACIONFW                   " tabla="FACCOMPRA      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VERSIONALTAFW                           " tabla="FACCOMPRA      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ZADSFW                                  " tabla="FACCOMPRA      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VERSIONMODIFICACIONFW                   " tabla="FACCOMPRA      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCRIPCIONFW                           " tabla="FACCOMPRA      " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SERIEALTAFW                             " tabla="FACCOMPRA      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="FACCOMPRA      " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAIMPO                                " tabla="FACCOMPRA      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAEXPO                                " tabla="FACCOMPRA      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAALTAFW                              " tabla="FACCOMPRA      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="HORAMODIFICACIONFW                      " tabla="FACCOMPRA      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALCANTIDAD                           " tabla="FACCOMPRA      " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIMESTAMP                               " tabla="FACCOMPRA      " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="FACCOMPRA      " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="FACCOMPRA      " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="FACCOMPRA      " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SIGNODEMOVIMIENTO                       " tabla="FACCOMPRA      " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIPOCOMPROBANTE                         " tabla="FACCOMPRA      " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=8                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CONDICIONIVA                            " tabla="FACCOMPRA      " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="FACCOMPRA      " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SITUACIONFISCAL                         " tabla="FACCOMPRA      " campo="SITFISCPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="proveedor.SituacionFiscal                                                                                                                                                                                                                                     " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="FACCOMPRA      " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALBRUTO                           " tabla="FACCOMPRA      " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal bruto                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="SUBTOTALNETO                            " tabla="FACCOMPRA      " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal neto                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="FACCOMPRA      " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="FACCOMPRA      " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="FACCOMPRA      " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="ANULADO                                 " tabla="FACCOMPRA      " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Está anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COMPROBANTEFISCAL                       " tabla="FACCOMPRA      " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCUENTOAUTOMATICO                     " tabla="FACCOMPRA      " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FACTURADETALLE                          " tabla="FACCOMPRADET   " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Artículos                                                                                                                                                       " dominio="DETALLEITEMARTICULOSCOMPRA    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VALORESDETALLE                          " tabla="VALFACCOMP     " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Valores                                                                                                                                                         " dominio="DETALLEITEMVALORESCOMPRA      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="9" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSDETALLE                        " tabla="IMPFACCOMP     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos detalle                                                                                                                                               " dominio="DETALLEITEMIMPUESTOSC         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IDVUELTO                                " tabla="FACCOMPRA      " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONEDASISTEMA                           " tabla="FACCOMPRA      " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="OBS                                     " tabla="FACCOMPRA      " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="FACCOMPRA      " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 2                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="FACCOMPRA      " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 1                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DESCUENTO                               " tabla="FACCOMPRA      " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Monto % descuento                                                                                                                                               " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOS                               " tabla="FACCOMPRA      " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TIPOCOMPROBANTERG1361                   " tabla="FACCOMPRA      " campo="TCRG1361  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="412" etiqueta="Tipo factura                                                                                                                                                    " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPFACC        " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Impuestos                                                                                                                                                       " dominio="DETALLEITEMIMPUESTOCOMPRA     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CODIGO                                  " tabla="FACCOMPRA      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="16" etiqueta="Nro. Interno                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHA                                   " tabla="FACCOMPRA      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="416" etiqueta="Ingreso                                                                                                                                                         " dominio="FECHACOMPROBANTEDECOMPRA      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAFACTURA                            " tabla="FACCOMPRA      " campo="FFCHFAC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="418" etiqueta="Emisión                                                                                                                                                         " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="FACCOMPRA      " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Monto descuento con impuestos                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="FACCOMPRA      " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="IMPUESTOSMANUALES                       " tabla="FACCOMPRA      " campo="IMPMAN    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="LETRA                                   " tabla="FACCOMPRA      " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Letra comprobante                                                                                                                                               " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="X                        " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOPORCENTAJE                       " tabla="FACCOMPRA      " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Recargo porcentaje                                                                                                                                              " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="FACCOMPRA      " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="14" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PUNTODEVENTAEXTENDIDO                   " tabla="FACCOMPRA      " campo="FPTOVENEXT" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Punto de venta                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999                    " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO                            " tabla="FACCOMPRA      " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Recargo % monto                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="COTIZACION                              " tabla="FACCOMPRA      " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="426" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CONDICIONPAGOPREFERENTE                 " tabla="FACCOMPRA      " campo="CONDPAGO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Condición de pago                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="NUMERO                                  " tabla="FACCOMPRA      " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Número factura                                                                                                                                                  " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAVENCIMIENTO                        " tabla="FACCOMPRA      " campo="FFCHVENC  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="430" etiqueta="Vencimiento                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="FACCOMPRA      " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="FACCOMPRA      " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="VUELTO                                  " tabla="FACCOMPRA      " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PUNTODEVENTA                            " tabla="FACCOMPRA      " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Pto. de venta                                                                                                                                                   " dominio="NROCOMPROBANTECOMPRASEDITABLE " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CAI                                     " tabla="FACCOMPRA      " campo="NCAI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="C.A.I./C.A.E.                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="FACCOMPRA      " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="6" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="MONEDACOMPROBANTE                       " tabla="FACCOMPRA      " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Moneda comprobante                                                                                                                                              " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="PROVEEDOR                               " tabla="FACCOMPRA      " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="10" etiqueta="Proveedor                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="CENTRODECOSTO                           " tabla="FACCOMPRA      " campo="CCOSTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CENTRODECOSTO                           " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Centro de costos                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="FECHAVTOCAI                             " tabla="FACCOMPRA      " campo="FVTOCAI   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="440" etiqueta="Vencimiento C.A.I./C.A.E.                                                                                                                                       " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTAL                                   " tabla="FACCOMPRA      " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                           " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO1                           " tabla="FACCOMPRA      " campo="RECMONTO1 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto 1                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="RECARGOMONTO2                           " tabla="FACCOMPRA      " campo="RECMONTO2 " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Recargo monto                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="DISTRIBUCIONPORCENTRODECOSTO            " tabla="FACCOMPRA      " campo="DISCCOS   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="DISTRIBUCIONCENTRODECOSTO               " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Distribución por centro de costos                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="LISTADEPRECIOS                          " tabla="FACCOMPRA      " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferenteCompras                                                                                                                                                                                  " obligatorio="true" admitebusqueda="446" etiqueta="Lista de precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="REMITO                                  " tabla="FACCOMPRA      " campo="NROREMITO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="16" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Remito                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="A 99999-99999999         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="2" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALIMPUESTOS                          " tabla="FACCOMPRA      " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total impuestos                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALRECARGOS                           " tabla="FACCOMPRA      " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo                                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="FACCOMPRA      " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo sin impuestos                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="15" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURADECOMPRA                         " atributo="TOTALDESCUENTOS                         " tabla="FACCOMPRA      " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuento                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="16" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CONDICIONDEPAGO                         " atributo="DESCRIPCION                             " tabla="CONDPAGO       " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="429" etiqueta="Detalle Con.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CONDPAGO On FACCOMPRA.CONDPAGO = CONDPAGO.CLCOD And  CONDPAGO.CLCOD != ''                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On FACCOMPRA.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="11" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On FACCOMPRA.FPERSON = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CENTRODECOSTO                           " atributo="DESCRIPCION                             " tabla="CCOSTO         " campo="COSDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Cen.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CCOSTO On FACCOMPRA.CCOSTO = CCOSTO.COSCOD And  CCOSTO.COSCOD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="DISTRIBUCIONCENTRODECOSTO               " atributo="DESCRIPCION                             " tabla="DCCOSTO        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="150" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Dis.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join DCCOSTO On FACCOMPRA.DISCCOS = DCCOSTO.Codigo And  DCCOSTO.CODIGO != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On FACCOMPRA.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext

			text to .cEstructuraDetalle noshow 
<?xml version = "1.0" encoding="Windows-1252" standalone="yes"?>
<VFPData xml:space="preserve">
	<xsd:schema id="VFPData" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
		<xsd:element name="VFPData" msdata:IsDataSet="true">
			<xsd:complexType>
				<xsd:choice maxOccurs="unbounded">
					<xsd:element name="row" minOccurs="0" maxOccurs="unbounded">
						<xsd:complexType>
							<xsd:attribute name="entidad" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tabla" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="15"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="campo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="claveprimaria" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="muestrarelacion" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="permitemodificar" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="esentidad" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="claveforanea" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="40"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="tipodato" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="10"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="longitud" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="decimales" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="valorsugerido" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="obligatorio" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="admitebusqueda" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="3"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="etiqueta" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="160"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="dominio" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="30"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="detalle" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="tipo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="atributoforaneo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="clavecandidata" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="mascara" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="25"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="ofuncionalidad" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="1"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="relaciones" use="required">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="254"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="filtrobuscador" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:string">
										<xsd:maxLength value="200"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="grupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="subgrupo" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="2"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="orden" use="optional">
								<xsd:simpleType>
									<xsd:restriction base="xsd:decimal">
										<xsd:totalDigits value="4"/>
										<xsd:fractionDigits value="0"/>
									</xsd:restriction>
								</xsd:simpleType>
							</xsd:attribute>
							<xsd:attribute name="alta" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluiratrib" type="xsd:boolean" use="required"/>
							<xsd:attribute name="excluiratrib" type="xsd:boolean" use="optional"/>
							<xsd:attribute name="incluirbussubent" type="xsd:boolean" use="required"/>
							<xsd:attribute name="utilizamismarelacion" type="xsd:boolean" use="required"/>
						</xsd:complexType>
					</xsd:element>
				</xsd:choice>
				<xsd:anyAttribute namespace="http://www.w3.org/XML/1998/namespace" processContents="lax"/>
			</xsd:complexType>
		</xsd:element>
	</xsd:schema>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="ARTICULO                                " tabla="FACCOMPRADET   " campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="ARTICULODETALLE                         " tabla="FACCOMPRADET   " campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="COLOR                                   " tabla="FACCOMPRADET   " campo="FCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="COLORDETALLE                            " tabla="FACCOMPRADET   " campo="FCOTXT    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Color descripción                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="TALLE                                   " tabla="FACCOMPRADET   " campo="FTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="CANTIDAD                                " tabla="FACCOMPRADET   " campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADOCO" detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="PRECIO                                  " tabla="FACCOMPRADET   " campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="DESCUENTO                               " tabla="FACCOMPRADET   " campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, % Descuento                                                                                                                                   " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="MONTODESCUENTO                          " tabla="FACCOMPRADET   " campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Monto descuento                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSCOMPRA                     " atributo="MONTO                                   " tabla="FACCOMPRADET   " campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FACCOMPRADET On FACCOMPRA.CODIGO = FACCOMPRADET.CODIGO And  FACCOMPRA.CODIGO != '' AND FACCOMPRA.FACTTIPO = 8                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
</VFPData>

			Endtext


			.listadecampos = .cEstructura
			.cEstructuraSinDetalle = .cEstructura
			.oEntidad = toEntidad
			.Indice = .Indice
			.Filtro = .Filtro
		endwith
	endfunc

enddefine