
define class Din_EntidadFACTURAELECTRONICAEXPORTACIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FACTURAELECTRONICAEXPORTACION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Secuencia]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0) + #tabla#.FACTSEC]
	cTagClaveCandidata = '_FEECC'
	cTagClavePk = '_FEEPK'
	cTablaPrincipal = 'COMPROBANTEV'
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
			local  lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFectrans, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFperson, lxComprobantevCotiz, lxComprobantevVmodifw, lxComprobantevFaltafw, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevHaltafw, lxComprobantevUmodifw, lxComprobantevHoraexpo, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevEsttrans, lxComprobantevSaltafw, lxComprobantevIdajuste, lxComprobantevBdaltafw, lxComprobantevValtafw, lxComprobantevBdmodifw, lxComprobantevSimbmon, lxComprobantevFactsec, lxComprobantevDesmntosi2, lxComprobantevFpodes2, lxComprobantevTotalcant, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevSitfisccli, lxComprobantevFacttipo, lxComprobantevTimestamp, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevCondivalp, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevRecmntosi, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevAnulado, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFcliente, lxComprobantevFturno, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevSenia, lxComprobantevMd1, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevFvuelto, lxComprobantevFptoven, lxComprobantevFnumcomp, lxComprobantevFfch, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFfchvtopag, lxComprobantevFdescu, lxComprobantevCodlista, lxComprobantevMd3, lxComprobantevEmail, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevCotizdesp, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevCotiz =  .Cotizacion			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFactsec =  .Secuencia			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFturno =  .Turno			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFnumcomp =  .Numero			lxComprobantevFfch =  .Fecha			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFfchvtopag =  .Fechavencimientopago			lxComprobantevFdescu =  .Descuento			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevEmail =  .Email			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevCotizdesp =  .Cotizaciondespacho			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxComprobantevCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.COMPROBANTEV ( "Fd2","Fecexpo","Fecimpo","Fmodifw","Fectrans","Fcuit","Idcaja","Fperson","Cotiz","Vmodifw","Faltafw","Descfw","Fhora","Zadsfw","Haltafw","Umodifw","Horaexpo","Smodifw","Horaimpo","Ualtafw","Hmodifw","Esttrans","Saltafw","Idajuste","Bdaltafw","Valtafw","Bdmodifw","Simbmon","Factsec","Desmntosi2","Fpodes2","Totalcant","Fsubtot","Fsubton","Sitfisccli","Facttipo","Timestamp","Signomov","Subtotsisi","Subtotcisi","Condivalp","Desmntosi","Recmntosi1","Recmntosi2","Desmntosi1","Desmntosi3","Recmntosi","Fajxre","Mdcimpu","Anulado","Fcompfis","Desaut","Monsis","Idvuelto","Fobs","Fpodes1","Fcliente","Fturno","Idsenia","Fmtdes2","Codigo","Senia","Md1","Fmtdes1","Receptor","Fven","Moneda","Fletra","Vtosenia","Totrecarsi","Trci","Fvuelto","Fptoven","Fnumcomp","Ffch","Ftotal","Totdescsi","Tdci","Fmtdes3","Fpodes","Recmnto2","Ffchvtopag","Fdescu","Codlista","Md3","Email","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecarci","Totdesc","Totimpue","Cotizdesp","Cancelar","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevIdcaja >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevTotalcant >>, <<lxComprobantevFsubtot >>, <<lxComprobantevFsubton >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFacttipo >>, <<lxComprobantevTimestamp >>, <<lxComprobantevSignomov >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevCondivalp >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevFajxre >>, <<lxComprobantevMdcimpu >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFturno >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'" >>, <<lxComprobantevMd1 >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFptoven >>, <<lxComprobantevFnumcomp >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevFtotal >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'" >>, <<lxComprobantevFdescu >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<lxComprobantevMd3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecarci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevCotizdesp >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >> )
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
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxUnidad_PK = loItem.Unidad_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxIdkit = loItem.Idkit
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxBruto = loItem.Bruto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAfe_cantidad = loItem.Afe_cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxIdorigen = loItem.Idorigen
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FUnid","afe_cod","CodAutDJCP","IdItem","IDKIT","MNTPRECCI","AjuCImp","AjuSImp","ConRestr","MNTPTOT","tasaimpint","AfeTS","MNTPPER","MNDESSI","MNDESCI","PRECIOSISR","MNPDSI","PRECIOCISR","FBruto","MNTPRECSI","MNTPDESCI","MNTPDESSI","PRECIOSR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","AfeTipoCom","AfeNroItem","AfeCANT","prunconimp","impinterno","iditemOrig","Prunsinimp","COMP","FPRUN","ciditem","FN11","UsarPLista","ArtSinDes","ProcStock","FART","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateototal>>, <<lxTasaimpuestointerno>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxPrecioconimpuestossinredondear>>, <<lxBruto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPreciosinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_tipocomprobante>>, <<lxAfe_nroitem>>, <<lxAfe_cantidad>>, <<lxPrecioconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxIdorigen>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxIditemvalores = loItem.Iditemvalores
					lxLetra = loItem.Letra
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxNrodocumento = loItem.Nrodocumento
					lxRedondeo = loItem.Redondeo
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxPuntodeventa = loItem.Puntodeventa
					lxSigno = loItem.Signo
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTurno = loItem.Turno
					lxTipo = loItem.Tipo
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxAutorizacionpos = loItem.Autorizacionpos
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxMontodesrec = loItem.Montodesrec
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","JJVen","TipoDoc","TIPCOMP","NroTarjeta","IdItem","Letra","IdretiroEf","NroDoc","Redondeo","descmonto","descporc","descsinimp","Montosiste","monderepes","MonDesPes","MonRecPes","PtoVenta","Signo","Pesos","NroCupon","NumCompr","JJCotiz","NroItem","JJTurno","JJT","recsinimp","Cotiza","VisualCaja","PersComp","CElectro","EsRetiroEf","esvuelto","Autorizado","CondPago","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","porcdesrec","recporc","mondesrec","recsinper","recmonto","JJTotFac","JJRecib","RecPesos","MonCupon","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxDescuentomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxRecargomontoenpesos>>, <<lxPuntodeventa>>, <<lxSigno>>, <<lxPesosalcambio>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTurno>>, <<lxTipo>>, <<lxRecargomontosinimpuestos>>, <<lxUltimacotizacion>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxPorcentajedesrec>>, <<lxRecargoporcentaje>>, <<lxMontodesrec>>, <<lxRecargosinpercepciones>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
					
					lxMontodeimpuestointerno = loItem.Montodeimpuestointerno
					lxNroitem = lnContadorNroItem
					lxMontodeimpuestointernosindescuento = loItem.Montodeimpuestointernosindescuento
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxMontonogravado = loItem.Montonogravado
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.IMPUESTOSV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxBasedecalculo = loItem.Basedecalculo
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodseguridadsire = loItem.Codseguridadsire
					lxDescripcion = loItem.Descripcion
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxCertificadosire = loItem.Certificadosire
					lxMinimo = loItem.Minimo
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMontobase = loItem.Montobase
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("Base","CodImp","codint","TipoI","SIRECS","Descri","RegimenImp","SIRECERT","MinimoPer","minoimp","MontoBase","NroItem","porcen","Monto","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimo>>, <<lxMinimonoimponible>>, <<lxMontobase>>, <<lxNroitem>>, <<lxPorcentaje>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxComportamiento = loItem.Comportamiento
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNeto = loItem.Neto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoiva = loItem.Montoiva
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontocfi = loItem.Montocfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","FUnid","MNTPTOT","MNTPRECCI","ACondIvaV","AfeSaldo","APorcIvaV","MNTPPER","AfeTS","MNTPDESSI","MNTPDESCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","COMP","PRECIOSISR","PRECIOCISR","MNPDSI","MNDESCI","MNTPRECSI","MNDESSI","AfeCANT","FX2","NroItem","FporDTO1","FporCFI","FNETO","AfeTipoCom","FmtoIVA","FKIT","FCFITot","FmtoCFI","prunconimp","FmtoDTO1","fporIva","AfeNroItem","iditemOrig","ciditem","FN11","Prunsinimp","FPRUN","UsarPLista","ProcStock","CODIGO","Equiv","FTXT","cColor","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxComportamiento>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxPorcentajecfi>>, <<lxNeto>>, <<lxAfe_tipocomprobante>>, <<lxMontoiva>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontocfi>>, <<lxPrecioconimpuestos>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxComprobantevTimestamp
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
			local  lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFectrans, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFperson, lxComprobantevCotiz, lxComprobantevVmodifw, lxComprobantevFaltafw, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevHaltafw, lxComprobantevUmodifw, lxComprobantevHoraexpo, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevEsttrans, lxComprobantevSaltafw, lxComprobantevIdajuste, lxComprobantevBdaltafw, lxComprobantevValtafw, lxComprobantevBdmodifw, lxComprobantevSimbmon, lxComprobantevFactsec, lxComprobantevDesmntosi2, lxComprobantevFpodes2, lxComprobantevTotalcant, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevSitfisccli, lxComprobantevFacttipo, lxComprobantevTimestamp, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevCondivalp, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevRecmntosi, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevAnulado, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFcliente, lxComprobantevFturno, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevSenia, lxComprobantevMd1, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevFvuelto, lxComprobantevFptoven, lxComprobantevFnumcomp, lxComprobantevFfch, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFfchvtopag, lxComprobantevFdescu, lxComprobantevCodlista, lxComprobantevMd3, lxComprobantevEmail, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevCotizdesp, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevCotiz =  .Cotizacion			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFactsec =  .Secuencia			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFturno =  .Turno			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFnumcomp =  .Numero			lxComprobantevFfch =  .Fecha			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFfchvtopag =  .Fechavencimientopago			lxComprobantevFdescu =  .Descuento			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevEmail =  .Email			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevCotizdesp =  .Cotizaciondespacho			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
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
				update ZooLogic.COMPROBANTEV set "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>,"Idcaja" = <<lxComprobantevIdcaja>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>,"Cotiz" = <<lxComprobantevCotiz>>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>,"Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>,"Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>,"Desmntosi2" = <<lxComprobantevDesmntosi2>>,"Fpodes2" = <<lxComprobantevFpodes2>>,"Totalcant" = <<lxComprobantevTotalcant>>,"Fsubtot" = <<lxComprobantevFsubtot>>,"Fsubton" = <<lxComprobantevFsubton>>,"Sitfisccli" = <<lxComprobantevSitfisccli>>,"Facttipo" = <<lxComprobantevFacttipo>>,"Timestamp" = <<lxComprobantevTimestamp>>,"Signomov" = <<lxComprobantevSignomov>>,"Subtotsisi" = <<lxComprobantevSubtotsisi>>,"Subtotcisi" = <<lxComprobantevSubtotcisi>>,"Condivalp" = <<lxComprobantevCondivalp>>,"Desmntosi" = <<lxComprobantevDesmntosi>>,"Recmntosi1" = <<lxComprobantevRecmntosi1>>,"Recmntosi2" = <<lxComprobantevRecmntosi2>>,"Desmntosi1" = <<lxComprobantevDesmntosi1>>,"Desmntosi3" = <<lxComprobantevDesmntosi3>>,"Recmntosi" = <<lxComprobantevRecmntosi>>,"Fajxre" = <<lxComprobantevFajxre>>,"Mdcimpu" = <<lxComprobantevMdcimpu>>,"Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>,"Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>,"Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>,"Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>,"Fpodes1" = <<lxComprobantevFpodes1>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>,"Fturno" = <<lxComprobantevFturno>>,"Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>,"Fmtdes2" = <<lxComprobantevFmtdes2>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>,"Senia" = <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'">>,"Md1" = <<lxComprobantevMd1>>,"Fmtdes1" = <<lxComprobantevFmtdes1>>,"Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>,"Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>,"Totrecarsi" = <<lxComprobantevTotrecarsi>>,"Trci" = <<lxComprobantevTrci>>,"Fvuelto" = <<lxComprobantevFvuelto>>,"Fptoven" = <<lxComprobantevFptoven>>,"Fnumcomp" = <<lxComprobantevFnumcomp>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>,"Ftotal" = <<lxComprobantevFtotal>>,"Totdescsi" = <<lxComprobantevTotdescsi>>,"Tdci" = <<lxComprobantevTdci>>,"Fmtdes3" = <<lxComprobantevFmtdes3>>,"Fpodes" = <<lxComprobantevFpodes>>,"Recmnto2" = <<lxComprobantevRecmnto2>>,"Ffchvtopag" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'">>,"Fdescu" = <<lxComprobantevFdescu>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>,"Md3" = <<lxComprobantevMd3>>,"Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>,"Percepcion" = <<lxComprobantevPercepcion>>,"Recmnto" = <<lxComprobantevRecmnto>>,"Recpor" = <<lxComprobantevRecpor>>,"Mr" = <<lxComprobantevMr>>,"Mr2" = <<lxComprobantevMr2>>,"Md2" = <<lxComprobantevMd2>>,"Mr1" = <<lxComprobantevMr1>>,"Recmnto1" = <<lxComprobantevRecmnto1>>,"Gravamen" = <<lxComprobantevGravamen>>,"Fimpuesto" = <<lxComprobantevFimpuesto>>,"Totrecarci" = <<lxComprobantevTotrecarci>>,"Totdesc" = <<lxComprobantevTotdesc>>,"Totimpue" = <<lxComprobantevTotimpue>>,"Cotizdesp" = <<lxComprobantevCotizdesp>>,"Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>,"Ivasis" = <<lxComprobantevIvasis>>,"Tipocrela" = <<lxComprobantevTipocrela>>,"Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>,"Puntorela" = <<lxComprobantevPuntorela>>,"Numerorela" = <<lxComprobantevNumerorela>>,"Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.IMPUESTOSV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxUnidad_PK = loItem.Unidad_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxIdkit = loItem.Idkit
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxBruto = loItem.Bruto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAfe_cantidad = loItem.Afe_cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxIdorigen = loItem.Idorigen
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FUnid","afe_cod","CodAutDJCP","IdItem","IDKIT","MNTPRECCI","AjuCImp","AjuSImp","ConRestr","MNTPTOT","tasaimpint","AfeTS","MNTPPER","MNDESSI","MNDESCI","PRECIOSISR","MNPDSI","PRECIOCISR","FBruto","MNTPRECSI","MNTPDESCI","MNTPDESSI","PRECIOSR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","AfeTipoCom","AfeNroItem","AfeCANT","prunconimp","impinterno","iditemOrig","Prunsinimp","COMP","FPRUN","ciditem","FN11","UsarPLista","ArtSinDes","ProcStock","FART","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateototal>>, <<lxTasaimpuestointerno>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxPrecioconimpuestossinredondear>>, <<lxBruto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPreciosinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_tipocomprobante>>, <<lxAfe_nroitem>>, <<lxAfe_cantidad>>, <<lxPrecioconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxIdorigen>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxIditemvalores = loItem.Iditemvalores
					lxLetra = loItem.Letra
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxNrodocumento = loItem.Nrodocumento
					lxRedondeo = loItem.Redondeo
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxPuntodeventa = loItem.Puntodeventa
					lxSigno = loItem.Signo
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTurno = loItem.Turno
					lxTipo = loItem.Tipo
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxAutorizacionpos = loItem.Autorizacionpos
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxMontodesrec = loItem.Montodesrec
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","JJVen","TipoDoc","TIPCOMP","NroTarjeta","IdItem","Letra","IdretiroEf","NroDoc","Redondeo","descmonto","descporc","descsinimp","Montosiste","monderepes","MonDesPes","MonRecPes","PtoVenta","Signo","Pesos","NroCupon","NumCompr","JJCotiz","NroItem","JJTurno","JJT","recsinimp","Cotiza","VisualCaja","PersComp","CElectro","EsRetiroEf","esvuelto","Autorizado","CondPago","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","porcdesrec","recporc","mondesrec","recsinper","recmonto","JJTotFac","JJRecib","RecPesos","MonCupon","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxDescuentomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxRecargomontoenpesos>>, <<lxPuntodeventa>>, <<lxSigno>>, <<lxPesosalcambio>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTurno>>, <<lxTipo>>, <<lxRecargomontosinimpuestos>>, <<lxUltimacotizacion>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxPorcentajedesrec>>, <<lxRecargoporcentaje>>, <<lxMontodesrec>>, <<lxRecargosinpercepciones>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
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
					
					lxMontodeimpuestointerno = loItem.Montodeimpuestointerno
					lxNroitem = lnContadorNroItem
					lxMontodeimpuestointernosindescuento = loItem.Montodeimpuestointernosindescuento
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxMontonogravado = loItem.Montonogravado
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.IMPUESTOSV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxBasedecalculo = loItem.Basedecalculo
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodseguridadsire = loItem.Codseguridadsire
					lxDescripcion = loItem.Descripcion
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxCertificadosire = loItem.Certificadosire
					lxMinimo = loItem.Minimo
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMontobase = loItem.Montobase
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("Base","CodImp","codint","TipoI","SIRECS","Descri","RegimenImp","SIRECERT","MinimoPer","minoimp","MontoBase","NroItem","porcen","Monto","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimo>>, <<lxMinimonoimponible>>, <<lxMontobase>>, <<lxNroitem>>, <<lxPorcentaje>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxComportamiento = loItem.Comportamiento
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNeto = loItem.Neto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoiva = loItem.Montoiva
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontocfi = loItem.Montocfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","FUnid","MNTPTOT","MNTPRECCI","ACondIvaV","AfeSaldo","APorcIvaV","MNTPPER","AfeTS","MNTPDESSI","MNTPDESCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","COMP","PRECIOSISR","PRECIOCISR","MNPDSI","MNDESCI","MNTPRECSI","MNDESSI","AfeCANT","FX2","NroItem","FporDTO1","FporCFI","FNETO","AfeTipoCom","FmtoIVA","FKIT","FCFITot","FmtoCFI","prunconimp","FmtoDTO1","fporIva","AfeNroItem","iditemOrig","ciditem","FN11","Prunsinimp","FPRUN","UsarPLista","ProcStock","CODIGO","Equiv","FTXT","cColor","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxComportamiento>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxPorcentajecfi>>, <<lxNeto>>, <<lxAfe_tipocomprobante>>, <<lxMontoiva>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontocfi>>, <<lxPrecioconimpuestos>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
		this.oEntidad.Timestamp = lxComprobantevTimestamp
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPROBANTEV where " + this.ConvertirFuncionesSql( " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33" ) )
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
			Local lxComprobantevCodigo
			lxComprobantevCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )

			if reccount( 'c_FACTURAELECTRONICAEXPORTACION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxCOMPROBANTEVFACTTIPO As Variant, lxCOMPROBANTEVFLETRA As Variant, lxCOMPROBANTEVFPTOVEN As Variant, lxCOMPROBANTEVFNUMCOMP As Variant, lxCOMPROBANTEVFACTSEC As Variant
			lxCOMPROBANTEVFACTTIPO = .TipoComprobante
			lxCOMPROBANTEVFLETRA = .Letra
			lxCOMPROBANTEVFPTOVEN = .PuntoDeVenta
			lxCOMPROBANTEVFNUMCOMP = .Numero
			lxCOMPROBANTEVFACTSEC = .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 And FACTTIPO = <<lxCOMPROBANTEVFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFLETRA ) + "'">> and FPTOVEN = <<lxCOMPROBANTEVFPTOVEN>> and FNUMCOMP = <<lxCOMPROBANTEVFNUMCOMP>> and FACTSEC = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFACTSEC ) + "'">>
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )
			if reccount( 'c_FACTURAELECTRONICAEXPORTACION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxComprobantevCodigo as Variant
		llRetorno = .t.
		lxComprobantevCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
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
				lcOrden =   iif( empty( .FechaAltaFW ), dtos( evaluate( goRegistry.Nucleo.FechaEnBlancoParaSqlServer ) ), dtos( .FechaAltaFW ) ) + .HoraAltaFW + .Codigo
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_FACTURAELECTRONICAEXPORTACION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAELECTRONICAEXPORTACION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAELECTRONICAEXPORTACION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fd2,Fecexpo,Fecimpo,Fmodifw,Fectrans,Fcuit,Idcaja,Fperson,Cotiz,Vmodifw,Faltafw,Descfw,Fhora" + ;
",Zadsfw,Haltafw,Umodifw,Horaexpo,Smodifw,Horaimpo,Ualtafw,Hmodifw,Esttrans,Saltafw,Idajuste,Bdaltafw" + ;
",Valtafw,Bdmodifw,Simbmon,Factsec,Desmntosi2,Fpodes2,Totalcant,Fsubtot,Fsubton,Sitfisccli,Facttipo,T" + ;
"imestamp,Signomov,Subtotsisi,Subtotcisi,Condivalp,Desmntosi,Recmntosi1,Recmntosi2,Desmntosi1,Desmnto" + ;
"si3,Recmntosi,Fajxre,Mdcimpu,Anulado,Fcompfis,Desaut,Monsis,Idvuelto,Fobs,Fpodes1,Fcliente,Fturno,Id" + ;
"senia,Fmtdes2,Codigo,Senia,Md1,Fmtdes1,Receptor,Fven,Moneda,Fletra,Vtosenia,Totrecarsi,Trci,Fvuelto," + ;
"Fptoven,Fnumcomp,Ffch,Ftotal,Totdescsi,Tdci,Fmtdes3,Fpodes,Recmnto2,Ffchvtopag,Fdescu,Codlista,Md3,E" + ;
"mail,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1,Gravamen,Fimpuesto,Totrecarci,Totdesc,Totimpu" + ;
"e,Cotizdesp,Cancelar,Ivasis,Tipocrela,Letrarela,Puntorela,Numerorela,Feccrela" + ;
" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33 and " + lcFiltro )
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
			local  lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFectrans, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFperson, lxComprobantevCotiz, lxComprobantevVmodifw, lxComprobantevFaltafw, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevHaltafw, lxComprobantevUmodifw, lxComprobantevHoraexpo, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevEsttrans, lxComprobantevSaltafw, lxComprobantevIdajuste, lxComprobantevBdaltafw, lxComprobantevValtafw, lxComprobantevBdmodifw, lxComprobantevSimbmon, lxComprobantevFactsec, lxComprobantevDesmntosi2, lxComprobantevFpodes2, lxComprobantevTotalcant, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevSitfisccli, lxComprobantevFacttipo, lxComprobantevTimestamp, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevCondivalp, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevRecmntosi, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevAnulado, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFcliente, lxComprobantevFturno, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevSenia, lxComprobantevMd1, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevFvuelto, lxComprobantevFptoven, lxComprobantevFnumcomp, lxComprobantevFfch, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFfchvtopag, lxComprobantevFdescu, lxComprobantevCodlista, lxComprobantevMd3, lxComprobantevEmail, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevCotizdesp, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFd2 = ctod( '  /  /    ' )			lxComprobantevFecexpo = ctod( '  /  /    ' )			lxComprobantevFecimpo = ctod( '  /  /    ' )			lxComprobantevFmodifw = ctod( '  /  /    ' )			lxComprobantevFectrans = ctod( '  /  /    ' )			lxComprobantevFcuit = []			lxComprobantevIdcaja = 0			lxComprobantevFperson = []			lxComprobantevCotiz = 0			lxComprobantevVmodifw = []			lxComprobantevFaltafw = ctod( '  /  /    ' )			lxComprobantevDescfw = []			lxComprobantevFhora = []			lxComprobantevZadsfw = []			lxComprobantevHaltafw = []			lxComprobantevUmodifw = []			lxComprobantevHoraexpo = []			lxComprobantevSmodifw = []			lxComprobantevHoraimpo = []			lxComprobantevUaltafw = []			lxComprobantevHmodifw = []			lxComprobantevEsttrans = []			lxComprobantevSaltafw = []			lxComprobantevIdajuste = []			lxComprobantevBdaltafw = []			lxComprobantevValtafw = []			lxComprobantevBdmodifw = []			lxComprobantevSimbmon = []			lxComprobantevFactsec = []			lxComprobantevDesmntosi2 = 0			lxComprobantevFpodes2 = 0			lxComprobantevTotalcant = 0			lxComprobantevFsubtot = 0			lxComprobantevFsubton = 0			lxComprobantevSitfisccli = 0			lxComprobantevFacttipo = 0			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevSignomov = 0			lxComprobantevSubtotsisi = 0			lxComprobantevSubtotcisi = 0			lxComprobantevCondivalp = 0			lxComprobantevDesmntosi = 0			lxComprobantevRecmntosi1 = 0			lxComprobantevRecmntosi2 = 0			lxComprobantevDesmntosi1 = 0			lxComprobantevDesmntosi3 = 0			lxComprobantevRecmntosi = 0			lxComprobantevFajxre = 0			lxComprobantevMdcimpu = 0			lxComprobantevAnulado = .F.			lxComprobantevFcompfis = .F.			lxComprobantevDesaut = .F.			lxComprobantevMonsis = []			lxComprobantevIdvuelto = []			lxComprobantevFobs = []			lxComprobantevFpodes1 = 0			lxComprobantevFcliente = []			lxComprobantevFturno = 0			lxComprobantevIdsenia = []			lxComprobantevFmtdes2 = 0			lxComprobantevCodigo = []			lxComprobantevSenia = []			lxComprobantevMd1 = 0			lxComprobantevFmtdes1 = 0			lxComprobantevReceptor = []			lxComprobantevFven = []			lxComprobantevMoneda = []			lxComprobantevFletra = []			lxComprobantevVtosenia = ctod( '  /  /    ' )			lxComprobantevTotrecarsi = 0			lxComprobantevTrci = 0			lxComprobantevFvuelto = 0			lxComprobantevFptoven = 0			lxComprobantevFnumcomp = 0			lxComprobantevFfch = ctod( '  /  /    ' )			lxComprobantevFtotal = 0			lxComprobantevTotdescsi = 0			lxComprobantevTdci = 0			lxComprobantevFmtdes3 = 0			lxComprobantevFpodes = 0			lxComprobantevRecmnto2 = 0			lxComprobantevFfchvtopag = ctod( '  /  /    ' )			lxComprobantevFdescu = 0			lxComprobantevCodlista = []			lxComprobantevMd3 = 0			lxComprobantevEmail = []			lxComprobantevPercepcion = 0			lxComprobantevRecmnto = 0			lxComprobantevRecpor = 0			lxComprobantevMr = 0			lxComprobantevMr2 = 0			lxComprobantevMd2 = 0			lxComprobantevMr1 = 0			lxComprobantevRecmnto1 = 0			lxComprobantevGravamen = 0			lxComprobantevFimpuesto = 0			lxComprobantevTotrecarci = 0			lxComprobantevTotdesc = 0			lxComprobantevTotimpue = 0			lxComprobantevCotizdesp = 0			lxComprobantevCancelar = .F.			lxComprobantevIvasis = 0			lxComprobantevTipocrela = 0			lxComprobantevLetrarela = []			lxComprobantevPuntorela = 0			lxComprobantevNumerorela = 0			lxComprobantevFeccrela = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.IMPUESTOSV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.COMPROBANTEV where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'COMPROBANTEV' + '_' + tcCampo
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
		lcWhere = " Where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPROBANTEV', '', tnTope )
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
	Function ObtenerDatosDetalleFacturaDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  COMPROBANTEVDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'COMPROBANTEVDET', 'FacturaDetalle', tnTope )
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
		lcWhere = " Where  VAL.JJNUM != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleValoresDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'VAL', 'ValoresDetalle', tnTope )
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
		lcWhere = " Where  IMPUESTOSV.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'IMPUESTOSV', 'ImpuestosDetalle', tnTope )
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
	Function ObtenerDatosDetalleImpuestosComprobante( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  IMPVENTAS.CCOD != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleImpuestosComprobante( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'impVentas', 'ImpuestosComprobante', tnTope )
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
	Function ObtenerDatosDetalleArticulosSeniadosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SENIAVDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Mntptot" as "Montoprorrateototal", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Acondivav" as "Articulo_condicionivaventas", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Comp" as "Comportamiento", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fpordto1" as "Porcentajedto1", "Fporcfi" as "Porcentajecfi", "Fneto" as "Neto", "Afetipocom" as "Afe_tipocomprobante", "Fmtoiva" as "Montoiva", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fmtocfi" as "Montocfi", "Prunconimp" as "Precioconimpuestos", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Prunsinimp" as "Preciosinimpuestos", "Fprun" as "Preciounitario", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codigo" as "Codigo", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleArticulosSeniadosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'SeniaVDet', 'ArticulosSeniadosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleArticulosSeniadosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleArticulosSeniadosDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'CODIGOAJUSTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDAJUSTE AS CODIGOAJUSTE'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCCLI AS SITUACIONFISCAL'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTESPORREDONDEOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAJXRE AS AJUSTESPORREDONDEOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDCIMPU AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUT AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'IDSENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSENIA AS IDSENIA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'SENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIA AS SENIA'
				Case lcAtributo == 'MONTODESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD1 AS MONTODESCUENTO1'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'RECEPTOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECEPTOR AS RECEPTOR'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS VENDEDOR'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'FECHAVTOSENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VTOSENIA AS FECHAVTOSENIA'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCI AS TOTALRECARGOSCONIMPUESTOS'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCI AS TOTALDESCUENTOSCONIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'FECHAVENCIMIENTOPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVTOPAG AS FECHAVENCIMIENTOPAGO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'MONTODESCUENTO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD3 AS MONTODESCUENTO3'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS EMAIL'
				Case lcAtributo == 'PERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERCEPCION AS PERCEPCIONES'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR2 AS RECARGOMONTO2'
				Case lcAtributo == 'MONTODESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD2 AS MONTODESCUENTO2'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR1 AS RECARGOMONTO1'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'GRAVAMENES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRAVAMEN AS GRAVAMENES'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARCI AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
				Case lcAtributo == 'COTIZACIONDESPACHO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZDESP AS COTIZACIONDESPACHO'
				Case lcAtributo == 'ACCIONCANCELATORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANCELAR AS ACCIONCANCELATORIA'
				Case lcAtributo == 'IVADELSISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVASIS AS IVADELSISTEMA'
				Case lcAtributo == 'TIPOCPTERELACIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOCRELA AS TIPOCPTERELACIONADO'
				Case lcAtributo == 'LETRACPTERELACIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRARELA AS LETRACPTERELACIONADO'
				Case lcAtributo == 'PUNTODEVENTACPTERELACIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PUNTORELA AS PUNTODEVENTACPTERELACIONADO'
				Case lcAtributo == 'NUMEROCPTERELACIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERORELA AS NUMEROCPTERELACIONADO'
				Case lcAtributo == 'FECHACPTERELACIONADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECCRELA AS FECHACPTERELACIONADO'
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
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'AFE_NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS AFE_NUMERO'
				Case lcAtributo == 'CODIGOGTIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODGTIN AS CODIGOGTIN'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'CODIGOAUTORIZACIONDJCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODAUTDJCP AS CODIGOAUTORIZACIONDJCP'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'TIENERESTRICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRESTR AS TIENERESTRICCION'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'AFE_SALDOLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_SLIQ AS AFE_SALDOLIQUIDACION'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'NUMEROGIFTCARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GIFTCARD AS NUMEROGIFTCARD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCU AS CODIGOMOTIVODESCUENTO'
				Case lcAtributo == 'CODIGOMOTIVODEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDEVOL AS CODIGOMOTIVODEVOLUCION'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
				Case lcAtributo == 'MONTOPRORRATEOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPINT AS MONTOPRORRATEOIMPUESTOINTERNO'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTATXT AS TALLEDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
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
				Case lcAtributo == 'FECHACOMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJFECHA AS FECHACOMP'
				Case lcAtributo == 'FECHAULTCOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHCOTI AS FECHAULTCOTIZACION'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'IDITEMVALORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMVALORES'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'IDITEMRETIROENEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDRETIROEF AS IDITEMRETIROENEFECTIVO'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDONDEO AS REDONDEO'
				Case lcAtributo == 'DESCUENTOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCMONTO AS DESCUENTOMONTO'
				Case lcAtributo == 'DESCUENTOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCPORC AS DESCUENTOPORCENTAJE'
				Case lcAtributo == 'DESCUENTOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCSINIMP AS DESCUENTOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'MONTODESRECPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDEREPES AS MONTODESRECPESOS'
				Case lcAtributo == 'DESCUENTOMONTOENPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESPES AS DESCUENTOMONTOENPESOS'
				Case lcAtributo == 'RECARGOMONTOENPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONRECPES AS RECARGOMONTOENPESOS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECSINIMP AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'ESRETIROEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESRETIROEF AS ESRETIROEFECTIVO'
				Case lcAtributo == 'ESVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESVUELTO AS ESVUELTO'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONDEPAGO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJNUM AS CODIGO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
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
				Case lcAtributo == 'PORCENTAJEDESREC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCDESREC AS PORCENTAJEDESREC'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPORC AS RECARGOPORCENTAJE'
				Case lcAtributo == 'MONTODESREC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESREC AS MONTODESREC'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECSINPER AS RECARGOSINPERCEPCIONES'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMONTO AS RECARGOMONTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'RECIBIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJRECIB AS RECIBIDO'
				Case lcAtributo == 'RECIBIDOALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPESOS AS RECIBIDOALCAMBIO'
				Case lcAtributo == 'MONTOCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONCUPON AS MONTOCUPON'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'CODIGODECUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCUPON AS CODIGODECUPON'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'NUMEROVALEDECAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALECAMBIO AS NUMEROVALEDECAMBIO'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
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
				Case lcAtributo == 'MONTODEIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INTMONTO AS MONTODEIMPUESTOINTERNO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTODEIMPUESTOINTERNOSINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INTMONSD AS MONTODEIMPUESTOINTERNOSINDESCUENTO'
				Case lcAtributo == 'MONTONOGRAVADOSINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMNGSD AS MONTONOGRAVADOSINDESCUENTO'
				Case lcAtributo == 'MONTONOGRAVADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONNG AS MONTONOGRAVADO'
				Case lcAtributo == 'PORCENTAJEDEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAPORCENT AS PORCENTAJEDEIVA'
				Case lcAtributo == 'MONTODEIVASINDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONSD AS MONTODEIVASINDESCUENTO'
				Case lcAtributo == 'MONTODEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVAMONTO AS MONTODEIVA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleImpuestosComprobante( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'BASEDECALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDECALCULO'
				Case lcAtributo == 'CODIGOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIGOIMPUESTO'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'CODSEGURIDADSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECS AS CODSEGURIDADSIRE'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
				Case lcAtributo == 'REGIMENIMPOSITIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMENIMP AS REGIMENIMPOSITIVO'
				Case lcAtributo == 'CERTIFICADOSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECERT AS CERTIFICADOSIRE'
				Case lcAtributo == 'MINIMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINIMOPER AS MINIMO'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'MONTOBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOBASE AS MONTOBASE'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'JURISDICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JURID AS JURISDICCION'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOD AS CODIGO'
				Case lcAtributo == 'RG5329PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS RG5329PORCENTAJE'
				Case lcAtributo == 'RG5329APLICAPORARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCE AS RG5329APLICAPORARTICULO'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleArticulosSeniadosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'AFE_NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENUMCOM AS AFE_NUMERO'
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'CODIGOGTIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODGTIN AS CODIGOGTIN'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLOR AS COLOR'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTATXT AS TALLEDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLE AS TALLE'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAJUSTE'
				lcCampo = 'IDAJUSTE'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCCLI'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTESPORREDONDEOS'
				lcCampo = 'FAJXRE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MDCIMPU'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUT'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIA'
				lcCampo = 'IDSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'SENIA'
				lcCampo = 'SENIA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO1'
				lcCampo = 'MD1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'RECEPTOR'
				lcCampo = 'RECEPTOR'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOSENIA'
				lcCampo = 'VTOSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSCONIMPUESTOS'
				lcCampo = 'TRCI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSCONIMPUESTOS'
				lcCampo = 'TDCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTOPAGO'
				lcCampo = 'FFCHVTOPAG'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO3'
				lcCampo = 'MD3'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONES'
				lcCampo = 'PERCEPCION'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'MR2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO2'
				lcCampo = 'MD2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'MR1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'GRAVAMENES'
				lcCampo = 'GRAVAMEN'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOS'
				lcCampo = 'TOTRECARCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACIONDESPACHO'
				lcCampo = 'COTIZDESP'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONCANCELATORIA'
				lcCampo = 'CANCELAR'
			Case upper( alltrim( tcAtributo ) ) == 'IVADELSISTEMA'
				lcCampo = 'IVASIS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCPTERELACIONADO'
				lcCampo = 'TIPOCRELA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRACPTERELACIONADO'
				lcCampo = 'LETRARELA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTACPTERELACIONADO'
				lcCampo = 'PUNTORELA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCPTERELACIONADO'
				lcCampo = 'NUMERORELA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHACPTERELACIONADO'
				lcCampo = 'FECCRELA'
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
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOGTIN'
				lcCampo = 'CODGTIN'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAUTORIZACIONDJCP'
				lcCampo = 'CODAUTDJCP'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIENERESTRICCION'
				lcCampo = 'CONRESTR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDOLIQUIDACION'
				lcCampo = 'AFE_SLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROGIFTCARD'
				lcCampo = 'GIFTCARD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTO'
				lcCampo = 'MOTDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODEVOLUCION'
				lcCampo = 'MOTDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIMPUESTOINTERNO'
				lcCampo = 'MNTPINT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'FTATXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHACOMP'
				lcCampo = 'JJFECHA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAULTCOTIZACION'
				lcCampo = 'FECHCOTI'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMVALORES'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMRETIROENEFECTIVO'
				lcCampo = 'IDRETIROEF'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'REDONDEO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTO'
				lcCampo = 'DESCMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPORCENTAJE'
				lcCampo = 'DESCPORC'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTOSINIMPUESTOS'
				lcCampo = 'DESCSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESRECPESOS'
				lcCampo = 'MONDEREPES'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTOENPESOS'
				lcCampo = 'MONDESPES'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOENPESOS'
				lcCampo = 'MONRECPES'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'ESRETIROEFECTIVO'
				lcCampo = 'ESRETIROEF'
			Case upper( alltrim( tcAtributo ) ) == 'ESVUELTO'
				lcCampo = 'ESVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'JJNUM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
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
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESREC'
				lcCampo = 'PORCDESREC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPORC'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESREC'
				lcCampo = 'MONDESREC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'RECSINPER'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'RECMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBIDO'
				lcCampo = 'JJRECIB'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBIDOALCAMBIO'
				lcCampo = 'RECPESOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCUPON'
				lcCampo = 'MONCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODECUPON'
				lcCampo = 'GUIDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROVALEDECAMBIO'
				lcCampo = 'VALECAMBIO'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleImpuestosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIMPUESTOINTERNO'
				lcCampo = 'INTMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIMPUESTOINTERNOSINDESCUENTO'
				lcCampo = 'INTMONSD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADOSINDESCUENTO'
				lcCampo = 'IVAMNGSD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTONOGRAVADO'
				lcCampo = 'IVAMONNG'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDEIVA'
				lcCampo = 'IVAPORCENT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVASINDESCUENTO'
				lcCampo = 'IVAMONSD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODEIVA'
				lcCampo = 'IVAMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
	Function ObtenerCampoDetalleImpuestosComprobante( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'BASEDECALCULO'
				lcCampo = 'BASE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOIMPUESTO'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'CODSEGURIDADSIRE'
				lcCampo = 'SIRECS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENIMPOSITIVO'
				lcCampo = 'REGIMENIMP'
			Case upper( alltrim( tcAtributo ) ) == 'CERTIFICADOSIRE'
				lcCampo = 'SIRECERT'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMO'
				lcCampo = 'MINIMOPER'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOBASE'
				lcCampo = 'MONTOBASE'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'JURISDICCION'
				lcCampo = 'JURID'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CCOD'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329PORCENTAJE'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'RG5329APLICAPORARTICULO'
				lcCampo = 'ARTPERCE'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleArticulosSeniadosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NUMERO'
				lcCampo = 'AFENUMCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOGTIN'
				lcCampo = 'CODGTIN'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'FTATXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'TALLE'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'COMPROBANTEVDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'VAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPUESTOSV'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPVENTAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ARTICULOSSENIADOSDETALLE'
			lcRetorno = 'SENIAVDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFectrans, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFperson, lxComprobantevCotiz, lxComprobantevVmodifw, lxComprobantevFaltafw, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevHaltafw, lxComprobantevUmodifw, lxComprobantevHoraexpo, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevEsttrans, lxComprobantevSaltafw, lxComprobantevIdajuste, lxComprobantevBdaltafw, lxComprobantevValtafw, lxComprobantevBdmodifw, lxComprobantevSimbmon, lxComprobantevFactsec, lxComprobantevDesmntosi2, lxComprobantevFpodes2, lxComprobantevTotalcant, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevSitfisccli, lxComprobantevFacttipo, lxComprobantevTimestamp, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevCondivalp, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevRecmntosi, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevAnulado, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFcliente, lxComprobantevFturno, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevSenia, lxComprobantevMd1, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevFvuelto, lxComprobantevFptoven, lxComprobantevFnumcomp, lxComprobantevFfch, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFfchvtopag, lxComprobantevFdescu, lxComprobantevCodlista, lxComprobantevMd3, lxComprobantevEmail, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevCotizdesp, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevCotiz =  .Cotizacion			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFactsec =  .Secuencia			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFturno =  .Turno			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFnumcomp =  .Numero			lxComprobantevFfch =  .Fecha			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFfchvtopag =  .Fechavencimientopago			lxComprobantevFdescu =  .Descuento			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevEmail =  .Email			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevCotizdesp =  .Cotizaciondespacho			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPROBANTEV ( "Fd2","Fecexpo","Fecimpo","Fmodifw","Fectrans","Fcuit","Idcaja","Fperson","Cotiz","Vmodifw","Faltafw","Descfw","Fhora","Zadsfw","Haltafw","Umodifw","Horaexpo","Smodifw","Horaimpo","Ualtafw","Hmodifw","Esttrans","Saltafw","Idajuste","Bdaltafw","Valtafw","Bdmodifw","Simbmon","Factsec","Desmntosi2","Fpodes2","Totalcant","Fsubtot","Fsubton","Sitfisccli","Facttipo","Timestamp","Signomov","Subtotsisi","Subtotcisi","Condivalp","Desmntosi","Recmntosi1","Recmntosi2","Desmntosi1","Desmntosi3","Recmntosi","Fajxre","Mdcimpu","Anulado","Fcompfis","Desaut","Monsis","Idvuelto","Fobs","Fpodes1","Fcliente","Fturno","Idsenia","Fmtdes2","Codigo","Senia","Md1","Fmtdes1","Receptor","Fven","Moneda","Fletra","Vtosenia","Totrecarsi","Trci","Fvuelto","Fptoven","Fnumcomp","Ffch","Ftotal","Totdescsi","Tdci","Fmtdes3","Fpodes","Recmnto2","Ffchvtopag","Fdescu","Codlista","Md3","Email","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecarci","Totdesc","Totimpue","Cotizdesp","Cancelar","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevIdcaja >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevTotalcant >>, <<lxComprobantevFsubtot >>, <<lxComprobantevFsubton >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFacttipo >>, <<lxComprobantevTimestamp >>, <<lxComprobantevSignomov >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevCondivalp >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevFajxre >>, <<lxComprobantevMdcimpu >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFturno >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'" >>, <<lxComprobantevMd1 >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFptoven >>, <<lxComprobantevFnumcomp >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevFtotal >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'" >>, <<lxComprobantevFdescu >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<lxComprobantevMd3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecarci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevCotizdesp >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >> )
		endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxUnidad_PK = loItem.Unidad_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxIdkit = loItem.Idkit
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxBruto = loItem.Bruto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAfe_cantidad = loItem.Afe_cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxIdorigen = loItem.Idorigen
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FUnid","afe_cod","CodAutDJCP","IdItem","IDKIT","MNTPRECCI","AjuCImp","AjuSImp","ConRestr","MNTPTOT","tasaimpint","AfeTS","MNTPPER","MNDESSI","MNDESCI","PRECIOSISR","MNPDSI","PRECIOCISR","FBruto","MNTPRECSI","MNTPDESCI","MNTPDESSI","PRECIOSR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","AfeTipoCom","AfeNroItem","AfeCANT","prunconimp","impinterno","iditemOrig","Prunsinimp","COMP","FPRUN","ciditem","FN11","UsarPLista","ArtSinDes","ProcStock","FART","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateototal>>, <<lxTasaimpuestointerno>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxPrecioconimpuestossinredondear>>, <<lxBruto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPreciosinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_tipocomprobante>>, <<lxAfe_nroitem>>, <<lxAfe_cantidad>>, <<lxPrecioconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxIdorigen>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxIditemvalores = loItem.Iditemvalores
					lxLetra = loItem.Letra
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxNrodocumento = loItem.Nrodocumento
					lxRedondeo = loItem.Redondeo
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxPuntodeventa = loItem.Puntodeventa
					lxSigno = loItem.Signo
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTurno = loItem.Turno
					lxTipo = loItem.Tipo
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxAutorizacionpos = loItem.Autorizacionpos
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxMontodesrec = loItem.Montodesrec
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","JJVen","TipoDoc","TIPCOMP","NroTarjeta","IdItem","Letra","IdretiroEf","NroDoc","Redondeo","descmonto","descporc","descsinimp","Montosiste","monderepes","MonDesPes","MonRecPes","PtoVenta","Signo","Pesos","NroCupon","NumCompr","JJCotiz","NroItem","JJTurno","JJT","recsinimp","Cotiza","VisualCaja","PersComp","CElectro","EsRetiroEf","esvuelto","Autorizado","CondPago","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","porcdesrec","recporc","mondesrec","recsinper","recmonto","JJTotFac","JJRecib","RecPesos","MonCupon","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxDescuentomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxRecargomontoenpesos>>, <<lxPuntodeventa>>, <<lxSigno>>, <<lxPesosalcambio>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTurno>>, <<lxTipo>>, <<lxRecargomontosinimpuestos>>, <<lxUltimacotizacion>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxPorcentajedesrec>>, <<lxRecargoporcentaje>>, <<lxMontodesrec>>, <<lxRecargosinpercepciones>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontodeimpuestointerno = loItem.Montodeimpuestointerno
					lxNroitem = lnContadorNroItem
					lxMontodeimpuestointernosindescuento = loItem.Montodeimpuestointernosindescuento
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxMontonogravado = loItem.Montonogravado
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.IMPUESTOSV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxBasedecalculo = loItem.Basedecalculo
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodseguridadsire = loItem.Codseguridadsire
					lxDescripcion = loItem.Descripcion
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxCertificadosire = loItem.Certificadosire
					lxMinimo = loItem.Minimo
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMontobase = loItem.Montobase
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("Base","CodImp","codint","TipoI","SIRECS","Descri","RegimenImp","SIRECERT","MinimoPer","minoimp","MontoBase","NroItem","porcen","Monto","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimo>>, <<lxMinimonoimponible>>, <<lxMontobase>>, <<lxNroitem>>, <<lxPorcentaje>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxComportamiento = loItem.Comportamiento
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNeto = loItem.Neto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoiva = loItem.Montoiva
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontocfi = loItem.Montocfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","FUnid","MNTPTOT","MNTPRECCI","ACondIvaV","AfeSaldo","APorcIvaV","MNTPPER","AfeTS","MNTPDESSI","MNTPDESCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","COMP","PRECIOSISR","PRECIOCISR","MNPDSI","MNDESCI","MNTPRECSI","MNDESSI","AfeCANT","FX2","NroItem","FporDTO1","FporCFI","FNETO","AfeTipoCom","FmtoIVA","FKIT","FCFITot","FmtoCFI","prunconimp","FmtoDTO1","fporIva","AfeNroItem","iditemOrig","ciditem","FN11","Prunsinimp","FPRUN","UsarPLista","ProcStock","CODIGO","Equiv","FTXT","cColor","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxComportamiento>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxPorcentajecfi>>, <<lxNeto>>, <<lxAfe_tipocomprobante>>, <<lxMontoiva>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontocfi>>, <<lxPrecioconimpuestos>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
			local  lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFectrans, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFperson, lxComprobantevCotiz, lxComprobantevVmodifw, lxComprobantevFaltafw, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevHaltafw, lxComprobantevUmodifw, lxComprobantevHoraexpo, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevEsttrans, lxComprobantevSaltafw, lxComprobantevIdajuste, lxComprobantevBdaltafw, lxComprobantevValtafw, lxComprobantevBdmodifw, lxComprobantevSimbmon, lxComprobantevFactsec, lxComprobantevDesmntosi2, lxComprobantevFpodes2, lxComprobantevTotalcant, lxComprobantevFsubtot, lxComprobantevFsubton, lxComprobantevSitfisccli, lxComprobantevFacttipo, lxComprobantevTimestamp, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevCondivalp, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevRecmntosi, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevAnulado, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFcliente, lxComprobantevFturno, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevSenia, lxComprobantevMd1, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevFvuelto, lxComprobantevFptoven, lxComprobantevFnumcomp, lxComprobantevFfch, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFfchvtopag, lxComprobantevFdescu, lxComprobantevCodlista, lxComprobantevMd3, lxComprobantevEmail, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevCotizdesp, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevCotiz =  .Cotizacion			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFactsec =  .Secuencia			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFturno =  .Turno			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevFnumcomp =  .Numero			lxComprobantevFfch =  .Fecha			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFfchvtopag =  .Fechavencimientopago			lxComprobantevFdescu =  .Descuento			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevEmail =  .Email			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevCotizdesp =  .Cotizaciondespacho			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPROBANTEV set "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>, "Idcaja" = <<lxComprobantevIdcaja>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>, "Cotiz" = <<lxComprobantevCotiz>>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>, "Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>, "Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>, "Desmntosi2" = <<lxComprobantevDesmntosi2>>, "Fpodes2" = <<lxComprobantevFpodes2>>, "Totalcant" = <<lxComprobantevTotalcant>>, "Fsubtot" = <<lxComprobantevFsubtot>>, "Fsubton" = <<lxComprobantevFsubton>>, "Sitfisccli" = <<lxComprobantevSitfisccli>>, "Facttipo" = <<lxComprobantevFacttipo>>, "Timestamp" = <<lxComprobantevTimestamp>>, "Signomov" = <<lxComprobantevSignomov>>, "Subtotsisi" = <<lxComprobantevSubtotsisi>>, "Subtotcisi" = <<lxComprobantevSubtotcisi>>, "Condivalp" = <<lxComprobantevCondivalp>>, "Desmntosi" = <<lxComprobantevDesmntosi>>, "Recmntosi1" = <<lxComprobantevRecmntosi1>>, "Recmntosi2" = <<lxComprobantevRecmntosi2>>, "Desmntosi1" = <<lxComprobantevDesmntosi1>>, "Desmntosi3" = <<lxComprobantevDesmntosi3>>, "Recmntosi" = <<lxComprobantevRecmntosi>>, "Fajxre" = <<lxComprobantevFajxre>>, "Mdcimpu" = <<lxComprobantevMdcimpu>>, "Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>, "Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>, "Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>, "Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>, "Fpodes1" = <<lxComprobantevFpodes1>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>, "Fturno" = <<lxComprobantevFturno>>, "Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>, "Fmtdes2" = <<lxComprobantevFmtdes2>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>, "Senia" = <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'">>, "Md1" = <<lxComprobantevMd1>>, "Fmtdes1" = <<lxComprobantevFmtdes1>>, "Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>, "Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>, "Totrecarsi" = <<lxComprobantevTotrecarsi>>, "Trci" = <<lxComprobantevTrci>>, "Fvuelto" = <<lxComprobantevFvuelto>>, "Fptoven" = <<lxComprobantevFptoven>>, "Fnumcomp" = <<lxComprobantevFnumcomp>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>, "Ftotal" = <<lxComprobantevFtotal>>, "Totdescsi" = <<lxComprobantevTotdescsi>>, "Tdci" = <<lxComprobantevTdci>>, "Fmtdes3" = <<lxComprobantevFmtdes3>>, "Fpodes" = <<lxComprobantevFpodes>>, "Recmnto2" = <<lxComprobantevRecmnto2>>, "Ffchvtopag" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'">>, "Fdescu" = <<lxComprobantevFdescu>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>, "Md3" = <<lxComprobantevMd3>>, "Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>, "Percepcion" = <<lxComprobantevPercepcion>>, "Recmnto" = <<lxComprobantevRecmnto>>, "Recpor" = <<lxComprobantevRecpor>>, "Mr" = <<lxComprobantevMr>>, "Mr2" = <<lxComprobantevMr2>>, "Md2" = <<lxComprobantevMd2>>, "Mr1" = <<lxComprobantevMr1>>, "Recmnto1" = <<lxComprobantevRecmnto1>>, "Gravamen" = <<lxComprobantevGravamen>>, "Fimpuesto" = <<lxComprobantevFimpuesto>>, "Totrecarci" = <<lxComprobantevTotrecarci>>, "Totdesc" = <<lxComprobantevTotdesc>>, "Totimpue" = <<lxComprobantevTotimpue>>, "Cotizdesp" = <<lxComprobantevCotizdesp>>, "Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>, "Ivasis" = <<lxComprobantevIvasis>>, "Tipocrela" = <<lxComprobantevTipocrela>>, "Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>, "Puntorela" = <<lxComprobantevPuntorela>>, "Numerorela" = <<lxComprobantevNumerorela>>, "Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxUnidad_PK = loItem.Unidad_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxIdkit = loItem.Idkit
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxBruto = loItem.Bruto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxMontocfi = loItem.Montocfi
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_nroitem = loItem.Afe_nroitem
					lxAfe_cantidad = loItem.Afe_cantidad
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxIdorigen = loItem.Idorigen
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxArticulo_PK = loItem.Articulo_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxIdseniacancelada = loItem.Idseniacancelada
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FUnid","afe_cod","CodAutDJCP","IdItem","IDKIT","MNTPRECCI","AjuCImp","AjuSImp","ConRestr","MNTPTOT","tasaimpint","AfeTS","MNTPPER","MNDESSI","MNDESCI","PRECIOSISR","MNPDSI","PRECIOCISR","FBruto","MNTPRECSI","MNTPDESCI","MNTPDESSI","PRECIOSR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","AfeTipoCom","AfeNroItem","AfeCANT","prunconimp","impinterno","iditemOrig","Prunsinimp","COMP","FPRUN","ciditem","FN11","UsarPLista","ArtSinDes","ProcStock","FART","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateototal>>, <<lxTasaimpuestointerno>>, <<lxAfe_timestamp>>, <<lxMontoprorrateopercepciones>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxPrecioconimpuestossinredondear>>, <<lxBruto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPreciosinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_tipocomprobante>>, <<lxAfe_nroitem>>, <<lxAfe_cantidad>>, <<lxPrecioconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxIdorigen>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ValoresDetalle
				if this.oEntidad.ValoresDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxFechacomp = loItem.Fechacomp
					lxFechaultcotizacion = loItem.Fechaultcotizacion
					lxCaja_PK = loItem.Caja_PK
					lxVendedor = loItem.Vendedor
					lxTipodocumento = loItem.Tipodocumento
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxNumerotarjeta = loItem.Numerotarjeta
					lxIditemvalores = loItem.Iditemvalores
					lxLetra = loItem.Letra
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxNrodocumento = loItem.Nrodocumento
					lxRedondeo = loItem.Redondeo
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxPuntodeventa = loItem.Puntodeventa
					lxSigno = loItem.Signo
					lxPesosalcambio = loItem.Pesosalcambio
					lxNumerocupon = loItem.Numerocupon
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxCotiza = loItem.Cotiza
					lxNroitem = lnContadorNroItem
					lxTurno = loItem.Turno
					lxTipo = loItem.Tipo
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxChequeelectronico = loItem.Chequeelectronico
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxAutorizacionpos = loItem.Autorizacionpos
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxMontodesrec = loItem.Montodesrec
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxRecargomonto = loItem.Recargomonto
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxPermitevuelto = loItem.Permitevuelto
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					lxCupon_PK = loItem.Cupon_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","JJVen","TipoDoc","TIPCOMP","NroTarjeta","IdItem","Letra","IdretiroEf","NroDoc","Redondeo","descmonto","descporc","descsinimp","Montosiste","monderepes","MonDesPes","MonRecPes","PtoVenta","Signo","Pesos","NroCupon","NumCompr","JJCotiz","NroItem","JJTurno","JJT","recsinimp","Cotiza","VisualCaja","PersComp","CElectro","EsRetiroEf","esvuelto","Autorizado","CondPago","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","porcdesrec","recporc","mondesrec","recsinper","recmonto","JJTotFac","JJRecib","RecPesos","MonCupon","guidComp","guidCupon","permvuelto","ValeCambio","Cupon" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxDescuentomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxRecargomontoenpesos>>, <<lxPuntodeventa>>, <<lxSigno>>, <<lxPesosalcambio>>, <<lxNumerocupon>>, <<lxNumerodecomprobante>>, <<lxCotiza>>, <<lxNroitem>>, <<lxTurno>>, <<lxTipo>>, <<lxRecargomontosinimpuestos>>, <<lxUltimacotizacion>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxPorcentajedesrec>>, <<lxRecargoporcentaje>>, <<lxMontodesrec>>, <<lxRecargosinpercepciones>>, <<lxRecargomonto>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosDetalle
				if this.oEntidad.ImpuestosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontodeimpuestointerno = loItem.Montodeimpuestointerno
					lxNroitem = lnContadorNroItem
					lxMontodeimpuestointernosindescuento = loItem.Montodeimpuestointernosindescuento
					lxMontonogravadosindescuento = loItem.Montonogravadosindescuento
					lxMontonogravado = loItem.Montonogravado
					lxPorcentajedeiva = loItem.Porcentajedeiva
					lxMontodeivasindescuento = loItem.Montodeivasindescuento
					lxMontodeiva = loItem.Montodeiva
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.IMPUESTOSV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

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
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxBasedecalculo = loItem.Basedecalculo
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodseguridadsire = loItem.Codseguridadsire
					lxDescripcion = loItem.Descripcion
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxCertificadosire = loItem.Certificadosire
					lxMinimo = loItem.Minimo
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMontobase = loItem.Montobase
					lxNroitem = lnContadorNroItem
					lxPorcentaje = loItem.Porcentaje
					lxMonto = loItem.Monto
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("Base","CodImp","codint","TipoI","SIRECS","Descri","RegimenImp","SIRECERT","MinimoPer","minoimp","MontoBase","NroItem","porcen","Monto","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimo>>, <<lxMinimonoimponible>>, <<lxMontobase>>, <<lxNroitem>>, <<lxPorcentaje>>, <<lxMonto>>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_saldo = loItem.Afe_saldo
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxComportamiento = loItem.Comportamiento
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxPorcentajecfi = loItem.Porcentajecfi
					lxNeto = loItem.Neto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoiva = loItem.Montoiva
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxMontocfi = loItem.Montocfi
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","FUnid","MNTPTOT","MNTPRECCI","ACondIvaV","AfeSaldo","APorcIvaV","MNTPPER","AfeTS","MNTPDESSI","MNTPDESCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","COMP","PRECIOSISR","PRECIOCISR","MNPDSI","MNDESCI","MNTPRECSI","MNDESSI","AfeCANT","FX2","NroItem","FporDTO1","FporCFI","FNETO","AfeTipoCom","FmtoIVA","FKIT","FCFITot","FmtoCFI","prunconimp","FmtoDTO1","fporIva","AfeNroItem","iditemOrig","ciditem","FN11","Prunsinimp","FPRUN","UsarPLista","ProcStock","CODIGO","Equiv","FTXT","cColor","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxComportamiento>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajedto1>>, <<lxPorcentajecfi>>, <<lxNeto>>, <<lxAfe_tipocomprobante>>, <<lxMontoiva>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxMontocfi>>, <<lxPrecioconimpuestos>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciosinimpuestos>>, <<lxPreciounitario>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33]
		loColeccion.Agregar( 'delete from ZooLogic.COMPROBANTEV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'COMPROBANTEV' 
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
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
				endtext
		return lcAtributos
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function GenerarSentenciasComponentes() as void
		local loColSentencias as ZooColeccion of zooColeccion.prg, lcItem as String
		dodefault()
		this.colSentencias.Remove( -1 )

		with this.oEntidad
		
			.oCompLimitesdeconsumo.lNuevo = .EsNuevo()
			.oCompLimitesdeconsumo.lEdicion = .EsEdicion()
			.oCompLimitesdeconsumo.lEliminar = .lEliminar
			.oCompLimitesdeconsumo.lAnular = .lAnular
			loColSentencias = .oCompLimitesdeconsumo.grabar()
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
			
			.FacturaDetalle.oItem.oCompGiftcard.lNuevo = .EsNuevo()
			.FacturaDetalle.oItem.oCompGiftcard.lEdicion = .EsEdicion()
			.FacturaDetalle.oItem.oCompGiftcard.lEliminar = .lEliminar
			.FacturaDetalle.oItem.oCompGiftcard.lAnular = .lAnular
			loColSentencias = .FacturaDetalle.oItem.oCompGiftcard.grabar()
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
			lcRetorno = [update ZooLogic.COMPROBANTEV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPROBANTEV where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33" )
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
					if empty( .oNumeraciones.ObtenerServicio('NUMERO') ) and iif( type( '.NUMERO' ) = 'C', int( val( .NUMERO ) ),.NUMERO ) = .oNumeraciones.UltimoNumero( 'NUMERO' )
						.oNumeraciones.Actualizar( 'NUMERO' )
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
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCOMPROBANTEVFACTSEC as variant, lxCOMPROBANTEVFACTTIPO as variant, lxCOMPROBANTEVFLETRA as variant, lxCOMPROBANTEVFPTOVEN as variant, lxCOMPROBANTEVFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPROBANTEV Where  FACTTIPO = ] + transform( &lcCursor..FACTTIPO   ) + [ and FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA     ) + "'" + [ and FPTOVEN = ] + transform( &lcCursor..FPTOVEN    ) + [ and FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP   ) + [ and FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC    ) + "'", 'curSeek', this.datasessionid )
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPROBANTEV set  FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, idAjuste = ] + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'"+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, SitFiscCli = ] + transform( &lcCursor..SitFiscCli )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, FAjXRe = ] + transform( &lcCursor..FAjXRe )+ [, MDCIMPU = ] + transform( &lcCursor..MDCIMPU )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, DESAUT = ] + Transform( iif( &lcCursor..DESAUT, 1, 0 ))+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, IDSenia = ] + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'"+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, Senia = ] + "'" + this.FormatearTextoSql( &lcCursor..Senia ) + "'"+ [, MD1 = ] + transform( &lcCursor..MD1 )+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, Receptor = ] + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, vtosenia = ] + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'"+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, TRCI = ] + transform( &lcCursor..TRCI )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, TDCI = ] + transform( &lcCursor..TDCI )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, ffchvtopag = ] + "'" + this.ConvertirDateSql( &lcCursor..ffchvtopag ) + "'"+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, Email = ] + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'"+ [, percepcion = ] + transform( &lcCursor..percepcion )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, MR = ] + transform( &lcCursor..MR )+ [, MR2 = ] + transform( &lcCursor..MR2 )+ [, MD2 = ] + transform( &lcCursor..MD2 )+ [, MR1 = ] + transform( &lcCursor..MR1 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, gravamen = ] + transform( &lcCursor..gravamen )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, totrecarCI = ] + transform( &lcCursor..totrecarCI )+ [, totdesc = ] + transform( &lcCursor..totdesc )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, CotizDesp = ] + transform( &lcCursor..CotizDesp )+ [, Cancelar = ] + Transform( iif( &lcCursor..Cancelar, 1, 0 ))+ [, IvaSis = ] + transform( &lcCursor..IvaSis )+ [, TipoCRela = ] + transform( &lcCursor..TipoCRela )+ [, letraRela = ] + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'"+ [, puntoRela = ] + transform( &lcCursor..puntoRela )+ [, numeroRela = ] + transform( &lcCursor..numeroRela )+ [, FecCRela = ] + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
				this.oConexion.EjecutarSql( [Select * From ZooLogic.COMPROBANTEV Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FD2, FECEXPO, FECIMPO, FMODIFW, FECTRANS, fCuit, IdCaja, FPerson, Cotiz, VMODIFW, FAltaFW, DescFW, FHORA, ZADSFW, HAltaFW, UMODIFW, HORAEXPO, SMODIFW, HORAIMPO, UALTAFW, HMODIFW, ESTTRANS, SALTAFW, idAjuste, BDALTAFW, VALTAFW, BDMODIFW, SimbMon, FACTSEC, DesMntoSI2, FPODES2, TotalCant, FSubTOT, fSubToN, SitFiscCli, FACTTIPO, TIMESTAMP, signomov, SubTotSISI, SubTotCISI, CondivaLp, DesMntoSI, RecMntoSI1, RecMntoSI2, DesMntoSI1, DesMntoSI3, RecMntoSI, FAjXRe, MDCIMPU, Anulado, FCOMPFIS, DESAUT, MonSis, idVuelto, FObs, FPODES1, FCLIENTE, FTurno, IDSenia, FMTDES2, CODIGO, Senia, MD1, FMTDES1, Receptor, FVEN, Moneda, FLETRA, vtosenia, totrecarSI, TRCI, FVuelto, FPTOVEN, FNUMCOMP, FFCH, FTotal, totdescSI, TDCI, FMTDES3, FPODES, RecMnto2, ffchvtopag, fDescu, CodLista, MD3, Email, percepcion, RecMnto, RecPor, MR, MR2, MD2, MR1, RecMnto1, gravamen, fImpuesto, totrecarCI, totdesc, totimpue, CotizDesp, Cancelar, IvaSis, TipoCRela, letraRela, puntoRela, numeroRela, FecCRela
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..IdCaja )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'" + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..SitFiscCli ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..signomov )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..FAjXRe )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MDCIMPU ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..DESAUT, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FPODES1 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + transform( &lcCursor..FTurno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'" + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Senia ) + "'" + ',' + transform( &lcCursor..MD1 ) + ',' + transform( &lcCursor..FMTDES1 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'" + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..TRCI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FVuelto ) + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..TDCI ) + ',' + transform( &lcCursor..FMTDES3 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..RecMnto2 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..ffchvtopag ) + "'" + ',' + transform( &lcCursor..fDescu ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + transform( &lcCursor..MD3 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'" + ',' + transform( &lcCursor..percepcion ) + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..MR )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MR2 ) + ',' + transform( &lcCursor..MD2 ) + ',' + transform( &lcCursor..MR1 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..gravamen ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..totrecarCI ) + ',' + transform( &lcCursor..totdesc ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..CotizDesp ) + ',' + Transform( iif( &lcCursor..Cancelar, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IvaSis ) + ',' + transform( &lcCursor..TipoCRela ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'" + ',' + transform( &lcCursor..puntoRela ) + ',' + transform( &lcCursor..numeroRela ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPROBANTEV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.COMPROBANTEVDET Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VAL Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.IMPUESTOSV Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.impVentas Where cCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SeniaVDet Where CODIGO] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FUnid","afe_cod","CodAutDJCP","IdItem","IDKIT","MNTPRECCI","AjuCImp","AjuSImp","ConRestr","MNTPTOT","tasaimpint","AfeTS","MNTPPER","MNDESSI","MNDESCI","PRECIOSISR","MNPDSI","PRECIOCISR","FBruto","MNTPRECSI","MNTPDESCI","MNTPDESSI","PRECIOSR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","AfeTipoCom","AfeNroItem","AfeCANT","prunconimp","impinterno","iditemOrig","Prunsinimp","COMP","FPRUN","ciditem","FN11","UsarPLista","ArtSinDes","ProcStock","FART","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPROBANTEVDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTATXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"JJfecha","FechCoti","IdCaja","JJVen","TipoDoc","TIPCOMP","NroTarjeta","IdItem","Letra","IdretiroEf","NroDoc","Redondeo","descmonto","descporc","descsinimp","Montosiste","monderepes","MonDesPes","MonRecPes","PtoVenta","Signo","Pesos","NroCupon","NumCompr","JJCotiz","NroItem","JJTurno","JJT","recsinimp","Cotiza","VisualCaja","PersComp","CElectro","EsRetiroEf","esvuelto","Autorizado","CondPago","JJNUM","NroCheque","NroChProp","JJCO","JJDE","JJFE","NroInterno","JJM","porcdesrec","recporc","mondesrec","recsinper","recmonto","JJTotFac","JJRecib","RecPesos","MonCupon","guidComp","guidCupon","permvuelto","ValeCambio","Cupon"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.VAL ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdretiroEf ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Redondeo   ) + "'" + ',' + transform( cDetallesExistentes.descmonto  ) + ',' + transform( cDetallesExistentes.descporc   ) + ',' + transform( cDetallesExistentes.descsinimp ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.monderepes ) + ',' + transform( cDetallesExistentes.MonDesPes  ) + ',' + transform( cDetallesExistentes.MonRecPes  ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.recsinimp  ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.EsRetiroEf, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.esvuelto  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CondPago   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.porcdesrec ) + ',' + transform( cDetallesExistentes.recporc    ) + ',' + transform( cDetallesExistentes.mondesrec  ) + ',' + transform( cDetallesExistentes.recsinper  ) + ',' + transform( cDetallesExistentes.recmonto   ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.JJRecib    ) + ',' + transform( cDetallesExistentes.RecPesos   ) + ',' + transform( cDetallesExistentes.MonCupon   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.IMPUESTOSV ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.INTMonto   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.INTMonSD   ) + ',' + transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOVENTAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Base","CodImp","codint","TipoI","SIRECS","Descri","RegimenImp","SIRECERT","MinimoPer","minoimp","MontoBase","NroItem","porcen","Monto","jurId","cCod","ArtPercep","ArtPerce"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.impVentas ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.Base       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECS     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RegimenImp ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECERT   ) + "'" + ',' + transform( cDetallesExistentes.MinimoPer  ) + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.MontoBase  ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + transform( cDetallesExistentes.Monto      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.jurId      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + Transform( iif( cDetallesExistentes.ArtPerce  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSENIADOSEX'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","FUnid","MNTPTOT","MNTPRECCI","ACondIvaV","AfeSaldo","APorcIvaV","MNTPPER","AfeTS","MNTPDESSI","MNTPDESCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","COMP","PRECIOSISR","PRECIOCISR","MNPDSI","MNDESCI","MNTPRECSI","MNDESSI","AfeCANT","FX2","NroItem","FporDTO1","FporCFI","FNETO","AfeTipoCom","FmtoIVA","FKIT","FCFITot","FmtoCFI","prunconimp","FmtoDTO1","fporIva","AfeNroItem","iditemOrig","ciditem","FN11","Prunsinimp","FPRUN","UsarPLista","ProcStock","CODIGO","Equiv","FTXT","cColor","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SeniaVDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTATXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION')
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORES',this.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION')
		this.oEntidad.FacturaDetalle.oItem.oCompGiftcard.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS', this.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Punto de venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..FNUMCOMP   )
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
			Case  lcAlias == lcPrefijo + 'FACTURAELECTRONICAEXPORTACION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FACTURAELECTRONICAEXPORTACION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSSENIADOSEX'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_COMPROBANTEV')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FACTURAELECTRONICAEXPORTACION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP ) or isnull( &lcCursor..FACTSEC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FACTURAELECTRONICAEXPORTACION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + FACTSEC as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( FACTTIPO, 2, 0) + FLETRA + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + FACTSEC, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  vtosenia  
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  ffchvtopag
		* Validar ANTERIORES A 1/1/1753  FecCRela  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPROBANTEV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPROBANTEV
Create Table ZooLogic.TablaTrabajo_COMPROBANTEV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fd2" datetime  null, 
"fecexpo" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fperson" char( 10 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"vmodifw" char( 13 )  null, 
"faltafw" datetime  null, 
"descfw" char( 200 )  null, 
"fhora" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"haltafw" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"horaexpo" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"saltafw" char( 7 )  null, 
"idajuste" char( 10 )  null, 
"bdaltafw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"bdmodifw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"factsec" char( 2 )  null, 
"desmntosi2" numeric( 15, 4 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"fsubtot" numeric( 15, 4 )  null, 
"fsubton" numeric( 15, 4 )  null, 
"sitfisccli" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"signomov" numeric( 2, 0 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"desmntosi" numeric( 15, 4 )  null, 
"recmntosi1" numeric( 15, 4 )  null, 
"recmntosi2" numeric( 15, 4 )  null, 
"desmntosi1" numeric( 15, 4 )  null, 
"desmntosi3" numeric( 15, 4 )  null, 
"recmntosi" numeric( 15, 4 )  null, 
"fajxre" numeric( 15, 2 )  null, 
"mdcimpu" numeric( 15, 4 )  null, 
"anulado" bit  null, 
"fcompfis" bit  null, 
"desaut" bit  null, 
"monsis" char( 10 )  null, 
"idvuelto" char( 5 )  null, 
"fobs" char( 250 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fcliente" char( 185 )  null, 
"fturno" numeric( 1, 0 )  null, 
"idsenia" char( 38 )  null, 
"fmtdes2" numeric( 15, 4 )  null, 
"codigo" char( 38 )  null, 
"senia" char( 38 )  null, 
"md1" numeric( 15, 2 )  null, 
"fmtdes1" numeric( 15, 4 )  null, 
"receptor" char( 10 )  null, 
"fven" char( 10 )  null, 
"moneda" char( 10 )  null, 
"fletra" char( 1 )  null, 
"vtosenia" datetime  null, 
"totrecarsi" numeric( 15, 4 )  null, 
"trci" numeric( 15, 4 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ffch" datetime  null, 
"ftotal" numeric( 15, 2 )  null, 
"totdescsi" numeric( 15, 4 )  null, 
"tdci" numeric( 15, 4 )  null, 
"fmtdes3" numeric( 15, 4 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"recmnto2" numeric( 15, 4 )  null, 
"ffchvtopag" datetime  null, 
"fdescu" numeric( 15, 2 )  null, 
"codlista" char( 6 )  null, 
"md3" numeric( 15, 2 )  null, 
"email" char( 250 )  null, 
"percepcion" numeric( 15, 2 )  null, 
"recmnto" numeric( 15, 4 )  null, 
"recpor" numeric( 6, 2 )  null, 
"mr" numeric( 15, 2 )  null, 
"mr2" numeric( 15, 2 )  null, 
"md2" numeric( 17, 4 )  null, 
"mr1" numeric( 17, 4 )  null, 
"recmnto1" numeric( 15, 4 )  null, 
"gravamen" numeric( 15, 2 )  null, 
"fimpuesto" numeric( 15, 2 )  null, 
"totrecarci" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"cotizdesp" numeric( 15, 4 )  null, 
"cancelar" bit  null, 
"ivasis" numeric( 10, 2 )  null, 
"tipocrela" numeric( 2, 0 )  null, 
"letrarela" char( 1 )  null, 
"puntorela" numeric( 4, 0 )  null, 
"numerorela" numeric( 8, 0 )  null, 
"feccrela" datetime  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_COMPROBANTEV' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_COMPROBANTEV' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAELECTRONICAEXPORTACION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('idajuste','idajuste')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('sitfisccli','sitfisccli')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('fajxre','fajxre')
			.AgregarMapeo('mdcimpu','mdcimpu')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('desaut','desaut')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('idsenia','idsenia')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('senia','senia')
			.AgregarMapeo('md1','md1')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('receptor','receptor')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('vtosenia','vtosenia')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('trci','trci')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('tdci','tdci')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('ffchvtopag','ffchvtopag')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('md3','md3')
			.AgregarMapeo('email','email')
			.AgregarMapeo('percepcion','percepcion')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('mr2','mr2')
			.AgregarMapeo('md2','md2')
			.AgregarMapeo('mr1','mr1')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('gravamen','gravamen')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('totrecarci','totrecarci')
			.AgregarMapeo('totdesc','totdesc')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('cotizdesp','cotizdesp')
			.AgregarMapeo('cancelar','cancelar')
			.AgregarMapeo('ivasis','ivasis')
			.AgregarMapeo('tipocrela','tipocrela')
			.AgregarMapeo('letrarela','letrarela')
			.AgregarMapeo('puntorela','puntorela')
			.AgregarMapeo('numerorela','numerorela')
			.AgregarMapeo('feccrela','feccrela')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_COMPROBANTEV'
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
				Update t Set t.FD2 = isnull( d.FD2, t.FD2 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.IDAJUSTE = isnull( d.IDAJUSTE, t.IDAJUSTE ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.SITFISCCLI = isnull( d.SITFISCCLI, t.SITFISCCLI ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.FAJXRE = isnull( d.FAJXRE, t.FAJXRE ),t.MDCIMPU = isnull( d.MDCIMPU, t.MDCIMPU ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.DESAUT = isnull( d.DESAUT, t.DESAUT ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.IDSENIA = isnull( d.IDSENIA, t.IDSENIA ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.SENIA = isnull( d.SENIA, t.SENIA ),t.MD1 = isnull( d.MD1, t.MD1 ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.RECEPTOR = isnull( d.RECEPTOR, t.RECEPTOR ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.VTOSENIA = isnull( d.VTOSENIA, t.VTOSENIA ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TRCI = isnull( d.TRCI, t.TRCI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.TDCI = isnull( d.TDCI, t.TDCI ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.FFCHVTOPAG = isnull( d.FFCHVTOPAG, t.FFCHVTOPAG ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.MD3 = isnull( d.MD3, t.MD3 ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.PERCEPCION = isnull( d.PERCEPCION, t.PERCEPCION ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.MR = isnull( d.MR, t.MR ),t.MR2 = isnull( d.MR2, t.MR2 ),t.MD2 = isnull( d.MD2, t.MD2 ),t.MR1 = isnull( d.MR1, t.MR1 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.GRAVAMEN = isnull( d.GRAVAMEN, t.GRAVAMEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TOTRECARCI = isnull( d.TOTRECARCI, t.TOTRECARCI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.COTIZDESP = isnull( d.COTIZDESP, t.COTIZDESP ),t.CANCELAR = isnull( d.CANCELAR, t.CANCELAR ),t.IVASIS = isnull( d.IVASIS, t.IVASIS ),t.TIPOCRELA = isnull( d.TIPOCRELA, t.TIPOCRELA ),t.LETRARELA = isnull( d.LETRARELA, t.LETRARELA ),t.PUNTORELA = isnull( d.PUNTORELA, t.PUNTORELA ),t.NUMERORELA = isnull( d.NUMERORELA, t.NUMERORELA ),t.FECCRELA = isnull( d.FECCRELA, t.FECCRELA )
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
				-- Fin Updates
				insert into ZooLogic.COMPROBANTEV(Fd2,Fecexpo,Fecimpo,Fmodifw,Fectrans,Fcuit,Idcaja,Fperson,Cotiz,Vmodifw,Faltafw,Descfw,Fhora,Zadsfw,Haltafw,Umodifw,Horaexpo,Smodifw,Horaimpo,Ualtafw,Hmodifw,Esttrans,Saltafw,Idajuste,Bdaltafw,Valtafw,Bdmodifw,Simbmon,Factsec,Desmntosi2,Fpodes2,Totalcant,Fsubtot,Fsubton,Sitfisccli,Facttipo,Timestamp,Signomov,Subtotsisi,Subtotcisi,Condivalp,Desmntosi,Recmntosi1,Recmntosi2,Desmntosi1,Desmntosi3,Recmntosi,Fajxre,Mdcimpu,Anulado,Fcompfis,Desaut,Monsis,Idvuelto,Fobs,Fpodes1,Fcliente,Fturno,Idsenia,Fmtdes2,Codigo,Senia,Md1,Fmtdes1,Receptor,Fven,Moneda,Fletra,Vtosenia,Totrecarsi,Trci,Fvuelto,Fptoven,Fnumcomp,Ffch,Ftotal,Totdescsi,Tdci,Fmtdes3,Fpodes,Recmnto2,Ffchvtopag,Fdescu,Codlista,Md3,Email,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1,Gravamen,Fimpuesto,Totrecarci,Totdesc,Totimpue,Cotizdesp,Cancelar,Ivasis,Tipocrela,Letrarela,Puntorela,Numerorela,Feccrela)
					Select isnull( d.FD2,''),isnull( d.FECEXPO,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FPERSON,''),isnull( d.COTIZ,0),isnull( d.VMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.DESCFW,''),isnull( d.FHORA,''),isnull( d.ZADSFW,''),convert( char(8), getdate(), 108 ),isnull( d.UMODIFW,''),isnull( d.HORAEXPO,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.SALTAFW,''),isnull( d.IDAJUSTE,''),isnull( d.BDALTAFW,''),isnull( d.VALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.SIMBMON,''),isnull( d.FACTSEC,''),isnull( d.DESMNTOSI2,0),isnull( d.FPODES2,0),isnull( d.TOTALCANT,0),isnull( d.FSUBTOT,0),isnull( d.FSUBTON,0),isnull( d.SITFISCCLI,0),isnull( d.FACTTIPO,0),isnull( d.TIMESTAMP,0),isnull( d.SIGNOMOV,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.CONDIVALP,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTOSI2,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI3,0),isnull( d.RECMNTOSI,0),isnull( d.FAJXRE,0),isnull( d.MDCIMPU,0),isnull( d.ANULADO,0),isnull( d.FCOMPFIS,0),isnull( d.DESAUT,0),isnull( d.MONSIS,''),isnull( d.IDVUELTO,''),isnull( d.FOBS,''),isnull( d.FPODES1,0),isnull( d.FCLIENTE,''),isnull( d.FTURNO,0),isnull( d.IDSENIA,''),isnull( d.FMTDES2,0),isnull( d.CODIGO,''),isnull( d.SENIA,''),isnull( d.MD1,0),isnull( d.FMTDES1,0),isnull( d.RECEPTOR,''),isnull( d.FVEN,''),isnull( d.MONEDA,''),isnull( d.FLETRA,''),isnull( d.VTOSENIA,''),isnull( d.TOTRECARSI,0),isnull( d.TRCI,0),isnull( d.FVUELTO,0),isnull( d.FPTOVEN,0),isnull( d.FNUMCOMP,0),isnull( d.FFCH,''),isnull( d.FTOTAL,0),isnull( d.TOTDESCSI,0),isnull( d.TDCI,0),isnull( d.FMTDES3,0),isnull( d.FPODES,0),isnull( d.RECMNTO2,0),isnull( d.FFCHVTOPAG,''),isnull( d.FDESCU,0),isnull( d.CODLISTA,''),isnull( d.MD3,0),isnull( d.EMAIL,''),isnull( d.PERCEPCION,0),isnull( d.RECMNTO,0),isnull( d.RECPOR,0),isnull( d.MR,0),isnull( d.MR2,0),isnull( d.MD2,0),isnull( d.MR1,0),isnull( d.RECMNTO1,0),isnull( d.GRAVAMEN,0),isnull( d.FIMPUESTO,0),isnull( d.TOTRECARCI,0),isnull( d.TOTDESC,0),isnull( d.TOTIMPUE,0),isnull( d.COTIZDESP,0),isnull( d.CANCELAR,0),isnull( d.IVASIS,0),isnull( d.TIPOCRELA,0),isnull( d.LETRARELA,''),isnull( d.PUNTORELA,0),isnull( d.NUMERORELA,0),isnull( d.FECCRELA,'')
						From deleted d left join ZooLogic.COMPROBANTEV pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.COMPROBANTEV cc 
							 on  d.FACTTIPO = cc.FACTTIPO
							 and  d.FLETRA = cc.FLETRA
							 and  d.FPTOVEN = cc.FPTOVEN
							 and  d.FNUMCOMP = cc.FNUMCOMP
							 and  d.FACTSEC = cc.FACTSEC
						Where pk.CODIGO Is Null 
							 and cc.FACTTIPO Is Null 
							 and cc.FLETRA Is Null 
							 and cc.FPTOVEN Is Null 
							 and cc.FNUMCOMP Is Null 
							 and cc.FACTSEC Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal no es la esperada'
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							on   t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PUNTO DE VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal a importar ya existe'
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.FACTTIPO = h.FACTTIPO
							 and   t.FLETRA = h.FLETRA
							 and   t.FPTOVEN = h.FPTOVEN
							 and   t.FNUMCOMP = h.FNUMCOMP
							 and   t.FACTSEC = h.FACTSEC
							where   h.FACTTIPO is null 
							 and   h.FLETRA is null 
							 and   h.FPTOVEN is null 
							 and   h.FNUMCOMP is null 
							 and   h.FACTSEC is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_COMPROBANTEVDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_COMPROBANTEVDET
ON ZooLogic.TablaTrabajo_COMPROBANTEV_COMPROBANTEVDET
AFTER DELETE
As
Begin
Update t Set 
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.CONRESTR = isnull( d.CONRESTR, t.CONRESTR ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.AFE_SLIQ = isnull( d.AFE_SLIQ, t.AFE_SLIQ ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.FART = isnull( d.FART, t.FART ),
t.GIFTCARD = isnull( d.GIFTCARD, t.GIFTCARD ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.MNTPINT = isnull( d.MNTPINT, t.MNTPINT ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.FTATXT = isnull( d.FTATXT, t.FTATXT ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.COMPROBANTEVDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COMPROBANTEVDET
( 
"AFEPTOVEN",
"AFELETRA",
"AFENUMCOM",
"CODGTIN",
"FUNID",
"AFE_COD",
"CODAUTDJCP",
"IDITEM",
"IDKIT",
"MNTPRECCI",
"AJUCIMP",
"AJUSIMP",
"CONRESTR",
"MNTPTOT",
"TASAIMPINT",
"AFETS",
"MNTPPER",
"MNDESSI",
"MNDESCI",
"PRECIOSISR",
"MNPDSI",
"PRECIOCISR",
"FBRUTO",
"MNTPRECSI",
"MNTPDESCI",
"MNTPDESSI",
"PRECIOSR",
"AFESALDO",
"APORCIVAV",
"FNETO",
"FMTOIVA",
"FX2",
"NROITEM",
"FMTODTO1",
"FPORCFI",
"FMTOCFI",
"AFE_SLIQ",
"ARTPERCEP",
"FKIT",
"FCFITOT",
"FPORDTO1",
"FPORIVA",
"ACONDIVAV",
"AFETIPOCOM",
"AFENROITEM",
"AFECANT",
"PRUNCONIMP",
"IMPINTERNO",
"IDITEMORIG",
"PRUNSINIMP",
"COMP",
"FPRUN",
"CIDITEM",
"FN11",
"USARPLISTA",
"ARTSINDES",
"PROCSTOCK",
"FART",
"GIFTCARD",
"CODIGO",
"MOTDESCU",
"MOTDEVOL",
"EQUIV",
"FTXT",
"CCOLOR",
"SENIACANCE",
"MNTPINT",
"MNTPIVA",
"FCOLTXT",
"FTATXT",
"TALLE",
"FCANT",
"FPRECIO",
"FCFI",
"MNTDES",
"FMONTO"
 )
Select 
d.AFEPTOVEN,
d.AFELETRA,
d.AFENUMCOM,
d.CODGTIN,
d.FUNID,
d.AFE_COD,
d.CODAUTDJCP,
d.IDITEM,
d.IDKIT,
d.MNTPRECCI,
d.AJUCIMP,
d.AJUSIMP,
d.CONRESTR,
d.MNTPTOT,
d.TASAIMPINT,
d.AFETS,
d.MNTPPER,
d.MNDESSI,
d.MNDESCI,
d.PRECIOSISR,
d.MNPDSI,
d.PRECIOCISR,
d.FBRUTO,
d.MNTPRECSI,
d.MNTPDESCI,
d.MNTPDESSI,
d.PRECIOSR,
d.AFESALDO,
d.APORCIVAV,
d.FNETO,
d.FMTOIVA,
d.FX2,
d.NROITEM,
d.FMTODTO1,
d.FPORCFI,
d.FMTOCFI,
d.AFE_SLIQ,
d.ARTPERCEP,
d.FKIT,
d.FCFITOT,
d.FPORDTO1,
d.FPORIVA,
d.ACONDIVAV,
d.AFETIPOCOM,
d.AFENROITEM,
d.AFECANT,
d.PRUNCONIMP,
d.IMPINTERNO,
d.IDITEMORIG,
d.PRUNSINIMP,
d.COMP,
d.FPRUN,
d.CIDITEM,
d.FN11,
d.USARPLISTA,
d.ARTSINDES,
d.PROCSTOCK,
d.FART,
d.GIFTCARD,
d.CODIGO,
d.MOTDESCU,
d.MOTDEVOL,
d.EQUIV,
d.FTXT,
d.CCOLOR,
d.SENIACANCE,
d.MNTPINT,
d.MNTPIVA,
d.FCOLTXT,
d.FTATXT,
d.TALLE,
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.COMPROBANTEVDET pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_VAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_VAL
ON ZooLogic.TablaTrabajo_COMPROBANTEV_VAL
AFTER DELETE
As
Begin
Update t Set 
t.JJFECHA = isnull( d.JJFECHA, t.JJFECHA ),
t.FECHCOTI = isnull( d.FECHCOTI, t.FECHCOTI ),
t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.IDRETIROEF = isnull( d.IDRETIROEF, t.IDRETIROEF ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.REDONDEO = isnull( d.REDONDEO, t.REDONDEO ),
t.DESCMONTO = isnull( d.DESCMONTO, t.DESCMONTO ),
t.DESCPORC = isnull( d.DESCPORC, t.DESCPORC ),
t.DESCSINIMP = isnull( d.DESCSINIMP, t.DESCSINIMP ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.MONDEREPES = isnull( d.MONDEREPES, t.MONDEREPES ),
t.MONDESPES = isnull( d.MONDESPES, t.MONDESPES ),
t.MONRECPES = isnull( d.MONRECPES, t.MONRECPES ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.JJT = isnull( d.JJT, t.JJT ),
t.RECSINIMP = isnull( d.RECSINIMP, t.RECSINIMP ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.ESRETIROEF = isnull( d.ESRETIROEF, t.ESRETIROEF ),
t.ESVUELTO = isnull( d.ESVUELTO, t.ESVUELTO ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.PORCDESREC = isnull( d.PORCDESREC, t.PORCDESREC ),
t.RECPORC = isnull( d.RECPORC, t.RECPORC ),
t.MONDESREC = isnull( d.MONDESREC, t.MONDESREC ),
t.RECSINPER = isnull( d.RECSINPER, t.RECSINPER ),
t.RECMONTO = isnull( d.RECMONTO, t.RECMONTO ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.JJRECIB = isnull( d.JJRECIB, t.JJRECIB ),
t.RECPESOS = isnull( d.RECPESOS, t.RECPESOS ),
t.MONCUPON = isnull( d.MONCUPON, t.MONCUPON ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO ),
t.CUPON = isnull( d.CUPON, t.CUPON )
from ZooLogic.VAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.VAL
( 
"JJFECHA",
"FECHCOTI",
"IDCAJA",
"JJVEN",
"TIPODOC",
"TIPCOMP",
"NROTARJETA",
"IDITEM",
"LETRA",
"IDRETIROEF",
"NRODOC",
"REDONDEO",
"DESCMONTO",
"DESCPORC",
"DESCSINIMP",
"MONTOSISTE",
"MONDEREPES",
"MONDESPES",
"MONRECPES",
"PTOVENTA",
"SIGNO",
"PESOS",
"NROCUPON",
"NUMCOMPR",
"JJCOTIZ",
"NROITEM",
"JJTURNO",
"JJT",
"RECSINIMP",
"COTIZA",
"VISUALCAJA",
"PERSCOMP",
"CELECTRO",
"ESRETIROEF",
"ESVUELTO",
"AUTORIZADO",
"CONDPAGO",
"JJNUM",
"NROCHEQUE",
"NROCHPROP",
"JJCO",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"PORCDESREC",
"RECPORC",
"MONDESREC",
"RECSINPER",
"RECMONTO",
"JJTOTFAC",
"JJRECIB",
"RECPESOS",
"MONCUPON",
"GUIDCOMP",
"GUIDCUPON",
"PERMVUELTO",
"VALECAMBIO",
"CUPON"
 )
Select 
d.JJFECHA,
d.FECHCOTI,
d.IDCAJA,
d.JJVEN,
d.TIPODOC,
d.TIPCOMP,
d.NROTARJETA,
d.IDITEM,
d.LETRA,
d.IDRETIROEF,
d.NRODOC,
d.REDONDEO,
d.DESCMONTO,
d.DESCPORC,
d.DESCSINIMP,
d.MONTOSISTE,
d.MONDEREPES,
d.MONDESPES,
d.MONRECPES,
d.PTOVENTA,
d.SIGNO,
d.PESOS,
d.NROCUPON,
d.NUMCOMPR,
d.JJCOTIZ,
d.NROITEM,
d.JJTURNO,
d.JJT,
d.RECSINIMP,
d.COTIZA,
d.VISUALCAJA,
d.PERSCOMP,
d.CELECTRO,
d.ESRETIROEF,
d.ESVUELTO,
d.AUTORIZADO,
d.CONDPAGO,
d.JJNUM,
d.NROCHEQUE,
d.NROCHPROP,
d.JJCO,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.PORCDESREC,
d.RECPORC,
d.MONDESREC,
d.RECSINPER,
d.RECMONTO,
d.JJTOTFAC,
d.JJRECIB,
d.RECPESOS,
d.MONCUPON,
d.GUIDCOMP,
d.GUIDCUPON,
d.PERMVUELTO,
d.VALECAMBIO,
d.CUPON
From deleted d left join ZooLogic.VAL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_IMPUESTOSV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_IMPUESTOSV
ON ZooLogic.TablaTrabajo_COMPROBANTEV_IMPUESTOSV
AFTER DELETE
As
Begin
Update t Set 
t.INTMONTO = isnull( d.INTMONTO, t.INTMONTO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.INTMONSD = isnull( d.INTMONSD, t.INTMONSD ),
t.IVAMNGSD = isnull( d.IVAMNGSD, t.IVAMNGSD ),
t.IVAMONNG = isnull( d.IVAMONNG, t.IVAMONNG ),
t.IVAPORCENT = isnull( d.IVAPORCENT, t.IVAPORCENT ),
t.IVAMONSD = isnull( d.IVAMONSD, t.IVAMONSD ),
t.IVAMONTO = isnull( d.IVAMONTO, t.IVAMONTO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.IMPUESTOSV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.IMPUESTOSV
( 
"INTMONTO",
"NROITEM",
"INTMONSD",
"IVAMNGSD",
"IVAMONNG",
"IVAPORCENT",
"IVAMONSD",
"IVAMONTO",
"CODIGO"
 )
Select 
d.INTMONTO,
d.NROITEM,
d.INTMONSD,
d.IVAMNGSD,
d.IVAMONNG,
d.IVAPORCENT,
d.IVAMONSD,
d.IVAMONTO,
d.CODIGO
From deleted d left join ZooLogic.IMPUESTOSV pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_CompAfe( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_CompAfe
ON ZooLogic.TablaTrabajo_COMPROBANTEV_CompAfe
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
	function ObtenerTriggerDeleteImportacion_impVentas( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_impVentas
ON ZooLogic.TablaTrabajo_COMPROBANTEV_impVentas
AFTER DELETE
As
Begin
Update t Set 
t.BASE = isnull( d.BASE, t.BASE ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.SIRECS = isnull( d.SIRECS, t.SIRECS ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.REGIMENIMP = isnull( d.REGIMENIMP, t.REGIMENIMP ),
t.SIRECERT = isnull( d.SIRECERT, t.SIRECERT ),
t.MINIMOPER = isnull( d.MINIMOPER, t.MINIMOPER ),
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.MONTOBASE = isnull( d.MONTOBASE, t.MONTOBASE ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.JURID = isnull( d.JURID, t.JURID ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.ARTPERCE = isnull( d.ARTPERCE, t.ARTPERCE )
from ZooLogic.impVentas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.impVentas
( 
"BASE",
"CODIMP",
"CODINT",
"TIPOI",
"SIRECS",
"DESCRI",
"REGIMENIMP",
"SIRECERT",
"MINIMOPER",
"MINOIMP",
"MONTOBASE",
"NROITEM",
"PORCEN",
"MONTO",
"JURID",
"CCOD",
"ARTPERCEP",
"ARTPERCE"
 )
Select 
d.BASE,
d.CODIMP,
d.CODINT,
d.TIPOI,
d.SIRECS,
d.DESCRI,
d.REGIMENIMP,
d.SIRECERT,
d.MINIMOPER,
d.MINOIMP,
d.MONTOBASE,
d.NROITEM,
d.PORCEN,
d.MONTO,
d.JURID,
d.CCOD,
d.ARTPERCEP,
d.ARTPERCE
From deleted d left join ZooLogic.impVentas pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_SeniaVDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_SeniaVDet
ON ZooLogic.TablaTrabajo_COMPROBANTEV_SeniaVDet
AFTER DELETE
As
Begin
Update t Set 
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FART = isnull( d.FART, t.FART ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.COMP = isnull( d.COMP, t.COMP ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.FTATXT = isnull( d.FTATXT, t.FTATXT ),
t.TALLE = isnull( d.TALLE, t.TALLE ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.SeniaVDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SeniaVDet
( 
"AFENUMCOM",
"AFEPTOVEN",
"AFELETRA",
"CODGTIN",
"FART",
"FUNID",
"MNTPTOT",
"MNTPRECCI",
"ACONDIVAV",
"AFESALDO",
"APORCIVAV",
"MNTPPER",
"AFETS",
"MNTPDESSI",
"MNTPDESCI",
"AJUCIMP",
"FBRUTO",
"AJUSIMP",
"PRECIOSR",
"COMP",
"PRECIOSISR",
"PRECIOCISR",
"MNPDSI",
"MNDESCI",
"MNTPRECSI",
"MNDESSI",
"AFECANT",
"FX2",
"NROITEM",
"FPORDTO1",
"FPORCFI",
"FNETO",
"AFETIPOCOM",
"FMTOIVA",
"FKIT",
"FCFITOT",
"FMTOCFI",
"PRUNCONIMP",
"FMTODTO1",
"FPORIVA",
"AFENROITEM",
"IDITEMORIG",
"CIDITEM",
"FN11",
"PRUNSINIMP",
"FPRUN",
"USARPLISTA",
"PROCSTOCK",
"CODIGO",
"EQUIV",
"FTXT",
"CCOLOR",
"MNTPIVA",
"FCOLTXT",
"FTATXT",
"TALLE",
"FCANT",
"FPRECIO",
"FCFI",
"MNTDES",
"FMONTO"
 )
Select 
d.AFENUMCOM,
d.AFEPTOVEN,
d.AFELETRA,
d.CODGTIN,
d.FART,
d.FUNID,
d.MNTPTOT,
d.MNTPRECCI,
d.ACONDIVAV,
d.AFESALDO,
d.APORCIVAV,
d.MNTPPER,
d.AFETS,
d.MNTPDESSI,
d.MNTPDESCI,
d.AJUCIMP,
d.FBRUTO,
d.AJUSIMP,
d.PRECIOSR,
d.COMP,
d.PRECIOSISR,
d.PRECIOCISR,
d.MNPDSI,
d.MNDESCI,
d.MNTPRECSI,
d.MNDESSI,
d.AFECANT,
d.FX2,
d.NROITEM,
d.FPORDTO1,
d.FPORCFI,
d.FNETO,
d.AFETIPOCOM,
d.FMTOIVA,
d.FKIT,
d.FCFITOT,
d.FMTOCFI,
d.PRUNCONIMP,
d.FMTODTO1,
d.FPORIVA,
d.AFENROITEM,
d.IDITEMORIG,
d.CIDITEM,
d.FN11,
d.PRUNSINIMP,
d.FPRUN,
d.USARPLISTA,
d.PROCSTOCK,
d.CODIGO,
d.EQUIV,
d.FTXT,
d.CCOLOR,
d.MNTPIVA,
d.FCOLTXT,
d.FTATXT,
d.TALLE,
d.FCANT,
d.FPRECIO,
d.FCFI,
d.MNTDES,
d.FMONTO
From deleted d left join ZooLogic.SeniaVDet pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPROBANTEV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPROBANTEV
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_FACTURAELECTRONICAEXPORTACION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_FACTURAELECTRONICAEXPORTACION.Cuit, [] )
					.Caja_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Caja, 0 )
					.Cliente_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Cliente, [] )
					.Cotizacion = nvl( c_FACTURAELECTRONICAEXPORTACION.Cotizacion, 0 )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Versionmodificacionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Versionmodificacionfw, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Descripcionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Descripcionfw, [] )
					.Hora = nvl( c_FACTURAELECTRONICAEXPORTACION.Hora, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Horaaltafw = nvl( c_FACTURAELECTRONICAEXPORTACION.Horaaltafw, [] )
					.Usuariomodificacionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Usuariomodificacionfw, [] )
					.Horaexpo = nvl( c_FACTURAELECTRONICAEXPORTACION.Horaexpo, [] )
					.Seriemodificacionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_FACTURAELECTRONICAEXPORTACION.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_FACTURAELECTRONICAEXPORTACION.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Horamodificacionfw, [] )
					.Estadotransferencia = nvl( c_FACTURAELECTRONICAEXPORTACION.Estadotransferencia, [] )
					.Seriealtafw = nvl( c_FACTURAELECTRONICAEXPORTACION.Seriealtafw, [] )
					.Codigoajuste = nvl( c_FACTURAELECTRONICAEXPORTACION.Codigoajuste, [] )
					.Basededatosaltafw = nvl( c_FACTURAELECTRONICAEXPORTACION.Basededatosaltafw, [] )
					.Versionaltafw = nvl( c_FACTURAELECTRONICAEXPORTACION.Versionaltafw, [] )
					.Basededatosmodificacionfw = nvl( c_FACTURAELECTRONICAEXPORTACION.Basededatosmodificacionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_FACTURAELECTRONICAEXPORTACION.Simbolomonetariocomprobante, [] )
					.Secuencia = nvl( c_FACTURAELECTRONICAEXPORTACION.Secuencia, [] )
					.Montodescuentosinimpuestos2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentosinimpuestos2, 0 )
					.Porcentajedescuento2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Porcentajedescuento2, 0 )
					.Totalcantidad = nvl( c_FACTURAELECTRONICAEXPORTACION.Totalcantidad, 0 )
					.Subtotalbruto = nvl( c_FACTURAELECTRONICAEXPORTACION.Subtotalbruto, 0 )
					.Subtotalneto = nvl( c_FACTURAELECTRONICAEXPORTACION.Subtotalneto, 0 )
					.Situacionfiscal_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Situacionfiscal, 0 )
					.Tipocomprobante = nvl( c_FACTURAELECTRONICAEXPORTACION.Tipocomprobante, 0 )
					.Timestamp = nvl( c_FACTURAELECTRONICAEXPORTACION.Timestamp, 0 )
					.Signodemovimiento = nvl( c_FACTURAELECTRONICAEXPORTACION.Signodemovimiento, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_FACTURAELECTRONICAEXPORTACION.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_FACTURAELECTRONICAEXPORTACION.Subtotalconimpuestossobreitems, 0 )
					.Condicioniva = nvl( c_FACTURAELECTRONICAEXPORTACION.Condicioniva, 0 )
					.Montodescuentosinimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentosinimpuestos, 0 )
					.Recargomontosinimpuestos1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontosinimpuestos1, 0 )
					.Recargomontosinimpuestos2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontosinimpuestos2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentosinimpuestos3, 0 )
					.Recargomontosinimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontosinimpuestos, 0 )
					.Ajustesporredondeos = nvl( c_FACTURAELECTRONICAEXPORTACION.Ajustesporredondeos, 0 )
					.Montodescuentoconimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentoconimpuestos, 0 )
					.Anulado = nvl( c_FACTURAELECTRONICAEXPORTACION.Anulado, .F. )
					.Comprobantefiscal = nvl( c_FACTURAELECTRONICAEXPORTACION.Comprobantefiscal, .F. )
					.Descuentoautomatico = nvl( c_FACTURAELECTRONICAEXPORTACION.Descuentoautomatico, .F. )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Monedasistema_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Monedasistema, [] )
					.Idvuelto_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Idvuelto, [] )
					.Obs = nvl( c_FACTURAELECTRONICAEXPORTACION.Obs, [] )
					.Porcentajedescuento1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Porcentajedescuento1, 0 )
					.Clientedescripcion = nvl( c_FACTURAELECTRONICAEXPORTACION.Clientedescripcion, [] )
					.Turno = nvl( c_FACTURAELECTRONICAEXPORTACION.Turno, 0 )
					.Idsenia = nvl( c_FACTURAELECTRONICAEXPORTACION.Idsenia, [] )
					.Montodescuentoconimpuestos2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentoconimpuestos2, 0 )
					.Codigo = nvl( c_FACTURAELECTRONICAEXPORTACION.Codigo, [] )
					.Senia_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Senia, [] )
					.Montodescuento1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuento1, 0 )
					.Montodescuentoconimpuestos1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentoconimpuestos1, 0 )
					.Receptor_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Receptor, [] )
					.Vendedor_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Vendedor, [] )
					.Articulosseniadosdetalle.Limpiar()
					.Articulosseniadosdetalle.SetearEsNavegacion( .lProcesando )
					.Articulosseniadosdetalle.Cargar()
					.Monedacomprobante_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Monedacomprobante, [] )
					.Letra = nvl( c_FACTURAELECTRONICAEXPORTACION.Letra, [] )
					.Fechavtosenia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechavtosenia, ctod( '  /  /    ' ) ) )
					.Totalrecargossinimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totalrecargossinimpuestos, 0 )
					.Totalrecargosconimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totalrecargosconimpuestos, 0 )
					.Vuelto = nvl( c_FACTURAELECTRONICAEXPORTACION.Vuelto, 0 )
					.Puntodeventa = nvl( c_FACTURAELECTRONICAEXPORTACION.Puntodeventa, 0 )
					.Numero = nvl( c_FACTURAELECTRONICAEXPORTACION.Numero, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fecha, ctod( '  /  /    ' ) ) )
					.Total = nvl( c_FACTURAELECTRONICAEXPORTACION.Total, 0 )
					.Totaldescuentossinimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totaldescuentossinimpuestos, 0 )
					.Totaldescuentosconimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totaldescuentosconimpuestos, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuentoconimpuestos3, 0 )
					.Porcentajedescuento = nvl( c_FACTURAELECTRONICAEXPORTACION.Porcentajedescuento, 0 )
					.Recargomontoconimpuestos2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontoconimpuestos2, 0 )
					.Fechavencimientopago = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechavencimientopago, ctod( '  /  /    ' ) ) )
					.Descuento = nvl( c_FACTURAELECTRONICAEXPORTACION.Descuento, 0 )
					.Listadeprecios_PK =  nvl( c_FACTURAELECTRONICAEXPORTACION.Listadeprecios, [] )
					.Montodescuento3 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuento3, 0 )
					.Email = nvl( c_FACTURAELECTRONICAEXPORTACION.Email, [] )
					.Percepciones = nvl( c_FACTURAELECTRONICAEXPORTACION.Percepciones, 0 )
					.Recargomontoconimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontoconimpuestos, 0 )
					.Recargoporcentaje = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargoporcentaje, 0 )
					.Recargomonto = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomonto, 0 )
					.Recargomonto2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomonto2, 0 )
					.Montodescuento2 = nvl( c_FACTURAELECTRONICAEXPORTACION.Montodescuento2, 0 )
					.Recargomonto1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomonto1, 0 )
					.Recargomontoconimpuestos1 = nvl( c_FACTURAELECTRONICAEXPORTACION.Recargomontoconimpuestos1, 0 )
					.Gravamenes = nvl( c_FACTURAELECTRONICAEXPORTACION.Gravamenes, 0 )
					.Impuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Impuestos, 0 )
					.Totalrecargos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totaldescuentos, 0 )
					.Totalimpuestos = nvl( c_FACTURAELECTRONICAEXPORTACION.Totalimpuestos, 0 )
					.Cotizaciondespacho = nvl( c_FACTURAELECTRONICAEXPORTACION.Cotizaciondespacho, 0 )
					.Accioncancelatoria = nvl( c_FACTURAELECTRONICAEXPORTACION.Accioncancelatoria, .F. )
					.Ivadelsistema = nvl( c_FACTURAELECTRONICAEXPORTACION.Ivadelsistema, 0 )
					.Tipocpterelacionado = nvl( c_FACTURAELECTRONICAEXPORTACION.Tipocpterelacionado, 0 )
					.Letracpterelacionado = nvl( c_FACTURAELECTRONICAEXPORTACION.Letracpterelacionado, [] )
					.Puntodeventacpterelacionado = nvl( c_FACTURAELECTRONICAEXPORTACION.Puntodeventacpterelacionado, 0 )
					.Numerocpterelacionado = nvl( c_FACTURAELECTRONICAEXPORTACION.Numerocpterelacionado, 0 )
					.Fechacpterelacionado = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAELECTRONICAEXPORTACION.Fechacpterelacionado, ctod( '  /  /    ' ) ) )
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
			lxRetorno = c_FACTURAELECTRONICAEXPORTACION.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
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

		loDetalle = this.oEntidad.ArticulosSeniadosDetalle
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
				lcSentencia = "UPDATE ZooLogic.COMPROBANTEVDET"
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
		return c_FACTURAELECTRONICAEXPORTACION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.COMPROBANTEV' )
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
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "COMPROBANTEV", "", lcCursor, set("Datasession") )
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
			"Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fperson" as "Cliente", "Cotiz" as "Cotizacion", "Vmodifw" as "Versionmodificacionfw", "Faltafw" as "Fechaaltafw", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Haltafw" as "Horaaltafw", "Umodifw" as "Usuariomodificacionfw", "Horaexpo" as "Horaexpo", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Esttrans" as "Estadotransferencia", "Saltafw" as "Seriealtafw", "Idajuste" as "Codigoajuste", "Bdaltafw" as "Basededatosaltafw", "Valtafw" as "Versionaltafw", "Bdmodifw" as "Basededatosmodificacionfw", "Simbmon" as "Simbolomonetariocomprobante", "Factsec" as "Secuencia", "Desmntosi2" as "Montodescuentosinimpuestos2", "Fpodes2" as "Porcentajedescuento2", "Totalcant" as "Totalcantidad", "Fsubtot" as "Subtotalbruto", "Fsubton" as "Subtotalneto", "Sitfisccli" as "Situacionfiscal", "Facttipo" as "Tipocomprobante", "Timestamp" as "Timestamp", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Condivalp" as "Condicioniva", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Recmntosi" as "Recargomontosinimpuestos", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Anulado" as "Anulado", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fcliente" as "Clientedescripcion", "Fturno" as "Turno", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Senia" as "Senia", "Md1" as "Montodescuento1", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Fvuelto" as "Vuelto", "Fptoven" as "Puntodeventa", "Fnumcomp" as "Numero", "Ffch" as "Fecha", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Ffchvtopag" as "Fechavencimientopago", "Fdescu" as "Descuento", "Codlista" as "Listadeprecios", "Md3" as "Montodescuento3", "Email" as "Email", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Cotizdesp" as "Cotizaciondespacho", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33
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
	Tabla = 'COMPROBANTEV'
	Filtro = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "ComprobanteV.FAltaFW, ComprobanteV.HAltaFW"
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
										<xsd:maxLength value="250"/>
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
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAMODIFICACION                       " tabla="COMPROBANTEV   " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAEXPO                               " tabla="COMPROBANTEV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAIMPO                               " tabla="COMPROBANTEV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHATRANSFERENCIA                      " tabla="COMPROBANTEV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CUIT                                    " tabla="COMPROBANTEV   " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="CUIT                                                                                                                                                                                                                                                      " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CAJA                                    " tabla="COMPROBANTEV   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                                                                                                                      " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CLIENTE                                 " tabla="COMPROBANTEV   " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                                                                                                                   " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="COTIZACION                              " tabla="COMPROBANTEV   " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FACTURADETALLE                          " tabla="COMPROBANTEVDET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMARTICULOSVENTAS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VALORESDETALLE                          " tabla="VAL            " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Valores                                                                                                                                                                                                                                                   " dominio="DETALLEITEMVALORES            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IMPUESTOSDETALLE                        " tabla="IMPUESTOSV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOS          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAALTAFW                             " tabla="COMPROBANTEV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="20" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="DESCRIPCIONFW                           " tabla="COMPROBANTEV   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="HORA                                    " tabla="COMPROBANTEV   " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="ZADSFW                                  " tabla="COMPROBANTEV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="HORAALTAFW                              " tabla="COMPROBANTEV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="22" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="HORAEXPO                                " tabla="COMPROBANTEV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SERIEMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="HORAIMPO                                " tabla="COMPROBANTEV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="USUARIOALTAFW                           " tabla="COMPROBANTEV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="HORAMODIFICACIONFW                      " tabla="COMPROBANTEV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPROBANTEV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SERIEALTAFW                             " tabla="COMPROBANTEV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CODIGOAJUSTE                            " tabla="COMPROBANTEV   " campo="IDAJUSTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo de Ajuste                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="BASEDEDATOSALTAFW                       " tabla="COMPROBANTEV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VERSIONALTAFW                           " tabla="COMPROBANTEV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPROBANTEV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="COMPROBANTEV   " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SECUENCIA                               " tabla="COMPROBANTEV   " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Secuencia                                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="COMPROBANTEV   " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PORCENTAJEDESCUENTO2                    " tabla="COMPROBANTEV   " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 2                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALCANTIDAD                           " tabla="COMPROBANTEV   " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total Cantidad                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALBRUTO                           " tabla="COMPROBANTEV   " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALNETO                            " tabla="COMPROBANTEV   " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SITUACIONFISCAL                         " tabla="COMPROBANTEV   " campo="SITFISCCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="=3                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TIPOCOMPROBANTE                         " tabla="COMPROBANTEV   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=33                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="18" etiqueta="Tipo de comprobante                                                                                                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TIMESTAMP                               " tabla="COMPROBANTEV   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPROBANTEV   " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CONDICIONIVA                            " tabla="COMPROBANTEV   " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="COMPROBANTEV   " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="COMPROBANTEV   " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="COMPROBANTEV   " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="AJUSTESPORREDONDEOS                     " tabla="COMPROBANTEV   " campo="FAJXRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Ajustes por redondeo                                                                                                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOCONIMPUESTOS              " tabla="COMPROBANTEV   " campo="MDCIMPU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="ANULADO                                 " tabla="COMPROBANTEV   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="COMPROBANTEFISCAL                       " tabla="COMPROBANTEV   " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="DESCUENTOAUTOMATICO                     " tabla="COMPROBANTEV   " campo="DESAUT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPVENTAS      " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos del comprobante                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOVENTAS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONEDASISTEMA                           " tabla="COMPROBANTEV   " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IDVUELTO                                " tabla="COMPROBANTEV   " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="OBS                                     " tabla="COMPROBANTEV   " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PORCENTAJEDESCUENTO1                    " tabla="COMPROBANTEV   " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 1                                                                                                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CLIENTEDESCRIPCION                      " tabla="COMPROBANTEV   " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Cliente descripción                                                                                                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TURNO                                   " tabla="COMPROBANTEV   " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                                                                                                                     " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IDSENIA                                 " tabla="COMPROBANTEV   " campo="IDSENIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código seña                                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="COMPROBANTEV   " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 2                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CODIGO                                  " tabla="COMPROBANTEV   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="24" etiqueta="Código número                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SENIA                                   " tabla="COMPROBANTEV   " campo="SENIA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SENIA                                   " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id del comprobante seña                                                                                                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTO1                         " tabla="COMPROBANTEV   " campo="MD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento 1                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="COMPROBANTEV   " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 1                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECEPTOR                                " tabla="COMPROBANTEV   " campo="RECEPTOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Despachar a                                                                                                                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VENDEDOR                                " tabla="COMPROBANTEV   " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Vendedor                                                                                                                                                                                                                                                  " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="ARTICULOSSENIADOSDETALLE                " tabla="SENIAVDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Artículos señados                                                                                                                                                                                                                                         " dominio="DETALLEITEMARTICULOSSENIADOSEX" detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONEDACOMPROBANTE                       " tabla="COMPROBANTEV   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="=ALLTRIM( goParametros.Felino.GestionDeVentas.FacturacionElectronica.Exportacion.CodigoDeMonedaExtranjeraSugerida )                                                                                                                                           " obligatorio="true" admitebusqueda="412" etiqueta="Moneda                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CODIGOBARRACAE                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código de barra                                                                                                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="LETRA                                   " tabla="COMPROBANTEV   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                                                                                                                     " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAVTOSENIA                           " tabla="COMPROBANTEV   " campo="VTOSENIA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento de la seña                                                                                                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="COMPROBANTEV   " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos Sin impuestos                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALRECARGOSCONIMPUESTOS               " tabla="COMPROBANTEV   " campo="TRCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargos con impuestos                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VUELTO                                  " tabla="COMPROBANTEV   " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto persistido                                                                                                                                                                                                                                         " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="VUELTOVIRTUAL                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Vuelto                                                                                                                                                                                                                                                    " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PUNTODEVENTA                            " tabla="COMPROBANTEV   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Punto de venta                                                                                                                                                                                                                                            " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="NUMERO                                  " tabla="COMPROBANTEV   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHA                                   " tabla="COMPROBANTEV   " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTAL                                   " tabla="COMPROBANTEV   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                                                                                                                     " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="COMPROBANTEV   " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALDESCUENTOSCONIMPUESTOS             " tabla="COMPROBANTEV   " campo="TDCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos con impuestos                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="CAE                                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="C.A.E.                                                                                                                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="COMPROBANTEV   " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 3                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAVENCIMIENTOCAE                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Vto C.A.E.                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PORCENTAJEDESCUENTO                     " tabla="COMPROBANTEV   " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Porcentaje de descuento                                                                                                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHAVENCIMIENTOPAGO                    " tabla="COMPROBANTEV   " campo="FFCHVTOPAG" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Vto de pago                                                                                                                                                                                                                                               " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="DESCUENTO                               " tabla="COMPROBANTEV   " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Monto % descuento                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="LISTADEPRECIOS                          " tabla="COMPROBANTEV   " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.GestionDeVentas.FacturacionElectronica.Exportacion.ListaDePreciosSugerida                                                                                                                                                                " obligatorio="true" admitebusqueda="426" etiqueta="Lista de precio                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTO3                         " tabla="COMPROBANTEV   " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Monto de descuento                                                                                                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="INCOTERMS                               " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INCOTERMS                               " tipodato="C         " longitud="3" decimales="0" valorsugerido="=goParametros.Felino.GestionDeVentas.FacturacionElectronica.Exportacion.Incoterms                                                                                                                                                                             " obligatorio="true" admitebusqueda="430" etiqueta="Incoterms                                                                                                                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="EMAIL                                   " tabla="COMPROBANTEV   " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Email                                                                                                                                                                                                                                                     " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="35" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PERCEPCIONES                            " tabla="COMPROBANTEV   " campo="PERCEPCION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepciones                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOPORCENTAJE                       " tabla="COMPROBANTEV   " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Recargo porcentaje                                                                                                                                                                                                                                        " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTO                            " tabla="COMPROBANTEV   " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Recargo % monto                                                                                                                                                                                                                                           " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTO2                           " tabla="COMPROBANTEV   " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Recargo monto                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTO2VISUAL                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Descuentos en valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="MONTODESCUENTO2                         " tabla="COMPROBANTEV   " campo="MD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento valores                                                                                                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTO1VISUAL                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Monto de recargo valores                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTO1                           " tabla="COMPROBANTEV   " campo="MR1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto recargo valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALSINIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal sin imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="GRAVAMENES                              " tabla="COMPROBANTEV   " campo="GRAVAMEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Interno                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IMPUESTOS                               " tabla="COMPROBANTEV   " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="I.V.A.                                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="SUBTOTALCONIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal con imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALRECARGOS                           " tabla="COMPROBANTEV   " campo="TOTRECARCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos total                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALDESCUENTOS                         " tabla="COMPROBANTEV   " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="28" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TOTALIMPUESTOS                          " tabla="COMPROBANTEV   " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Total impuestos                                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="COTIZACIONDESPACHO                      " tabla="COMPROBANTEV   " campo="COTIZDESP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="448" etiqueta="Cotización despacho                                                                                                                                                                                                                                       " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="70" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="ACCIONCANCELATORIA                      " tabla="COMPROBANTEV   " campo="CANCELAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="80" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="IVADELSISTEMA                           " tabla="COMPROBANTEV   " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="TIPOCPTERELACIONADO                     " tabla="COMPROBANTEV   " campo="TIPOCRELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="90" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="LETRACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="LETRARELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante asociado                                                                                                                                                                                                                                      " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="91" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="PUNTODEVENTACPTERELACIONADO             " tabla="COMPROBANTEV   " campo="PUNTORELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="92" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="NUMEROCPTERELACIONADO                   " tabla="COMPROBANTEV   " campo="NUMERORELA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="93" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAELECTRONICAEXPORTACION           " atributo="FECHACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="FECCRELA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha comprobante asociado                                                                                                                                                                                                                                " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="94" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="17" etiqueta="Detalle Des.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.RECEPTOR = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ven.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPROBANTEV.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Mon.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COMPROBANTEV.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Lis.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMPROBANTEV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULO                                " tabla="COMPROBANTEVDET" campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULODETALLE                         " tabla="COMPROBANTEVDET" campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLOR                                   " tabla="COMPROBANTEVDET" campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLORDETALLE                            " tabla="COMPROBANTEVDET" campo="FCOLTXT   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Color descripción                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="TALLE                                   " tabla="COMPROBANTEVDET" campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="CANTIDAD                                " tabla="COMPROBANTEVDET" campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="=this.CompletarCantidadSegunParametro()                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADO  " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="PRECIO                                  " tabla="COMPROBANTEVDET" campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="DESCUENTO                               " tabla="COMPROBANTEVDET" campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, % Descuento                                                                                                                                   " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTODESCUENTO                          " tabla="COMPROBANTEVDET" campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Monto descuento                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTO                                   " tabla="COMPROBANTEVDET" campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 33                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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