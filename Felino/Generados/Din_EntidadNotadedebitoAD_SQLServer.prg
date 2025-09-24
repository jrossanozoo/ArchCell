
define class Din_EntidadNOTADEDEBITOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_NOTADEDEBITO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Secuencia]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0) + #tabla#.FACTSEC]
	cTagClaveCandidata = '_021CC'
	cTagClavePk = '_021PK'
	cTablaPrincipal = 'COMPROBANTEV'
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
			local  lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFectrans, lxComprobantevFaltafw, lxComprobantevFmodifw, lxComprobantevIdcaja, lxComprobantevMr, lxComprobantevRecpor, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevDesmntosi3, lxComprobantevTimestamp, lxComprobantevDesmntosi2, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMr2, lxComprobantevDesmntosi1, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevFsubtot, lxComprobantevDesmntosi, lxComprobantevRecmnto2, lxComprobantevRecmntosi, lxComprobantevRecmntosi2, lxComprobantevRecmntosi1, lxComprobantevRecmnto1, lxComprobantevFpodes2, lxComprobantevRecmnto, lxComprobantevDesauto, lxComprobantevAnulado, lxComprobantevNoper, lxComprobantevFcompfis, lxComprobantevEsttrans, lxComprobantevBdmodifw, lxComprobantevValtafw, lxComprobantevZadsfw, lxComprobantevOpecomm, lxComprobantevUmodifw, lxComprobantevUaltafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevSaltafw, lxComprobantevBdaltafw, lxComprobantevFhora, lxComprobantevSimbmon, lxComprobantevDescfw, lxComprobantevIdajuste, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFletra, lxComprobantevFfch, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevMd2, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFven, lxComprobantevFptoven, lxComprobantevDeuda, lxComprobantevFmtdes3, lxComprobantevMoneda, lxComprobantevFnumcomp, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevSitfisccli, lxComprobantevCodlista, lxComprobantevFcuit, lxComprobantevCotiz, lxComprobantevEmail, lxComprobantevFvuelto, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevMr1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevMr =  .Recargomonto			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevDesauto =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevNoper =  .Nocalculapercepcion			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevFhora =  .Hora			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFletra =  .Letra			lxComprobantevFfch =  .Fecha			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevDeuda =  .Deuda			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFnumcomp =  .Numero			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevCotiz =  .Cotizacion			lxComprobantevEmail =  .Email			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
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
				insert into ZooLogic.COMPROBANTEV ( "Fecimpo","Fd2","Fecexpo","Fectrans","Faltafw","Fmodifw","Idcaja","Mr","Recpor","Fpodes1","Fperson","Fturno","Mdcimpu","Fajxre","Desmntosi3","Timestamp","Desmntosi2","Factsec","Totalcant","Mr2","Desmntosi1","Condivalp","Subtotsisi","Subtotcisi","Signomov","Fsubton","Facttipo","Fsubtot","Desmntosi","Recmnto2","Recmntosi","Recmntosi2","Recmntosi1","Recmnto1","Fpodes2","Recmnto","Desauto","Anulado","Noper","Fcompfis","Esttrans","Bdmodifw","Valtafw","Zadsfw","Opecomm","Umodifw","Ualtafw","Vmodifw","Hmodifw","Smodifw","Haltafw","Horaimpo","Horaexpo","Saltafw","Bdaltafw","Fhora","Simbmon","Descfw","Idajuste","Monsis","Idvuelto","Motdescdev","Fobs","Fletra","Ffch","Md1","Fcliente","Md2","Fmtdes1","Fmtdes2","Codigo","Fven","Fptoven","Deuda","Fmtdes3","Moneda","Fnumcomp","Tdci","Totdescsi","Sitfisccli","Codlista","Fcuit","Cotiz","Email","Fvuelto","Ftotal","Fpodes","Fdescu","Md3","Percepcion","Mr1","Gravamen","Fimpuesto","Totrecar","Totrecarsi","Trci","Totdesc","Totimpue","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevMr >>, <<lxComprobantevRecpor >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevFajxre >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevTimestamp >>, <<lxComprobantevDesmntosi2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevMr2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevSignomov >>, <<lxComprobantevFsubton >>, <<lxComprobantevFacttipo >>, <<lxComprobantevFsubtot >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevRecmnto >>, <<iif( lxComprobantevDesauto, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevNoper, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevMd2 >>, <<lxComprobantevFmtdes1 >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevFptoven >>, <<lxComprobantevDeuda >>, <<lxComprobantevFmtdes3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevTdci >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevSitfisccli >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFtotal >>, <<lxComprobantevFpodes >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevMr1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >> )
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
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxComportamiento = loItem.Comportamiento
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_saldo = loItem.Afe_saldo
					lxMontodto1 = loItem.Montodto1
					lxMontoiva = loItem.Montoiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNeto = loItem.Neto
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxMontocfi = loItem.Montocfi
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ComprobanteVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.ComprobanteVDet" )
this.xmlacursor( lcXml, 'c_ComprobanteVDetciditem' )
loItem.idItem = c_ComprobanteVDetciditem.ciditem
use in select( 'c_ComprobanteVDetciditem' )
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
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxSigno = loItem.Signo
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNumerocupon = loItem.Numerocupon
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxTurno = loItem.Turno
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxRedondeo = loItem.Redondeo
					lxNrodocumento = loItem.Nrodocumento
					lxTipodocumento = loItem.Tipodocumento
					lxIditemvalores = loItem.Iditemvalores
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxLetra = loItem.Letra
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargomonto = loItem.Recargomonto
					lxMontodesrec = loItem.Montodesrec
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","descmonto","descporc","Cotiza","MonRecPes","monderepes","MonDesPes","descsinimp","Signo","NroItem","NumCompr","NroCupon","Pesos","JJT","PtoVenta","JJCotiz","JJTurno","EsRetiroEf","esvuelto","CElectro","VisualCaja","Autorizado","PersComp","TIPCOMP","Redondeo","NroDoc","TipoDoc","IdItem","IdretiroEf","JJVen","NroTarjeta","Letra","condpago","NroChProp","NroCheque","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","porcdesrec","jrecmnt","mondesrec","JJTotFac","JJRecib","jrecmntsi","Montosiste","RecPesos","MonCupon","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxUltimacotizacion>>, <<lxRecargomontoenpesos>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxDescuentomontosinimpuestos>>, <<lxSigno>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<lxNumerocupon>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxTurno>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxPorcentajedesrec>>, <<lxRecargomonto>>, <<lxMontodesrec>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
						Insert into ZooLogic.ImpuestosV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
					
					lxMontobase = loItem.Montobase
					lxMinimo = loItem.Minimo
					lxPorcentaje = loItem.Porcentaje
					lxCertificadosire = loItem.Certificadosire
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMonto = loItem.Monto
					lxNroitem = lnContadorNroItem
					lxCodseguridadsire = loItem.Codseguridadsire
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxDescripcion = loItem.Descripcion
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("MontoBase","MinimoPer","porcen","SIRECERT","minoimp","Monto","NroItem","SIRECS","Base","RegimenImp","TipoI","codint","CodImp","Descri","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<lxMontobase>>, <<lxMinimo>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimonoimponible>>, <<lxMonto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxComportamiento = loItem.Comportamiento
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxOferta = loItem.Oferta
					lxMontocfi = loItem.Montocfi
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxAfe_saldo = loItem.Afe_saldo
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxAfe_codigo = loItem.Afe_codigo
					lxUnidad_PK = loItem.Unidad_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KITDET("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","MNTPPER","MNTPDESCI","MNTPTOT","ConRestr","AfeTS","MNTPRECCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","tasaimpint","PRECIOSISR","PRECIOCISR","COMP","MNTPDESSI","MNDESCI","MNPDSI","MNTPRECSI","MNDESSI","AfeCANT","APorcIvaV","FNETO","FmtoIVA","NroItem","FmtoDTO1","FX2","FmtoCFI","ArtPercep","FCFITot","FporCFI","FKIT","FporDTO1","ACondIvaV","AfeNroItem","iditemOrig","AfeTipoCom","impinterno","Afe_SLiq","fporIva","Prunsinimp","prunconimp","FPRUN","AfeSaldo","FN11","ArtSinDes","ProcStock","UsarPLista","IDKIT","FAMate","IdItem","CodAutDJCP","afe_cod","FUnid","CODIGO","GiftCard","Equiv","MotDevol","MotDescu","FTXT","FCOLO","FCOLDET","FTALL","FCFI","MNTDES","MNTPIVA","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxTienerestriccion>>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxTasaimpuestointerno>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxComportamiento>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxOferta>>, <<lxMontocfi>>, <<lxPercepcionivarg5329>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajecfi>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxAfe_tipocomprobante>>, <<lxMontoimpuestointerno>>, <<lxAfe_saldoliquidacion>>, <<lxPorcentajeiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxPreciounitario>>, <<lxAfe_saldo>>, <<lxTipolistadeprecio>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.KITDET" )
this.xmlacursor( lcXml, 'c_KITDETciditem' )
loItem.idItem = c_KITDETciditem.ciditem
use in select( 'c_KITDETciditem' )
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
			local  lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFectrans, lxComprobantevFaltafw, lxComprobantevFmodifw, lxComprobantevIdcaja, lxComprobantevMr, lxComprobantevRecpor, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevDesmntosi3, lxComprobantevTimestamp, lxComprobantevDesmntosi2, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMr2, lxComprobantevDesmntosi1, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevFsubtot, lxComprobantevDesmntosi, lxComprobantevRecmnto2, lxComprobantevRecmntosi, lxComprobantevRecmntosi2, lxComprobantevRecmntosi1, lxComprobantevRecmnto1, lxComprobantevFpodes2, lxComprobantevRecmnto, lxComprobantevDesauto, lxComprobantevAnulado, lxComprobantevNoper, lxComprobantevFcompfis, lxComprobantevEsttrans, lxComprobantevBdmodifw, lxComprobantevValtafw, lxComprobantevZadsfw, lxComprobantevOpecomm, lxComprobantevUmodifw, lxComprobantevUaltafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevSaltafw, lxComprobantevBdaltafw, lxComprobantevFhora, lxComprobantevSimbmon, lxComprobantevDescfw, lxComprobantevIdajuste, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFletra, lxComprobantevFfch, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevMd2, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFven, lxComprobantevFptoven, lxComprobantevDeuda, lxComprobantevFmtdes3, lxComprobantevMoneda, lxComprobantevFnumcomp, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevSitfisccli, lxComprobantevCodlista, lxComprobantevFcuit, lxComprobantevCotiz, lxComprobantevEmail, lxComprobantevFvuelto, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevMr1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevMr =  .Recargomonto			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevDesauto =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevNoper =  .Nocalculapercepcion			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevFhora =  .Hora			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFletra =  .Letra			lxComprobantevFfch =  .Fecha			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevDeuda =  .Deuda			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFnumcomp =  .Numero			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevCotiz =  .Cotizacion			lxComprobantevEmail =  .Email			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
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
				update ZooLogic.COMPROBANTEV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>,"Idcaja" = <<lxComprobantevIdcaja>>,"Mr" = <<lxComprobantevMr>>,"Recpor" = <<lxComprobantevRecpor>>,"Fpodes1" = <<lxComprobantevFpodes1>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>,"Fturno" = <<lxComprobantevFturno>>,"Mdcimpu" = <<lxComprobantevMdcimpu>>,"Fajxre" = <<lxComprobantevFajxre>>,"Desmntosi3" = <<lxComprobantevDesmntosi3>>,"Timestamp" = <<lxComprobantevTimestamp>>,"Desmntosi2" = <<lxComprobantevDesmntosi2>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>,"Totalcant" = <<lxComprobantevTotalcant>>,"Mr2" = <<lxComprobantevMr2>>,"Desmntosi1" = <<lxComprobantevDesmntosi1>>,"Condivalp" = <<lxComprobantevCondivalp>>,"Subtotsisi" = <<lxComprobantevSubtotsisi>>,"Subtotcisi" = <<lxComprobantevSubtotcisi>>,"Signomov" = <<lxComprobantevSignomov>>,"Fsubton" = <<lxComprobantevFsubton>>,"Facttipo" = <<lxComprobantevFacttipo>>,"Fsubtot" = <<lxComprobantevFsubtot>>,"Desmntosi" = <<lxComprobantevDesmntosi>>,"Recmnto2" = <<lxComprobantevRecmnto2>>,"Recmntosi" = <<lxComprobantevRecmntosi>>,"Recmntosi2" = <<lxComprobantevRecmntosi2>>,"Recmntosi1" = <<lxComprobantevRecmntosi1>>,"Recmnto1" = <<lxComprobantevRecmnto1>>,"Fpodes2" = <<lxComprobantevFpodes2>>,"Recmnto" = <<lxComprobantevRecmnto>>,"Desauto" = <<iif( lxComprobantevDesauto, 1, 0 )>>,"Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>,"Noper" = <<iif( lxComprobantevNoper, 1, 0 )>>,"Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>,"Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>,"Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>,"Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>,"Md1" = <<lxComprobantevMd1>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>,"Md2" = <<lxComprobantevMd2>>,"Fmtdes1" = <<lxComprobantevFmtdes1>>,"Fmtdes2" = <<lxComprobantevFmtdes2>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>,"Fptoven" = <<lxComprobantevFptoven>>,"Deuda" = <<lxComprobantevDeuda>>,"Fmtdes3" = <<lxComprobantevFmtdes3>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>,"Fnumcomp" = <<lxComprobantevFnumcomp>>,"Tdci" = <<lxComprobantevTdci>>,"Totdescsi" = <<lxComprobantevTotdescsi>>,"Sitfisccli" = <<lxComprobantevSitfisccli>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>,"Cotiz" = <<lxComprobantevCotiz>>,"Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>,"Fvuelto" = <<lxComprobantevFvuelto>>,"Ftotal" = <<lxComprobantevFtotal>>,"Fpodes" = <<lxComprobantevFpodes>>,"Fdescu" = <<lxComprobantevFdescu>>,"Md3" = <<lxComprobantevMd3>>,"Percepcion" = <<lxComprobantevPercepcion>>,"Mr1" = <<lxComprobantevMr1>>,"Gravamen" = <<lxComprobantevGravamen>>,"Fimpuesto" = <<lxComprobantevFimpuesto>>,"Totrecar" = <<lxComprobantevTotrecar>>,"Totrecarsi" = <<lxComprobantevTotrecarsi>>,"Trci" = <<lxComprobantevTrci>>,"Totdesc" = <<lxComprobantevTotdesc>>,"Totimpue" = <<lxComprobantevTotimpue>>,"Ivasis" = <<lxComprobantevIvasis>>,"Tipocrela" = <<lxComprobantevTipocrela>>,"Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>,"Puntorela" = <<lxComprobantevPuntorela>>,"Numerorela" = <<lxComprobantevNumerorela>>,"Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ComprobanteVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpuestosV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KITDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxComportamiento = loItem.Comportamiento
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_saldo = loItem.Afe_saldo
					lxMontodto1 = loItem.Montodto1
					lxMontoiva = loItem.Montoiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNeto = loItem.Neto
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxMontocfi = loItem.Montocfi
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ComprobanteVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.ComprobanteVDet" )
this.xmlacursor( lcXml, 'c_ComprobanteVDetciditem' )
loItem.idItem = c_ComprobanteVDetciditem.ciditem
use in select( 'c_ComprobanteVDetciditem' )
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
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxSigno = loItem.Signo
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNumerocupon = loItem.Numerocupon
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxTurno = loItem.Turno
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxRedondeo = loItem.Redondeo
					lxNrodocumento = loItem.Nrodocumento
					lxTipodocumento = loItem.Tipodocumento
					lxIditemvalores = loItem.Iditemvalores
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxLetra = loItem.Letra
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargomonto = loItem.Recargomonto
					lxMontodesrec = loItem.Montodesrec
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","descmonto","descporc","Cotiza","MonRecPes","monderepes","MonDesPes","descsinimp","Signo","NroItem","NumCompr","NroCupon","Pesos","JJT","PtoVenta","JJCotiz","JJTurno","EsRetiroEf","esvuelto","CElectro","VisualCaja","Autorizado","PersComp","TIPCOMP","Redondeo","NroDoc","TipoDoc","IdItem","IdretiroEf","JJVen","NroTarjeta","Letra","condpago","NroChProp","NroCheque","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","porcdesrec","jrecmnt","mondesrec","JJTotFac","JJRecib","jrecmntsi","Montosiste","RecPesos","MonCupon","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxUltimacotizacion>>, <<lxRecargomontoenpesos>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxDescuentomontosinimpuestos>>, <<lxSigno>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<lxNumerocupon>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxTurno>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxPorcentajedesrec>>, <<lxRecargomonto>>, <<lxMontodesrec>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
						Insert into ZooLogic.ImpuestosV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
					
					lxMontobase = loItem.Montobase
					lxMinimo = loItem.Minimo
					lxPorcentaje = loItem.Porcentaje
					lxCertificadosire = loItem.Certificadosire
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMonto = loItem.Monto
					lxNroitem = lnContadorNroItem
					lxCodseguridadsire = loItem.Codseguridadsire
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxDescripcion = loItem.Descripcion
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("MontoBase","MinimoPer","porcen","SIRECERT","minoimp","Monto","NroItem","SIRECS","Base","RegimenImp","TipoI","codint","CodImp","Descri","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<lxMontobase>>, <<lxMinimo>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimonoimponible>>, <<lxMonto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxComportamiento = loItem.Comportamiento
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxOferta = loItem.Oferta
					lxMontocfi = loItem.Montocfi
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxAfe_saldo = loItem.Afe_saldo
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxAfe_codigo = loItem.Afe_codigo
					lxUnidad_PK = loItem.Unidad_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KITDET("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","MNTPPER","MNTPDESCI","MNTPTOT","ConRestr","AfeTS","MNTPRECCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","tasaimpint","PRECIOSISR","PRECIOCISR","COMP","MNTPDESSI","MNDESCI","MNPDSI","MNTPRECSI","MNDESSI","AfeCANT","APorcIvaV","FNETO","FmtoIVA","NroItem","FmtoDTO1","FX2","FmtoCFI","ArtPercep","FCFITot","FporCFI","FKIT","FporDTO1","ACondIvaV","AfeNroItem","iditemOrig","AfeTipoCom","impinterno","Afe_SLiq","fporIva","Prunsinimp","prunconimp","FPRUN","AfeSaldo","FN11","ArtSinDes","ProcStock","UsarPLista","IDKIT","FAMate","IdItem","CodAutDJCP","afe_cod","FUnid","CODIGO","GiftCard","Equiv","MotDevol","MotDescu","FTXT","FCOLO","FCOLDET","FTALL","FCFI","MNTDES","MNTPIVA","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxTienerestriccion>>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxTasaimpuestointerno>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxComportamiento>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxOferta>>, <<lxMontocfi>>, <<lxPercepcionivarg5329>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajecfi>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxAfe_tipocomprobante>>, <<lxMontoimpuestointerno>>, <<lxAfe_saldoliquidacion>>, <<lxPorcentajeiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxPreciounitario>>, <<lxAfe_saldo>>, <<lxTipolistadeprecio>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.KITDET" )
this.xmlacursor( lcXml, 'c_KITDETciditem' )
loItem.idItem = c_KITDETciditem.ciditem
use in select( 'c_KITDETciditem' )
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPROBANTEV where " + this.ConvertirFuncionesSql( " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4" ) )
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
				select "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )

			if reccount( 'c_NOTADEDEBITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxComprobanteVFACTTIPO As Variant, lxComprobanteVFLETRA As Variant, lxComprobanteVFPTOVEN As Variant, lxComprobanteVFNUMCOMP As Variant, lxCOMPROBANTEVFACTSEC As Variant
			lxComprobanteVFACTTIPO = .TipoComprobante
			lxComprobanteVFLETRA = .Letra
			lxComprobanteVFPTOVEN = .PuntoDeVenta
			lxComprobanteVFNUMCOMP = .Numero
			lxCOMPROBANTEVFACTSEC = .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 And FACTTIPO = <<lxComprobanteVFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxComprobanteVFLETRA ) + "'">> and FPTOVEN = <<lxComprobanteVFPTOVEN>> and FNUMCOMP = <<lxComprobanteVFNUMCOMP>> and FACTSEC = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFACTSEC ) + "'">>
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )
			if reccount( 'c_NOTADEDEBITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
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
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP,FACTSEC
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( FACTSEC, 2, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP,FACTSEC
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( FACTSEC, 2, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc,FACTSEC desc
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
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
				lcOrden =  str( .TipoComprobante, 2, 0) + .Letra + str( .PuntoDeVenta, 4, 0) + str( .Numero, 8, 0) + .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc,FACTSEC desc
			endtext
			use in select('c_NOTADEDEBITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADEDEBITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.ComprobanteVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.ImpuestosV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADEDEBITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fd2,Fecexpo,Fectrans,Faltafw,Fmodifw,Idcaja,Mr,Recpor,Fpodes1,Fperson,Fturno,Mdcimpu" + ;
",Fajxre,Desmntosi3,Timestamp,Desmntosi2,Factsec,Totalcant,Mr2,Desmntosi1,Condivalp,Subtotsisi,Subtot" + ;
"cisi,Signomov,Fsubton,Facttipo,Fsubtot,Desmntosi,Recmnto2,Recmntosi,Recmntosi2,Recmntosi1,Recmnto1,F" + ;
"podes2,Recmnto,Desauto,Anulado,Noper,Fcompfis,Esttrans,Bdmodifw,Valtafw,Zadsfw,Opecomm,Umodifw,Ualta" + ;
"fw,Vmodifw,Hmodifw,Smodifw,Haltafw,Horaimpo,Horaexpo,Saltafw,Bdaltafw,Fhora,Simbmon,Descfw,Idajuste," + ;
"Monsis,Idvuelto,Motdescdev,Fobs,Fletra,Ffch,Md1,Fcliente,Md2,Fmtdes1,Fmtdes2,Codigo,Fven,Fptoven,Deu" + ;
"da,Fmtdes3,Moneda,Fnumcomp,Tdci,Totdescsi,Sitfisccli,Codlista,Fcuit,Cotiz,Email,Fvuelto,Ftotal,Fpode" + ;
"s,Fdescu,Md3,Percepcion,Mr1,Gravamen,Fimpuesto,Totrecar,Totrecarsi,Trci,Totdesc,Totimpue,Ivasis,Tipo" + ;
"crela,Letrarela,Puntorela,Numerorela,Feccrela" + ;
" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4 and " + lcFiltro )
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
			local  lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFectrans, lxComprobantevFaltafw, lxComprobantevFmodifw, lxComprobantevIdcaja, lxComprobantevMr, lxComprobantevRecpor, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevDesmntosi3, lxComprobantevTimestamp, lxComprobantevDesmntosi2, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMr2, lxComprobantevDesmntosi1, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevFsubtot, lxComprobantevDesmntosi, lxComprobantevRecmnto2, lxComprobantevRecmntosi, lxComprobantevRecmntosi2, lxComprobantevRecmntosi1, lxComprobantevRecmnto1, lxComprobantevFpodes2, lxComprobantevRecmnto, lxComprobantevDesauto, lxComprobantevAnulado, lxComprobantevNoper, lxComprobantevFcompfis, lxComprobantevEsttrans, lxComprobantevBdmodifw, lxComprobantevValtafw, lxComprobantevZadsfw, lxComprobantevOpecomm, lxComprobantevUmodifw, lxComprobantevUaltafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevSaltafw, lxComprobantevBdaltafw, lxComprobantevFhora, lxComprobantevSimbmon, lxComprobantevDescfw, lxComprobantevIdajuste, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFletra, lxComprobantevFfch, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevMd2, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFven, lxComprobantevFptoven, lxComprobantevDeuda, lxComprobantevFmtdes3, lxComprobantevMoneda, lxComprobantevFnumcomp, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevSitfisccli, lxComprobantevCodlista, lxComprobantevFcuit, lxComprobantevCotiz, lxComprobantevEmail, lxComprobantevFvuelto, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevMr1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFecimpo = ctod( '  /  /    ' )			lxComprobantevFd2 = ctod( '  /  /    ' )			lxComprobantevFecexpo = ctod( '  /  /    ' )			lxComprobantevFectrans = ctod( '  /  /    ' )			lxComprobantevFaltafw = ctod( '  /  /    ' )			lxComprobantevFmodifw = ctod( '  /  /    ' )			lxComprobantevIdcaja = 0			lxComprobantevMr = 0			lxComprobantevRecpor = 0			lxComprobantevFpodes1 = 0			lxComprobantevFperson = []			lxComprobantevFturno = 0			lxComprobantevMdcimpu = 0			lxComprobantevFajxre = 0			lxComprobantevDesmntosi3 = 0			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevDesmntosi2 = 0			lxComprobantevFactsec = []			lxComprobantevTotalcant = 0			lxComprobantevMr2 = 0			lxComprobantevDesmntosi1 = 0			lxComprobantevCondivalp = 0			lxComprobantevSubtotsisi = 0			lxComprobantevSubtotcisi = 0			lxComprobantevSignomov = 0			lxComprobantevFsubton = 0			lxComprobantevFacttipo = 0			lxComprobantevFsubtot = 0			lxComprobantevDesmntosi = 0			lxComprobantevRecmnto2 = 0			lxComprobantevRecmntosi = 0			lxComprobantevRecmntosi2 = 0			lxComprobantevRecmntosi1 = 0			lxComprobantevRecmnto1 = 0			lxComprobantevFpodes2 = 0			lxComprobantevRecmnto = 0			lxComprobantevDesauto = .F.			lxComprobantevAnulado = .F.			lxComprobantevNoper = .F.			lxComprobantevFcompfis = .F.			lxComprobantevEsttrans = []			lxComprobantevBdmodifw = []			lxComprobantevValtafw = []			lxComprobantevZadsfw = []			lxComprobantevOpecomm = []			lxComprobantevUmodifw = []			lxComprobantevUaltafw = []			lxComprobantevVmodifw = []			lxComprobantevHmodifw = []			lxComprobantevSmodifw = []			lxComprobantevHaltafw = []			lxComprobantevHoraimpo = []			lxComprobantevHoraexpo = []			lxComprobantevSaltafw = []			lxComprobantevBdaltafw = []			lxComprobantevFhora = []			lxComprobantevSimbmon = []			lxComprobantevDescfw = []			lxComprobantevIdajuste = []			lxComprobantevMonsis = []			lxComprobantevIdvuelto = []			lxComprobantevMotdescdev = []			lxComprobantevFobs = []			lxComprobantevFletra = []			lxComprobantevFfch = ctod( '  /  /    ' )			lxComprobantevMd1 = 0			lxComprobantevFcliente = []			lxComprobantevMd2 = 0			lxComprobantevFmtdes1 = 0			lxComprobantevFmtdes2 = 0			lxComprobantevCodigo = []			lxComprobantevFven = []			lxComprobantevFptoven = 0			lxComprobantevDeuda = 0			lxComprobantevFmtdes3 = 0			lxComprobantevMoneda = []			lxComprobantevFnumcomp = 0			lxComprobantevTdci = 0			lxComprobantevTotdescsi = 0			lxComprobantevSitfisccli = 0			lxComprobantevCodlista = []			lxComprobantevFcuit = []			lxComprobantevCotiz = 0			lxComprobantevEmail = []			lxComprobantevFvuelto = 0			lxComprobantevFtotal = 0			lxComprobantevFpodes = 0			lxComprobantevFdescu = 0			lxComprobantevMd3 = 0			lxComprobantevPercepcion = 0			lxComprobantevMr1 = 0			lxComprobantevGravamen = 0			lxComprobantevFimpuesto = 0			lxComprobantevTotrecar = 0			lxComprobantevTotrecarsi = 0			lxComprobantevTrci = 0			lxComprobantevTotdesc = 0			lxComprobantevTotimpue = 0			lxComprobantevIvasis = 0			lxComprobantevTipocrela = 0			lxComprobantevLetrarela = []			lxComprobantevPuntorela = 0			lxComprobantevNumerorela = 0			lxComprobantevFeccrela = ctod( '  /  /    ' )
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ComprobanteVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ImpuestosV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KITDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
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
		lcWhere = " Where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado"
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
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleFacturaDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ComprobanteVDet', 'FacturaDetalle', tnTope )
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
					"Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio"
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
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ImpuestosV', 'ImpuestosDetalle', tnTope )
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
					"Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen"
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
					"Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo"
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
	Function ObtenerDatosDetalleKitsDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  KITDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleKitsDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'KITDET', 'KitsDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleKitsDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleKitsDetalle( lcAtributo )
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
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR AS RECARGOMONTO'
				Case lcAtributo == 'RECARGOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPOR AS RECARGOPORCENTAJE'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDCIMPU AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTESPORREDONDEOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAJXRE AS AJUSTESPORREDONDEOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'RECARGOMONTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR2 AS RECARGOMONTO2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO1 AS RECARGOMONTOCONIMPUESTOS1'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO AS RECARGOMONTOCONIMPUESTOS'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUTO AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'NOCALCULAPERCEPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NOPER AS NOCALCULAPERCEPCION'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'NROOPECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPECOMM AS NROOPECOMMERCE'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'CODIGOAJUSTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDAJUSTE AS CODIGOAJUSTE'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCDEV AS CODIGOMOTIVODESCUENTOENSUBTOTAL'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'MONTODESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD1 AS MONTODESCUENTO1'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'MONTODESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD2 AS MONTODESCUENTO2'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS VENDEDOR'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'DEUDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEUDA AS DEUDA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'TOTALDESCUENTOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCI AS TOTALDESCUENTOSCONIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCCLI AS SITUACIONFISCAL'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS EMAIL'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD3 AS MONTODESCUENTO3'
				Case lcAtributo == 'PERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERCEPCION AS PERCEPCIONES'
				Case lcAtributo == 'RECARGOMONTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MR1 AS RECARGOMONTO1'
				Case lcAtributo == 'GRAVAMENES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRAVAMEN AS GRAVAMENES'
				Case lcAtributo == 'IMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FIMPUESTO AS IMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECAR AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCI AS TOTALRECARGOSCONIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
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
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'TIENERESTRICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRESTR AS TIENERESTRICCION'
				Case lcAtributo == 'AFE_SALDOLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_SLIQ AS AFE_SALDOLIQUIDACION'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'CODIGOAUTORIZACIONDJCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODAUTDJCP AS CODIGOAUTORIZACIONDJCP'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROGIFTCARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GIFTCARD AS NUMEROGIFTCARD'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCU AS CODIGOMOTIVODESCUENTO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'CODIGOMOTIVODEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDEVOL AS CODIGOMOTIVODEVOLUCION'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLO AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
				Case lcAtributo == 'MONTOPRORRATEOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPINT AS MONTOPRORRATEOIMPUESTOINTERNO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCANT AS CANTIDAD'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
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
				Case lcAtributo == 'DESCUENTOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCMONTO AS DESCUENTOMONTO'
				Case lcAtributo == 'DESCUENTOPORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCPORC AS DESCUENTOPORCENTAJE'
				Case lcAtributo == 'ULTIMACOTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZA AS ULTIMACOTIZACION'
				Case lcAtributo == 'RECARGOMONTOENPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONRECPES AS RECARGOMONTOENPESOS'
				Case lcAtributo == 'MONTODESRECPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDEREPES AS MONTODESRECPESOS'
				Case lcAtributo == 'DESCUENTOMONTOENPESOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESPES AS DESCUENTOMONTOENPESOS'
				Case lcAtributo == 'DESCUENTOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCSINIMP AS DESCUENTOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SIGNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNO AS SIGNO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'NUMERODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMCOMPR AS NUMERODECOMPROBANTE'
				Case lcAtributo == 'NUMEROCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCUPON AS NUMEROCUPON'
				Case lcAtributo == 'PESOSALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PESOS AS PESOSALCAMBIO'
				Case lcAtributo == 'TIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJT AS TIPO'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PTOVENTA AS PUNTODEVENTA'
				Case lcAtributo == 'COTIZA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJCOTIZ AS COTIZA'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTURNO AS TURNO'
				Case lcAtributo == 'ESRETIROEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESRETIROEF AS ESRETIROEFECTIVO'
				Case lcAtributo == 'ESVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESVUELTO AS ESVUELTO'
				Case lcAtributo == 'CHEQUEELECTRONICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CELECTRO AS CHEQUEELECTRONICO'
				Case lcAtributo == 'VISUALIZARENESTADODECAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VISUALCAJA AS VISUALIZARENESTADODECAJA'
				Case lcAtributo == 'AUTORIZACIONPOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AUTORIZADO AS AUTORIZACIONPOS'
				Case lcAtributo == 'PERSONALIZARCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERSCOMP AS PERSONALIZARCOMPROBANTE'
				Case lcAtributo == 'TIPODECOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPCOMP AS TIPODECOMPROBANTE'
				Case lcAtributo == 'REDONDEO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REDONDEO AS REDONDEO'
				Case lcAtributo == 'NRODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NRODOC AS NRODOCUMENTO'
				Case lcAtributo == 'TIPODOCUMENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODOC AS TIPODOCUMENTO'
				Case lcAtributo == 'IDITEMVALORES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMVALORES'
				Case lcAtributo == 'IDITEMRETIROENEFECTIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDRETIROEF AS IDITEMRETIROENEFECTIVO'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJVEN AS VENDEDOR'
				Case lcAtributo == 'NUMEROTARJETA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROTARJETA AS NUMEROTARJETA'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LETRA AS LETRA'
				Case lcAtributo == 'CONDICIONDEPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDPAGO AS CONDICIONDEPAGO'
				Case lcAtributo == 'NUMEROCHEQUEPROPIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHPROP AS NUMEROCHEQUEPROPIO'
				Case lcAtributo == 'NUMEROCHEQUE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROCHEQUE AS NUMEROCHEQUE'
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
				Case lcAtributo == 'PORCENTAJEDESREC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCDESREC AS PORCENTAJEDESREC'
				Case lcAtributo == 'RECARGOMONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNT AS RECARGOMONTO'
				Case lcAtributo == 'MONTODESREC'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONDESREC AS MONTODESREC'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJTOTFAC AS TOTAL'
				Case lcAtributo == 'RECIBIDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JJRECIB AS RECIBIDO'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRECMNTSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOAMONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOSISTE AS MONTOAMONEDASISTEMA'
				Case lcAtributo == 'RECIBIDOALCAMBIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECPESOS AS RECIBIDOALCAMBIO'
				Case lcAtributo == 'MONTOCUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONCUPON AS MONTOCUPON'
				Case lcAtributo == 'RECARGOSINPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'JRRECSPERC AS RECARGOSINPERCEPCIONES'
				Case lcAtributo == 'PERMITEVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PERMVUELTO AS PERMITEVUELTO'
				Case lcAtributo == 'IDITEMCOMPONENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCOMP AS IDITEMCOMPONENTE'
				Case lcAtributo == 'CODIGODECUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GUIDCUPON AS CODIGODECUPON'
				Case lcAtributo == 'CUPON'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CUPON AS CUPON'
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
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS TIPOCOMPROBANTE'
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
				Case lcAtributo == 'MONTOBASE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTOBASE AS MONTOBASE'
				Case lcAtributo == 'MINIMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINIMOPER AS MINIMO'
				Case lcAtributo == 'PORCENTAJE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PORCEN AS PORCENTAJE'
				Case lcAtributo == 'CERTIFICADOSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECERT AS CERTIFICADOSIRE'
				Case lcAtributo == 'MINIMONOIMPONIBLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MINOIMP AS MINIMONOIMPONIBLE'
				Case lcAtributo == 'MONTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODSEGURIDADSIRE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIRECS AS CODSEGURIDADSIRE'
				Case lcAtributo == 'BASEDECALCULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BASE AS BASEDECALCULO'
				Case lcAtributo == 'REGIMENIMPOSITIVO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'REGIMENIMP AS REGIMENIMPOSITIVO'
				Case lcAtributo == 'TIPOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOI AS TIPOIMPUESTO'
				Case lcAtributo == 'CODIGOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODINT AS CODIGOINTERNO'
				Case lcAtributo == 'CODIGOIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIMP AS CODIGOIMPUESTO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRI AS DESCRIPCION'
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
	Function ObtenerCamposSelectDetalleKitsDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'TIENERESTRICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRESTR AS TIENERESTRICCION'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'PERCEPCIONIVARG5329'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTPERCEP AS PERCEPCIONIVARG5329'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFITOT AS MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'AFE_SALDOLIQUIDACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_SLIQ AS AFE_SALDOLIQUIDACION'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'CODIGOAUTORIZACIONDJCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODAUTDJCP AS CODIGOAUTORIZACIONDJCP'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROGIFTCARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GIFTCARD AS NUMEROGIFTCARD'
				Case lcAtributo == 'EQUIVALENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EQUIV AS EQUIVALENCIA'
				Case lcAtributo == 'CODIGOMOTIVODEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDEVOL AS CODIGOMOTIVODEVOLUCION'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCU AS CODIGOMOTIVODESCUENTO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTXT AS ARTICULODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLO AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLDET AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTALL AS TALLE'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCFI AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTDES AS MONTODESCUENTO'
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'MONTOPRORRATEOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPINT AS MONTOPRORRATEOIMPUESTOINTERNO'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCANT AS CANTIDAD'
				Case lcAtributo == 'IDSENIACANCELADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIACANCE AS IDSENIACANCELADA'
				Case lcAtributo == 'PRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRECIO AS PRECIO'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'MR'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOPORCENTAJE'
				lcCampo = 'RECPOR'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MDCIMPU'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTESPORREDONDEOS'
				lcCampo = 'FAJXRE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO2'
				lcCampo = 'MR2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS1'
				lcCampo = 'RECMNTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS'
				lcCampo = 'RECMNTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUTO'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'NOCALCULAPERCEPCION'
				lcCampo = 'NOPER'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'NROOPECOMMERCE'
				lcCampo = 'OPECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAJUSTE'
				lcCampo = 'IDAJUSTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
				lcCampo = 'MOTDESCDEV'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO1'
				lcCampo = 'MD1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO2'
				lcCampo = 'MD2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'DEUDA'
				lcCampo = 'DEUDA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSCONIMPUESTOS'
				lcCampo = 'TDCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCCLI'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO3'
				lcCampo = 'MD3'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONES'
				lcCampo = 'PERCEPCION'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO1'
				lcCampo = 'MR1'
			Case upper( alltrim( tcAtributo ) ) == 'GRAVAMENES'
				lcCampo = 'GRAVAMEN'
			Case upper( alltrim( tcAtributo ) ) == 'IMPUESTOS'
				lcCampo = 'FIMPUESTO'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOS'
				lcCampo = 'TOTRECAR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSCONIMPUESTOS'
				lcCampo = 'TRCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
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
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'TIENERESTRICCION'
				lcCampo = 'CONRESTR'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDOLIQUIDACION'
				lcCampo = 'AFE_SLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAUTORIZACIONDJCP'
				lcCampo = 'CODAUTDJCP'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROGIFTCARD'
				lcCampo = 'GIFTCARD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTO'
				lcCampo = 'MOTDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODEVOLUCION'
				lcCampo = 'MOTDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'FCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIMPUESTOINTERNO'
				lcCampo = 'MNTPINT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'FCANT'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
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
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTO'
				lcCampo = 'DESCMONTO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOPORCENTAJE'
				lcCampo = 'DESCPORC'
			Case upper( alltrim( tcAtributo ) ) == 'ULTIMACOTIZACION'
				lcCampo = 'COTIZA'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOENPESOS'
				lcCampo = 'MONRECPES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESRECPESOS'
				lcCampo = 'MONDEREPES'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTOENPESOS'
				lcCampo = 'MONDESPES'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOMONTOSINIMPUESTOS'
				lcCampo = 'DESCSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNO'
				lcCampo = 'SIGNO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERODECOMPROBANTE'
				lcCampo = 'NUMCOMPR'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCUPON'
				lcCampo = 'NROCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'PESOSALCAMBIO'
				lcCampo = 'PESOS'
			Case upper( alltrim( tcAtributo ) ) == 'TIPO'
				lcCampo = 'JJT'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'PTOVENTA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZA'
				lcCampo = 'JJCOTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'JJTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'ESRETIROEFECTIVO'
				lcCampo = 'ESRETIROEF'
			Case upper( alltrim( tcAtributo ) ) == 'ESVUELTO'
				lcCampo = 'ESVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEELECTRONICO'
				lcCampo = 'CELECTRO'
			Case upper( alltrim( tcAtributo ) ) == 'VISUALIZARENESTADODECAJA'
				lcCampo = 'VISUALCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'AUTORIZACIONPOS'
				lcCampo = 'AUTORIZADO'
			Case upper( alltrim( tcAtributo ) ) == 'PERSONALIZARCOMPROBANTE'
				lcCampo = 'PERSCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODECOMPROBANTE'
				lcCampo = 'TIPCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'REDONDEO'
				lcCampo = 'REDONDEO'
			Case upper( alltrim( tcAtributo ) ) == 'NRODOCUMENTO'
				lcCampo = 'NRODOC'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODOCUMENTO'
				lcCampo = 'TIPODOC'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMVALORES'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMRETIROENEFECTIVO'
				lcCampo = 'IDRETIROEF'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'JJVEN'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROTARJETA'
				lcCampo = 'NROTARJETA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'LETRA'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONDEPAGO'
				lcCampo = 'CONDPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUEPROPIO'
				lcCampo = 'NROCHPROP'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROCHEQUE'
				lcCampo = 'NROCHEQUE'
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
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESREC'
				lcCampo = 'PORCDESREC'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTO'
				lcCampo = 'JRECMNT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESREC'
				lcCampo = 'MONDESREC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'JJTOTFAC'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBIDO'
				lcCampo = 'JJRECIB'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'JRECMNTSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOAMONEDASISTEMA'
				lcCampo = 'MONTOSISTE'
			Case upper( alltrim( tcAtributo ) ) == 'RECIBIDOALCAMBIO'
				lcCampo = 'RECPESOS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCUPON'
				lcCampo = 'MONCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOSINPERCEPCIONES'
				lcCampo = 'JRRECSPERC'
			Case upper( alltrim( tcAtributo ) ) == 'PERMITEVUELTO'
				lcCampo = 'PERMVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMCOMPONENTE'
				lcCampo = 'GUIDCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGODECUPON'
				lcCampo = 'GUIDCUPON'
			Case upper( alltrim( tcAtributo ) ) == 'CUPON'
				lcCampo = 'CUPON'
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
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTOBASE'
				lcCampo = 'MONTOBASE'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMO'
				lcCampo = 'MINIMOPER'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJE'
				lcCampo = 'PORCEN'
			Case upper( alltrim( tcAtributo ) ) == 'CERTIFICADOSIRE'
				lcCampo = 'SIRECERT'
			Case upper( alltrim( tcAtributo ) ) == 'MINIMONOIMPONIBLE'
				lcCampo = 'MINOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODSEGURIDADSIRE'
				lcCampo = 'SIRECS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDECALCULO'
				lcCampo = 'BASE'
			Case upper( alltrim( tcAtributo ) ) == 'REGIMENIMPOSITIVO'
				lcCampo = 'REGIMENIMP'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOIMPUESTO'
				lcCampo = 'TIPOI'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOINTERNO'
				lcCampo = 'CODINT'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOIMPUESTO'
				lcCampo = 'CODIMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRI'
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
	Function ObtenerCampoDetalleKitsDetalle( tcAtributo As String ) As String
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'TIENERESTRICCION'
				lcCampo = 'CONRESTR'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'PERCEPCIONIVARG5329'
				lcCampo = 'ARTPERCEP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOCONIMPUESTO'
				lcCampo = 'FCFITOT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDOLIQUIDACION'
				lcCampo = 'AFE_SLIQ'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAUTORIZACIONDJCP'
				lcCampo = 'CODAUTDJCP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROGIFTCARD'
				lcCampo = 'GIFTCARD'
			Case upper( alltrim( tcAtributo ) ) == 'EQUIVALENCIA'
				lcCampo = 'EQUIV'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODEVOLUCION'
				lcCampo = 'MOTDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTO'
				lcCampo = 'MOTDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'FTXT'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'FCOLO'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLDET'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'FTALL'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO'
				lcCampo = 'MNTDES'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIMPUESTOINTERNO'
				lcCampo = 'MNTPINT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'FCANT'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIACANCELADA'
				lcCampo = 'SENIACANCE'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIO'
				lcCampo = 'FPRECIO'
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
		if upper( alltrim( tcDetalle ) ) == 'KITSDETALLE'
			lcRetorno = 'KITDET'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFectrans, lxComprobantevFaltafw, lxComprobantevFmodifw, lxComprobantevIdcaja, lxComprobantevMr, lxComprobantevRecpor, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevDesmntosi3, lxComprobantevTimestamp, lxComprobantevDesmntosi2, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMr2, lxComprobantevDesmntosi1, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevFsubtot, lxComprobantevDesmntosi, lxComprobantevRecmnto2, lxComprobantevRecmntosi, lxComprobantevRecmntosi2, lxComprobantevRecmntosi1, lxComprobantevRecmnto1, lxComprobantevFpodes2, lxComprobantevRecmnto, lxComprobantevDesauto, lxComprobantevAnulado, lxComprobantevNoper, lxComprobantevFcompfis, lxComprobantevEsttrans, lxComprobantevBdmodifw, lxComprobantevValtafw, lxComprobantevZadsfw, lxComprobantevOpecomm, lxComprobantevUmodifw, lxComprobantevUaltafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevSaltafw, lxComprobantevBdaltafw, lxComprobantevFhora, lxComprobantevSimbmon, lxComprobantevDescfw, lxComprobantevIdajuste, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFletra, lxComprobantevFfch, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevMd2, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFven, lxComprobantevFptoven, lxComprobantevDeuda, lxComprobantevFmtdes3, lxComprobantevMoneda, lxComprobantevFnumcomp, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevSitfisccli, lxComprobantevCodlista, lxComprobantevFcuit, lxComprobantevCotiz, lxComprobantevEmail, lxComprobantevFvuelto, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevMr1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevMr =  .Recargomonto			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevDesauto =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevNoper =  .Nocalculapercepcion			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevFhora =  .Hora			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFletra =  .Letra			lxComprobantevFfch =  .Fecha			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevDeuda =  .Deuda			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFnumcomp =  .Numero			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevCotiz =  .Cotizacion			lxComprobantevEmail =  .Email			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPROBANTEV ( "Fecimpo","Fd2","Fecexpo","Fectrans","Faltafw","Fmodifw","Idcaja","Mr","Recpor","Fpodes1","Fperson","Fturno","Mdcimpu","Fajxre","Desmntosi3","Timestamp","Desmntosi2","Factsec","Totalcant","Mr2","Desmntosi1","Condivalp","Subtotsisi","Subtotcisi","Signomov","Fsubton","Facttipo","Fsubtot","Desmntosi","Recmnto2","Recmntosi","Recmntosi2","Recmntosi1","Recmnto1","Fpodes2","Recmnto","Desauto","Anulado","Noper","Fcompfis","Esttrans","Bdmodifw","Valtafw","Zadsfw","Opecomm","Umodifw","Ualtafw","Vmodifw","Hmodifw","Smodifw","Haltafw","Horaimpo","Horaexpo","Saltafw","Bdaltafw","Fhora","Simbmon","Descfw","Idajuste","Monsis","Idvuelto","Motdescdev","Fobs","Fletra","Ffch","Md1","Fcliente","Md2","Fmtdes1","Fmtdes2","Codigo","Fven","Fptoven","Deuda","Fmtdes3","Moneda","Fnumcomp","Tdci","Totdescsi","Sitfisccli","Codlista","Fcuit","Cotiz","Email","Fvuelto","Ftotal","Fpodes","Fdescu","Md3","Percepcion","Mr1","Gravamen","Fimpuesto","Totrecar","Totrecarsi","Trci","Totdesc","Totimpue","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevMr >>, <<lxComprobantevRecpor >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevFajxre >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevTimestamp >>, <<lxComprobantevDesmntosi2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevMr2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevSignomov >>, <<lxComprobantevFsubton >>, <<lxComprobantevFacttipo >>, <<lxComprobantevFsubtot >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevRecmnto >>, <<iif( lxComprobantevDesauto, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevNoper, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevMd2 >>, <<lxComprobantevFmtdes1 >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevFptoven >>, <<lxComprobantevDeuda >>, <<lxComprobantevFmtdes3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevTdci >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevSitfisccli >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFtotal >>, <<lxComprobantevFpodes >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevMr1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >> )
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
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxComportamiento = loItem.Comportamiento
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_saldo = loItem.Afe_saldo
					lxMontodto1 = loItem.Montodto1
					lxMontoiva = loItem.Montoiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNeto = loItem.Neto
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxMontocfi = loItem.Montocfi
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ComprobanteVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.ComprobanteVDet" )
this.xmlacursor( lcXml, 'c_ComprobanteVDetciditem' )
loItem.idItem = c_ComprobanteVDetciditem.ciditem
use in select( 'c_ComprobanteVDetciditem' )
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
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxSigno = loItem.Signo
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNumerocupon = loItem.Numerocupon
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxTurno = loItem.Turno
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxRedondeo = loItem.Redondeo
					lxNrodocumento = loItem.Nrodocumento
					lxTipodocumento = loItem.Tipodocumento
					lxIditemvalores = loItem.Iditemvalores
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxLetra = loItem.Letra
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargomonto = loItem.Recargomonto
					lxMontodesrec = loItem.Montodesrec
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","descmonto","descporc","Cotiza","MonRecPes","monderepes","MonDesPes","descsinimp","Signo","NroItem","NumCompr","NroCupon","Pesos","JJT","PtoVenta","JJCotiz","JJTurno","EsRetiroEf","esvuelto","CElectro","VisualCaja","Autorizado","PersComp","TIPCOMP","Redondeo","NroDoc","TipoDoc","IdItem","IdretiroEf","JJVen","NroTarjeta","Letra","condpago","NroChProp","NroCheque","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","porcdesrec","jrecmnt","mondesrec","JJTotFac","JJRecib","jrecmntsi","Montosiste","RecPesos","MonCupon","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxUltimacotizacion>>, <<lxRecargomontoenpesos>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxDescuentomontosinimpuestos>>, <<lxSigno>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<lxNumerocupon>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxTurno>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxPorcentajedesrec>>, <<lxRecargomonto>>, <<lxMontodesrec>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
						Insert into ZooLogic.ImpuestosV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobase = loItem.Montobase
					lxMinimo = loItem.Minimo
					lxPorcentaje = loItem.Porcentaje
					lxCertificadosire = loItem.Certificadosire
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMonto = loItem.Monto
					lxNroitem = lnContadorNroItem
					lxCodseguridadsire = loItem.Codseguridadsire
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxDescripcion = loItem.Descripcion
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("MontoBase","MinimoPer","porcen","SIRECERT","minoimp","Monto","NroItem","SIRECS","Base","RegimenImp","TipoI","codint","CodImp","Descri","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<lxMontobase>>, <<lxMinimo>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimonoimponible>>, <<lxMonto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxComportamiento = loItem.Comportamiento
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxOferta = loItem.Oferta
					lxMontocfi = loItem.Montocfi
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxAfe_saldo = loItem.Afe_saldo
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxAfe_codigo = loItem.Afe_codigo
					lxUnidad_PK = loItem.Unidad_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KITDET("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","MNTPPER","MNTPDESCI","MNTPTOT","ConRestr","AfeTS","MNTPRECCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","tasaimpint","PRECIOSISR","PRECIOCISR","COMP","MNTPDESSI","MNDESCI","MNPDSI","MNTPRECSI","MNDESSI","AfeCANT","APorcIvaV","FNETO","FmtoIVA","NroItem","FmtoDTO1","FX2","FmtoCFI","ArtPercep","FCFITot","FporCFI","FKIT","FporDTO1","ACondIvaV","AfeNroItem","iditemOrig","AfeTipoCom","impinterno","Afe_SLiq","fporIva","Prunsinimp","prunconimp","FPRUN","AfeSaldo","FN11","ArtSinDes","ProcStock","UsarPLista","IDKIT","FAMate","IdItem","CodAutDJCP","afe_cod","FUnid","CODIGO","GiftCard","Equiv","MotDevol","MotDescu","FTXT","FCOLO","FCOLDET","FTALL","FCFI","MNTDES","MNTPIVA","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxTienerestriccion>>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxTasaimpuestointerno>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxComportamiento>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxOferta>>, <<lxMontocfi>>, <<lxPercepcionivarg5329>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajecfi>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxAfe_tipocomprobante>>, <<lxMontoimpuestointerno>>, <<lxAfe_saldoliquidacion>>, <<lxPorcentajeiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxPreciounitario>>, <<lxAfe_saldo>>, <<lxTipolistadeprecio>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.KITDET" )
this.xmlacursor( lcXml, 'c_KITDETciditem' )
loItem.idItem = c_KITDETciditem.ciditem
use in select( 'c_KITDETciditem' )
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
			local  lxComprobantevFecimpo, lxComprobantevFd2, lxComprobantevFecexpo, lxComprobantevFectrans, lxComprobantevFaltafw, lxComprobantevFmodifw, lxComprobantevIdcaja, lxComprobantevMr, lxComprobantevRecpor, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevMdcimpu, lxComprobantevFajxre, lxComprobantevDesmntosi3, lxComprobantevTimestamp, lxComprobantevDesmntosi2, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMr2, lxComprobantevDesmntosi1, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevSignomov, lxComprobantevFsubton, lxComprobantevFacttipo, lxComprobantevFsubtot, lxComprobantevDesmntosi, lxComprobantevRecmnto2, lxComprobantevRecmntosi, lxComprobantevRecmntosi2, lxComprobantevRecmntosi1, lxComprobantevRecmnto1, lxComprobantevFpodes2, lxComprobantevRecmnto, lxComprobantevDesauto, lxComprobantevAnulado, lxComprobantevNoper, lxComprobantevFcompfis, lxComprobantevEsttrans, lxComprobantevBdmodifw, lxComprobantevValtafw, lxComprobantevZadsfw, lxComprobantevOpecomm, lxComprobantevUmodifw, lxComprobantevUaltafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevSaltafw, lxComprobantevBdaltafw, lxComprobantevFhora, lxComprobantevSimbmon, lxComprobantevDescfw, lxComprobantevIdajuste, lxComprobantevMonsis, lxComprobantevIdvuelto, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFletra, lxComprobantevFfch, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevMd2, lxComprobantevFmtdes1, lxComprobantevFmtdes2, lxComprobantevCodigo, lxComprobantevFven, lxComprobantevFptoven, lxComprobantevDeuda, lxComprobantevFmtdes3, lxComprobantevMoneda, lxComprobantevFnumcomp, lxComprobantevTdci, lxComprobantevTotdescsi, lxComprobantevSitfisccli, lxComprobantevCodlista, lxComprobantevFcuit, lxComprobantevCotiz, lxComprobantevEmail, lxComprobantevFvuelto, lxComprobantevFtotal, lxComprobantevFpodes, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevMr1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevMr =  .Recargomonto			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevDesauto =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevNoper =  .Nocalculapercepcion			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevFhora =  .Hora			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFletra =  .Letra			lxComprobantevFfch =  .Fecha			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevCodigo =  .Codigo			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevDeuda =  .Deuda			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFnumcomp =  .Numero			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFcuit =  .Cuit			lxComprobantevCotiz =  .Cotizacion			lxComprobantevEmail =  .Email			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFtotal =  .Total			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPROBANTEV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>, "Idcaja" = <<lxComprobantevIdcaja>>, "Mr" = <<lxComprobantevMr>>, "Recpor" = <<lxComprobantevRecpor>>, "Fpodes1" = <<lxComprobantevFpodes1>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>, "Fturno" = <<lxComprobantevFturno>>, "Mdcimpu" = <<lxComprobantevMdcimpu>>, "Fajxre" = <<lxComprobantevFajxre>>, "Desmntosi3" = <<lxComprobantevDesmntosi3>>, "Timestamp" = <<lxComprobantevTimestamp>>, "Desmntosi2" = <<lxComprobantevDesmntosi2>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>, "Totalcant" = <<lxComprobantevTotalcant>>, "Mr2" = <<lxComprobantevMr2>>, "Desmntosi1" = <<lxComprobantevDesmntosi1>>, "Condivalp" = <<lxComprobantevCondivalp>>, "Subtotsisi" = <<lxComprobantevSubtotsisi>>, "Subtotcisi" = <<lxComprobantevSubtotcisi>>, "Signomov" = <<lxComprobantevSignomov>>, "Fsubton" = <<lxComprobantevFsubton>>, "Facttipo" = <<lxComprobantevFacttipo>>, "Fsubtot" = <<lxComprobantevFsubtot>>, "Desmntosi" = <<lxComprobantevDesmntosi>>, "Recmnto2" = <<lxComprobantevRecmnto2>>, "Recmntosi" = <<lxComprobantevRecmntosi>>, "Recmntosi2" = <<lxComprobantevRecmntosi2>>, "Recmntosi1" = <<lxComprobantevRecmntosi1>>, "Recmnto1" = <<lxComprobantevRecmnto1>>, "Fpodes2" = <<lxComprobantevFpodes2>>, "Recmnto" = <<lxComprobantevRecmnto>>, "Desauto" = <<iif( lxComprobantevDesauto, 1, 0 )>>, "Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>, "Noper" = <<iif( lxComprobantevNoper, 1, 0 )>>, "Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>, "Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>, "Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>, "Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>, "Md1" = <<lxComprobantevMd1>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>, "Md2" = <<lxComprobantevMd2>>, "Fmtdes1" = <<lxComprobantevFmtdes1>>, "Fmtdes2" = <<lxComprobantevFmtdes2>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>, "Fptoven" = <<lxComprobantevFptoven>>, "Deuda" = <<lxComprobantevDeuda>>, "Fmtdes3" = <<lxComprobantevFmtdes3>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>, "Fnumcomp" = <<lxComprobantevFnumcomp>>, "Tdci" = <<lxComprobantevTdci>>, "Totdescsi" = <<lxComprobantevTotdescsi>>, "Sitfisccli" = <<lxComprobantevSitfisccli>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>, "Cotiz" = <<lxComprobantevCotiz>>, "Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>, "Fvuelto" = <<lxComprobantevFvuelto>>, "Ftotal" = <<lxComprobantevFtotal>>, "Fpodes" = <<lxComprobantevFpodes>>, "Fdescu" = <<lxComprobantevFdescu>>, "Md3" = <<lxComprobantevMd3>>, "Percepcion" = <<lxComprobantevPercepcion>>, "Mr1" = <<lxComprobantevMr1>>, "Gravamen" = <<lxComprobantevGravamen>>, "Fimpuesto" = <<lxComprobantevFimpuesto>>, "Totrecar" = <<lxComprobantevTotrecar>>, "Totrecarsi" = <<lxComprobantevTotrecarsi>>, "Trci" = <<lxComprobantevTrci>>, "Totdesc" = <<lxComprobantevTotdesc>>, "Totimpue" = <<lxComprobantevTotimpue>>, "Ivasis" = <<lxComprobantevIvasis>>, "Tipocrela" = <<lxComprobantevTipocrela>>, "Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>, "Puntorela" = <<lxComprobantevPuntorela>>, "Numerorela" = <<lxComprobantevNumerorela>>, "Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ComprobanteVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpuestosV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KITDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.FacturaDetalle
				if this.oEntidad.FacturaDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxComportamiento = loItem.Comportamiento
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxPorcentajecfi = loItem.Porcentajecfi
					lxOferta = loItem.Oferta
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNroitem = lnContadorNroItem
					lxPorcentajeiva = loItem.Porcentajeiva
					lxAfe_saldo = loItem.Afe_saldo
					lxMontodto1 = loItem.Montodto1
					lxMontoiva = loItem.Montoiva
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxNeto = loItem.Neto
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxKit = loItem.Kit
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxMontocfi = loItem.Montocfi
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ComprobanteVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.ComprobanteVDet" )
this.xmlacursor( lcXml, 'c_ComprobanteVDetciditem' )
loItem.idItem = c_ComprobanteVDetciditem.ciditem
use in select( 'c_ComprobanteVDetciditem' )
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
					lxDescuentomonto = loItem.Descuentomonto
					lxDescuentoporcentaje = loItem.Descuentoporcentaje
					lxUltimacotizacion = loItem.Ultimacotizacion
					lxRecargomontoenpesos = loItem.Recargomontoenpesos
					lxMontodesrecpesos = loItem.Montodesrecpesos
					lxDescuentomontoenpesos = loItem.Descuentomontoenpesos
					lxDescuentomontosinimpuestos = loItem.Descuentomontosinimpuestos
					lxSigno = loItem.Signo
					lxNroitem = lnContadorNroItem
					lxNumerodecomprobante = loItem.Numerodecomprobante
					lxNumerocupon = loItem.Numerocupon
					lxPesosalcambio = loItem.Pesosalcambio
					lxTipo = loItem.Tipo
					lxPuntodeventa = loItem.Puntodeventa
					lxCotiza = loItem.Cotiza
					lxTurno = loItem.Turno
					lxEsretiroefectivo = loItem.Esretiroefectivo
					lxEsvuelto = loItem.Esvuelto
					lxChequeelectronico = loItem.Chequeelectronico
					lxVisualizarenestadodecaja = loItem.Visualizarenestadodecaja
					lxAutorizacionpos = loItem.Autorizacionpos
					lxPersonalizarcomprobante = loItem.Personalizarcomprobante
					lxTipodecomprobante = loItem.Tipodecomprobante
					lxRedondeo = loItem.Redondeo
					lxNrodocumento = loItem.Nrodocumento
					lxTipodocumento = loItem.Tipodocumento
					lxIditemvalores = loItem.Iditemvalores
					lxIditemretiroenefectivo = loItem.Iditemretiroenefectivo
					lxVendedor = loItem.Vendedor
					lxNumerotarjeta = loItem.Numerotarjeta
					lxLetra = loItem.Letra
					lxCondiciondepago_PK = loItem.Condiciondepago_PK
					lxNumerochequepropio_PK = loItem.Numerochequepropio_PK
					lxNumerocheque_PK = loItem.Numerocheque_PK
					lxValor_PK = loItem.Valor_PK
					lxValordetalle = loItem.Valordetalle
					lxFecha = loItem.Fecha
					lxNumerointerno = loItem.Numerointerno
					lxMonto = loItem.Monto
					lxRecargoporcentaje = loItem.Recargoporcentaje
					lxPorcentajedesrec = loItem.Porcentajedesrec
					lxRecargomonto = loItem.Recargomonto
					lxMontodesrec = loItem.Montodesrec
					lxTotal = loItem.Total
					lxRecibido = loItem.Recibido
					lxRecargomontosinimpuestos = loItem.Recargomontosinimpuestos
					lxMontoamonedasistema = loItem.Montoamonedasistema
					lxRecibidoalcambio = loItem.Recibidoalcambio
					lxMontocupon = loItem.Montocupon
					lxRecargosinpercepciones = loItem.Recargosinpercepciones
					lxPermitevuelto = loItem.Permitevuelto
					lxIditemcomponente = loItem.Iditemcomponente
					lxCodigodecupon = loItem.Codigodecupon
					lxCupon_PK = loItem.Cupon_PK
					lxNumerovaledecambio_PK = loItem.Numerovaledecambio_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.VAL("JJfecha","FechCoti","IdCaja","descmonto","descporc","Cotiza","MonRecPes","monderepes","MonDesPes","descsinimp","Signo","NroItem","NumCompr","NroCupon","Pesos","JJT","PtoVenta","JJCotiz","JJTurno","EsRetiroEf","esvuelto","CElectro","VisualCaja","Autorizado","PersComp","TIPCOMP","Redondeo","NroDoc","TipoDoc","IdItem","IdretiroEf","JJVen","NroTarjeta","Letra","condpago","NroChProp","NroCheque","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","porcdesrec","jrecmnt","mondesrec","JJTotFac","JJRecib","jrecmntsi","Montosiste","RecPesos","MonCupon","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio" ) values ( <<"'" + this.ConvertirDateSql( lxFechacomp ) + "'">>, <<"'" + this.ConvertirDateSql( lxFechaultcotizacion ) + "'">>, <<lxCaja_PK>>, <<lxDescuentomonto>>, <<lxDescuentoporcentaje>>, <<lxUltimacotizacion>>, <<lxRecargomontoenpesos>>, <<lxMontodesrecpesos>>, <<lxDescuentomontoenpesos>>, <<lxDescuentomontosinimpuestos>>, <<lxSigno>>, <<lxNroitem>>, <<lxNumerodecomprobante>>, <<lxNumerocupon>>, <<lxPesosalcambio>>, <<lxTipo>>, <<lxPuntodeventa>>, <<lxCotiza>>, <<lxTurno>>, <<iif( lxEsretiroefectivo, 1, 0 )>>, <<iif( lxEsvuelto, 1, 0 )>>, <<iif( lxChequeelectronico, 1, 0 )>>, <<iif( lxVisualizarenestadodecaja, 1, 0 )>>, <<iif( lxAutorizacionpos, 1, 0 )>>, <<iif( lxPersonalizarcomprobante, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxTipodecomprobante ) + "'">>, <<"'" + this.FormatearTextoSql( lxRedondeo ) + "'">>, <<"'" + this.FormatearTextoSql( lxNrodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipodocumento ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemvalores ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemretiroenefectivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerotarjeta ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCondiciondepago_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerochequepropio_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerocheque_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxValor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValordetalle ) + "'">>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerointerno ) + "'">>, <<lxMonto>>, <<lxRecargoporcentaje>>, <<lxPorcentajedesrec>>, <<lxRecargomonto>>, <<lxMontodesrec>>, <<lxTotal>>, <<lxRecibido>>, <<lxRecargomontosinimpuestos>>, <<lxMontoamonedasistema>>, <<lxRecibidoalcambio>>, <<lxMontocupon>>, <<lxRecargosinpercepciones>>, <<iif( lxPermitevuelto, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIditemcomponente ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigodecupon ) + "'">>, <<"'" + this.FormatearTextoSql( lxCupon_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerovaledecambio_PK ) + "'">> ) 
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
						Insert into ZooLogic.ImpuestosV("INTMonto","NROITEM","INTMonSD","IVAMNGSD","IVAMonNG","IVAPorcent","IVAMonSD","IVAMonto","Codigo" ) values ( <<lxMontodeimpuestointerno>>, <<lxNroitem>>, <<lxMontodeimpuestointernosindescuento>>, <<lxMontonogravadosindescuento>>, <<lxMontonogravado>>, <<lxPorcentajedeiva>>, <<lxMontodeivasindescuento>>, <<lxMontodeiva>>, << lcValorClavePrimariaString >> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.ImpuestosComprobante
				if this.oEntidad.ImpuestosComprobante.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobase = loItem.Montobase
					lxMinimo = loItem.Minimo
					lxPorcentaje = loItem.Porcentaje
					lxCertificadosire = loItem.Certificadosire
					lxMinimonoimponible = loItem.Minimonoimponible
					lxMonto = loItem.Monto
					lxNroitem = lnContadorNroItem
					lxCodseguridadsire = loItem.Codseguridadsire
					lxBasedecalculo = loItem.Basedecalculo
					lxRegimenimpositivo = loItem.Regimenimpositivo
					lxTipoimpuesto = loItem.Tipoimpuesto
					lxCodigointerno = loItem.Codigointerno
					lxCodigoimpuesto = loItem.Codigoimpuesto
					lxDescripcion = loItem.Descripcion
					lxJurisdiccion_PK = loItem.Jurisdiccion_PK
					lxRg5329porcentaje = loItem.Rg5329porcentaje
					lxRg5329aplicaporarticulo = loItem.Rg5329aplicaporarticulo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.impVentas("MontoBase","MinimoPer","porcen","SIRECERT","minoimp","Monto","NroItem","SIRECS","Base","RegimenImp","TipoI","codint","CodImp","Descri","jurId","cCod","ArtPercep","ArtPerce" ) values ( <<lxMontobase>>, <<lxMinimo>>, <<lxPorcentaje>>, <<"'" + this.FormatearTextoSql( lxCertificadosire ) + "'">>, <<lxMinimonoimponible>>, <<lxMonto>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxCodseguridadsire ) + "'">>, <<"'" + this.FormatearTextoSql( lxBasedecalculo ) + "'">>, <<"'" + this.FormatearTextoSql( lxRegimenimpositivo ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigointerno ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoimpuesto ) + "'">>, <<"'" + this.FormatearTextoSql( lxDescripcion ) + "'">>, <<"'" + this.FormatearTextoSql( lxJurisdiccion_PK ) + "'">>, << lcValorClavePrimariaString >>, <<lxRg5329porcentaje>>, <<iif( lxRg5329aplicaporarticulo, 1, 0 )>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_numero = loItem.Afe_numero
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxTienerestriccion = loItem.Tienerestriccion
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxComportamiento = loItem.Comportamiento
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxNeto = loItem.Neto
					lxMontoiva = loItem.Montoiva
					lxNroitem = lnContadorNroItem
					lxMontodto1 = loItem.Montodto1
					lxOferta = loItem.Oferta
					lxMontocfi = loItem.Montocfi
					lxPercepcionivarg5329 = loItem.Percepcionivarg5329
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxPorcentajecfi = loItem.Porcentajecfi
					lxKit = loItem.Kit
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxAfe_saldoliquidacion = loItem.Afe_saldoliquidacion
					lxPorcentajeiva = loItem.Porcentajeiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciounitario = loItem.Preciounitario
					lxAfe_saldo = loItem.Afe_saldo
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxIdkit = loItem.Idkit
					lxMaterial_PK = loItem.Material_PK
					lxIditemarticulos = loItem.Iditemarticulos
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxAfe_codigo = loItem.Afe_codigo
					lxUnidad_PK = loItem.Unidad_PK
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle = loItem.Talle
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxCantidad = loItem.Cantidad
					lxIdseniacancelada = loItem.Idseniacancelada
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.KITDET("AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","MNTPPER","MNTPDESCI","MNTPTOT","ConRestr","AfeTS","MNTPRECCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","tasaimpint","PRECIOSISR","PRECIOCISR","COMP","MNTPDESSI","MNDESCI","MNPDSI","MNTPRECSI","MNDESSI","AfeCANT","APorcIvaV","FNETO","FmtoIVA","NroItem","FmtoDTO1","FX2","FmtoCFI","ArtPercep","FCFITot","FporCFI","FKIT","FporDTO1","ACondIvaV","AfeNroItem","iditemOrig","AfeTipoCom","impinterno","Afe_SLiq","fporIva","Prunsinimp","prunconimp","FPRUN","AfeSaldo","FN11","ArtSinDes","ProcStock","UsarPLista","IDKIT","FAMate","IdItem","CodAutDJCP","afe_cod","FUnid","CODIGO","GiftCard","Equiv","MotDevol","MotDescu","FTXT","FCOLO","FCOLDET","FTALL","FCFI","MNTDES","MNTPIVA","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_numero>>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateototal>>, <<lxTienerestriccion>>, <<lxAfe_timestamp>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxTasaimpuestointerno>>, <<lxPreciosinimpuestossinredondear>>, <<lxPrecioconimpuestossinredondear>>, <<lxComportamiento>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxAfe_cantidad>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxOferta>>, <<lxMontocfi>>, <<lxPercepcionivarg5329>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajecfi>>, <<lxKit>>, <<lxPorcentajedto1>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxAfe_tipocomprobante>>, <<lxMontoimpuestointerno>>, <<lxAfe_saldoliquidacion>>, <<lxPorcentajeiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxPreciounitario>>, <<lxAfe_saldo>>, <<lxTipolistadeprecio>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.KITDET" )
this.xmlacursor( lcXml, 'c_KITDETciditem' )
loItem.idItem = c_KITDETciditem.ciditem
use in select( 'c_KITDETciditem' )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4]
		loColeccion.Agregar( 'delete from ZooLogic.COMPROBANTEV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ComprobanteVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ImpuestosV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KITDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
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
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto"
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
			
			.oCompDatosadicionalescomprobantesa.lNuevo = .EsNuevo()
			.oCompDatosadicionalescomprobantesa.lEdicion = .EsEdicion()
			.oCompDatosadicionalescomprobantesa.lEliminar = .lEliminar
			.oCompDatosadicionalescomprobantesa.lAnular = .lAnular
			loColSentencias = .oCompDatosadicionalescomprobantesa.grabar()
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
			
			.KitsDetalle.oItem.oCompStock.lNuevo = .EsNuevo()
			.KitsDetalle.oItem.oCompStock.lEdicion = .EsEdicion()
			.KitsDetalle.oItem.oCompStock.lEliminar = .lEliminar
			.KitsDetalle.oItem.oCompStock.lAnular = .lAnular
			loColSentencias = .KitsDetalle.oItem.oCompStock.grabar()
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
			
			.KitsDetalle.oItem.oCompPrecios.lNuevo = .EsNuevo()
			.KitsDetalle.oItem.oCompPrecios.lEdicion = .EsEdicion()
			.KitsDetalle.oItem.oCompPrecios.lEliminar = .lEliminar
			.KitsDetalle.oItem.oCompPrecios.lAnular = .lAnular
			loColSentencias = .KitsDetalle.oItem.oCompPrecios.grabar()
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
			lcRetorno = [update ZooLogic.COMPROBANTEV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPROBANTEV where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxCOMPROBANTEVFACTSEC as variant, lxComprobanteVFACTTIPO as variant, lxComprobanteVFLETRA as variant, lxComprobanteVFPTOVEN as variant, lxComprobanteVFNUMCOMP as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO'
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPROBANTEV set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, MR = ] + transform( &lcCursor..MR )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, MDCIMPU = ] + transform( &lcCursor..MDCIMPU )+ [, FAjXRe = ] + transform( &lcCursor..FAjXRe )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'"+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, MR2 = ] + transform( &lcCursor..MR2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, DesAuto = ] + Transform( iif( &lcCursor..DesAuto, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, noper = ] + Transform( iif( &lcCursor..noper, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, OPEcomm = ] + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, idAjuste = ] + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MotDescDev = ] + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, MD1 = ] + transform( &lcCursor..MD1 )+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, MD2 = ] + transform( &lcCursor..MD2 )+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Deuda = ] + transform( &lcCursor..Deuda )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, TDCI = ] + transform( &lcCursor..TDCI )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, SitFiscCli = ] + transform( &lcCursor..SitFiscCli )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, Email = ] + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'"+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, percepcion = ] + transform( &lcCursor..percepcion )+ [, MR1 = ] + transform( &lcCursor..MR1 )+ [, gravamen = ] + transform( &lcCursor..gravamen )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, TRCI = ] + transform( &lcCursor..TRCI )+ [, totdesc = ] + transform( &lcCursor..totdesc )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, IvaSis = ] + transform( &lcCursor..IvaSis )+ [, TipoCRela = ] + transform( &lcCursor..TipoCRela )+ [, letraRela = ] + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'"+ [, puntoRela = ] + transform( &lcCursor..puntoRela )+ [, numeroRela = ] + transform( &lcCursor..numeroRela )+ [, FecCRela = ] + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FECIMPO, FD2, FECEXPO, FECTRANS, FALTAFW, FMODIFW, IdCaja, MR, RecPor, FPODES1, FPerson, FTurno, MDCIMPU, FAjXRe, DesMntoSI3, TIMESTAMP, DesMntoSI2, FACTSEC, TotalCant, MR2, DesMntoSI1, CondivaLp, SubTotSISI, SubTotCISI, signomov, fSubToN, FACTTIPO, FSubTOT, DesMntoSI, RecMnto2, RecMntoSI, RecMntoSI2, RecMntoSI1, RecMnto1, FPODES2, RecMnto, DesAuto, Anulado, noper, FCOMPFIS, ESTTRANS, BDMODIFW, VALTAFW, ZADSFW, OPEcomm, UMODIFW, UALTAFW, VMODIFW, HMODIFW, SMODIFW, HALTAFW, HORAIMPO, HORAEXPO, SALTAFW, BDALTAFW, FHORA, SimbMon, DescFW, idAjuste, MonSis, idVuelto, MotDescDev, FObs, FLETRA, FFCH, MD1, FCLIENTE, MD2, FMTDES1, FMTDES2, CODIGO, FVEN, FPTOVEN, Deuda, FMTDES3, Moneda, FNUMCOMP, TDCI, totdescSI, SitFiscCli, CodLista, fCuit, Cotiz, Email, FVuelto, FTotal, FPODES, fDescu, MD3, percepcion, MR1, gravamen, fImpuesto, totrecar, totrecarSI, TRCI, totdesc, totimpue, IvaSis, TipoCRela, letraRela, puntoRela, numeroRela, FecCRela
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + transform( &lcCursor..IdCaja )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..FTurno ) + ',' + transform( &lcCursor..MDCIMPU ) + ',' + transform( &lcCursor..FAjXRe ) + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..DesMntoSI2 )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'" + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..MR2 ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..FACTTIPO )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..RecMnto ) + ',' + Transform( iif( &lcCursor..DesAuto, 1, 0 ))
lcValoresCampos = lcValoresCampos  + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..noper, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..MD1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + transform( &lcCursor..MD2 ) + ',' + transform( &lcCursor..FMTDES1 ) + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..Deuda )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES3 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..TDCI ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..SitFiscCli ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..Cotiz )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'" + ',' + transform( &lcCursor..FVuelto ) + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..MD3 ) + ',' + transform( &lcCursor..percepcion ) + ',' + transform( &lcCursor..MR1 ) + ',' + transform( &lcCursor..gravamen ) + ',' + transform( &lcCursor..fImpuesto )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..totrecar ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..TRCI ) + ',' + transform( &lcCursor..totdesc ) + ',' + transform( &lcCursor..totimpue ) + ',' + transform( &lcCursor..IvaSis ) + ',' + transform( &lcCursor..TipoCRela ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'" + ',' + transform( &lcCursor..puntoRela ) + ',' + transform( &lcCursor..numeroRela )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPROBANTEV ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ComprobanteVDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VAL Where JJNUM] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ImpuestosV Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.impVentas Where cCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.KITDET Where CODIGO] + lcIn  )
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
			"AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ComprobanteVDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afe_cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMVALORES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where JJNUM in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"JJfecha","FechCoti","IdCaja","descmonto","descporc","Cotiza","MonRecPes","monderepes","MonDesPes","descsinimp","Signo","NroItem","NumCompr","NroCupon","Pesos","JJT","PtoVenta","JJCotiz","JJTurno","EsRetiroEf","esvuelto","CElectro","VisualCaja","Autorizado","PersComp","TIPCOMP","Redondeo","NroDoc","TipoDoc","IdItem","IdretiroEf","JJVen","NroTarjeta","Letra","condpago","NroChProp","NroCheque","JJNUM","JJCO","JJDE","JJFE","NroInterno","JJM","jrecporc","porcdesrec","jrecmnt","mondesrec","JJTotFac","JJRecib","jrecmntsi","Montosiste","RecPesos","MonCupon","jrrecsperc","permvuelto","guidComp","guidCupon","Cupon","ValeCambio"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.VAL ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.ConvertirDateSql( cDetallesExistentes.JJfecha    ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.FechCoti   ) + "'" + ',' + transform( cDetallesExistentes.IdCaja     ) + ',' + transform( cDetallesExistentes.descmonto  ) + ',' + transform( cDetallesExistentes.descporc   ) + ',' + transform( cDetallesExistentes.Cotiza     ) + ',' + transform( cDetallesExistentes.MonRecPes  ) + ',' + transform( cDetallesExistentes.monderepes ) + ',' + transform( cDetallesExistentes.MonDesPes  ) + ',' + transform( cDetallesExistentes.descsinimp ) + ',' + transform( cDetallesExistentes.Signo      ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.NumCompr   ) + ',' + transform( cDetallesExistentes.NroCupon   ) + ',' + transform( cDetallesExistentes.Pesos      ) + ',' + transform( cDetallesExistentes.JJT        ) + ',' + transform( cDetallesExistentes.PtoVenta   ) + ',' + transform( cDetallesExistentes.JJCotiz    ) + ',' + transform( cDetallesExistentes.JJTurno    ) + ',' + Transform( iif( cDetallesExistentes.EsRetiroEf, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.esvuelto  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.CElectro  , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.VisualCaja, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.Autorizado, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.PersComp  , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TIPCOMP    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Redondeo   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroDoc     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoDoc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdretiroEf ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJVen      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroTarjeta ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Letra      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.condpago   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroChProp  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroCheque  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJNUM      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJCO       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.JJDE       ) + "'" + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.JJFE       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NroInterno ) + "'" + ',' + transform( cDetallesExistentes.JJM        ) + ',' + transform( cDetallesExistentes.jrecporc   ) + ',' + transform( cDetallesExistentes.porcdesrec ) + ',' + transform( cDetallesExistentes.jrecmnt    ) + ',' + transform( cDetallesExistentes.mondesrec  ) + ',' + transform( cDetallesExistentes.JJTotFac   ) + ',' + transform( cDetallesExistentes.JJRecib    ) + ',' + transform( cDetallesExistentes.jrecmntsi  ) + ',' + transform( cDetallesExistentes.Montosiste ) + ',' + transform( cDetallesExistentes.RecPesos   ) + ',' + transform( cDetallesExistentes.MonCupon   ) + ',' + transform( cDetallesExistentes.jrrecsperc ) + ',' + Transform( iif( cDetallesExistentes.permvuelto, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidComp   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.guidCupon  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Cupon      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ValeCambio ) + "'" + ' )'  )
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
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ImpuestosV ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.INTMonto   ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.INTMonSD   ) + ',' + transform( cDetallesExistentes.IVAMNGSD   ) + ',' + transform( cDetallesExistentes.IVAMonNG   ) + ',' + transform( cDetallesExistentes.IVAPorcent ) + ',' + transform( cDetallesExistentes.IVAMonSD   ) + ',' + transform( cDetallesExistentes.IVAMonto   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMCOMPROBANTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where Codigo in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.CompAfe ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeComprob ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.ConvertirDateSql( cDetallesExistentes.afefecha   ) + "'" + ',' + transform( cDetallesExistentes.afetotal   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afevend    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afetipo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afecta     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DescInter  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.NomInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodInter   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Origen     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMIMPUESTOVENTAS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where cCod in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"MontoBase","MinimoPer","porcen","SIRECERT","minoimp","Monto","NroItem","SIRECS","Base","RegimenImp","TipoI","codint","CodImp","Descri","jurId","cCod","ArtPercep","ArtPerce"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.impVentas ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.MontoBase  ) + ',' + transform( cDetallesExistentes.MinimoPer  ) + ',' + transform( cDetallesExistentes.porcen     ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECERT   ) + "'" + ',' + transform( cDetallesExistentes.minoimp    ) + ',' + transform( cDetallesExistentes.Monto      ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SIRECS     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Base       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.RegimenImp ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TipoI      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codint     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodImp     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Descri     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.jurId      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cCod       ) + "'" + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + Transform( iif( cDetallesExistentes.ArtPerce  , 1, 0 )) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMKITS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfePTOVEN","AfeLETRA","codgtin","FART","MNTPPER","MNTPDESCI","MNTPTOT","ConRestr","AfeTS","MNTPRECCI","AjuCImp","FBruto","AjuSImp","PRECIOSR","tasaimpint","PRECIOSISR","PRECIOCISR","COMP","MNTPDESSI","MNDESCI","MNPDSI","MNTPRECSI","MNDESSI","AfeCANT","APorcIvaV","FNETO","FmtoIVA","NroItem","FmtoDTO1","FX2","FmtoCFI","ArtPercep","FCFITot","FporCFI","FKIT","FporDTO1","ACondIvaV","AfeNroItem","iditemOrig","AfeTipoCom","impinterno","Afe_SLiq","fporIva","Prunsinimp","prunconimp","FPRUN","AfeSaldo","FN11","ArtSinDes","ProcStock","UsarPLista","IDKIT","FAMate","IdItem","CodAutDJCP","afe_cod","FUnid","CODIGO","GiftCard","Equiv","MotDevol","MotDescu","FTXT","FCOLO","FCOLDET","FTALL","FCFI","MNTDES","MNTPIVA","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.KITDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLDET    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.KitsDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.KitsDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORES',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.FacturaDetalle.oItem.oCompGiftcard.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS', this.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. Venta: ' + transform( &tcCursor..FPTOVEN    )
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..FNUMCOMP   )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'NOTADEDEBITO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOTADEDEBITO_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOTADEDEBITO_FOBS'
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
			Case  lcAlias == lcPrefijo + 'ITEMKITS'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ComprobanteV')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'NOTADEDEBITO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP ) or isnull( &lcCursor..FACTSEC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad NOTADEDEBITO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FecCRela  
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ComprobanteV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ComprobanteV
Create Table ZooLogic.TablaTrabajo_ComprobanteV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fd2" datetime  null, 
"fecexpo" datetime  null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"idcaja" numeric( 2, 0 )  null, 
"mr" numeric( 15, 2 )  null, 
"recpor" numeric( 6, 2 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fperson" char( 5 )  null, 
"fturno" numeric( 1, 0 )  null, 
"mdcimpu" numeric( 15, 4 )  null, 
"fajxre" numeric( 8, 2 )  null, 
"desmntosi3" numeric( 15, 4 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"desmntosi2" numeric( 15, 4 )  null, 
"factsec" char( 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"mr2" numeric( 15, 2 )  null, 
"desmntosi1" numeric( 15, 4 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"signomov" numeric( 2, 0 )  null, 
"fsubton" numeric( 15, 4 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"fsubtot" numeric( 15, 4 )  null, 
"desmntosi" numeric( 15, 4 )  null, 
"recmnto2" numeric( 15, 4 )  null, 
"recmntosi" numeric( 15, 4 )  null, 
"recmntosi2" numeric( 15, 4 )  null, 
"recmntosi1" numeric( 15, 4 )  null, 
"recmnto1" numeric( 15, 4 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"recmnto" numeric( 15, 4 )  null, 
"desauto" bit  null, 
"anulado" bit  null, 
"noper" bit  null, 
"fcompfis" bit  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"valtafw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"opecomm" char( 254 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"haltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"bdaltafw" char( 8 )  null, 
"fhora" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"descfw" char( 200 )  null, 
"idajuste" char( 10 )  null, 
"monsis" char( 10 )  null, 
"idvuelto" char( 5 )  null, 
"motdescdev" char( 10 )  null, 
"fobs" varchar(max)  null, 
"fletra" char( 1 )  null, 
"ffch" datetime  null, 
"md1" numeric( 15, 2 )  null, 
"fcliente" char( 30 )  null, 
"md2" numeric( 17, 4 )  null, 
"fmtdes1" numeric( 15, 4 )  null, 
"fmtdes2" numeric( 15, 4 )  null, 
"codigo" char( 38 )  null, 
"fven" char( 5 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"deuda" numeric( 15, 2 )  null, 
"fmtdes3" numeric( 15, 4 )  null, 
"moneda" char( 10 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"tdci" numeric( 15, 4 )  null, 
"totdescsi" numeric( 15, 4 )  null, 
"sitfisccli" numeric( 2, 0 )  null, 
"codlista" char( 6 )  null, 
"fcuit" char( 15 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"email" char( 250 )  null, 
"fvuelto" numeric( 8, 2 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"fdescu" numeric( 8, 2 )  null, 
"md3" numeric( 15, 2 )  null, 
"percepcion" numeric( 15, 2 )  null, 
"mr1" numeric( 17, 4 )  null, 
"gravamen" numeric( 15, 2 )  null, 
"fimpuesto" numeric( 8, 2 )  null, 
"totrecar" numeric( 8, 2 )  null, 
"totrecarsi" numeric( 15, 4 )  null, 
"trci" numeric( 15, 4 )  null, 
"totdesc" numeric( 8, 2 )  null, 
"totimpue" numeric( 8, 2 )  null, 
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
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ComprobanteV' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ComprobanteV' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADEDEBITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('mr','mr')
			.AgregarMapeo('recpor','recpor')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('mdcimpu','mdcimpu')
			.AgregarMapeo('fajxre','fajxre')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('mr2','mr2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmnto1','recmnto1')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('recmnto','recmnto')
			.AgregarMapeo('desauto','desauto')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('noper','noper')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('opecomm','opecomm')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('idajuste','idajuste')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('motdescdev','motdescdev')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('md1','md1')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('md2','md2')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('deuda','deuda')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('tdci','tdci')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('sitfisccli','sitfisccli')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('email','email')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('md3','md3')
			.AgregarMapeo('percepcion','percepcion')
			.AgregarMapeo('mr1','mr1')
			.AgregarMapeo('gravamen','gravamen')
			.AgregarMapeo('fimpuesto','fimpuesto')
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('trci','trci')
			.AgregarMapeo('totdesc','totdesc')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('ivasis','ivasis')
			.AgregarMapeo('tipocrela','tipocrela')
			.AgregarMapeo('letrarela','letrarela')
			.AgregarMapeo('puntorela','puntorela')
			.AgregarMapeo('numerorela','numerorela')
			.AgregarMapeo('feccrela','feccrela')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ComprobanteV'
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.MR = isnull( d.MR, t.MR ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.MDCIMPU = isnull( d.MDCIMPU, t.MDCIMPU ),t.FAJXRE = isnull( d.FAJXRE, t.FAJXRE ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.MR2 = isnull( d.MR2, t.MR2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.DESAUTO = isnull( d.DESAUTO, t.DESAUTO ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.NOPER = isnull( d.NOPER, t.NOPER ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.OPECOMM = isnull( d.OPECOMM, t.OPECOMM ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.IDAJUSTE = isnull( d.IDAJUSTE, t.IDAJUSTE ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MOTDESCDEV = isnull( d.MOTDESCDEV, t.MOTDESCDEV ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.MD1 = isnull( d.MD1, t.MD1 ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.MD2 = isnull( d.MD2, t.MD2 ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.DEUDA = isnull( d.DEUDA, t.DEUDA ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.TDCI = isnull( d.TDCI, t.TDCI ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.SITFISCCLI = isnull( d.SITFISCCLI, t.SITFISCCLI ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.MD3 = isnull( d.MD3, t.MD3 ),t.PERCEPCION = isnull( d.PERCEPCION, t.PERCEPCION ),t.MR1 = isnull( d.MR1, t.MR1 ),t.GRAVAMEN = isnull( d.GRAVAMEN, t.GRAVAMEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TRCI = isnull( d.TRCI, t.TRCI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.IVASIS = isnull( d.IVASIS, t.IVASIS ),t.TIPOCRELA = isnull( d.TIPOCRELA, t.TIPOCRELA ),t.LETRARELA = isnull( d.LETRARELA, t.LETRARELA ),t.PUNTORELA = isnull( d.PUNTORELA, t.PUNTORELA ),t.NUMERORELA = isnull( d.NUMERORELA, t.NUMERORELA ),t.FECCRELA = isnull( d.FECCRELA, t.FECCRELA )
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
				-- Fin Updates
				insert into ZooLogic.COMPROBANTEV(Fecimpo,Fd2,Fecexpo,Fectrans,Faltafw,Fmodifw,Idcaja,Mr,Recpor,Fpodes1,Fperson,Fturno,Mdcimpu,Fajxre,Desmntosi3,Timestamp,Desmntosi2,Factsec,Totalcant,Mr2,Desmntosi1,Condivalp,Subtotsisi,Subtotcisi,Signomov,Fsubton,Facttipo,Fsubtot,Desmntosi,Recmnto2,Recmntosi,Recmntosi2,Recmntosi1,Recmnto1,Fpodes2,Recmnto,Desauto,Anulado,Noper,Fcompfis,Esttrans,Bdmodifw,Valtafw,Zadsfw,Opecomm,Umodifw,Ualtafw,Vmodifw,Hmodifw,Smodifw,Haltafw,Horaimpo,Horaexpo,Saltafw,Bdaltafw,Fhora,Simbmon,Descfw,Idajuste,Monsis,Idvuelto,Motdescdev,Fobs,Fletra,Ffch,Md1,Fcliente,Md2,Fmtdes1,Fmtdes2,Codigo,Fven,Fptoven,Deuda,Fmtdes3,Moneda,Fnumcomp,Tdci,Totdescsi,Sitfisccli,Codlista,Fcuit,Cotiz,Email,Fvuelto,Ftotal,Fpodes,Fdescu,Md3,Percepcion,Mr1,Gravamen,Fimpuesto,Totrecar,Totrecarsi,Trci,Totdesc,Totimpue,Ivasis,Tipocrela,Letrarela,Puntorela,Numerorela,Feccrela)
					Select isnull( d.FECIMPO,''),isnull( d.FD2,''),isnull( d.FECEXPO,''),isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.IDCAJA,0),isnull( d.MR,0),isnull( d.RECPOR,0),isnull( d.FPODES1,0),isnull( d.FPERSON,''),isnull( d.FTURNO,0),isnull( d.MDCIMPU,0),isnull( d.FAJXRE,0),isnull( d.DESMNTOSI3,0),isnull( d.TIMESTAMP,0),isnull( d.DESMNTOSI2,0),isnull( d.FACTSEC,''),isnull( d.TOTALCANT,0),isnull( d.MR2,0),isnull( d.DESMNTOSI1,0),isnull( d.CONDIVALP,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.SIGNOMOV,0),isnull( d.FSUBTON,0),isnull( d.FACTTIPO,0),isnull( d.FSUBTOT,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTO2,0),isnull( d.RECMNTOSI,0),isnull( d.RECMNTOSI2,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTO1,0),isnull( d.FPODES2,0),isnull( d.RECMNTO,0),isnull( d.DESAUTO,0),isnull( d.ANULADO,0),isnull( d.NOPER,0),isnull( d.FCOMPFIS,0),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.VALTAFW,''),isnull( d.ZADSFW,''),isnull( d.OPECOMM,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),convert( char(8), getdate(), 108 ),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.SALTAFW,''),isnull( d.BDALTAFW,''),isnull( d.FHORA,''),isnull( d.SIMBMON,''),isnull( d.DESCFW,''),isnull( d.IDAJUSTE,''),isnull( d.MONSIS,''),isnull( d.IDVUELTO,''),isnull( d.MOTDESCDEV,''),isnull( d.FOBS,''),isnull( d.FLETRA,''),isnull( d.FFCH,''),isnull( d.MD1,0),isnull( d.FCLIENTE,''),isnull( d.MD2,0),isnull( d.FMTDES1,0),isnull( d.FMTDES2,0),isnull( d.CODIGO,''),isnull( d.FVEN,''),isnull( d.FPTOVEN,0),isnull( d.DEUDA,0),isnull( d.FMTDES3,0),isnull( d.MONEDA,''),isnull( d.FNUMCOMP,0),isnull( d.TDCI,0),isnull( d.TOTDESCSI,0),isnull( d.SITFISCCLI,0),isnull( d.CODLISTA,''),isnull( d.FCUIT,''),isnull( d.COTIZ,0),isnull( d.EMAIL,''),isnull( d.FVUELTO,0),isnull( d.FTOTAL,0),isnull( d.FPODES,0),isnull( d.FDESCU,0),isnull( d.MD3,0),isnull( d.PERCEPCION,0),isnull( d.MR1,0),isnull( d.GRAVAMEN,0),isnull( d.FIMPUESTO,0),isnull( d.TOTRECAR,0),isnull( d.TOTRECARSI,0),isnull( d.TRCI,0),isnull( d.TOTDESC,0),isnull( d.TOTIMPUE,0),isnull( d.IVASIS,0),isnull( d.TIPOCRELA,0),isnull( d.LETRARELA,''),isnull( d.PUNTORELA,0),isnull( d.NUMERORELA,0),isnull( d.FECCRELA,'')
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal no es la esperada'
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>:  ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal a importar ya existe'
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
	function ObtenerTriggerDeleteImportacion_ComprobanteVDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_ComprobanteVDet
ON ZooLogic.TablaTrabajo_COMPROBANTEV_ComprobanteVDet
AFTER DELETE
As
Begin
Update t Set 
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FART = isnull( d.FART, t.FART ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.CONRESTR = isnull( d.CONRESTR, t.CONRESTR ),
t.AFE_SLIQ = isnull( d.AFE_SLIQ, t.AFE_SLIQ ),
t.COMP = isnull( d.COMP, t.COMP ),
t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.GIFTCARD = isnull( d.GIFTCARD, t.GIFTCARD ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.FCOTXT = isnull( d.FCOTXT, t.FCOTXT ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.MNTPINT = isnull( d.MNTPINT, t.MNTPINT ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.ComprobanteVDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ComprobanteVDet
( 
"AFEPTOVEN",
"AFELETRA",
"AFENUMCOM",
"CODGTIN",
"FART",
"MNTPRECSI",
"MNTPDESSI",
"MNTPRECCI",
"AFETS",
"MNTPTOT",
"MNTPDESCI",
"MNTPPER",
"PRECIOSISR",
"MNPDSI",
"CONRESTR",
"AFE_SLIQ",
"COMP",
"IMPINTERNO",
"ARTPERCEP",
"AJUSIMP",
"TASAIMPINT",
"PRECIOCISR",
"MNDESSI",
"FBRUTO",
"PRECIOSR",
"MNDESCI",
"AJUCIMP",
"APORCIVAV",
"ACONDIVAV",
"FPORCFI",
"FX2",
"FPORDTO1",
"NROITEM",
"FPORIVA",
"AFESALDO",
"FMTODTO1",
"FMTOIVA",
"PRUNCONIMP",
"FNETO",
"PRUNSINIMP",
"FKIT",
"FCFITOT",
"AFETIPOCOM",
"AFECANT",
"AFENROITEM",
"IDITEMORIG",
"FN11",
"CIDITEM",
"FMTOCFI",
"FPRUN",
"ARTSINDES",
"USARPLISTA",
"PROCSTOCK",
"CODAUTDJCP",
"IDITEM",
"AFE_COD",
"IDKIT",
"FAMATE",
"CODIGO",
"GIFTCARD",
"MOTDESCU",
"FUNID",
"MOTDEVOL",
"EQUIV",
"FTXT",
"FCOLO",
"FCOTXT",
"FTALL",
"FCFI",
"MNTPIVA",
"MNTDES",
"MNTPINT",
"FCANT",
"SENIACANCE",
"FPRECIO",
"FMONTO"
 )
Select 
d.AFEPTOVEN,
d.AFELETRA,
d.AFENUMCOM,
d.CODGTIN,
d.FART,
d.MNTPRECSI,
d.MNTPDESSI,
d.MNTPRECCI,
d.AFETS,
d.MNTPTOT,
d.MNTPDESCI,
d.MNTPPER,
d.PRECIOSISR,
d.MNPDSI,
d.CONRESTR,
d.AFE_SLIQ,
d.COMP,
d.IMPINTERNO,
d.ARTPERCEP,
d.AJUSIMP,
d.TASAIMPINT,
d.PRECIOCISR,
d.MNDESSI,
d.FBRUTO,
d.PRECIOSR,
d.MNDESCI,
d.AJUCIMP,
d.APORCIVAV,
d.ACONDIVAV,
d.FPORCFI,
d.FX2,
d.FPORDTO1,
d.NROITEM,
d.FPORIVA,
d.AFESALDO,
d.FMTODTO1,
d.FMTOIVA,
d.PRUNCONIMP,
d.FNETO,
d.PRUNSINIMP,
d.FKIT,
d.FCFITOT,
d.AFETIPOCOM,
d.AFECANT,
d.AFENROITEM,
d.IDITEMORIG,
d.FN11,
d.CIDITEM,
d.FMTOCFI,
d.FPRUN,
d.ARTSINDES,
d.USARPLISTA,
d.PROCSTOCK,
d.CODAUTDJCP,
d.IDITEM,
d.AFE_COD,
d.IDKIT,
d.FAMATE,
d.CODIGO,
d.GIFTCARD,
d.MOTDESCU,
d.FUNID,
d.MOTDEVOL,
d.EQUIV,
d.FTXT,
d.FCOLO,
d.FCOTXT,
d.FTALL,
d.FCFI,
d.MNTPIVA,
d.MNTDES,
d.MNTPINT,
d.FCANT,
d.SENIACANCE,
d.FPRECIO,
d.FMONTO
From deleted d left join ZooLogic.ComprobanteVDet pk 
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
t.DESCMONTO = isnull( d.DESCMONTO, t.DESCMONTO ),
t.DESCPORC = isnull( d.DESCPORC, t.DESCPORC ),
t.COTIZA = isnull( d.COTIZA, t.COTIZA ),
t.MONRECPES = isnull( d.MONRECPES, t.MONRECPES ),
t.MONDEREPES = isnull( d.MONDEREPES, t.MONDEREPES ),
t.MONDESPES = isnull( d.MONDESPES, t.MONDESPES ),
t.DESCSINIMP = isnull( d.DESCSINIMP, t.DESCSINIMP ),
t.SIGNO = isnull( d.SIGNO, t.SIGNO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.NUMCOMPR = isnull( d.NUMCOMPR, t.NUMCOMPR ),
t.NROCUPON = isnull( d.NROCUPON, t.NROCUPON ),
t.PESOS = isnull( d.PESOS, t.PESOS ),
t.JJT = isnull( d.JJT, t.JJT ),
t.PTOVENTA = isnull( d.PTOVENTA, t.PTOVENTA ),
t.JJCOTIZ = isnull( d.JJCOTIZ, t.JJCOTIZ ),
t.JJTURNO = isnull( d.JJTURNO, t.JJTURNO ),
t.ESRETIROEF = isnull( d.ESRETIROEF, t.ESRETIROEF ),
t.ESVUELTO = isnull( d.ESVUELTO, t.ESVUELTO ),
t.CELECTRO = isnull( d.CELECTRO, t.CELECTRO ),
t.VISUALCAJA = isnull( d.VISUALCAJA, t.VISUALCAJA ),
t.AUTORIZADO = isnull( d.AUTORIZADO, t.AUTORIZADO ),
t.PERSCOMP = isnull( d.PERSCOMP, t.PERSCOMP ),
t.TIPCOMP = isnull( d.TIPCOMP, t.TIPCOMP ),
t.REDONDEO = isnull( d.REDONDEO, t.REDONDEO ),
t.NRODOC = isnull( d.NRODOC, t.NRODOC ),
t.TIPODOC = isnull( d.TIPODOC, t.TIPODOC ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.IDRETIROEF = isnull( d.IDRETIROEF, t.IDRETIROEF ),
t.JJVEN = isnull( d.JJVEN, t.JJVEN ),
t.NROTARJETA = isnull( d.NROTARJETA, t.NROTARJETA ),
t.LETRA = isnull( d.LETRA, t.LETRA ),
t.CONDPAGO = isnull( d.CONDPAGO, t.CONDPAGO ),
t.NROCHPROP = isnull( d.NROCHPROP, t.NROCHPROP ),
t.NROCHEQUE = isnull( d.NROCHEQUE, t.NROCHEQUE ),
t.JJNUM = isnull( d.JJNUM, t.JJNUM ),
t.JJCO = isnull( d.JJCO, t.JJCO ),
t.JJDE = isnull( d.JJDE, t.JJDE ),
t.JJFE = isnull( d.JJFE, t.JJFE ),
t.NROINTERNO = isnull( d.NROINTERNO, t.NROINTERNO ),
t.JJM = isnull( d.JJM, t.JJM ),
t.JRECPORC = isnull( d.JRECPORC, t.JRECPORC ),
t.PORCDESREC = isnull( d.PORCDESREC, t.PORCDESREC ),
t.JRECMNT = isnull( d.JRECMNT, t.JRECMNT ),
t.MONDESREC = isnull( d.MONDESREC, t.MONDESREC ),
t.JJTOTFAC = isnull( d.JJTOTFAC, t.JJTOTFAC ),
t.JJRECIB = isnull( d.JJRECIB, t.JJRECIB ),
t.JRECMNTSI = isnull( d.JRECMNTSI, t.JRECMNTSI ),
t.MONTOSISTE = isnull( d.MONTOSISTE, t.MONTOSISTE ),
t.RECPESOS = isnull( d.RECPESOS, t.RECPESOS ),
t.MONCUPON = isnull( d.MONCUPON, t.MONCUPON ),
t.JRRECSPERC = isnull( d.JRRECSPERC, t.JRRECSPERC ),
t.PERMVUELTO = isnull( d.PERMVUELTO, t.PERMVUELTO ),
t.GUIDCOMP = isnull( d.GUIDCOMP, t.GUIDCOMP ),
t.GUIDCUPON = isnull( d.GUIDCUPON, t.GUIDCUPON ),
t.CUPON = isnull( d.CUPON, t.CUPON ),
t.VALECAMBIO = isnull( d.VALECAMBIO, t.VALECAMBIO )
from ZooLogic.VAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.VAL
( 
"JJFECHA",
"FECHCOTI",
"IDCAJA",
"DESCMONTO",
"DESCPORC",
"COTIZA",
"MONRECPES",
"MONDEREPES",
"MONDESPES",
"DESCSINIMP",
"SIGNO",
"NROITEM",
"NUMCOMPR",
"NROCUPON",
"PESOS",
"JJT",
"PTOVENTA",
"JJCOTIZ",
"JJTURNO",
"ESRETIROEF",
"ESVUELTO",
"CELECTRO",
"VISUALCAJA",
"AUTORIZADO",
"PERSCOMP",
"TIPCOMP",
"REDONDEO",
"NRODOC",
"TIPODOC",
"IDITEM",
"IDRETIROEF",
"JJVEN",
"NROTARJETA",
"LETRA",
"CONDPAGO",
"NROCHPROP",
"NROCHEQUE",
"JJNUM",
"JJCO",
"JJDE",
"JJFE",
"NROINTERNO",
"JJM",
"JRECPORC",
"PORCDESREC",
"JRECMNT",
"MONDESREC",
"JJTOTFAC",
"JJRECIB",
"JRECMNTSI",
"MONTOSISTE",
"RECPESOS",
"MONCUPON",
"JRRECSPERC",
"PERMVUELTO",
"GUIDCOMP",
"GUIDCUPON",
"CUPON",
"VALECAMBIO"
 )
Select 
d.JJFECHA,
d.FECHCOTI,
d.IDCAJA,
d.DESCMONTO,
d.DESCPORC,
d.COTIZA,
d.MONRECPES,
d.MONDEREPES,
d.MONDESPES,
d.DESCSINIMP,
d.SIGNO,
d.NROITEM,
d.NUMCOMPR,
d.NROCUPON,
d.PESOS,
d.JJT,
d.PTOVENTA,
d.JJCOTIZ,
d.JJTURNO,
d.ESRETIROEF,
d.ESVUELTO,
d.CELECTRO,
d.VISUALCAJA,
d.AUTORIZADO,
d.PERSCOMP,
d.TIPCOMP,
d.REDONDEO,
d.NRODOC,
d.TIPODOC,
d.IDITEM,
d.IDRETIROEF,
d.JJVEN,
d.NROTARJETA,
d.LETRA,
d.CONDPAGO,
d.NROCHPROP,
d.NROCHEQUE,
d.JJNUM,
d.JJCO,
d.JJDE,
d.JJFE,
d.NROINTERNO,
d.JJM,
d.JRECPORC,
d.PORCDESREC,
d.JRECMNT,
d.MONDESREC,
d.JJTOTFAC,
d.JJRECIB,
d.JRECMNTSI,
d.MONTOSISTE,
d.RECPESOS,
d.MONCUPON,
d.JRRECSPERC,
d.PERMVUELTO,
d.GUIDCOMP,
d.GUIDCUPON,
d.CUPON,
d.VALECAMBIO
From deleted d left join ZooLogic.VAL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ImpuestosV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_ImpuestosV
ON ZooLogic.TablaTrabajo_COMPROBANTEV_ImpuestosV
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
from ZooLogic.ImpuestosV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ImpuestosV
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
From deleted d left join ZooLogic.ImpuestosV pk 
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
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
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
"NROITEM",
"CODIGO",
"AFETIPOCOM",
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
d.NROITEM,
d.CODIGO,
d.AFETIPOCOM,
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
t.MONTOBASE = isnull( d.MONTOBASE, t.MONTOBASE ),
t.MINIMOPER = isnull( d.MINIMOPER, t.MINIMOPER ),
t.PORCEN = isnull( d.PORCEN, t.PORCEN ),
t.SIRECERT = isnull( d.SIRECERT, t.SIRECERT ),
t.MINOIMP = isnull( d.MINOIMP, t.MINOIMP ),
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.SIRECS = isnull( d.SIRECS, t.SIRECS ),
t.BASE = isnull( d.BASE, t.BASE ),
t.REGIMENIMP = isnull( d.REGIMENIMP, t.REGIMENIMP ),
t.TIPOI = isnull( d.TIPOI, t.TIPOI ),
t.CODINT = isnull( d.CODINT, t.CODINT ),
t.CODIMP = isnull( d.CODIMP, t.CODIMP ),
t.DESCRI = isnull( d.DESCRI, t.DESCRI ),
t.JURID = isnull( d.JURID, t.JURID ),
t.CCOD = isnull( d.CCOD, t.CCOD ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.ARTPERCE = isnull( d.ARTPERCE, t.ARTPERCE )
from ZooLogic.impVentas t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.impVentas
( 
"MONTOBASE",
"MINIMOPER",
"PORCEN",
"SIRECERT",
"MINOIMP",
"MONTO",
"NROITEM",
"SIRECS",
"BASE",
"REGIMENIMP",
"TIPOI",
"CODINT",
"CODIMP",
"DESCRI",
"JURID",
"CCOD",
"ARTPERCEP",
"ARTPERCE"
 )
Select 
d.MONTOBASE,
d.MINIMOPER,
d.PORCEN,
d.SIRECERT,
d.MINOIMP,
d.MONTO,
d.NROITEM,
d.SIRECS,
d.BASE,
d.REGIMENIMP,
d.TIPOI,
d.CODINT,
d.CODIMP,
d.DESCRI,
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
	function ObtenerTriggerDeleteImportacion_KITDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_KITDET
ON ZooLogic.TablaTrabajo_COMPROBANTEV_KITDET
AFTER DELETE
As
Begin
Update t Set 
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FART = isnull( d.FART, t.FART ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.CONRESTR = isnull( d.CONRESTR, t.CONRESTR ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.COMP = isnull( d.COMP, t.COMP ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FX2 = isnull( d.FX2, t.FX2 ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.ARTPERCEP = isnull( d.ARTPERCEP, t.ARTPERCEP ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),
t.AFE_SLIQ = isnull( d.AFE_SLIQ, t.AFE_SLIQ ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.GIFTCARD = isnull( d.GIFTCARD, t.GIFTCARD ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.FCOLO = isnull( d.FCOLO, t.FCOLO ),
t.FCOLDET = isnull( d.FCOLDET, t.FCOLDET ),
t.FTALL = isnull( d.FTALL, t.FTALL ),
t.FCFI = isnull( d.FCFI, t.FCFI ),
t.MNTDES = isnull( d.MNTDES, t.MNTDES ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.MNTPINT = isnull( d.MNTPINT, t.MNTPINT ),
t.FCANT = isnull( d.FCANT, t.FCANT ),
t.SENIACANCE = isnull( d.SENIACANCE, t.SENIACANCE ),
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.KITDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.KITDET
( 
"AFENUMCOM",
"AFEPTOVEN",
"AFELETRA",
"CODGTIN",
"FART",
"MNTPPER",
"MNTPDESCI",
"MNTPTOT",
"CONRESTR",
"AFETS",
"MNTPRECCI",
"AJUCIMP",
"FBRUTO",
"AJUSIMP",
"PRECIOSR",
"TASAIMPINT",
"PRECIOSISR",
"PRECIOCISR",
"COMP",
"MNTPDESSI",
"MNDESCI",
"MNPDSI",
"MNTPRECSI",
"MNDESSI",
"AFECANT",
"APORCIVAV",
"FNETO",
"FMTOIVA",
"NROITEM",
"FMTODTO1",
"FX2",
"FMTOCFI",
"ARTPERCEP",
"FCFITOT",
"FPORCFI",
"FKIT",
"FPORDTO1",
"ACONDIVAV",
"AFENROITEM",
"IDITEMORIG",
"AFETIPOCOM",
"CIDITEM",
"IMPINTERNO",
"AFE_SLIQ",
"FPORIVA",
"PRUNSINIMP",
"PRUNCONIMP",
"FPRUN",
"AFESALDO",
"FN11",
"ARTSINDES",
"PROCSTOCK",
"USARPLISTA",
"IDKIT",
"FAMATE",
"IDITEM",
"CODAUTDJCP",
"AFE_COD",
"FUNID",
"CODIGO",
"GIFTCARD",
"EQUIV",
"MOTDEVOL",
"MOTDESCU",
"FTXT",
"FCOLO",
"FCOLDET",
"FTALL",
"FCFI",
"MNTDES",
"MNTPIVA",
"MNTPINT",
"FCANT",
"SENIACANCE",
"FPRECIO",
"FMONTO"
 )
Select 
d.AFENUMCOM,
d.AFEPTOVEN,
d.AFELETRA,
d.CODGTIN,
d.FART,
d.MNTPPER,
d.MNTPDESCI,
d.MNTPTOT,
d.CONRESTR,
d.AFETS,
d.MNTPRECCI,
d.AJUCIMP,
d.FBRUTO,
d.AJUSIMP,
d.PRECIOSR,
d.TASAIMPINT,
d.PRECIOSISR,
d.PRECIOCISR,
d.COMP,
d.MNTPDESSI,
d.MNDESCI,
d.MNPDSI,
d.MNTPRECSI,
d.MNDESSI,
d.AFECANT,
d.APORCIVAV,
d.FNETO,
d.FMTOIVA,
d.NROITEM,
d.FMTODTO1,
d.FX2,
d.FMTOCFI,
d.ARTPERCEP,
d.FCFITOT,
d.FPORCFI,
d.FKIT,
d.FPORDTO1,
d.ACONDIVAV,
d.AFENROITEM,
d.IDITEMORIG,
d.AFETIPOCOM,
d.CIDITEM,
d.IMPINTERNO,
d.AFE_SLIQ,
d.FPORIVA,
d.PRUNSINIMP,
d.PRUNCONIMP,
d.FPRUN,
d.AFESALDO,
d.FN11,
d.ARTSINDES,
d.PROCSTOCK,
d.USARPLISTA,
d.IDKIT,
d.FAMATE,
d.IDITEM,
d.CODAUTDJCP,
d.AFE_COD,
d.FUNID,
d.CODIGO,
d.GIFTCARD,
d.EQUIV,
d.MOTDEVOL,
d.MOTDESCU,
d.FTXT,
d.FCOLO,
d.FCOLDET,
d.FTALL,
d.FCFI,
d.MNTDES,
d.MNTPIVA,
d.MNTPINT,
d.FCANT,
d.SENIACANCE,
d.FPRECIO,
d.FMONTO
From deleted d left join ZooLogic.KITDET pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ComprobanteV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ComprobanteV
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_NOTADEDEBITO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Caja_PK =  nvl( c_NOTADEDEBITO.Caja, 0 )
					.Recargomonto = nvl( c_NOTADEDEBITO.Recargomonto, 0 )
					.Recargoporcentaje = nvl( c_NOTADEDEBITO.Recargoporcentaje, 0 )
					.Porcentajedescuento1 = nvl( c_NOTADEDEBITO.Porcentajedescuento1, 0 )
					.Cliente_PK =  nvl( c_NOTADEDEBITO.Cliente, [] )
					.Turno = nvl( c_NOTADEDEBITO.Turno, 0 )
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Montodescuentoconimpuestos = nvl( c_NOTADEDEBITO.Montodescuentoconimpuestos, 0 )
					.Ajustesporredondeos = nvl( c_NOTADEDEBITO.Ajustesporredondeos, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_NOTADEDEBITO.Montodescuentosinimpuestos3, 0 )
					.Timestamp = nvl( c_NOTADEDEBITO.Timestamp, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_NOTADEDEBITO.Montodescuentosinimpuestos2, 0 )
					.Secuencia = nvl( c_NOTADEDEBITO.Secuencia, [] )
					.Totalcantidad = nvl( c_NOTADEDEBITO.Totalcantidad, 0 )
					.Recargomonto2 = nvl( c_NOTADEDEBITO.Recargomonto2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_NOTADEDEBITO.Montodescuentosinimpuestos1, 0 )
					.Condicioniva = nvl( c_NOTADEDEBITO.Condicioniva, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_NOTADEDEBITO.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_NOTADEDEBITO.Subtotalconimpuestossobreitems, 0 )
					.Signodemovimiento = nvl( c_NOTADEDEBITO.Signodemovimiento, 0 )
					.Subtotalneto = nvl( c_NOTADEDEBITO.Subtotalneto, 0 )
					.Tipocomprobante = nvl( c_NOTADEDEBITO.Tipocomprobante, 0 )
					.Subtotalbruto = nvl( c_NOTADEDEBITO.Subtotalbruto, 0 )
					.Montodescuentosinimpuestos = nvl( c_NOTADEDEBITO.Montodescuentosinimpuestos, 0 )
					.Recargomontoconimpuestos2 = nvl( c_NOTADEDEBITO.Recargomontoconimpuestos2, 0 )
					.Recargomontosinimpuestos = nvl( c_NOTADEDEBITO.Recargomontosinimpuestos, 0 )
					.Recargomontosinimpuestos2 = nvl( c_NOTADEDEBITO.Recargomontosinimpuestos2, 0 )
					.Recargomontosinimpuestos1 = nvl( c_NOTADEDEBITO.Recargomontosinimpuestos1, 0 )
					.Recargomontoconimpuestos1 = nvl( c_NOTADEDEBITO.Recargomontoconimpuestos1, 0 )
					.Porcentajedescuento2 = nvl( c_NOTADEDEBITO.Porcentajedescuento2, 0 )
					.Recargomontoconimpuestos = nvl( c_NOTADEDEBITO.Recargomontoconimpuestos, 0 )
					.Descuentoautomatico = nvl( c_NOTADEDEBITO.Descuentoautomatico, .F. )
					.Anulado = nvl( c_NOTADEDEBITO.Anulado, .F. )
					.Nocalculapercepcion = nvl( c_NOTADEDEBITO.Nocalculapercepcion, .F. )
					.Comprobantefiscal = nvl( c_NOTADEDEBITO.Comprobantefiscal, .F. )
					.Estadotransferencia = nvl( c_NOTADEDEBITO.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_NOTADEDEBITO.Basededatosmodificacionfw, [] )
					.Versionaltafw = nvl( c_NOTADEDEBITO.Versionaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Nroopecommerce = nvl( c_NOTADEDEBITO.Nroopecommerce, [] )
					.Usuariomodificacionfw = nvl( c_NOTADEDEBITO.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_NOTADEDEBITO.Usuarioaltafw, [] )
					.Versionmodificacionfw = nvl( c_NOTADEDEBITO.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_NOTADEDEBITO.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_NOTADEDEBITO.Seriemodificacionfw, [] )
					.Horaaltafw = nvl( c_NOTADEDEBITO.Horaaltafw, [] )
					.Horaimpo = nvl( c_NOTADEDEBITO.Horaimpo, [] )
					.Horaexpo = nvl( c_NOTADEDEBITO.Horaexpo, [] )
					.Seriealtafw = nvl( c_NOTADEDEBITO.Seriealtafw, [] )
					.Basededatosaltafw = nvl( c_NOTADEDEBITO.Basededatosaltafw, [] )
					.Hora = nvl( c_NOTADEDEBITO.Hora, [] )
					.Simbolomonetariocomprobante = nvl( c_NOTADEDEBITO.Simbolomonetariocomprobante, [] )
					.Descripcionfw = nvl( c_NOTADEDEBITO.Descripcionfw, [] )
					.Codigoajuste = nvl( c_NOTADEDEBITO.Codigoajuste, [] )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Monedasistema_PK =  nvl( c_NOTADEDEBITO.Monedasistema, [] )
					.Idvuelto_PK =  nvl( c_NOTADEDEBITO.Idvuelto, [] )
					.Codigomotivodescuentoensubtotal_PK =  nvl( c_NOTADEDEBITO.Codigomotivodescuentoensubtotal, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Letra = nvl( c_NOTADEDEBITO.Letra, [] )
					.Kitsdetalle.Limpiar()
					.Kitsdetalle.SetearEsNavegacion( .lProcesando )
					.Kitsdetalle.Cargar()
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fecha, ctod( '  /  /    ' ) ) )
					.Montodescuento1 = nvl( c_NOTADEDEBITO.Montodescuento1, 0 )
					.Clientedescripcion = nvl( c_NOTADEDEBITO.Clientedescripcion, [] )
					.Montodescuento2 = nvl( c_NOTADEDEBITO.Montodescuento2, 0 )
					.Montodescuentoconimpuestos1 = nvl( c_NOTADEDEBITO.Montodescuentoconimpuestos1, 0 )
					.Montodescuentoconimpuestos2 = nvl( c_NOTADEDEBITO.Montodescuentoconimpuestos2, 0 )
					.Codigo = nvl( c_NOTADEDEBITO.Codigo, [] )
					.Vendedor_PK =  nvl( c_NOTADEDEBITO.Vendedor, [] )
					.Puntodeventa = nvl( c_NOTADEDEBITO.Puntodeventa, 0 )
					.Deuda = nvl( c_NOTADEDEBITO.Deuda, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_NOTADEDEBITO.Montodescuentoconimpuestos3, 0 )
					.Monedacomprobante_PK =  nvl( c_NOTADEDEBITO.Monedacomprobante, [] )
					.Numero = nvl( c_NOTADEDEBITO.Numero, 0 )
					.Totaldescuentosconimpuestos = nvl( c_NOTADEDEBITO.Totaldescuentosconimpuestos, 0 )
					.Totaldescuentossinimpuestos = nvl( c_NOTADEDEBITO.Totaldescuentossinimpuestos, 0 )
					.Situacionfiscal_PK =  nvl( c_NOTADEDEBITO.Situacionfiscal, 0 )
					.Listadeprecios_PK =  nvl( c_NOTADEDEBITO.Listadeprecios, [] )
					.Cuit = nvl( c_NOTADEDEBITO.Cuit, [] )
					.Cotizacion = nvl( c_NOTADEDEBITO.Cotizacion, 0 )
					.Email = nvl( c_NOTADEDEBITO.Email, [] )
					.Vuelto = nvl( c_NOTADEDEBITO.Vuelto, 0 )
					.Total = nvl( c_NOTADEDEBITO.Total, 0 )
					.Porcentajedescuento = nvl( c_NOTADEDEBITO.Porcentajedescuento, 0 )
					.Descuento = nvl( c_NOTADEDEBITO.Descuento, 0 )
					.Montodescuento3 = nvl( c_NOTADEDEBITO.Montodescuento3, 0 )
					.Percepciones = nvl( c_NOTADEDEBITO.Percepciones, 0 )
					.Recargomonto1 = nvl( c_NOTADEDEBITO.Recargomonto1, 0 )
					.Gravamenes = nvl( c_NOTADEDEBITO.Gravamenes, 0 )
					.Impuestos = nvl( c_NOTADEDEBITO.Impuestos, 0 )
					.Totalrecargos = nvl( c_NOTADEDEBITO.Totalrecargos, 0 )
					.Totalrecargossinimpuestos = nvl( c_NOTADEDEBITO.Totalrecargossinimpuestos, 0 )
					.Totalrecargosconimpuestos = nvl( c_NOTADEDEBITO.Totalrecargosconimpuestos, 0 )
					.Totaldescuentos = nvl( c_NOTADEDEBITO.Totaldescuentos, 0 )
					.Totalimpuestos = nvl( c_NOTADEDEBITO.Totalimpuestos, 0 )
					.Ivadelsistema = nvl( c_NOTADEDEBITO.Ivadelsistema, 0 )
					.Tipocpterelacionado = nvl( c_NOTADEDEBITO.Tipocpterelacionado, 0 )
					.Letracpterelacionado = nvl( c_NOTADEDEBITO.Letracpterelacionado, [] )
					.Puntodeventacpterelacionado = nvl( c_NOTADEDEBITO.Puntodeventacpterelacionado, 0 )
					.Numerocpterelacionado = nvl( c_NOTADEDEBITO.Numerocpterelacionado, 0 )
					.Fechacpterelacionado = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADEDEBITO.Fechacpterelacionado, ctod( '  /  /    ' ) ) )
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
			lxRetorno = c_NOTADEDEBITO.CODIGO
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

		loDetalle = this.oEntidad.KitsDetalle
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
				lcSentencia = "UPDATE ZooLogic.ComprobanteVDet"
				lcSentencia = lcSentencia + " Set " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "AFE_SALDO" ) ) + " = " + transform(loItem.afe_saldo) + " where " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "NroItem" ) ) +  "= " + transform( loItem.NroItem ) + " and CODIGO='" + this.oEntidad.codigo + "'"
				lcSentencia = lcSentencia + iif(  '<VENTAS>' $ this.oEntidad.ObtenerFuncionalidades(), " and " + alltrim( .ObtenerCampoDetalleFacturaDetalle( "idItemArticulos" ) ) + "= '" + alltrim( loItem.idItemArticulos ) + "'","")
				loColeccion.agregar( strtran( lcSentencia, chr( 9 ), "" ) )
			endfor
		
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.COMPAFEC
				if this.oEntidad.COMPAFEC.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxTipocomprobante = loItem.Tipocomprobante
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
						Insert into ZooLogic.CompAfe("NROITEM","Codigo","AfeTipoCom","AfeComprob","AfeLETRA","AfePTOVEN","AfeNUMCOM","afefecha","afetotal","afevend","afetipo","Afecta","DescInter","NomInter","CodInter","Origen" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<lxTipocomprobante>>, <<"'" + this.FormatearTextoSql( lxTipocompcaracter ) + "'">>, <<"'" + this.FormatearTextoSql( lxLetra ) + "'">>, <<lxPuntodeventa>>, <<lxNumero>>, <<"'" + this.ConvertirDateSql( lxFecha ) + "'">>, <<lxTotal>>, <<"'" + this.FormatearTextoSql( lxVendedor ) + "'">>, <<"'" + this.FormatearTextoSql( lxTipo ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfecta ) + "'">>, <<"'" + this.FormatearTextoSql( lxInterviniente ) + "'">>, <<"'" + this.FormatearTextoSql( lxNombreentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoentidad ) + "'">>, <<"'" + this.FormatearTextoSql( lxOrigen ) + "'">> ) 
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
		return c_NOTADEDEBITO.&lcAtributo
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
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4
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
			"Fecimpo" as "Fechaimpo", "Fd2" as "Fechamodificacion", "Fecexpo" as "Fechaexpo", "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Idcaja" as "Caja", "Mr" as "Recargomonto", "Recpor" as "Recargoporcentaje", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Mdcimpu" as "Montodescuentoconimpuestos", "Fajxre" as "Ajustesporredondeos", "Desmntosi3" as "Montodescuentosinimpuestos3", "Timestamp" as "Timestamp", "Desmntosi2" as "Montodescuentosinimpuestos2", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mr2" as "Recargomonto2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Signomov" as "Signodemovimiento", "Fsubton" as "Subtotalneto", "Facttipo" as "Tipocomprobante", "Fsubtot" as "Subtotalbruto", "Desmntosi" as "Montodescuentosinimpuestos", "Recmnto2" as "Recargomontoconimpuestos2", "Recmntosi" as "Recargomontosinimpuestos", "Recmntosi2" as "Recargomontosinimpuestos2", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmnto1" as "Recargomontoconimpuestos1", "Fpodes2" as "Porcentajedescuento2", "Recmnto" as "Recargomontoconimpuestos", "Desauto" as "Descuentoautomatico", "Anulado" as "Anulado", "Noper" as "Nocalculapercepcion", "Fcompfis" as "Comprobantefiscal", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Valtafw" as "Versionaltafw", "Zadsfw" as "Zadsfw", "Opecomm" as "Nroopecommerce", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Haltafw" as "Horaaltafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Saltafw" as "Seriealtafw", "Bdaltafw" as "Basededatosaltafw", "Fhora" as "Hora", "Simbmon" as "Simbolomonetariocomprobante", "Descfw" as "Descripcionfw", "Idajuste" as "Codigoajuste", "Monsis" as "Monedasistema", "Idvuelto" as "Idvuelto", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fletra" as "Letra", "Ffch" as "Fecha", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Md2" as "Montodescuento2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Fmtdes2" as "Montodescuentoconimpuestos2", "Codigo" as "Codigo", "Fven" as "Vendedor", "Fptoven" as "Puntodeventa", "Deuda" as "Deuda", "Fmtdes3" as "Montodescuentoconimpuestos3", "Moneda" as "Monedacomprobante", "Fnumcomp" as "Numero", "Tdci" as "Totaldescuentosconimpuestos", "Totdescsi" as "Totaldescuentossinimpuestos", "Sitfisccli" as "Situacionfiscal", "Codlista" as "Listadeprecios", "Fcuit" as "Cuit", "Cotiz" as "Cotizacion", "Email" as "Email", "Fvuelto" as "Vuelto", "Ftotal" as "Total", "Fpodes" as "Porcentajedescuento", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Mr1" as "Recargomonto1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4
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
	Filtro = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 4"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = ""
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
	<row entidad="NOTADEDEBITO                            " atributo="FECHAIMPO                               " tabla="COMPROBANTEV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHAMODIFICACION                       " tabla="COMPROBANTEV   " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHAEXPO                               " tabla="COMPROBANTEV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHATRANSFERENCIA                      " tabla="COMPROBANTEV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHAALTAFW                             " tabla="COMPROBANTEV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHAMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FACTURADETALLE                          " tabla="COMPROBANTEVDET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMARTICULOSVENTAS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VALORESDETALLE                          " tabla="VAL            " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMVALORES            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CAJA                                    " tabla="COMPROBANTEV   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTO                            " tabla="COMPROBANTEV   " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Monto recargo                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOPORCENTAJE                       " tabla="COMPROBANTEV   " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Recargo %                                                                                                                                                       " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PORCENTAJEDESCUENTO1                    " tabla="COMPROBANTEV   " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Descuento %                                                                                                                                                     " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CLIENTE                                 " tabla="COMPROBANTEV   " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Cliente                                                                                                                                                         " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TURNO                                   " tabla="COMPROBANTEV   " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                           " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="IMPUESTOSDETALLE                        " tabla="IMPUESTOSV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOS          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOCONIMPUESTOS              " tabla="COMPROBANTEV   " campo="MDCIMPU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="AJUSTESPORREDONDEOS                     " tabla="COMPROBANTEV   " campo="FAJXRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Ajustes por redondeo                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="COMPROBANTEV   " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TIMESTAMP                               " tabla="COMPROBANTEV   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="COMPROBANTEV   " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SECUENCIA                               " tabla="COMPROBANTEV   " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Secuencia                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALCANTIDAD                           " tabla="COMPROBANTEV   " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total Cantidad                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTO2                           " tabla="COMPROBANTEV   " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Monto recargo 2                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="COMPROBANTEV   " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CONDICIONIVA                            " tabla="COMPROBANTEV   " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condicion de iva                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPROBANTEV   " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALNETO                            " tabla="COMPROBANTEV   " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TIPOCOMPROBANTE                         " tabla="COMPROBANTEV   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=4                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALBRUTO                           " tabla="COMPROBANTEV   " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="COMPROBANTEV   " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PORCENTAJEDESCUENTO2                    " tabla="COMPROBANTEV   " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Descuento %                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de recargo                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="DESCUENTOAUTOMATICO                     " tabla="COMPROBANTEV   " campo="DESAUTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="ANULADO                                 " tabla="COMPROBANTEV   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                    " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="NOCALCULAPERCEPCION                     " tabla="COMPROBANTEV   " campo="NOPER     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="No calcula percepciones                                                                                                                                         " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="COMPROBANTEFISCAL                       " tabla="COMPROBANTEV   " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPROBANTEV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPROBANTEV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VERSIONALTAFW                           " tabla="COMPROBANTEV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="ZADSFW                                  " tabla="COMPROBANTEV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="NROOPECOMMERCE                          " tabla="COMPROBANTEV   " campo="OPECOMM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="USUARIOALTAFW                           " tabla="COMPROBANTEV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="HORAMODIFICACIONFW                      " tabla="COMPROBANTEV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SERIEMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="HORAALTAFW                              " tabla="COMPROBANTEV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="HORAIMPO                                " tabla="COMPROBANTEV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="HORAEXPO                                " tabla="COMPROBANTEV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SERIEALTAFW                             " tabla="COMPROBANTEV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="BASEDEDATOSALTAFW                       " tabla="COMPROBANTEV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="HORA                                    " tabla="COMPROBANTEV   " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="COMPROBANTEV   " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="DESCRIPCIONFW                           " tabla="COMPROBANTEV   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CODIGOAJUSTE                            " tabla="COMPROBANTEV   " campo="IDAJUSTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo de Ajuste                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPVENTAS      " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="DETALLEITEMIMPUESTOVENTAS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONEDASISTEMA                           " tabla="COMPROBANTEV   " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="IDVUELTO                                " tabla="COMPROBANTEV   " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CODIGOMOTIVODESCUENTOENSUBTOTAL         " tabla="COMPROBANTEV   " campo="MOTDESCDEV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVODESCUENTOYDEVOLUCION              " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="OBS                                     " tabla="COMPROBANTEV   " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="                                                                                                                                                                " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="LETRA                                   " tabla="COMPROBANTEV   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra                                                                                                                                                           " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="KITSDETALLE                             " tabla="KITDET         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Detalle de Kits                                                                                                                                                 " dominio="DETALLEITEMKITS               " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHA                                   " tabla="COMPROBANTEV   " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.Librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="8" etiqueta="Fecha                                                                                                                                                           " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTO1                         " tabla="COMPROBANTEV   " campo="MD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Monto descuento 1                                                                                                                                               " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CLIENTEDESCRIPCION                      " tabla="COMPROBANTEV   " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="                                                                                                                                                                " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTO2                         " tabla="COMPROBANTEV   " campo="MD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="426" etiqueta="Descuentos en valores                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="COMPROBANTEV   " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="COMPROBANTEV   " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento %                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CODIGO                                  " tabla="COMPROBANTEV   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="198" etiqueta="Nro Interno                                                                                                                                                     " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VENDEDOR                                " tabla="COMPROBANTEV   " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Vendedor                                                                                                                                                        " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PUNTODEVENTA                            " tabla="COMPROBANTEV   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. Venta                                                                                                                                                      " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="9999                     " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="DEUDA                                   " tabla="COMPROBANTEV   " campo="DEUDA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Saldo de cta. cte.                                                                                                                                              " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="COMPROBANTEV   " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto de descuento.                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONEDACOMPROBANTE                       " tabla="COMPROBANTEV   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Moneda                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="NUMERO                                  " tabla="COMPROBANTEV   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="NUMEROPTOVTAEDITABLE          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALDESCUENTOSCONIMPUESTOS             " tabla="COMPROBANTEV   " campo="TDCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="COMPROBANTEV   " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SITUACIONFISCAL                         " tabla="COMPROBANTEV   " campo="SITFISCCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="=3                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Sit.Fis                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="LISTADEPRECIOS                          " tabla="COMPROBANTEV   " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferente                                                                                                                                                                                         " obligatorio="true" admitebusqueda="434" etiqueta="Lista de Precio                                                                                                                                                 " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="CUIT                                    " tabla="COMPROBANTEV   " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Sit.Fis                                                                                                                                                         " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="COTIZACION                              " tabla="COMPROBANTEV   " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="436" etiqueta="Cotización                                                                                                                                                      " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="EMAIL                                   " tabla="COMPROBANTEV   " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Email                                                                                                                                                           " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VUELTOVIRTUAL                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Vuelto                                                                                                                                                          " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="VUELTO                                  " tabla="COMPROBANTEV   " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto persistido                                                                                                                                               " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTAL                                   " tabla="COMPROBANTEV   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="10" etiqueta="Total                                                                                                                                                           " dominio="TOTALPESOS                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PORCENTAJEDESCUENTO                     " tabla="COMPROBANTEV   " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Des%                                                                                                                                                            " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="DESCUENTO                               " tabla="COMPROBANTEV   " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Des%                                                                                                                                                            " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTO3                         " tabla="COMPROBANTEV   " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Monto descuento 3                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PERCEPCIONES                            " tabla="COMPROBANTEV   " campo="PERCEPCION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepciones                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTO1                           " tabla="COMPROBANTEV   " campo="MR1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Monto recargo 1                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="MONTODESCUENTO2VISUAL                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Descuentos en valores                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="RECARGOMONTO1VISUAL                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Monto de recargo valores                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="GRAVAMENES                              " tabla="COMPROBANTEV   " campo="GRAVAMEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Interno                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALSINIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal sin imp                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="IMPUESTOS                               " tabla="COMPROBANTEV   " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="I.V.A.                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="SUBTOTALCONIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal con imp                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALRECARGOS                           " tabla="COMPROBANTEV   " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="COMPROBANTEV   " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALRECARGOSCONIMPUESTOS               " tabla="COMPROBANTEV   " campo="TRCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALDESCUENTOS                         " tabla="COMPROBANTEV   " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="28" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TOTALIMPUESTOS                          " tabla="COMPROBANTEV   " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Impuestos                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="26" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="IVADELSISTEMA                           " tabla="COMPROBANTEV   " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="TIPOCPTERELACIONADO                     " tabla="COMPROBANTEV   " campo="TIPOCRELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Tipo comprobante asociado                                                                                                                                       " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="LETRACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="LETRARELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Comprobante asociado                                                                                                                                            " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="91" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="PUNTODEVENTACPTERELACIONADO             " tabla="COMPROBANTEV   " campo="PUNTORELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Pto. de venta comprobante asociado                                                                                                                              " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="92" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="NUMEROCPTERELACIONADO                   " tabla="COMPROBANTEV   " campo="NUMERORELA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Número comprobante asociado                                                                                                                                     " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="93" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADEDEBITO                            " atributo="FECHACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="FECCRELA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="466" etiqueta="Fecha comprobante asociado                                                                                                                                      " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="94" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="411" etiqueta="Detalle Cli.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Ven.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPROBANTEV.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Mon.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COMPROBANTEV.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Lis.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMPROBANTEV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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