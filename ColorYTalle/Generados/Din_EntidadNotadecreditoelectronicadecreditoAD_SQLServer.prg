
define class Din_EntidadNOTADECREDITOELECTRONICADECREDITOAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_NOTADECREDITOELECTRONICADECREDITO'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Secuencia]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0) + #tabla#.FACTSEC]
	cTagClaveCandidata = '_CEMCC'
	cTagClavePk = '_CEMPK'
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
			local  lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFectrans, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevDatosecomm, lxComprobantevIdcaja, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevOpecomm, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevIdajuste, lxComprobantevEsttrans, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevFhora, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevZadsfw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevSaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevBdmodifw, lxComprobantevTimestamp, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMdcimpu, lxComprobantevSitfisccli, lxComprobantevRecmntosi, lxComprobantevFsubton, lxComprobantevFpodes2, lxComprobantevFsubtot, lxComprobantevSignomov, lxComprobantevFacttipo, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevFajxre, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevAnulado, lxComprobantevOrigonline, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevFmtdes1, lxComprobantevCodigo, lxComprobantevDesmntosi3, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevCodlista, lxComprobantevEmail, lxComprobantevVtosenia, lxComprobantevFptoven, lxComprobantevTrci, lxComprobantevTotrecarsi, lxComprobantevFvuelto, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevFfch, lxComprobantevCotiz, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevEntregapos, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevMerconsign, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela, lxComprobantevDeuda
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFhora =  .Hora			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevOrigonline =  .Basadoencomprobanteonline			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevCodigo =  .Codigo			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevEmail =  .Email			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevFfch =  .Fecha			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado			lxComprobantevDeuda =  .Deuda
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
				insert into ZooLogic.COMPROBANTEV ( "Fd2","Informnube","Fectrans","Fecimpo","Fmodifw","Fecexpo","Datosecomm","Idcaja","Fpodes1","Fperson","Fturno","Opecomm","Faltafw","Haltafw","Idajuste","Esttrans","Descfw","Simbmon","Fhora","Umodifw","Bdaltafw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaimpo","Horaexpo","Bdmodifw","Timestamp","Factsec","Totalcant","Mdcimpu","Sitfisccli","Recmntosi","Fsubton","Fpodes2","Fsubtot","Signomov","Facttipo","Condivalp","Subtotsisi","Subtotcisi","Recmntosi1","Recmntosi2","Fajxre","Desmntosi2","Desmntosi1","Desmntosi","Fcompfis","Desaut","Anulado","Origonline","Idvuelto","Monsis","Motdescdev","Fobs","Fcuit","Md1","Fcliente","Idsenia","Fmtdes2","Fmtdes1","Codigo","Desmntosi3","Receptor","Fven","Totdescsi","Tdci","Moneda","Fletra","Codlista","Email","Vtosenia","Fptoven","Trci","Totrecarsi","Fvuelto","Fnumcomp","Ftotal","Ffch","Cotiz","Fmtdes3","Fpodes","Recmnto2","Entregapos","Fdescu","Md3","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecar","Totdesc","Totimpue","Merconsign","Cancelar","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela","Deuda" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<lxComprobantevTimestamp >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevFsubton >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevFsubtot >>, <<lxComprobantevSignomov >>, <<lxComprobantevFacttipo >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevFajxre >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevOrigonline, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<lxComprobantevFmtdes2 >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<lxComprobantevDesmntosi3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevFptoven >>, <<lxComprobantevTrci >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFtotal >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevCotiz >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevEntregapos >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >>, <<lxComprobantevDeuda >> )
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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxIdkit = loItem.Idkit
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
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
					lxIdorigen = loItem.Idorigen
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxIditem = loItem.Iditem
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","codgtin","FART","FUnid","IDKIT","CodAutDJCP","IdItem","afe_cod","MNTPTOT","MNTPPER","AfeTS","MNTPDESCI","ConRestr","MNTPRECCI","MNPDSI","AjuCImp","FBruto","tasaimpint","AjuSImp","PRECIOSR","impinterno","PRECIOCISR","MNTPDESSI","MNDESSI","MNDESCI","MNTPRECSI","PRECIOSISR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","iditemOrig","AfeNroItem","prunconimp","AfeCANT","ciditem","Prunsinimp","COMP","FPRUN","AfeTipoCom","FN11","UsarPLista","ProcStock","ArtSinDes","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","MNTPIVA","MNTPINT","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxTasaimpuestointerno>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxMontoimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxIdorigen>>, <<lxAfe_nroitem>>, <<lxPrecioconimpuestos>>, <<lxAfe_cantidad>>, <<lxIditem>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxAfe_tipocomprobante>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxAfe_saldo = loItem.Afe_saldo
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
					lxComportamiento = loItem.Comportamiento
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxIdorigen = loItem.Idorigen
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
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
						Insert into ZooLogic.KITDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","FUnid","CodAutDJCP","IDKIT","IdItem","afe_cod","MNTPPER","MNTPTOT","MNTPDESCI","AfeTS","ConRestr","MNTPRECCI","MNPDSI","MNTPRECSI","AjuSImp","AjuCImp","impinterno","tasaimpint","FBruto","PRECIOSR","MNDESCI","PRECIOSISR","MNDESSI","MNTPDESSI","PRECIOCISR","AfeSaldo","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","COMP","AfeCANT","AfeTipoCom","ACondIvaV","AfeNroItem","APorcIvaV","iditemOrig","prunconimp","Prunsinimp","ciditem","FN11","FPRUN","ArtSinDes","ProcStock","UsarPLista","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_timestamp>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxTasaimpuestointerno>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPrecioconimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxAfe_cantidad>>, <<lxAfe_tipocomprobante>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxArticulo_porcentajeivaventas>>, <<lxIdorigen>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
			local  lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFectrans, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevDatosecomm, lxComprobantevIdcaja, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevOpecomm, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevIdajuste, lxComprobantevEsttrans, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevFhora, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevZadsfw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevSaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevBdmodifw, lxComprobantevTimestamp, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMdcimpu, lxComprobantevSitfisccli, lxComprobantevRecmntosi, lxComprobantevFsubton, lxComprobantevFpodes2, lxComprobantevFsubtot, lxComprobantevSignomov, lxComprobantevFacttipo, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevFajxre, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevAnulado, lxComprobantevOrigonline, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevFmtdes1, lxComprobantevCodigo, lxComprobantevDesmntosi3, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevCodlista, lxComprobantevEmail, lxComprobantevVtosenia, lxComprobantevFptoven, lxComprobantevTrci, lxComprobantevTotrecarsi, lxComprobantevFvuelto, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevFfch, lxComprobantevCotiz, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevEntregapos, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevMerconsign, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela, lxComprobantevDeuda
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFhora =  .Hora			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevOrigonline =  .Basadoencomprobanteonline			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevCodigo =  .Codigo			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevEmail =  .Email			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevFfch =  .Fecha			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado			lxComprobantevDeuda =  .Deuda
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
				update ZooLogic.COMPROBANTEV set "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>,"Informnube" = <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>,"Datosecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'">>,"Idcaja" = <<lxComprobantevIdcaja>>,"Fpodes1" = <<lxComprobantevFpodes1>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>,"Fturno" = <<lxComprobantevFturno>>,"Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>,"Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>,"Timestamp" = <<lxComprobantevTimestamp>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>,"Totalcant" = <<lxComprobantevTotalcant>>,"Mdcimpu" = <<lxComprobantevMdcimpu>>,"Sitfisccli" = <<lxComprobantevSitfisccli>>,"Recmntosi" = <<lxComprobantevRecmntosi>>,"Fsubton" = <<lxComprobantevFsubton>>,"Fpodes2" = <<lxComprobantevFpodes2>>,"Fsubtot" = <<lxComprobantevFsubtot>>,"Signomov" = <<lxComprobantevSignomov>>,"Facttipo" = <<lxComprobantevFacttipo>>,"Condivalp" = <<lxComprobantevCondivalp>>,"Subtotsisi" = <<lxComprobantevSubtotsisi>>,"Subtotcisi" = <<lxComprobantevSubtotcisi>>,"Recmntosi1" = <<lxComprobantevRecmntosi1>>,"Recmntosi2" = <<lxComprobantevRecmntosi2>>,"Fajxre" = <<lxComprobantevFajxre>>,"Desmntosi2" = <<lxComprobantevDesmntosi2>>,"Desmntosi1" = <<lxComprobantevDesmntosi1>>,"Desmntosi" = <<lxComprobantevDesmntosi>>,"Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>,"Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>,"Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>,"Origonline" = <<iif( lxComprobantevOrigonline, 1, 0 )>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>,"Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>,"Md1" = <<lxComprobantevMd1>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>,"Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>,"Fmtdes2" = <<lxComprobantevFmtdes2>>,"Fmtdes1" = <<lxComprobantevFmtdes1>>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>,"Desmntosi3" = <<lxComprobantevDesmntosi3>>,"Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>,"Totdescsi" = <<lxComprobantevTotdescsi>>,"Tdci" = <<lxComprobantevTdci>>,"Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>,"Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>,"Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>,"Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>,"Fptoven" = <<lxComprobantevFptoven>>,"Trci" = <<lxComprobantevTrci>>,"Totrecarsi" = <<lxComprobantevTotrecarsi>>,"Fvuelto" = <<lxComprobantevFvuelto>>,"Fnumcomp" = <<lxComprobantevFnumcomp>>,"Ftotal" = <<lxComprobantevFtotal>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>,"Cotiz" = <<lxComprobantevCotiz>>,"Fmtdes3" = <<lxComprobantevFmtdes3>>,"Fpodes" = <<lxComprobantevFpodes>>,"Recmnto2" = <<lxComprobantevRecmnto2>>,"Entregapos" = <<lxComprobantevEntregapos>>,"Fdescu" = <<lxComprobantevFdescu>>,"Md3" = <<lxComprobantevMd3>>,"Percepcion" = <<lxComprobantevPercepcion>>,"Recmnto" = <<lxComprobantevRecmnto>>,"Recpor" = <<lxComprobantevRecpor>>,"Mr" = <<lxComprobantevMr>>,"Mr2" = <<lxComprobantevMr2>>,"Md2" = <<lxComprobantevMd2>>,"Mr1" = <<lxComprobantevMr1>>,"Recmnto1" = <<lxComprobantevRecmnto1>>,"Gravamen" = <<lxComprobantevGravamen>>,"Fimpuesto" = <<lxComprobantevFimpuesto>>,"Totrecar" = <<lxComprobantevTotrecar>>,"Totdesc" = <<lxComprobantevTotdesc>>,"Totimpue" = <<lxComprobantevTotimpue>>,"Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>,"Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>,"Ivasis" = <<lxComprobantevIvasis>>,"Tipocrela" = <<lxComprobantevTipocrela>>,"Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>,"Puntorela" = <<lxComprobantevPuntorela>>,"Numerorela" = <<lxComprobantevNumerorela>>,"Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">>,"Deuda" = <<lxComprobantevDeuda>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KITDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxIdkit = loItem.Idkit
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
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
					lxIdorigen = loItem.Idorigen
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxIditem = loItem.Iditem
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","codgtin","FART","FUnid","IDKIT","CodAutDJCP","IdItem","afe_cod","MNTPTOT","MNTPPER","AfeTS","MNTPDESCI","ConRestr","MNTPRECCI","MNPDSI","AjuCImp","FBruto","tasaimpint","AjuSImp","PRECIOSR","impinterno","PRECIOCISR","MNTPDESSI","MNDESSI","MNDESCI","MNTPRECSI","PRECIOSISR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","iditemOrig","AfeNroItem","prunconimp","AfeCANT","ciditem","Prunsinimp","COMP","FPRUN","AfeTipoCom","FN11","UsarPLista","ProcStock","ArtSinDes","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","MNTPIVA","MNTPINT","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxTasaimpuestointerno>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxMontoimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxIdorigen>>, <<lxAfe_nroitem>>, <<lxPrecioconimpuestos>>, <<lxAfe_cantidad>>, <<lxIditem>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxAfe_tipocomprobante>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxAfe_saldo = loItem.Afe_saldo
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
					lxComportamiento = loItem.Comportamiento
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxIdorigen = loItem.Idorigen
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
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
						Insert into ZooLogic.KITDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","FUnid","CodAutDJCP","IDKIT","IdItem","afe_cod","MNTPPER","MNTPTOT","MNTPDESCI","AfeTS","ConRestr","MNTPRECCI","MNPDSI","MNTPRECSI","AjuSImp","AjuCImp","impinterno","tasaimpint","FBruto","PRECIOSR","MNDESCI","PRECIOSISR","MNDESSI","MNTPDESSI","PRECIOCISR","AfeSaldo","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","COMP","AfeCANT","AfeTipoCom","ACondIvaV","AfeNroItem","APorcIvaV","iditemOrig","prunconimp","Prunsinimp","ciditem","FN11","FPRUN","ArtSinDes","ProcStock","UsarPLista","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_timestamp>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxTasaimpuestointerno>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPrecioconimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxAfe_cantidad>>, <<lxAfe_tipocomprobante>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxArticulo_porcentajeivaventas>>, <<lxIdorigen>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPROBANTEV where " + this.ConvertirFuncionesSql( " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55" ) )
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
				select "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )

			if reccount( 'c_NOTADECREDITOELECTRONICADECREDITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
			Local lxCOMPROBANTEVFACTTIPO As Variant, lxCOMPROBANTEVFLETRA As Variant, lxCOMPROBANTEVFPTOVEN As Variant, lxCOMPROBANTEVFNUMCOMP As Variant, lxCOMPROBANTEVFACTSEC As Variant
			lxCOMPROBANTEVFACTTIPO = .TipoComprobante
			lxCOMPROBANTEVFLETRA = .Letra
			lxCOMPROBANTEVFPTOVEN = .PuntoDeVenta
			lxCOMPROBANTEVFNUMCOMP = .Numero
			lxCOMPROBANTEVFACTSEC = .Secuencia
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 And FACTTIPO = <<lxCOMPROBANTEVFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFLETRA ) + "'">> and FPTOVEN = <<lxCOMPROBANTEVFPTOVEN>> and FNUMCOMP = <<lxCOMPROBANTEVFNUMCOMP>> and FACTSEC = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFACTSEC ) + "'">>
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )
			if reccount( 'c_NOTADECREDITOELECTRONICADECREDITO' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55
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
				select top 1 "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP,FACTSEC
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( FACTSEC, 2, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 order by FACTTIPO,FLETRA,FPTOVEN,FNUMCOMP,FACTSEC
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where  str( FACTTIPO, 2, 0) + funciones.padr( FLETRA, 1, ' ' ) + str( FPTOVEN, 4, 0) + str( FNUMCOMP, 8, 0) + funciones.padr( FACTSEC, 2, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc,FACTSEC desc
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
				select top 1 "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 order by FACTTIPO desc,FLETRA desc,FPTOVEN desc,FNUMCOMP desc,FACTSEC desc
			endtext
			use in select('c_NOTADECREDITOELECTRONICADECREDITO')
			this.oConexion.EjecutarSql( lcSentencia, 'c_NOTADECREDITOELECTRONICADECREDITO', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Funid" as "Unidad", "Afe_cod" as "Afe_codigo", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Idkit" as "Idkit", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Conrestr" as "Tienerestriccion", "Mntptot" as "Montoprorrateototal", "Tasaimpint" as "Tasaimpuestointerno", "Afets" as "Afe_timestamp", "Mntpper" as "Montoprorrateopercepciones", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Preciocisr" as "Precioconimpuestossinredondear", "Fbruto" as "Bruto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciosr" as "Preciosinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Afetipocom" as "Afe_tipocomprobante", "Afenroitem" as "Afe_nroitem", "Afecant" as "Afe_cantidad", "Prunconimp" as "Precioconimpuestos", "Impinterno" as "Montoimpuestointerno", "Iditemorig" as "Idorigen", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Fart" as "Articulo", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Jjven" as "Vendedor", "Tipodoc" as "Tipodocumento", "Tipcomp" as "Tipodecomprobante", "Nrotarjeta" as "Numerotarjeta", "Iditem" as "Iditemvalores", "Letra" as "Letra", "Idretiroef" as "Iditemretiroenefectivo", "Nrodoc" as "Nrodocumento", "Redondeo" as "Redondeo", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Descsinimp" as "Descuentomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Monrecpes" as "Recargomontoenpesos", "Ptoventa" as "Puntodeventa", "Signo" as "Signo", "Pesos" as "Pesosalcambio", "Nrocupon" as "Numerocupon", "Numcompr" as "Numerodecomprobante", "Jjcotiz" as "Cotiza", "Nroitem" as "Nroitem", "Jjturno" as "Turno", "Jjt" as "Tipo", "Recsinimp" as "Recargomontosinimpuestos", "Cotiza" as "Ultimacotizacion", "Visualcaja" as "Visualizarenestadodecaja", "Perscomp" as "Personalizarcomprobante", "Celectro" as "Chequeelectronico", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Autorizado" as "Autorizacionpos", "Condpago" as "Condiciondepago", "Jjnum" as "Codigo", "Nrocheque" as "Numerocheque", "Nrochprop" as "Numerochequepropio", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Porcdesrec" as "Porcentajedesrec", "Recporc" as "Recargoporcentaje", "Mondesrec" as "Montodesrec", "Recsinper" as "Recargosinpercepciones", "Recmonto" as "Recargomonto", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Permvuelto" as "Permitevuelto", "Valecambio" as "Numerovaledecambio", "Cupon" as "Cupon" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afetipocom" as "Tipocomprobante", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Base" as "Basedecalculo", "Codimp" as "Codigoimpuesto", "Codint" as "Codigointerno", "Tipoi" as "Tipoimpuesto", "Sirecs" as "Codseguridadsire", "Descri" as "Descripcion", "Regimenimp" as "Regimenimpositivo", "Sirecert" as "Certificadosire", "Minimoper" as "Minimo", "Minoimp" as "Minimonoimponible", "Montobase" as "Montobase", "Nroitem" as "Nroitem", "Porcen" as "Porcentaje", "Monto" as "Monto", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_NOTADECREDITOELECTRONICADECREDITO.CODIGO ) + "'">> Order by NroItem
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
			lcXml = this.oConexion.EjecutarSql( "select Fd2,Informnube,Fectrans,Fecimpo,Fmodifw,Fecexpo,Datosecomm,Idcaja,Fpodes1,Fperson,Fturno,Ope" + ;
"comm,Faltafw,Haltafw,Idajuste,Esttrans,Descfw,Simbmon,Fhora,Umodifw,Bdaltafw,Zadsfw,Valtafw,Vmodifw," + ;
"Ualtafw,Hmodifw,Smodifw,Saltafw,Horaimpo,Horaexpo,Bdmodifw,Timestamp,Factsec,Totalcant,Mdcimpu,Sitfi" + ;
"sccli,Recmntosi,Fsubton,Fpodes2,Fsubtot,Signomov,Facttipo,Condivalp,Subtotsisi,Subtotcisi,Recmntosi1" + ;
",Recmntosi2,Fajxre,Desmntosi2,Desmntosi1,Desmntosi,Fcompfis,Desaut,Anulado,Origonline,Idvuelto,Monsi" + ;
"s,Motdescdev,Fobs,Fcuit,Md1,Fcliente,Idsenia,Fmtdes2,Fmtdes1,Codigo,Desmntosi3,Receptor,Fven,Totdesc" + ;
"si,Tdci,Moneda,Fletra,Codlista,Email,Vtosenia,Fptoven,Trci,Totrecarsi,Fvuelto,Fnumcomp,Ftotal,Ffch,C" + ;
"otiz,Fmtdes3,Fpodes,Recmnto2,Entregapos,Fdescu,Md3,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1" + ;
",Gravamen,Fimpuesto,Totrecar,Totdesc,Totimpue,Merconsign,Cancelar,Ivasis,Tipocrela,Letrarela,Puntore" + ;
"la,Numerorela,Feccrela,Deuda" + ;
" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55 and " + lcFiltro )
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
			local  lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFectrans, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevDatosecomm, lxComprobantevIdcaja, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevOpecomm, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevIdajuste, lxComprobantevEsttrans, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevFhora, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevZadsfw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevSaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevBdmodifw, lxComprobantevTimestamp, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMdcimpu, lxComprobantevSitfisccli, lxComprobantevRecmntosi, lxComprobantevFsubton, lxComprobantevFpodes2, lxComprobantevFsubtot, lxComprobantevSignomov, lxComprobantevFacttipo, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevFajxre, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevAnulado, lxComprobantevOrigonline, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevFmtdes1, lxComprobantevCodigo, lxComprobantevDesmntosi3, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevCodlista, lxComprobantevEmail, lxComprobantevVtosenia, lxComprobantevFptoven, lxComprobantevTrci, lxComprobantevTotrecarsi, lxComprobantevFvuelto, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevFfch, lxComprobantevCotiz, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevEntregapos, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevMerconsign, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela, lxComprobantevDeuda
				lxComprobantevFd2 = ctod( '  /  /    ' )			lxComprobantevInformnube = ctod( '  /  /    ' )			lxComprobantevFectrans = ctod( '  /  /    ' )			lxComprobantevFecimpo = ctod( '  /  /    ' )			lxComprobantevFmodifw = ctod( '  /  /    ' )			lxComprobantevFecexpo = ctod( '  /  /    ' )			lxComprobantevDatosecomm = []			lxComprobantevIdcaja = 0			lxComprobantevFpodes1 = 0			lxComprobantevFperson = []			lxComprobantevFturno = 0			lxComprobantevOpecomm = []			lxComprobantevFaltafw = ctod( '  /  /    ' )			lxComprobantevHaltafw = []			lxComprobantevIdajuste = []			lxComprobantevEsttrans = []			lxComprobantevDescfw = []			lxComprobantevSimbmon = []			lxComprobantevFhora = []			lxComprobantevUmodifw = []			lxComprobantevBdaltafw = []			lxComprobantevZadsfw = []			lxComprobantevValtafw = []			lxComprobantevVmodifw = []			lxComprobantevUaltafw = []			lxComprobantevHmodifw = []			lxComprobantevSmodifw = []			lxComprobantevSaltafw = []			lxComprobantevHoraimpo = []			lxComprobantevHoraexpo = []			lxComprobantevBdmodifw = []			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevFactsec = []			lxComprobantevTotalcant = 0			lxComprobantevMdcimpu = 0			lxComprobantevSitfisccli = 0			lxComprobantevRecmntosi = 0			lxComprobantevFsubton = 0			lxComprobantevFpodes2 = 0			lxComprobantevFsubtot = 0			lxComprobantevSignomov = 0			lxComprobantevFacttipo = 0			lxComprobantevCondivalp = 0			lxComprobantevSubtotsisi = 0			lxComprobantevSubtotcisi = 0			lxComprobantevRecmntosi1 = 0			lxComprobantevRecmntosi2 = 0			lxComprobantevFajxre = 0			lxComprobantevDesmntosi2 = 0			lxComprobantevDesmntosi1 = 0			lxComprobantevDesmntosi = 0			lxComprobantevFcompfis = .F.			lxComprobantevDesaut = .F.			lxComprobantevAnulado = .F.			lxComprobantevOrigonline = .F.			lxComprobantevIdvuelto = []			lxComprobantevMonsis = []			lxComprobantevMotdescdev = []			lxComprobantevFobs = []			lxComprobantevFcuit = []			lxComprobantevMd1 = 0			lxComprobantevFcliente = []			lxComprobantevIdsenia = []			lxComprobantevFmtdes2 = 0			lxComprobantevFmtdes1 = 0			lxComprobantevCodigo = []			lxComprobantevDesmntosi3 = 0			lxComprobantevReceptor = []			lxComprobantevFven = []			lxComprobantevTotdescsi = 0			lxComprobantevTdci = 0			lxComprobantevMoneda = []			lxComprobantevFletra = []			lxComprobantevCodlista = []			lxComprobantevEmail = []			lxComprobantevVtosenia = ctod( '  /  /    ' )			lxComprobantevFptoven = 0			lxComprobantevTrci = 0			lxComprobantevTotrecarsi = 0			lxComprobantevFvuelto = 0			lxComprobantevFnumcomp = 0			lxComprobantevFtotal = 0			lxComprobantevFfch = ctod( '  /  /    ' )			lxComprobantevCotiz = 0			lxComprobantevFmtdes3 = 0			lxComprobantevFpodes = 0			lxComprobantevRecmnto2 = 0			lxComprobantevEntregapos = 0			lxComprobantevFdescu = 0			lxComprobantevMd3 = 0			lxComprobantevPercepcion = 0			lxComprobantevRecmnto = 0			lxComprobantevRecpor = 0			lxComprobantevMr = 0			lxComprobantevMr2 = 0			lxComprobantevMd2 = 0			lxComprobantevMr1 = 0			lxComprobantevRecmnto1 = 0			lxComprobantevGravamen = 0			lxComprobantevFimpuesto = 0			lxComprobantevTotrecar = 0			lxComprobantevTotdesc = 0			lxComprobantevTotimpue = 0			lxComprobantevMerconsign = .F.			lxComprobantevCancelar = .F.			lxComprobantevIvasis = 0			lxComprobantevTipocrela = 0			lxComprobantevLetrarela = []			lxComprobantevPuntorela = 0			lxComprobantevNumerorela = 0			lxComprobantevFeccrela = ctod( '  /  /    ' )			lxComprobantevDeuda = 0
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
		lcWhere = " Where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda"
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
					"Afenumcom" as "Afe_numero", "Afeletra" as "Afe_letra", "Afeptoven" as "Afe_puntodeventa", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Idkit" as "Idkit", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntptot" as "Montoprorrateototal", "Mntpper" as "Montoprorrateopercepciones", "Afets" as "Afe_timestamp", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Tasaimpint" as "Tasaimpuestointerno", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Impinterno" as "Montoimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Acondivav" as "Articulo_condicionivaventas", "Iditemorig" as "Idorigen", "Afenroitem" as "Afe_nroitem", "Prunconimp" as "Precioconimpuestos", "Afecant" as "Afe_cantidad", "Ciditem" as "Iditem", "Prunsinimp" as "Preciosinimpuestos", "Comp" as "Comportamiento", "Fprun" as "Preciounitario", "Afetipocom" as "Afe_tipocomprobante", "Fn11" as "Tipolistadeprecio", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Artsindes" as "Restringirdescuentos", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
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
	Function ObtenerDatosDetalleKitsDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  KITDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Funid" as "Unidad", "Codautdjcp" as "Codigoautorizaciondjcp", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Mntpper" as "Montoprorrateopercepciones", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Afets" as "Afe_timestamp", "Conrestr" as "Tienerestriccion", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Impinterno" as "Montoimpuestointerno", "Tasaimpint" as "Tasaimpuestointerno", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Preciosisr" as "Preciosinimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Preciocisr" as "Precioconimpuestossinredondear", "Afesaldo" as "Afe_saldo", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fporcfi" as "Porcentajecfi", "Fmtocfi" as "Montocfi", "Afe_sliq" as "Afe_saldoliquidacion", "Artpercep" as "Percepcionivarg5329", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fpordto1" as "Porcentajedto1", "Fporiva" as "Porcentajeiva", "Comp" as "Comportamiento", "Afecant" as "Afe_cantidad", "Afetipocom" as "Afe_tipocomprobante", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Aporcivav" as "Articulo_porcentajeivaventas", "Iditemorig" as "Idorigen", "Prunconimp" as "Precioconimpuestos", "Prunsinimp" as "Preciosinimpuestos", "Ciditem" as "Iditem", "Fn11" as "Tipolistadeprecio", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Giftcard" as "Numerogiftcard", "Codigo" as "Codigo", "Motdescu" as "Codigomotivodescuento", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Ccolor" as "Color", "Seniacance" as "Idseniacancelada", "Mntpint" as "Montoprorrateoimpuestointerno", "Mntpiva" as "Montoprorrateoiva", "Fcoltxt" as "Colordetalle", "Ftatxt" as "Talledetalle", "Talle" as "Talle", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Fmonto" as "Monto"
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
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FUEINFORMADOALANUBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INFORMNUBE AS FUEINFORMADOALANUBE'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'DATAECOM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DATOSECOMM AS DATAECOM'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'NROOPECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPECOMM AS NROOPECOMMERCE'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'CODIGOAJUSTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDAJUSTE AS CODIGOAJUSTE'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDCIMPU AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCCLI AS SITUACIONFISCAL'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'AJUSTESPORREDONDEOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAJXRE AS AJUSTESPORREDONDEOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUT AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'BASADOENCOMPROBANTEONLINE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORIGONLINE AS BASADOENCOMPROBANTEONLINE'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCDEV AS CODIGOMOTIVODESCUENTOENSUBTOTAL'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'MONTODESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD1 AS MONTODESCUENTO1'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
				Case lcAtributo == 'IDSENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSENIA AS IDSENIA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES1 AS MONTODESCUENTOCONIMPUESTOS1'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'RECEPTOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECEPTOR AS RECEPTOR'
				Case lcAtributo == 'VENDEDOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVEN AS VENDEDOR'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCI AS TOTALDESCUENTOSCONIMPUESTOS'
				Case lcAtributo == 'MONEDACOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONEDA AS MONEDACOMPROBANTE'
				Case lcAtributo == 'LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FLETRA AS LETRA'
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS EMAIL'
				Case lcAtributo == 'FECHAVTOSENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VTOSENIA AS FECHAVTOSENIA'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'TOTALRECARGOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TRCI AS TOTALRECARGOSCONIMPUESTOS'
				Case lcAtributo == 'TOTALRECARGOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARSI AS TOTALRECARGOSSINIMPUESTOS'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'ENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPOS AS ENTREGAPOSTERIOR'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MONTODESCUENTO3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD3 AS MONTODESCUENTO3'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECAR AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
				Case lcAtributo == 'MERCADERIACONSIGNACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MERCONSIGN AS MERCADERIACONSIGNACION'
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
				Case lcAtributo == 'DEUDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEUDA AS DEUDA'
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
				Case lcAtributo == 'AFE_LETRA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFELETRA AS AFE_LETRA'
				Case lcAtributo == 'AFE_PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFEPTOVEN AS AFE_PUNTODEVENTA'
				Case lcAtributo == 'CODIGOGTIN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODGTIN AS CODIGOGTIN'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FART AS ARTICULO'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'CODIGOAUTORIZACIONDJCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODAUTDJCP AS CODIGOAUTORIZACIONDJCP'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'TIENERESTRICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRESTR AS TIENERESTRICCION'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
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
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
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
				Case lcAtributo == 'MONTOPRORRATEOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPIVA AS MONTOPRORRATEOIVA'
				Case lcAtributo == 'MONTOPRORRATEOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPINT AS MONTOPRORRATEOIMPUESTOINTERNO'
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
	Function ObtenerCamposSelectDetalleKitsDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'CODIGOAUTORIZACIONDJCP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODAUTDJCP AS CODIGOAUTORIZACIONDJCP'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'MONTOPRORRATEOPERCEPCIONES'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPPER AS MONTOPRORRATEOPERCEPCIONES'
				Case lcAtributo == 'MONTOPRORRATEOTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPTOT AS MONTOPRORRATEOTOTAL'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESCI AS MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'AFE_TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETS AS AFE_TIMESTAMP'
				Case lcAtributo == 'TIENERESTRICCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONRESTR AS TIENERESTRICCION'
				Case lcAtributo == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECCI AS MONTOPRORRATEORECARGOCONIMPUESTOS'
				Case lcAtributo == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNPDSI AS MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				Case lcAtributo == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPRECSI AS MONTOPRORRATEORECARGOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUSIMP AS AJUSTEPORREDONDEOSINIMPUESTOS'
				Case lcAtributo == 'AJUSTEPORREDONDEOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AJUCIMP AS AJUSTEPORREDONDEOCONIMPUESTOS'
				Case lcAtributo == 'MONTOIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IMPINTERNO AS MONTOIMPUESTOINTERNO'
				Case lcAtributo == 'TASAIMPUESTOINTERNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TASAIMPINT AS TASAIMPUESTOINTERNO'
				Case lcAtributo == 'BRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FBRUTO AS BRUTO'
				Case lcAtributo == 'PRECIOSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSR AS PRECIOSINREDONDEAR'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESCI AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOSISR AS PRECIOSINIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNDESSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MNTPDESSI AS MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOCONIMPUESTOSSINREDONDEAR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRECIOCISR AS PRECIOCONIMPUESTOSSINREDONDEAR'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
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
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'AFE_CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFECANT AS AFE_CANTIDAD'
				Case lcAtributo == 'AFE_TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFETIPOCOM AS AFE_TIPOCOMPROBANTE'
				Case lcAtributo == 'ARTICULO_CONDICIONIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ACONDIVAV AS ARTICULO_CONDICIONIVAVENTAS'
				Case lcAtributo == 'AFE_NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFENROITEM AS AFE_NROITEM'
				Case lcAtributo == 'ARTICULO_PORCENTAJEIVAVENTAS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'APORCIVAV AS ARTICULO_PORCENTAJEIVAVENTAS'
				Case lcAtributo == 'IDORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEMORIG AS IDORIGEN'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'IDITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CIDITEM AS IDITEM'
				Case lcAtributo == 'TIPOLISTADEPRECIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FN11 AS TIPOLISTADEPRECIO'
				Case lcAtributo == 'PRECIOUNITARIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPRUN AS PRECIOUNITARIO'
				Case lcAtributo == 'RESTRINGIRDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTSINDES AS RESTRINGIRDESCUENTOS'
				Case lcAtributo == 'NOPROCESARSTOCK'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCSTOCK AS NOPROCESARSTOCK'
				Case lcAtributo == 'USARPRECIODELISTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'USARPLISTA AS USARPRECIODELISTA'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FUEINFORMADOALANUBE'
				lcCampo = 'INFORMNUBE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'DATAECOM'
				lcCampo = 'DATOSECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'NROOPECOMMERCE'
				lcCampo = 'OPECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAJUSTE'
				lcCampo = 'IDAJUSTE'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MDCIMPU'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCCLI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTESPORREDONDEOS'
				lcCampo = 'FAJXRE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUT'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'BASADOENCOMPROBANTEONLINE'
				lcCampo = 'ORIGONLINE'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
				lcCampo = 'MOTDESCDEV'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO1'
				lcCampo = 'MD1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIA'
				lcCampo = 'IDSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS1'
				lcCampo = 'FMTDES1'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'RECEPTOR'
				lcCampo = 'RECEPTOR'
			Case upper( alltrim( tcAtributo ) ) == 'VENDEDOR'
				lcCampo = 'FVEN'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSCONIMPUESTOS'
				lcCampo = 'TDCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDACOMPROBANTE'
				lcCampo = 'MONEDA'
			Case upper( alltrim( tcAtributo ) ) == 'LETRA'
				lcCampo = 'FLETRA'
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOSENIA'
				lcCampo = 'VTOSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSCONIMPUESTOS'
				lcCampo = 'TRCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALRECARGOSSINIMPUESTOS'
				lcCampo = 'TOTRECARSI'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPOSTERIOR'
				lcCampo = 'ENTREGAPOS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO3'
				lcCampo = 'MD3'
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
				lcCampo = 'TOTRECAR'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
			Case upper( alltrim( tcAtributo ) ) == 'MERCADERIACONSIGNACION'
				lcCampo = 'MERCONSIGN'
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
			Case upper( alltrim( tcAtributo ) ) == 'DEUDA'
				lcCampo = 'DEUDA'
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
			Case upper( alltrim( tcAtributo ) ) == 'AFE_LETRA'
				lcCampo = 'AFELETRA'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_PUNTODEVENTA'
				lcCampo = 'AFEPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOGTIN'
				lcCampo = 'CODGTIN'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'FART'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAUTORIZACIONDJCP'
				lcCampo = 'CODAUTDJCP'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'TIENERESTRICCION'
				lcCampo = 'CONRESTR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
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
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
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
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIVA'
				lcCampo = 'MNTPIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOIMPUESTOINTERNO'
				lcCampo = 'MNTPINT'
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
	Function ObtenerCampoDetalleKitsDetalle( tcAtributo As String ) As String
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
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAUTORIZACIONDJCP'
				lcCampo = 'CODAUTDJCP'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOPERCEPCIONES'
				lcCampo = 'MNTPPER'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEOTOTAL'
				lcCampo = 'MNTPTOT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNTPDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIMESTAMP'
				lcCampo = 'AFETS'
			Case upper( alltrim( tcAtributo ) ) == 'TIENERESTRICCION'
				lcCampo = 'CONRESTR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOCONIMPUESTOS'
				lcCampo = 'MNTPRECCI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPORCENTAJEDESCUENTOSINIMPUESTO'
				lcCampo = 'MNPDSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEORECARGOSINIMPUESTOS'
				lcCampo = 'MNTPRECSI'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOSINIMPUESTOS'
				lcCampo = 'AJUSIMP'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTEPORREDONDEOCONIMPUESTOS'
				lcCampo = 'AJUCIMP'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIMPUESTOINTERNO'
				lcCampo = 'IMPINTERNO'
			Case upper( alltrim( tcAtributo ) ) == 'TASAIMPUESTOINTERNO'
				lcCampo = 'TASAIMPINT'
			Case upper( alltrim( tcAtributo ) ) == 'BRUTO'
				lcCampo = 'FBRUTO'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINREDONDEAR'
				lcCampo = 'PRECIOSR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MNDESCI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOSISR'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOPRORRATEODESCUENTOSINIMPUESTOS'
				lcCampo = 'MNTPDESSI'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOSSINREDONDEAR'
				lcCampo = 'PRECIOCISR'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
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
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CANTIDAD'
				lcCampo = 'AFECANT'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_TIPOCOMPROBANTE'
				lcCampo = 'AFETIPOCOM'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_CONDICIONIVAVENTAS'
				lcCampo = 'ACONDIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_NROITEM'
				lcCampo = 'AFENROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO_PORCENTAJEIVAVENTAS'
				lcCampo = 'APORCIVAV'
			Case upper( alltrim( tcAtributo ) ) == 'IDORIGEN'
				lcCampo = 'IDITEMORIG'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEM'
				lcCampo = 'CIDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOLISTADEPRECIO'
				lcCampo = 'FN11'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOUNITARIO'
				lcCampo = 'FPRUN'
			Case upper( alltrim( tcAtributo ) ) == 'RESTRINGIRDESCUENTOS'
				lcCampo = 'ARTSINDES'
			Case upper( alltrim( tcAtributo ) ) == 'NOPROCESARSTOCK'
				lcCampo = 'PROCSTOCK'
			Case upper( alltrim( tcAtributo ) ) == 'USARPRECIODELISTA'
				lcCampo = 'USARPLISTA'
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
			local  lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFectrans, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevDatosecomm, lxComprobantevIdcaja, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevOpecomm, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevIdajuste, lxComprobantevEsttrans, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevFhora, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevZadsfw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevSaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevBdmodifw, lxComprobantevTimestamp, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMdcimpu, lxComprobantevSitfisccli, lxComprobantevRecmntosi, lxComprobantevFsubton, lxComprobantevFpodes2, lxComprobantevFsubtot, lxComprobantevSignomov, lxComprobantevFacttipo, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevFajxre, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevAnulado, lxComprobantevOrigonline, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevFmtdes1, lxComprobantevCodigo, lxComprobantevDesmntosi3, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevCodlista, lxComprobantevEmail, lxComprobantevVtosenia, lxComprobantevFptoven, lxComprobantevTrci, lxComprobantevTotrecarsi, lxComprobantevFvuelto, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevFfch, lxComprobantevCotiz, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevEntregapos, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevMerconsign, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela, lxComprobantevDeuda
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFhora =  .Hora			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevOrigonline =  .Basadoencomprobanteonline			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevCodigo =  .Codigo			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevEmail =  .Email			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevFfch =  .Fecha			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado			lxComprobantevDeuda =  .Deuda
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPROBANTEV ( "Fd2","Informnube","Fectrans","Fecimpo","Fmodifw","Fecexpo","Datosecomm","Idcaja","Fpodes1","Fperson","Fturno","Opecomm","Faltafw","Haltafw","Idajuste","Esttrans","Descfw","Simbmon","Fhora","Umodifw","Bdaltafw","Zadsfw","Valtafw","Vmodifw","Ualtafw","Hmodifw","Smodifw","Saltafw","Horaimpo","Horaexpo","Bdmodifw","Timestamp","Factsec","Totalcant","Mdcimpu","Sitfisccli","Recmntosi","Fsubton","Fpodes2","Fsubtot","Signomov","Facttipo","Condivalp","Subtotsisi","Subtotcisi","Recmntosi1","Recmntosi2","Fajxre","Desmntosi2","Desmntosi1","Desmntosi","Fcompfis","Desaut","Anulado","Origonline","Idvuelto","Monsis","Motdescdev","Fobs","Fcuit","Md1","Fcliente","Idsenia","Fmtdes2","Fmtdes1","Codigo","Desmntosi3","Receptor","Fven","Totdescsi","Tdci","Moneda","Fletra","Codlista","Email","Vtosenia","Fptoven","Trci","Totrecarsi","Fvuelto","Fnumcomp","Ftotal","Ffch","Cotiz","Fmtdes3","Fpodes","Recmnto2","Entregapos","Fdescu","Md3","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecar","Totdesc","Totimpue","Merconsign","Cancelar","Ivasis","Tipocrela","Letrarela","Puntorela","Numerorela","Feccrela","Deuda" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<lxComprobantevTimestamp >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevRecmntosi >>, <<lxComprobantevFsubton >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevFsubtot >>, <<lxComprobantevSignomov >>, <<lxComprobantevFacttipo >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevFajxre >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevOrigonline, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<lxComprobantevFmtdes2 >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<lxComprobantevDesmntosi3 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevFptoven >>, <<lxComprobantevTrci >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevFvuelto >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFtotal >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevCotiz >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevEntregapos >>, <<lxComprobantevFdescu >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecar >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >>, <<lxComprobantevTipocrela >>, <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'" >>, <<lxComprobantevPuntorela >>, <<lxComprobantevNumerorela >>, <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'" >>, <<lxComprobantevDeuda >> )
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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxIdkit = loItem.Idkit
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
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
					lxIdorigen = loItem.Idorigen
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxIditem = loItem.Iditem
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","codgtin","FART","FUnid","IDKIT","CodAutDJCP","IdItem","afe_cod","MNTPTOT","MNTPPER","AfeTS","MNTPDESCI","ConRestr","MNTPRECCI","MNPDSI","AjuCImp","FBruto","tasaimpint","AjuSImp","PRECIOSR","impinterno","PRECIOCISR","MNTPDESSI","MNDESSI","MNDESCI","MNTPRECSI","PRECIOSISR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","iditemOrig","AfeNroItem","prunconimp","AfeCANT","ciditem","Prunsinimp","COMP","FPRUN","AfeTipoCom","FN11","UsarPLista","ProcStock","ArtSinDes","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","MNTPIVA","MNTPINT","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxTasaimpuestointerno>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxMontoimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxIdorigen>>, <<lxAfe_nroitem>>, <<lxPrecioconimpuestos>>, <<lxAfe_cantidad>>, <<lxIditem>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxAfe_tipocomprobante>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxAfe_saldo = loItem.Afe_saldo
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
					lxComportamiento = loItem.Comportamiento
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxIdorigen = loItem.Idorigen
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
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
						Insert into ZooLogic.KITDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","FUnid","CodAutDJCP","IDKIT","IdItem","afe_cod","MNTPPER","MNTPTOT","MNTPDESCI","AfeTS","ConRestr","MNTPRECCI","MNPDSI","MNTPRECSI","AjuSImp","AjuCImp","impinterno","tasaimpint","FBruto","PRECIOSR","MNDESCI","PRECIOSISR","MNDESSI","MNTPDESSI","PRECIOCISR","AfeSaldo","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","COMP","AfeCANT","AfeTipoCom","ACondIvaV","AfeNroItem","APorcIvaV","iditemOrig","prunconimp","Prunsinimp","ciditem","FN11","FPRUN","ArtSinDes","ProcStock","UsarPLista","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_timestamp>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxTasaimpuestointerno>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPrecioconimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxAfe_cantidad>>, <<lxAfe_tipocomprobante>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxArticulo_porcentajeivaventas>>, <<lxIdorigen>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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
			local  lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFectrans, lxComprobantevFecimpo, lxComprobantevFmodifw, lxComprobantevFecexpo, lxComprobantevDatosecomm, lxComprobantevIdcaja, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevOpecomm, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevIdajuste, lxComprobantevEsttrans, lxComprobantevDescfw, lxComprobantevSimbmon, lxComprobantevFhora, lxComprobantevUmodifw, lxComprobantevBdaltafw, lxComprobantevZadsfw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevUaltafw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevSaltafw, lxComprobantevHoraimpo, lxComprobantevHoraexpo, lxComprobantevBdmodifw, lxComprobantevTimestamp, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevMdcimpu, lxComprobantevSitfisccli, lxComprobantevRecmntosi, lxComprobantevFsubton, lxComprobantevFpodes2, lxComprobantevFsubtot, lxComprobantevSignomov, lxComprobantevFacttipo, lxComprobantevCondivalp, lxComprobantevSubtotsisi, lxComprobantevSubtotcisi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi2, lxComprobantevFajxre, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi, lxComprobantevFcompfis, lxComprobantevDesaut, lxComprobantevAnulado, lxComprobantevOrigonline, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFcuit, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevIdsenia, lxComprobantevFmtdes2, lxComprobantevFmtdes1, lxComprobantevCodigo, lxComprobantevDesmntosi3, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevCodlista, lxComprobantevEmail, lxComprobantevVtosenia, lxComprobantevFptoven, lxComprobantevTrci, lxComprobantevTotrecarsi, lxComprobantevFvuelto, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevFfch, lxComprobantevCotiz, lxComprobantevFmtdes3, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevEntregapos, lxComprobantevFdescu, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecar, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevMerconsign, lxComprobantevCancelar, lxComprobantevIvasis, lxComprobantevTipocrela, lxComprobantevLetrarela, lxComprobantevPuntorela, lxComprobantevNumerorela, lxComprobantevFeccrela, lxComprobantevDeuda
				lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevDatosecomm =  .Dataecom			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFhora =  .Hora			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevAnulado =  .Anulado			lxComprobantevOrigonline =  .Basadoencomprobanteonline			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFcuit =  .Cuit			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevIdsenia =  .Idsenia			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevCodigo =  .Codigo			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevEmail =  .Email			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevFvuelto =  .Vuelto			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevFfch =  .Fecha			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFdescu =  .Descuento			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecar =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema			lxComprobantevTipocrela =  .Tipocpterelacionado			lxComprobantevLetrarela =  .Letracpterelacionado			lxComprobantevPuntorela =  .Puntodeventacpterelacionado			lxComprobantevNumerorela =  .Numerocpterelacionado			lxComprobantevFeccrela =  .Fechacpterelacionado			lxComprobantevDeuda =  .Deuda
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPROBANTEV set "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>, "Informnube" = <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>, "Datosecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevDatosecomm ) + "'">>, "Idcaja" = <<lxComprobantevIdcaja>>, "Fpodes1" = <<lxComprobantevFpodes1>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>, "Fturno" = <<lxComprobantevFturno>>, "Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>, "Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>, "Timestamp" = <<lxComprobantevTimestamp>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>, "Totalcant" = <<lxComprobantevTotalcant>>, "Mdcimpu" = <<lxComprobantevMdcimpu>>, "Sitfisccli" = <<lxComprobantevSitfisccli>>, "Recmntosi" = <<lxComprobantevRecmntosi>>, "Fsubton" = <<lxComprobantevFsubton>>, "Fpodes2" = <<lxComprobantevFpodes2>>, "Fsubtot" = <<lxComprobantevFsubtot>>, "Signomov" = <<lxComprobantevSignomov>>, "Facttipo" = <<lxComprobantevFacttipo>>, "Condivalp" = <<lxComprobantevCondivalp>>, "Subtotsisi" = <<lxComprobantevSubtotsisi>>, "Subtotcisi" = <<lxComprobantevSubtotcisi>>, "Recmntosi1" = <<lxComprobantevRecmntosi1>>, "Recmntosi2" = <<lxComprobantevRecmntosi2>>, "Fajxre" = <<lxComprobantevFajxre>>, "Desmntosi2" = <<lxComprobantevDesmntosi2>>, "Desmntosi1" = <<lxComprobantevDesmntosi1>>, "Desmntosi" = <<lxComprobantevDesmntosi>>, "Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>, "Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>, "Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>, "Origonline" = <<iif( lxComprobantevOrigonline, 1, 0 )>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>, "Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>, "Md1" = <<lxComprobantevMd1>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>, "Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>, "Fmtdes2" = <<lxComprobantevFmtdes2>>, "Fmtdes1" = <<lxComprobantevFmtdes1>>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>, "Desmntosi3" = <<lxComprobantevDesmntosi3>>, "Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>, "Totdescsi" = <<lxComprobantevTotdescsi>>, "Tdci" = <<lxComprobantevTdci>>, "Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>, "Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>, "Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>, "Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>, "Fptoven" = <<lxComprobantevFptoven>>, "Trci" = <<lxComprobantevTrci>>, "Totrecarsi" = <<lxComprobantevTotrecarsi>>, "Fvuelto" = <<lxComprobantevFvuelto>>, "Fnumcomp" = <<lxComprobantevFnumcomp>>, "Ftotal" = <<lxComprobantevFtotal>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>, "Cotiz" = <<lxComprobantevCotiz>>, "Fmtdes3" = <<lxComprobantevFmtdes3>>, "Fpodes" = <<lxComprobantevFpodes>>, "Recmnto2" = <<lxComprobantevRecmnto2>>, "Entregapos" = <<lxComprobantevEntregapos>>, "Fdescu" = <<lxComprobantevFdescu>>, "Md3" = <<lxComprobantevMd3>>, "Percepcion" = <<lxComprobantevPercepcion>>, "Recmnto" = <<lxComprobantevRecmnto>>, "Recpor" = <<lxComprobantevRecpor>>, "Mr" = <<lxComprobantevMr>>, "Mr2" = <<lxComprobantevMr2>>, "Md2" = <<lxComprobantevMd2>>, "Mr1" = <<lxComprobantevMr1>>, "Recmnto1" = <<lxComprobantevRecmnto1>>, "Gravamen" = <<lxComprobantevGravamen>>, "Fimpuesto" = <<lxComprobantevFimpuesto>>, "Totrecar" = <<lxComprobantevTotrecar>>, "Totdesc" = <<lxComprobantevTotdesc>>, "Totimpue" = <<lxComprobantevTotimpue>>, "Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>, "Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>, "Ivasis" = <<lxComprobantevIvasis>>, "Tipocrela" = <<lxComprobantevTipocrela>>, "Letrarela" = <<"'" + this.FormatearTextoSql( lxComprobantevLetrarela ) + "'">>, "Puntorela" = <<lxComprobantevPuntorela>>, "Numerorela" = <<lxComprobantevNumerorela>>, "Feccrela" = <<"'" + this.ConvertirDateSql( lxComprobantevFeccrela ) + "'">>, "Deuda" = <<lxComprobantevDeuda>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KITDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
					lxAfe_letra = loItem.Afe_letra
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxIdkit = loItem.Idkit
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxAfe_timestamp = loItem.Afe_timestamp
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxBruto = loItem.Bruto
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
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
					lxIdorigen = loItem.Idorigen
					lxAfe_nroitem = loItem.Afe_nroitem
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxAfe_cantidad = loItem.Afe_cantidad
					lxIditem = loItem.Iditem
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxComportamiento = loItem.Comportamiento
					lxPreciounitario = loItem.Preciounitario
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxEquivalencia_PK = loItem.Equivalencia_PK
					lxArticulodetalle = loItem.Articulodetalle
					lxColor_PK = loItem.Color_PK
					lxMontoprorrateoiva = loItem.Montoprorrateoiva
					lxMontoprorrateoimpuestointerno = loItem.Montoprorrateoimpuestointerno
					lxColordetalle = loItem.Colordetalle
					lxTalledetalle = loItem.Talledetalle
					lxTalle_PK = loItem.Talle_PK
					lxCantidad = loItem.Cantidad
					lxPrecio = loItem.Precio
					lxDescuento = loItem.Descuento
					lxMontodescuento = loItem.Montodescuento
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfeNUMCOM","AfeLETRA","AfePTOVEN","codgtin","FART","FUnid","IDKIT","CodAutDJCP","IdItem","afe_cod","MNTPTOT","MNTPPER","AfeTS","MNTPDESCI","ConRestr","MNTPRECCI","MNPDSI","AjuCImp","FBruto","tasaimpint","AjuSImp","PRECIOSR","impinterno","PRECIOCISR","MNTPDESSI","MNDESSI","MNDESCI","MNTPRECSI","PRECIOSISR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","iditemOrig","AfeNroItem","prunconimp","AfeCANT","ciditem","Prunsinimp","COMP","FPRUN","AfeTipoCom","FN11","UsarPLista","ProcStock","ArtSinDes","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","MNTPIVA","MNTPINT","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateototal>>, <<lxMontoprorrateopercepciones>>, <<lxAfe_timestamp>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxAjusteporredondeoconimpuestos>>, <<lxBruto>>, <<lxTasaimpuestointerno>>, <<lxAjusteporredondeosinimpuestos>>, <<lxPreciosinredondear>>, <<lxMontoimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontodescuentosinimpuestos>>, <<lxMontodescuentoconimpuestos>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxArticulo_porcentajeivaventas>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxArticulo_condicionivaventas>>, <<lxIdorigen>>, <<lxAfe_nroitem>>, <<lxPrecioconimpuestos>>, <<lxAfe_cantidad>>, <<lxIditem>>, <<lxPreciosinimpuestos>>, <<lxComportamiento>>, <<lxPreciounitario>>, <<lxAfe_tipocomprobante>>, <<lxTipolistadeprecio>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<lxMontoprorrateoiva>>, <<lxMontoprorrateoimpuestointerno>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.KitsDetalle
				if this.oEntidad.KitsDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxAfe_puntodeventa = loItem.Afe_puntodeventa
					lxAfe_letra = loItem.Afe_letra
					lxAfe_numero = loItem.Afe_numero
					lxCodigogtin = loItem.Codigogtin
					lxArticulo_PK = loItem.Articulo_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxAfe_codigo = loItem.Afe_codigo
					lxMontoprorrateopercepciones = loItem.Montoprorrateopercepciones
					lxMontoprorrateototal = loItem.Montoprorrateototal
					lxMontoprorrateodescuentoconimpuestos = loItem.Montoprorrateodescuentoconimpuestos
					lxAfe_timestamp = loItem.Afe_timestamp
					lxTienerestriccion = loItem.Tienerestriccion
					lxMontoprorrateorecargoconimpuestos = loItem.Montoprorrateorecargoconimpuestos
					lxMontoporcentajedescuentosinimpuesto = loItem.Montoporcentajedescuentosinimpuesto
					lxMontoprorrateorecargosinimpuestos = loItem.Montoprorrateorecargosinimpuestos
					lxAjusteporredondeosinimpuestos = loItem.Ajusteporredondeosinimpuestos
					lxAjusteporredondeoconimpuestos = loItem.Ajusteporredondeoconimpuestos
					lxMontoimpuestointerno = loItem.Montoimpuestointerno
					lxTasaimpuestointerno = loItem.Tasaimpuestointerno
					lxBruto = loItem.Bruto
					lxPreciosinredondear = loItem.Preciosinredondear
					lxMontodescuentoconimpuestos = loItem.Montodescuentoconimpuestos
					lxPreciosinimpuestossinredondear = loItem.Preciosinimpuestossinredondear
					lxMontodescuentosinimpuestos = loItem.Montodescuentosinimpuestos
					lxMontoprorrateodescuentosinimpuestos = loItem.Montoprorrateodescuentosinimpuestos
					lxPrecioconimpuestossinredondear = loItem.Precioconimpuestossinredondear
					lxAfe_saldo = loItem.Afe_saldo
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
					lxComportamiento = loItem.Comportamiento
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxArticulo_condicionivaventas = loItem.Articulo_condicionivaventas
					lxAfe_nroitem = loItem.Afe_nroitem
					lxArticulo_porcentajeivaventas = loItem.Articulo_porcentajeivaventas
					lxIdorigen = loItem.Idorigen
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxIditem = loItem.Iditem
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxNoprocesarstock = loItem.Noprocesarstock
					lxUsarpreciodelista = loItem.Usarpreciodelista
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
						Insert into ZooLogic.KITDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","FUnid","CodAutDJCP","IDKIT","IdItem","afe_cod","MNTPPER","MNTPTOT","MNTPDESCI","AfeTS","ConRestr","MNTPRECCI","MNPDSI","MNTPRECSI","AjuSImp","AjuCImp","impinterno","tasaimpint","FBruto","PRECIOSR","MNDESCI","PRECIOSISR","MNDESSI","MNTPDESSI","PRECIOCISR","AfeSaldo","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","COMP","AfeCANT","AfeTipoCom","ACondIvaV","AfeNroItem","APorcIvaV","iditemOrig","prunconimp","Prunsinimp","ciditem","FN11","FPRUN","ArtSinDes","ProcStock","UsarPLista","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<lxMontoprorrateopercepciones>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxAfe_timestamp>>, <<lxTienerestriccion>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxAjusteporredondeosinimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxMontoimpuestointerno>>, <<lxTasaimpuestointerno>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxPrecioconimpuestossinredondear>>, <<lxAfe_saldo>>, <<lxNeto>>, <<lxMontoiva>>, <<lxOferta>>, <<lxNroitem>>, <<lxMontodto1>>, <<lxPorcentajecfi>>, <<lxMontocfi>>, <<lxAfe_saldoliquidacion>>, <<lxPercepcionivarg5329>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxPorcentajedto1>>, <<lxPorcentajeiva>>, <<lxComportamiento>>, <<lxAfe_cantidad>>, <<lxAfe_tipocomprobante>>, <<lxArticulo_condicionivaventas>>, <<lxAfe_nroitem>>, <<lxArticulo_porcentajeivaventas>>, <<lxIdorigen>>, <<lxPrecioconimpuestos>>, <<lxPreciosinimpuestos>>, <<lxIditem>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxMontoprorrateoimpuestointerno>>, <<lxMontoprorrateoiva>>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<lxCantidad>>, <<lxPrecio>>, <<lxDescuento>>, <<lxMontodescuento>>, <<lxMonto>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55]
		loColeccion.Agregar( 'delete from ZooLogic.COMPROBANTEV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
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
			
			.oCompSenias.lNuevo = .EsNuevo()
			.oCompSenias.lEdicion = .EsEdicion()
			.oCompSenias.lEliminar = .lEliminar
			.oCompSenias.lAnular = .lAnular
			loColSentencias = .oCompSenias.grabar()
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
			
			.oCompDatosadicionalessire.lNuevo = .EsNuevo()
			.oCompDatosadicionalessire.lEdicion = .EsEdicion()
			.oCompDatosadicionalessire.lEliminar = .lEliminar
			.oCompDatosadicionalessire.lAnular = .lAnular
			loColSentencias = .oCompDatosadicionalessire.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.oCompRegistroliquidacionconsignaciones.lNuevo = .EsNuevo()
			.oCompRegistroliquidacionconsignaciones.lEdicion = .EsEdicion()
			.oCompRegistroliquidacionconsignaciones.lEliminar = .lEliminar
			.oCompRegistroliquidacionconsignaciones.lAnular = .lAnular
			loColSentencias = .oCompRegistroliquidacionconsignaciones.grabar()
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
			.KitsDetalle.oItem.oCompStock.lNuevo = .EsNuevo()
			.KitsDetalle.oItem.oCompStock.lEdicion = .EsEdicion()
			.KitsDetalle.oItem.oCompStock.lEliminar = .lEliminar
			.KitsDetalle.oItem.oCompStock.lAnular = .lAnular
			loColSentencias = .KitsDetalle.oItem.oCompStock.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
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
			
			.KitsDetalle.oItem.oCompPrecios.lNuevo = .EsNuevo()
			.KitsDetalle.oItem.oCompPrecios.lEdicion = .EsEdicion()
			.KitsDetalle.oItem.oCompPrecios.lEliminar = .lEliminar
			.KitsDetalle.oItem.oCompPrecios.lAnular = .lAnular
			loColSentencias = .KitsDetalle.oItem.oCompPrecios.grabar()
			for each lcItem in loColSentencias
				this.colSentencias.Agregar( lcItem )
			endfor
			
			.ArticulosSeniadosDetalle.oItem.oCompPrecios.lNuevo = .EsNuevo()
			.ArticulosSeniadosDetalle.oItem.oCompPrecios.lEdicion = .EsEdicion()
			.ArticulosSeniadosDetalle.oItem.oCompPrecios.lEliminar = .lEliminar
			.ArticulosSeniadosDetalle.oItem.oCompPrecios.lAnular = .lAnular
			loColSentencias = .ArticulosSeniadosDetalle.oItem.oCompPrecios.grabar()
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
			lcRetorno = [update ZooLogic.COMPROBANTEV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPROBANTEV where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55" )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO'
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPROBANTEV set  FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, InformNube = ] + "'" + this.ConvertirDateSql( &lcCursor..InformNube ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, DatosEComm = ] + "'" + this.FormatearTextoSql( &lcCursor..DatosEComm ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, OPEcomm = ] + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'"+ [, idAjuste = ] + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'"+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, MDCIMPU = ] + transform( &lcCursor..MDCIMPU )+ [, SitFiscCli = ] + transform( &lcCursor..SitFiscCli )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, FAjXRe = ] + transform( &lcCursor..FAjXRe )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, DESAUT = ] + Transform( iif( &lcCursor..DESAUT, 1, 0 ))+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, OrigOnline = ] + Transform( iif( &lcCursor..OrigOnline, 1, 0 ))+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, MotDescDev = ] + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, MD1 = ] + transform( &lcCursor..MD1 )+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, IDSenia = ] + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'"+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, Receptor = ] + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, TDCI = ] + transform( &lcCursor..TDCI )+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, Email = ] + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'"+ [, vtosenia = ] + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, TRCI = ] + transform( &lcCursor..TRCI )+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, EntregaPos = ] + transform( &lcCursor..EntregaPos )+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, percepcion = ] + transform( &lcCursor..percepcion )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, MR = ] + transform( &lcCursor..MR )+ [, MR2 = ] + transform( &lcCursor..MR2 )+ [, MD2 = ] + transform( &lcCursor..MD2 )+ [, MR1 = ] + transform( &lcCursor..MR1 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, gravamen = ] + transform( &lcCursor..gravamen )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, totrecar = ] + transform( &lcCursor..totrecar )+ [, totdesc = ] + transform( &lcCursor..totdesc )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, MerConsign = ] + Transform( iif( &lcCursor..MerConsign, 1, 0 ))+ [, Cancelar = ] + Transform( iif( &lcCursor..Cancelar, 1, 0 ))+ [, IvaSis = ] + transform( &lcCursor..IvaSis )+ [, TipoCRela = ] + transform( &lcCursor..TipoCRela )+ [, letraRela = ] + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'"+ [, puntoRela = ] + transform( &lcCursor..puntoRela )+ [, numeroRela = ] + transform( &lcCursor..numeroRela )+ [, FecCRela = ] + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'"+ [, Deuda = ] + transform( &lcCursor..Deuda ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FD2, InformNube, FECTRANS, FECIMPO, FMODIFW, FECEXPO, DatosEComm, IdCaja, FPODES1, FPerson, FTurno, OPEcomm, FAltaFW, HAltaFW, idAjuste, ESTTRANS, DescFW, SimbMon, FHORA, UMODIFW, BDALTAFW, ZADSFW, VALTAFW, VMODIFW, UALTAFW, HMODIFW, SMODIFW, SALTAFW, HORAIMPO, HORAEXPO, BDMODIFW, TIMESTAMP, FACTSEC, TotalCant, MDCIMPU, SitFiscCli, RecMntoSI, fSubToN, FPODES2, FSubTOT, signomov, FACTTIPO, CondivaLp, SubTotSISI, SubTotCISI, RecMntoSI1, RecMntoSI2, FAjXRe, DesMntoSI2, DesMntoSI1, DesMntoSI, FCOMPFIS, DESAUT, Anulado, OrigOnline, idVuelto, MonSis, MotDescDev, FObs, fCuit, MD1, FCLIENTE, IDSenia, FMTDES2, FMTDES1, CODIGO, DesMntoSI3, Receptor, FVEN, totdescSI, TDCI, Moneda, FLETRA, CodLista, Email, vtosenia, FPTOVEN, TRCI, totrecarSI, FVuelto, FNUMCOMP, FTotal, FFCH, Cotiz, FMTDES3, FPODES, RecMnto2, EntregaPos, fDescu, MD3, percepcion, RecMnto, RecPor, MR, MR2, MD2, MR1, RecMnto1, gravamen, fImpuesto, totrecar, totdesc, totimpue, MerConsign, Cancelar, IvaSis, TipoCRela, letraRela, puntoRela, numeroRela, FecCRela, Deuda
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..InformNube ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DatosEComm ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FPODES1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..FTurno ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'" + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..MDCIMPU ) + ',' + transform( &lcCursor..SitFiscCli ) + ',' + transform( &lcCursor..RecMntoSI )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..FPODES2 ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..FACTTIPO ) + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMntoSI2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FAjXRe ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI1 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + Transform( iif( &lcCursor..DESAUT, 1, 0 )) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..OrigOnline, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..MD1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES2 ) + ',' + transform( &lcCursor..FMTDES1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..TDCI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'" + ',' + transform( &lcCursor..FPTOVEN ) + ',' + transform( &lcCursor..TRCI ) + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..FVuelto )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..FTotal ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..Cotiz ) + ',' + transform( &lcCursor..FMTDES3 ) + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..EntregaPos ) + ',' + transform( &lcCursor..fDescu ) + ',' + transform( &lcCursor..MD3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..percepcion ) + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..MR2 ) + ',' + transform( &lcCursor..MD2 ) + ',' + transform( &lcCursor..MR1 ) + ',' + transform( &lcCursor..RecMnto1 ) + ',' + transform( &lcCursor..gravamen ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..totrecar )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..totdesc ) + ',' + transform( &lcCursor..totimpue ) + ',' + Transform( iif( &lcCursor..MerConsign, 1, 0 )) + ',' + Transform( iif( &lcCursor..Cancelar, 1, 0 )) + ',' + transform( &lcCursor..IvaSis ) + ',' + transform( &lcCursor..TipoCRela ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..letraRela ) + "'" + ',' + transform( &lcCursor..puntoRela ) + ',' + transform( &lcCursor..numeroRela )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FecCRela ) + "'" + ',' + transform( &lcCursor..Deuda )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO'
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSENIADOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfeNUMCOM","AfeLETRA","AfePTOVEN","codgtin","FART","FUnid","IDKIT","CodAutDJCP","IdItem","afe_cod","MNTPTOT","MNTPPER","AfeTS","MNTPDESCI","ConRestr","MNTPRECCI","MNPDSI","AjuCImp","FBruto","tasaimpint","AjuSImp","PRECIOSR","impinterno","PRECIOCISR","MNTPDESSI","MNDESSI","MNDESCI","MNTPRECSI","PRECIOSISR","AfeSaldo","APorcIvaV","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","ACondIvaV","iditemOrig","AfeNroItem","prunconimp","AfeCANT","ciditem","Prunsinimp","COMP","FPRUN","AfeTipoCom","FN11","UsarPLista","ProcStock","ArtSinDes","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","MNTPIVA","MNTPINT","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SeniaVDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_cod    ) + "'" + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTATXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMKITS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","FUnid","CodAutDJCP","IDKIT","IdItem","afe_cod","MNTPPER","MNTPTOT","MNTPDESCI","AfeTS","ConRestr","MNTPRECCI","MNPDSI","MNTPRECSI","AjuSImp","AjuCImp","impinterno","tasaimpint","FBruto","PRECIOSR","MNDESCI","PRECIOSISR","MNDESSI","MNTPDESSI","PRECIOCISR","AfeSaldo","FNETO","FmtoIVA","FX2","NroItem","FmtoDTO1","FporCFI","FmtoCFI","Afe_SLiq","ArtPercep","FKIT","FCFITot","FporDTO1","fporIva","COMP","AfeCANT","AfeTipoCom","ACondIvaV","AfeNroItem","APorcIvaV","iditemOrig","prunconimp","Prunsinimp","ciditem","FN11","FPRUN","ArtSinDes","ProcStock","UsarPLista","GiftCard","CODIGO","MotDescu","MotDevol","Equiv","FTXT","cColor","seniacance","MNTPINT","MNTPIVA","FCOLTXT","FTATXT","Talle","FCANT","FPRECIO","FCFI","MNTDES","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.KITDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.afe_cod    ) + "'" + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.ciditem    ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTATXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Talle      ) + "'" + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.KitsDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.ArticulosSeniadosDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'ArticulosSeniadosDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSENIADOS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.KitsDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORES',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.FacturaDetalle.oItem.oCompGiftcard.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS', this.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Letra de comprobante: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..FPTOVEN    )
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
			Case  lcAlias == lcPrefijo + 'NOTADECREDITOELECTRONICADECREDITO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOTADECREDITOELECTRONICADECREDITO_DATOSECOMM'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'NOTADECREDITOELECTRONICADECREDITO_ZADSFW'
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
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSSENIADOS'
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
		lcCursor = This.oEntidad.cPrefijoImportar + 'NOTADECREDITOELECTRONICADECREDITO'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP ) or isnull( &lcCursor..FACTSEC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad NOTADECREDITOELECTRONICADECREDITO. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  InformNube
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  vtosenia  
		* Validar ANTERIORES A 1/1/1753  FFCH      
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
"informnube" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"datosecomm" varchar(max)  null, 
"idcaja" numeric( 2, 0 )  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fperson" char( 10 )  null, 
"fturno" numeric( 1, 0 )  null, 
"opecomm" char( 254 )  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"idajuste" char( 10 )  null, 
"esttrans" char( 20 )  null, 
"descfw" char( 200 )  null, 
"simbmon" char( 3 )  null, 
"fhora" char( 8 )  null, 
"umodifw" char( 100 )  null, 
"bdaltafw" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"ualtafw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"saltafw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdmodifw" char( 8 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"factsec" char( 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"mdcimpu" numeric( 15, 4 )  null, 
"sitfisccli" numeric( 2, 0 )  null, 
"recmntosi" numeric( 15, 4 )  null, 
"fsubton" numeric( 15, 4 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"fsubtot" numeric( 15, 4 )  null, 
"signomov" numeric( 2, 0 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"subtotsisi" numeric( 15, 2 )  null, 
"subtotcisi" numeric( 15, 2 )  null, 
"recmntosi1" numeric( 15, 4 )  null, 
"recmntosi2" numeric( 15, 4 )  null, 
"fajxre" numeric( 15, 2 )  null, 
"desmntosi2" numeric( 15, 4 )  null, 
"desmntosi1" numeric( 15, 4 )  null, 
"desmntosi" numeric( 15, 4 )  null, 
"fcompfis" bit  null, 
"desaut" bit  null, 
"anulado" bit  null, 
"origonline" bit  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"motdescdev" char( 10 )  null, 
"fobs" char( 250 )  null, 
"fcuit" char( 15 )  null, 
"md1" numeric( 15, 2 )  null, 
"fcliente" char( 185 )  null, 
"idsenia" char( 38 )  null, 
"fmtdes2" numeric( 15, 4 )  null, 
"fmtdes1" numeric( 15, 4 )  null, 
"codigo" char( 38 )  null, 
"desmntosi3" numeric( 15, 4 )  null, 
"receptor" char( 10 )  null, 
"fven" char( 10 )  null, 
"totdescsi" numeric( 15, 4 )  null, 
"tdci" numeric( 15, 4 )  null, 
"moneda" char( 10 )  null, 
"fletra" char( 1 )  null, 
"codlista" char( 6 )  null, 
"email" char( 250 )  null, 
"vtosenia" datetime  null, 
"fptoven" numeric( 4, 0 )  null, 
"trci" numeric( 15, 4 )  null, 
"totrecarsi" numeric( 15, 4 )  null, 
"fvuelto" numeric( 15, 2 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ftotal" numeric( 15, 2 )  null, 
"ffch" datetime  null, 
"cotiz" numeric( 15, 5 )  null, 
"fmtdes3" numeric( 15, 4 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"recmnto2" numeric( 15, 4 )  null, 
"entregapos" numeric( 1, 0 )  null, 
"fdescu" numeric( 15, 2 )  null, 
"md3" numeric( 15, 2 )  null, 
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
"totrecar" numeric( 15, 2 )  null, 
"totdesc" numeric( 15, 2 )  null, 
"totimpue" numeric( 15, 2 )  null, 
"merconsign" bit  null, 
"cancelar" bit  null, 
"ivasis" numeric( 10, 2 )  null, 
"tipocrela" numeric( 2, 0 )  null, 
"letrarela" char( 1 )  null, 
"puntorela" numeric( 4, 0 )  null, 
"numerorela" numeric( 8, 0 )  null, 
"feccrela" datetime  null, 
"deuda" numeric( 15, 2 )  null )
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'NOTADECREDITOELECTRONICADECREDITO'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('informnube','informnube')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('datosecomm','datosecomm')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('opecomm','opecomm')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('idajuste','idajuste')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('mdcimpu','mdcimpu')
			.AgregarMapeo('sitfisccli','sitfisccli')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('fajxre','fajxre')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('desaut','desaut')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('origonline','origonline')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('motdescdev','motdescdev')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('md1','md1')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('idsenia','idsenia')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('receptor','receptor')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('tdci','tdci')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('email','email')
			.AgregarMapeo('vtosenia','vtosenia')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('trci','trci')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('entregapos','entregapos')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('md3','md3')
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
			.AgregarMapeo('totrecar','totrecar')
			.AgregarMapeo('totdesc','totdesc')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('merconsign','merconsign')
			.AgregarMapeo('cancelar','cancelar')
			.AgregarMapeo('ivasis','ivasis')
			.AgregarMapeo('tipocrela','tipocrela')
			.AgregarMapeo('letrarela','letrarela')
			.AgregarMapeo('puntorela','puntorela')
			.AgregarMapeo('numerorela','numerorela')
			.AgregarMapeo('feccrela','feccrela')
			.AgregarMapeo('deuda','deuda')
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
				Update t Set t.FD2 = isnull( d.FD2, t.FD2 ),t.INFORMNUBE = isnull( d.INFORMNUBE, t.INFORMNUBE ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.DATOSECOMM = isnull( d.DATOSECOMM, t.DATOSECOMM ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.OPECOMM = isnull( d.OPECOMM, t.OPECOMM ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.IDAJUSTE = isnull( d.IDAJUSTE, t.IDAJUSTE ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.MDCIMPU = isnull( d.MDCIMPU, t.MDCIMPU ),t.SITFISCCLI = isnull( d.SITFISCCLI, t.SITFISCCLI ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.FAJXRE = isnull( d.FAJXRE, t.FAJXRE ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.DESAUT = isnull( d.DESAUT, t.DESAUT ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.ORIGONLINE = isnull( d.ORIGONLINE, t.ORIGONLINE ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MOTDESCDEV = isnull( d.MOTDESCDEV, t.MOTDESCDEV ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.MD1 = isnull( d.MD1, t.MD1 ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.IDSENIA = isnull( d.IDSENIA, t.IDSENIA ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.RECEPTOR = isnull( d.RECEPTOR, t.RECEPTOR ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.TDCI = isnull( d.TDCI, t.TDCI ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.VTOSENIA = isnull( d.VTOSENIA, t.VTOSENIA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.TRCI = isnull( d.TRCI, t.TRCI ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.ENTREGAPOS = isnull( d.ENTREGAPOS, t.ENTREGAPOS ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.MD3 = isnull( d.MD3, t.MD3 ),t.PERCEPCION = isnull( d.PERCEPCION, t.PERCEPCION ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.MR = isnull( d.MR, t.MR ),t.MR2 = isnull( d.MR2, t.MR2 ),t.MD2 = isnull( d.MD2, t.MD2 ),t.MR1 = isnull( d.MR1, t.MR1 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.GRAVAMEN = isnull( d.GRAVAMEN, t.GRAVAMEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TOTRECAR = isnull( d.TOTRECAR, t.TOTRECAR ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.MERCONSIGN = isnull( d.MERCONSIGN, t.MERCONSIGN ),t.CANCELAR = isnull( d.CANCELAR, t.CANCELAR ),t.IVASIS = isnull( d.IVASIS, t.IVASIS ),t.TIPOCRELA = isnull( d.TIPOCRELA, t.TIPOCRELA ),t.LETRARELA = isnull( d.LETRARELA, t.LETRARELA ),t.PUNTORELA = isnull( d.PUNTORELA, t.PUNTORELA ),t.NUMERORELA = isnull( d.NUMERORELA, t.NUMERORELA ),t.FECCRELA = isnull( d.FECCRELA, t.FECCRELA ),t.DEUDA = isnull( d.DEUDA, t.DEUDA )
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
				-- Fin Updates
				insert into ZooLogic.COMPROBANTEV(Fd2,Informnube,Fectrans,Fecimpo,Fmodifw,Fecexpo,Datosecomm,Idcaja,Fpodes1,Fperson,Fturno,Opecomm,Faltafw,Haltafw,Idajuste,Esttrans,Descfw,Simbmon,Fhora,Umodifw,Bdaltafw,Zadsfw,Valtafw,Vmodifw,Ualtafw,Hmodifw,Smodifw,Saltafw,Horaimpo,Horaexpo,Bdmodifw,Timestamp,Factsec,Totalcant,Mdcimpu,Sitfisccli,Recmntosi,Fsubton,Fpodes2,Fsubtot,Signomov,Facttipo,Condivalp,Subtotsisi,Subtotcisi,Recmntosi1,Recmntosi2,Fajxre,Desmntosi2,Desmntosi1,Desmntosi,Fcompfis,Desaut,Anulado,Origonline,Idvuelto,Monsis,Motdescdev,Fobs,Fcuit,Md1,Fcliente,Idsenia,Fmtdes2,Fmtdes1,Codigo,Desmntosi3,Receptor,Fven,Totdescsi,Tdci,Moneda,Fletra,Codlista,Email,Vtosenia,Fptoven,Trci,Totrecarsi,Fvuelto,Fnumcomp,Ftotal,Ffch,Cotiz,Fmtdes3,Fpodes,Recmnto2,Entregapos,Fdescu,Md3,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1,Gravamen,Fimpuesto,Totrecar,Totdesc,Totimpue,Merconsign,Cancelar,Ivasis,Tipocrela,Letrarela,Puntorela,Numerorela,Feccrela,Deuda)
					Select isnull( d.FD2,''),isnull( d.INFORMNUBE,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.DATOSECOMM,''),isnull( d.IDCAJA,0),isnull( d.FPODES1,0),isnull( d.FPERSON,''),isnull( d.FTURNO,0),isnull( d.OPECOMM,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.IDAJUSTE,''),isnull( d.ESTTRANS,''),isnull( d.DESCFW,''),isnull( d.SIMBMON,''),isnull( d.FHORA,''),isnull( d.UMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.UALTAFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.HORAEXPO,''),isnull( d.BDMODIFW,''),isnull( d.TIMESTAMP,0),isnull( d.FACTSEC,''),isnull( d.TOTALCANT,0),isnull( d.MDCIMPU,0),isnull( d.SITFISCCLI,0),isnull( d.RECMNTOSI,0),isnull( d.FSUBTON,0),isnull( d.FPODES2,0),isnull( d.FSUBTOT,0),isnull( d.SIGNOMOV,0),isnull( d.FACTTIPO,0),isnull( d.CONDIVALP,0),isnull( d.SUBTOTSISI,0),isnull( d.SUBTOTCISI,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTOSI2,0),isnull( d.FAJXRE,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI,0),isnull( d.FCOMPFIS,0),isnull( d.DESAUT,0),isnull( d.ANULADO,0),isnull( d.ORIGONLINE,0),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.MOTDESCDEV,''),isnull( d.FOBS,''),isnull( d.FCUIT,''),isnull( d.MD1,0),isnull( d.FCLIENTE,''),isnull( d.IDSENIA,''),isnull( d.FMTDES2,0),isnull( d.FMTDES1,0),isnull( d.CODIGO,''),isnull( d.DESMNTOSI3,0),isnull( d.RECEPTOR,''),isnull( d.FVEN,''),isnull( d.TOTDESCSI,0),isnull( d.TDCI,0),isnull( d.MONEDA,''),isnull( d.FLETRA,''),isnull( d.CODLISTA,''),isnull( d.EMAIL,''),isnull( d.VTOSENIA,''),isnull( d.FPTOVEN,0),isnull( d.TRCI,0),isnull( d.TOTRECARSI,0),isnull( d.FVUELTO,0),isnull( d.FNUMCOMP,0),isnull( d.FTOTAL,0),isnull( d.FFCH,''),isnull( d.COTIZ,0),isnull( d.FMTDES3,0),isnull( d.FPODES,0),isnull( d.RECMNTO2,0),isnull( d.ENTREGAPOS,0),isnull( d.FDESCU,0),isnull( d.MD3,0),isnull( d.PERCEPCION,0),isnull( d.RECMNTO,0),isnull( d.RECPOR,0),isnull( d.MR,0),isnull( d.MR2,0),isnull( d.MD2,0),isnull( d.MR1,0),isnull( d.RECMNTO1,0),isnull( d.GRAVAMEN,0),isnull( d.FIMPUESTO,0),isnull( d.TOTRECAR,0),isnull( d.TOTDESC,0),isnull( d.TOTIMPUE,0),isnull( d.MERCONSIGN,0),isnull( d.CANCELAR,0),isnull( d.IVASIS,0),isnull( d.TIPOCRELA,0),isnull( d.LETRARELA,''),isnull( d.PUNTORELA,0),isnull( d.NUMERORELA,0),isnull( d.FECCRELA,''),isnull( d.DEUDA,0)
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA DE COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal no es la esperada'
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
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: TIPO DE COMPROBANTE ' + cast( d.FACTTIPO as Varchar(2) ) + ', LETRA DE COMPROBANTE ' + cast( d.FLETRA as Varchar(1) ) + ', PTO. VENTA ' + cast( d.FPTOVEN as Varchar(4) ) + ', NÚMERO ' + cast( d.FNUMCOMP as Varchar(8) ) + ', SECUENCIA ' + cast( d.FACTSEC as Varchar(2) ) + '','La clave principal a importar ya existe'
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
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FART = isnull( d.FART, t.FART ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.CONRESTR = isnull( d.CONRESTR, t.CONRESTR ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
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
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.COMP = isnull( d.COMP, t.COMP ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.GIFTCARD = isnull( d.GIFTCARD, t.GIFTCARD ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.EQUIV = isnull( d.EQUIV, t.EQUIV ),
t.FTXT = isnull( d.FTXT, t.FTXT ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.MNTPIVA = isnull( d.MNTPIVA, t.MNTPIVA ),
t.MNTPINT = isnull( d.MNTPINT, t.MNTPINT ),
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
"AFELETRA",
"AFEPTOVEN",
"CODGTIN",
"FART",
"FUNID",
"IDKIT",
"CODAUTDJCP",
"IDITEM",
"AFE_COD",
"MNTPTOT",
"MNTPPER",
"AFETS",
"MNTPDESCI",
"CONRESTR",
"MNTPRECCI",
"MNPDSI",
"AJUCIMP",
"FBRUTO",
"TASAIMPINT",
"AJUSIMP",
"PRECIOSR",
"IMPINTERNO",
"PRECIOCISR",
"MNTPDESSI",
"MNDESSI",
"MNDESCI",
"MNTPRECSI",
"PRECIOSISR",
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
"IDITEMORIG",
"AFENROITEM",
"PRUNCONIMP",
"AFECANT",
"CIDITEM",
"PRUNSINIMP",
"COMP",
"FPRUN",
"AFETIPOCOM",
"FN11",
"USARPLISTA",
"PROCSTOCK",
"ARTSINDES",
"GIFTCARD",
"CODIGO",
"MOTDESCU",
"MOTDEVOL",
"EQUIV",
"FTXT",
"CCOLOR",
"MNTPIVA",
"MNTPINT",
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
d.AFELETRA,
d.AFEPTOVEN,
d.CODGTIN,
d.FART,
d.FUNID,
d.IDKIT,
d.CODAUTDJCP,
d.IDITEM,
d.AFE_COD,
d.MNTPTOT,
d.MNTPPER,
d.AFETS,
d.MNTPDESCI,
d.CONRESTR,
d.MNTPRECCI,
d.MNPDSI,
d.AJUCIMP,
d.FBRUTO,
d.TASAIMPINT,
d.AJUSIMP,
d.PRECIOSR,
d.IMPINTERNO,
d.PRECIOCISR,
d.MNTPDESSI,
d.MNDESSI,
d.MNDESCI,
d.MNTPRECSI,
d.PRECIOSISR,
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
d.IDITEMORIG,
d.AFENROITEM,
d.PRUNCONIMP,
d.AFECANT,
d.CIDITEM,
d.PRUNSINIMP,
d.COMP,
d.FPRUN,
d.AFETIPOCOM,
d.FN11,
d.USARPLISTA,
d.PROCSTOCK,
d.ARTSINDES,
d.GIFTCARD,
d.CODIGO,
d.MOTDESCU,
d.MOTDEVOL,
d.EQUIV,
d.FTXT,
d.CCOLOR,
d.MNTPIVA,
d.MNTPINT,
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
	function ObtenerTriggerDeleteImportacion_KITDET( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_KITDET
ON ZooLogic.TablaTrabajo_COMPROBANTEV_KITDET
AFTER DELETE
As
Begin
Update t Set 
t.AFEPTOVEN = isnull( d.AFEPTOVEN, t.AFEPTOVEN ),
t.AFELETRA = isnull( d.AFELETRA, t.AFELETRA ),
t.AFENUMCOM = isnull( d.AFENUMCOM, t.AFENUMCOM ),
t.CODGTIN = isnull( d.CODGTIN, t.CODGTIN ),
t.FART = isnull( d.FART, t.FART ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.MNTPPER = isnull( d.MNTPPER, t.MNTPPER ),
t.MNTPTOT = isnull( d.MNTPTOT, t.MNTPTOT ),
t.MNTPDESCI = isnull( d.MNTPDESCI, t.MNTPDESCI ),
t.AFETS = isnull( d.AFETS, t.AFETS ),
t.CONRESTR = isnull( d.CONRESTR, t.CONRESTR ),
t.MNTPRECCI = isnull( d.MNTPRECCI, t.MNTPRECCI ),
t.MNPDSI = isnull( d.MNPDSI, t.MNPDSI ),
t.MNTPRECSI = isnull( d.MNTPRECSI, t.MNTPRECSI ),
t.AJUSIMP = isnull( d.AJUSIMP, t.AJUSIMP ),
t.AJUCIMP = isnull( d.AJUCIMP, t.AJUCIMP ),
t.IMPINTERNO = isnull( d.IMPINTERNO, t.IMPINTERNO ),
t.TASAIMPINT = isnull( d.TASAIMPINT, t.TASAIMPINT ),
t.FBRUTO = isnull( d.FBRUTO, t.FBRUTO ),
t.PRECIOSR = isnull( d.PRECIOSR, t.PRECIOSR ),
t.MNDESCI = isnull( d.MNDESCI, t.MNDESCI ),
t.PRECIOSISR = isnull( d.PRECIOSISR, t.PRECIOSISR ),
t.MNDESSI = isnull( d.MNDESSI, t.MNDESSI ),
t.MNTPDESSI = isnull( d.MNTPDESSI, t.MNTPDESSI ),
t.PRECIOCISR = isnull( d.PRECIOCISR, t.PRECIOCISR ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
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
t.COMP = isnull( d.COMP, t.COMP ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.ACONDIVAV = isnull( d.ACONDIVAV, t.ACONDIVAV ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.APORCIVAV = isnull( d.APORCIVAV, t.APORCIVAV ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
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
from ZooLogic.KITDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.KITDET
( 
"AFEPTOVEN",
"AFELETRA",
"AFENUMCOM",
"CODGTIN",
"FART",
"FUNID",
"CODAUTDJCP",
"IDKIT",
"IDITEM",
"AFE_COD",
"MNTPPER",
"MNTPTOT",
"MNTPDESCI",
"AFETS",
"CONRESTR",
"MNTPRECCI",
"MNPDSI",
"MNTPRECSI",
"AJUSIMP",
"AJUCIMP",
"IMPINTERNO",
"TASAIMPINT",
"FBRUTO",
"PRECIOSR",
"MNDESCI",
"PRECIOSISR",
"MNDESSI",
"MNTPDESSI",
"PRECIOCISR",
"AFESALDO",
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
"COMP",
"AFECANT",
"AFETIPOCOM",
"ACONDIVAV",
"AFENROITEM",
"APORCIVAV",
"IDITEMORIG",
"PRUNCONIMP",
"PRUNSINIMP",
"CIDITEM",
"FN11",
"FPRUN",
"ARTSINDES",
"PROCSTOCK",
"USARPLISTA",
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
d.FART,
d.FUNID,
d.CODAUTDJCP,
d.IDKIT,
d.IDITEM,
d.AFE_COD,
d.MNTPPER,
d.MNTPTOT,
d.MNTPDESCI,
d.AFETS,
d.CONRESTR,
d.MNTPRECCI,
d.MNPDSI,
d.MNTPRECSI,
d.AJUSIMP,
d.AJUCIMP,
d.IMPINTERNO,
d.TASAIMPINT,
d.FBRUTO,
d.PRECIOSR,
d.MNDESCI,
d.PRECIOSISR,
d.MNDESSI,
d.MNTPDESSI,
d.PRECIOCISR,
d.AFESALDO,
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
d.COMP,
d.AFECANT,
d.AFETIPOCOM,
d.ACONDIVAV,
d.AFENROITEM,
d.APORCIVAV,
d.IDITEMORIG,
d.PRUNCONIMP,
d.PRUNSINIMP,
d.CIDITEM,
d.FN11,
d.FPRUN,
d.ARTSINDES,
d.PROCSTOCK,
d.USARPLISTA,
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
			if reccount( 'c_NOTADECREDITOELECTRONICADECREDITO' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fueinformadoalanube = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fueinformadoalanube, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechaexpo, ctod( '  /  /    ' ) ) )
					lcValor = This.ObtenerMemo( 'c_Dataecom')
					.Dataecom = lcValor 
					.Caja_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Caja, 0 )
					.Porcentajedescuento1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Porcentajedescuento1, 0 )
					.Cliente_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Cliente, [] )
					.Turno = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Turno, 0 )
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
					.Nroopecommerce = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Nroopecommerce, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Horaaltafw, [] )
					.Codigoajuste = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Codigoajuste, [] )
					.Estadotransferencia = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Estadotransferencia, [] )
					.Descripcionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Descripcionfw, [] )
					.Simbolomonetariocomprobante = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Simbolomonetariocomprobante, [] )
					.Hora = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Hora, [] )
					.Usuariomodificacionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Usuariomodificacionfw, [] )
					.Basededatosaltafw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Basededatosaltafw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Versionmodificacionfw, [] )
					.Usuarioaltafw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Usuarioaltafw, [] )
					.Horamodificacionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Seriemodificacionfw, [] )
					.Seriealtafw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Seriealtafw, [] )
					.Horaimpo = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Horaimpo, [] )
					.Horaexpo = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Horaexpo, [] )
					.Basededatosmodificacionfw = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Basededatosmodificacionfw, [] )
					.Timestamp = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Timestamp, 0 )
					.Secuencia = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Secuencia, [] )
					.Totalcantidad = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totalcantidad, 0 )
					.Montodescuentoconimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentoconimpuestos, 0 )
					.Situacionfiscal_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Situacionfiscal, 0 )
					.Recargomontosinimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontosinimpuestos, 0 )
					.Subtotalneto = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Subtotalneto, 0 )
					.Porcentajedescuento2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Porcentajedescuento2, 0 )
					.Subtotalbruto = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Subtotalbruto, 0 )
					.Signodemovimiento = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Signodemovimiento, 0 )
					.Tipocomprobante = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Tipocomprobante, 0 )
					.Condicioniva = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Condicioniva, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Subtotalsinimpuestossobreitems, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Subtotalconimpuestossobreitems, 0 )
					.Recargomontosinimpuestos1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontosinimpuestos1, 0 )
					.Recargomontosinimpuestos2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontosinimpuestos2, 0 )
					.Ajustesporredondeos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Ajustesporredondeos, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentosinimpuestos, 0 )
					.Comprobantefiscal = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Comprobantefiscal, .F. )
					.Descuentoautomatico = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Descuentoautomatico, .F. )
					.Anulado = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Anulado, .F. )
					.Basadoencomprobanteonline = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Basadoencomprobanteonline, .F. )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Idvuelto_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Monedasistema, [] )
					.Codigomotivodescuentoensubtotal_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Codigomotivodescuentoensubtotal, [] )
					.Obs = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Obs, [] )
					.Cuit = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Cuit, [] )
					.Montodescuento1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuento1, 0 )
					.Clientedescripcion = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Clientedescripcion, [] )
					.Idsenia = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Idsenia, [] )
					.Montodescuentoconimpuestos2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentoconimpuestos2, 0 )
					.Montodescuentoconimpuestos1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentoconimpuestos1, 0 )
					.Codigo = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Codigo, [] )
					.Montodescuentosinimpuestos3 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentosinimpuestos3, 0 )
					.Receptor_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Receptor, [] )
					.Vendedor_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Vendedor, [] )
					.Totaldescuentossinimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totaldescuentossinimpuestos, 0 )
					.Totaldescuentosconimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totaldescuentosconimpuestos, 0 )
					.Articulosseniadosdetalle.Limpiar()
					.Articulosseniadosdetalle.SetearEsNavegacion( .lProcesando )
					.Articulosseniadosdetalle.Cargar()
					.Monedacomprobante_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Monedacomprobante, [] )
					.Letra = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Letra, [] )
					.Listadeprecios_PK =  nvl( c_NOTADECREDITOELECTRONICADECREDITO.Listadeprecios, [] )
					.Kitsdetalle.Limpiar()
					.Kitsdetalle.SetearEsNavegacion( .lProcesando )
					.Kitsdetalle.Cargar()
					.Email = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Email, [] )
					.Fechavtosenia = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechavtosenia, ctod( '  /  /    ' ) ) )
					.Puntodeventa = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Puntodeventa, 0 )
					.Totalrecargosconimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totalrecargosconimpuestos, 0 )
					.Totalrecargossinimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totalrecargossinimpuestos, 0 )
					.Vuelto = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Vuelto, 0 )
					.Numero = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Numero, 0 )
					.Total = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Total, 0 )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fecha, ctod( '  /  /    ' ) ) )
					.Cotizacion = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Cotizacion, 0 )
					.Montodescuentoconimpuestos3 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuentoconimpuestos3, 0 )
					.Porcentajedescuento = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Porcentajedescuento, 0 )
					.Recargomontoconimpuestos2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontoconimpuestos2, 0 )
					.Entregaposterior = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Entregaposterior, 0 )
					.Descuento = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Descuento, 0 )
					.Montodescuento3 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuento3, 0 )
					.Percepciones = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Percepciones, 0 )
					.Recargomontoconimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontoconimpuestos, 0 )
					.Recargoporcentaje = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargoporcentaje, 0 )
					.Recargomonto = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomonto, 0 )
					.Recargomonto2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomonto2, 0 )
					.Montodescuento2 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Montodescuento2, 0 )
					.Recargomonto1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomonto1, 0 )
					.Recargomontoconimpuestos1 = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Recargomontoconimpuestos1, 0 )
					.Gravamenes = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Gravamenes, 0 )
					.Impuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Impuestos, 0 )
					.Totalrecargos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totaldescuentos, 0 )
					.Totalimpuestos = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Totalimpuestos, 0 )
					.Mercaderiaconsignacion = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Mercaderiaconsignacion, .F. )
					.Accioncancelatoria = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Accioncancelatoria, .F. )
					.Ivadelsistema = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Ivadelsistema, 0 )
					.Tipocpterelacionado = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Tipocpterelacionado, 0 )
					.Letracpterelacionado = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Letracpterelacionado, [] )
					.Puntodeventacpterelacionado = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Puntodeventacpterelacionado, 0 )
					.Numerocpterelacionado = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Numerocpterelacionado, 0 )
					.Fechacpterelacionado = GoLibrerias.ObtenerFechaFormateada( nvl( c_NOTADECREDITOELECTRONICADECREDITO.Fechacpterelacionado, ctod( '  /  /    ' ) ) )
					.Deuda = nvl( c_NOTADECREDITOELECTRONICADECREDITO.Deuda, 0 )
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
			lxRetorno = c_NOTADECREDITOELECTRONICADECREDITO.CODIGO
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
		return c_NOTADECREDITOELECTRONICADECREDITO.&lcAtributo
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
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55
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
			"Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Datosecomm" as "Dataecom", "Idcaja" as "Caja", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Opecomm" as "Nroopecommerce", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Idajuste" as "Codigoajuste", "Esttrans" as "Estadotransferencia", "Descfw" as "Descripcionfw", "Simbmon" as "Simbolomonetariocomprobante", "Fhora" as "Hora", "Umodifw" as "Usuariomodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Ualtafw" as "Usuarioaltafw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Saltafw" as "Seriealtafw", "Horaimpo" as "Horaimpo", "Horaexpo" as "Horaexpo", "Bdmodifw" as "Basededatosmodificacionfw", "Timestamp" as "Timestamp", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Mdcimpu" as "Montodescuentoconimpuestos", "Sitfisccli" as "Situacionfiscal", "Recmntosi" as "Recargomontosinimpuestos", "Fsubton" as "Subtotalneto", "Fpodes2" as "Porcentajedescuento2", "Fsubtot" as "Subtotalbruto", "Signomov" as "Signodemovimiento", "Facttipo" as "Tipocomprobante", "Condivalp" as "Condicioniva", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi2" as "Recargomontosinimpuestos2", "Fajxre" as "Ajustesporredondeos", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi" as "Montodescuentosinimpuestos", "Fcompfis" as "Comprobantefiscal", "Desaut" as "Descuentoautomatico", "Anulado" as "Anulado", "Origonline" as "Basadoencomprobanteonline", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fcuit" as "Cuit", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Idsenia" as "Idsenia", "Fmtdes2" as "Montodescuentoconimpuestos2", "Fmtdes1" as "Montodescuentoconimpuestos1", "Codigo" as "Codigo", "Desmntosi3" as "Montodescuentosinimpuestos3", "Receptor" as "Receptor", "Fven" as "Vendedor", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Codlista" as "Listadeprecios", "Email" as "Email", "Vtosenia" as "Fechavtosenia", "Fptoven" as "Puntodeventa", "Trci" as "Totalrecargosconimpuestos", "Totrecarsi" as "Totalrecargossinimpuestos", "Fvuelto" as "Vuelto", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Ffch" as "Fecha", "Cotiz" as "Cotizacion", "Fmtdes3" as "Montodescuentoconimpuestos3", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Entregapos" as "Entregaposterior", "Fdescu" as "Descuento", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecar" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Merconsign" as "Mercaderiaconsignacion", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema", "Tipocrela" as "Tipocpterelacionado", "Letrarela" as "Letracpterelacionado", "Puntorela" as "Puntodeventacpterelacionado", "Numerorela" as "Numerocpterelacionado", "Feccrela" as "Fechacpterelacionado", "Deuda" as "Deuda"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55
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
	Filtro = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55"
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
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAMODIFICACION                       " tabla="COMPROBANTEV   " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FUEINFORMADOALANUBE                     " tabla="COMPROBANTEV   " campo="INFORMNUBE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHATRANSFERENCIA                      " tabla="COMPROBANTEV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAIMPO                               " tabla="COMPROBANTEV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAEXPO                               " tabla="COMPROBANTEV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="DATAECOM                                " tabla="COMPROBANTEV   " campo="DATOSECOMM" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="TEXTO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CAJA                                    " tabla="COMPROBANTEV   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                                                                                                                      " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PORCENTAJEDESCUENTO1                    " tabla="COMPROBANTEV   " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 1                                                                                                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CLIENTE                                 " tabla="COMPROBANTEV   " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                                                                                                                   " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TURNO                                   " tabla="COMPROBANTEV   " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                                                                                                                     " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FACTURADETALLE                          " tabla="COMPROBANTEVDET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMARTICULOSVENTAS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VALORESDETALLE                          " tabla="VAL            " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Valores                                                                                                                                                                                                                                                   " dominio="DETALLEITEMVALORES            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IMPUESTOSDETALLE                        " tabla="IMPUESTOSV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOS          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="NROOPECOMMERCE                          " tabla="COMPROBANTEV   " campo="OPECOMM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Nro. op. ecommerce                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAALTAFW                             " tabla="COMPROBANTEV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="HORAALTAFW                              " tabla="COMPROBANTEV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CODIGOAJUSTE                            " tabla="COMPROBANTEV   " campo="IDAJUSTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo de Ajuste                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPROBANTEV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="DESCRIPCIONFW                           " tabla="COMPROBANTEV   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="COMPROBANTEV   " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="HORA                                    " tabla="COMPROBANTEV   " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="BASEDEDATOSALTAFW                       " tabla="COMPROBANTEV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ZADSFW                                  " tabla="COMPROBANTEV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VERSIONALTAFW                           " tabla="COMPROBANTEV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="USUARIOALTAFW                           " tabla="COMPROBANTEV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="HORAMODIFICACIONFW                      " tabla="COMPROBANTEV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SERIEMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SERIEALTAFW                             " tabla="COMPROBANTEV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="HORAIMPO                                " tabla="COMPROBANTEV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="HORAEXPO                                " tabla="COMPROBANTEV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPROBANTEV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TIMESTAMP                               " tabla="COMPROBANTEV   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SECUENCIA                               " tabla="COMPROBANTEV   " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Secuencia                                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALCANTIDAD                           " tabla="COMPROBANTEV   " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total Cantidad                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOCONIMPUESTOS              " tabla="COMPROBANTEV   " campo="MDCIMPU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SITUACIONFISCAL                         " tabla="COMPROBANTEV   " campo="SITFISCCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="=3                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALNETO                            " tabla="COMPROBANTEV   " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PORCENTAJEDESCUENTO2                    " tabla="COMPROBANTEV   " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 2                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALBRUTO                           " tabla="COMPROBANTEV   " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPROBANTEV   " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="-1                                                                                                                                                                                                                                                            " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TIPOCOMPROBANTE                         " tabla="COMPROBANTEV   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="=55                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="18" etiqueta="Tipo de comprobante                                                                                                                                                                                                                                       " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CONDICIONIVA                            " tabla="COMPROBANTEV   " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="AJUSTESPORREDONDEOS                     " tabla="COMPROBANTEV   " campo="FAJXRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Ajustes por redondeo                                                                                                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="COMPROBANTEV   " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="COMPROBANTEV   " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="COMPROBANTEV   " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="COMPROBANTEFISCAL                       " tabla="COMPROBANTEV   " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="DESCUENTOAUTOMATICO                     " tabla="COMPROBANTEV   " campo="DESAUT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ANULADO                                 " tabla="COMPROBANTEV   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="BASADOENCOMPROBANTEONLINE               " tabla="COMPROBANTEV   " campo="ORIGONLINE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPVENTAS      " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos del comprobante                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOVENTAS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IDVUELTO                                " tabla="COMPROBANTEV   " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONEDASISTEMA                           " tabla="COMPROBANTEV   " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CODIGOMOTIVODESCUENTOENSUBTOTAL         " tabla="COMPROBANTEV   " campo="MOTDESCDEV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVODESCUENTOYDEVOLUCION              " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="OBS                                     " tabla="COMPROBANTEV   " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CUIT                                    " tabla="COMPROBANTEV   " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="CUIT                                                                                                                                                                                                                                                      " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTO1                         " tabla="COMPROBANTEV   " campo="MD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento 1                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CLIENTEDESCRIPCION                      " tabla="COMPROBANTEV   " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Cliente descripción                                                                                                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IDSENIA                                 " tabla="COMPROBANTEV   " campo="IDSENIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id del comprobante seña                                                                                                                                                                                                                                   " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="COMPROBANTEV   " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 2                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="COMPROBANTEV   " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 1                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CODIGO                                  " tabla="COMPROBANTEV   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="20" etiqueta="Código número                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="COMPROBANTEV   " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento sin impuestos 3                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="5" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECEPTOR                                " tabla="COMPROBANTEV   " campo="RECEPTOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Despachar a                                                                                                                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VENDEDOR                                " tabla="COMPROBANTEV   " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Vendedor                                                                                                                                                                                                                                                  " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="COMPROBANTEV   " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALDESCUENTOSCONIMPUESTOS             " tabla="COMPROBANTEV   " campo="TDCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos con impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="3" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ARTICULOSSENIADOSDETALLE                " tabla="SENIAVDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Artículos señados                                                                                                                                                                                                                                         " dominio="DETALLEITEMARTICULOSSENIADOS  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONEDACOMPROBANTE                       " tabla="COMPROBANTEV   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="414" etiqueta="Moneda                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="LETRA                                   " tabla="COMPROBANTEV   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra de comprobante                                                                                                                                                                                                                                      " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CODIGOBARRACAE                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código de barra                                                                                                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="LISTADEPRECIOS                          " tabla="COMPROBANTEV   " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferente                                                                                                                                                                                         " obligatorio="true" admitebusqueda="416" etiqueta="Lista de precio                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="KITSDETALLE                             " tabla="KITDET         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Detalle de kits                                                                                                                                                                                                                                           " dominio="DETALLEITEMKITS               " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="4" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="EMAIL                                   " tabla="COMPROBANTEV   " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Email                                                                                                                                                                                                                                                     " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAVTOSENIA                           " tabla="COMPROBANTEV   " campo="VTOSENIA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Vencimiento de la seña                                                                                                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PUNTODEVENTA                            " tabla="COMPROBANTEV   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                                                                                                                " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALRECARGOSCONIMPUESTOS               " tabla="COMPROBANTEV   " campo="TRCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="COMPROBANTEV   " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo sin impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VUELTO                                  " tabla="COMPROBANTEV   " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto persistido                                                                                                                                                                                                                                         " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="VUELTOVIRTUAL                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Vuelto                                                                                                                                                                                                                                                    " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="NUMERO                                  " tabla="COMPROBANTEV   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="NUMEROCOMPROBANTE             " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="X 9999-99999999          " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTAL                                   " tabla="COMPROBANTEV   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                                                                                                                     " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHA                                   " tabla="COMPROBANTEV   " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="COTIZACION                              " tabla="COMPROBANTEV   " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="426" etiqueta="Cotización                                                                                                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="COMPROBANTEV   " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 3                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="CAE                                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="C.A.E.                                                                                                                                                                                                                                                    " dominio="CAE                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PORCENTAJEDESCUENTO                     " tabla="COMPROBANTEV   " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Porcentaje de descuento                                                                                                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAVENCIMIENTOCAE                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Vto C.A.E.                                                                                                                                                                                                                                                " dominio="CAE                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHAVENCIMIENTOMIPYME                  " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha() + goparametros.felino.gestionDEVENTAS.facTURACIONELECTRONICA.fechaDEVENCIMIENTOSUGERIDAPARALOSCOMPROBANTESDECREDITOENDIAS                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Vto pago                                                                                                                                                                                                                                                  " dominio="DATOSMIPYME                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="OPCIONTRANSMISIONMIPYME                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=iif(inlist(goparametros.felino.gestiondeventas.facturacionelectronica.opciondetransmisionparacomprobantesdecreditomipyme,2,4),&quot;SCA&quot;,&quot;ADC&quot;)                                                                                                                   " obligatorio="false" admitebusqueda="0" etiqueta="Opción de transmisión                                                                                                                                                                                                                                     " dominio="DATOSMIPYME                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="13" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ENTREGAPOSTERIOR                        " tabla="COMPROBANTEV   " campo="ENTREGAPOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Tipo entrega                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="15" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="DESCUENTO                               " tabla="COMPROBANTEV   " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Monto % descuento                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTO3                         " tabla="COMPROBANTEV   " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Monto de descuento                                                                                                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PERCEPCIONES                            " tabla="COMPROBANTEV   " campo="PERCEPCION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepciones                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOPORCENTAJE                       " tabla="COMPROBANTEV   " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="438" etiqueta="Recargo porcentaje                                                                                                                                                                                                                                        " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTO                            " tabla="COMPROBANTEV   " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Recargo % monto                                                                                                                                                                                                                                           " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTO2                           " tabla="COMPROBANTEV   " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Recargo monto                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTO2                         " tabla="COMPROBANTEV   " campo="MD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento valores                                                                                                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MONTODESCUENTO2VISUAL                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Descuentos en valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTO1                           " tabla="COMPROBANTEV   " campo="MR1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto recargo valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTO1VISUAL                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Monto de recargo valores                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALSINIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal sin imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="GRAVAMENES                              " tabla="COMPROBANTEV   " campo="GRAVAMEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Interno                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IMPUESTOS                               " tabla="COMPROBANTEV   " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="I.V.A.                                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="SUBTOTALCONIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal con imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALRECARGOS                           " tabla="COMPROBANTEV   " campo="TOTRECAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargo                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALDESCUENTOS                         " tabla="COMPROBANTEV   " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuento                                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="28" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TOTALIMPUESTOS                          " tabla="COMPROBANTEV   " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Total impuestos                                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="MERCADERIACONSIGNACION                  " tabla="COMPROBANTEV   " campo="MERCONSIGN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Mercadería en consignación                                                                                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="65" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ACCIONCANCELATORIA                      " tabla="COMPROBANTEV   " campo="CANCELAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="80" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="IVADELSISTEMA                           " tabla="COMPROBANTEV   " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="TIPOCPTERELACIONADO                     " tabla="COMPROBANTEV   " campo="TIPOCRELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Tipo comprobante asociado                                                                                                                                                                                                                                 " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="90" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="LETRACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="LETRARELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Comprobante asociado                                                                                                                                                                                                                                      " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="91" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="PUNTODEVENTACPTERELACIONADO             " tabla="COMPROBANTEV   " campo="PUNTORELA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="Pto. de venta comprobante asociado                                                                                                                                                                                                                        " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="92" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="NUMEROCPTERELACIONADO                   " tabla="COMPROBANTEV   " campo="NUMERORELA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Número comprobante asociado                                                                                                                                                                                                                               " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="93" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="FECHACPTERELACIONADO                    " tabla="COMPROBANTEV   " campo="FECCRELA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="460" etiqueta="Fecha comprobante asociado                                                                                                                                                                                                                                " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="94" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="ENTREGAPOSTERIORVIRTUAL                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="462" etiqueta="Tipo de entrega                                                                                                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="95" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="NOTADECREDITOELECTRONICADECREDITO       " atributo="DEUDA                                   " tabla="COMPROBANTEV   " campo="DEUDA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="464" etiqueta="Saldo de cta. cte.                                                                                                                                                                                                                                        " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="97" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="185" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="17" etiqueta="Detalle Des.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.RECEPTOR = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Ven.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPROBANTEV.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Mon.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COMPROBANTEV.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Lis.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMPROBANTEV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULO                                " tabla="COMPROBANTEVDET" campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CONSOPORTEPREPANTALLA         " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULODETALLE                         " tabla="COMPROBANTEVDET" campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Artículo descripción                                                                                                                          " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLOR                                   " tabla="COMPROBANTEVDET" campo="CCOLOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLORDETALLE                            " tabla="COMPROBANTEVDET" campo="FCOLTXT   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Color descripción                                                                                                                             " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Color.Descripcion                                                                                                                                                                                                                                             " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="TALLE                                   " tabla="COMPROBANTEVDET" campo="TALLE     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Talle                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="CANTIDAD                                " tabla="COMPROBANTEVDET" campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="=this.CompletarCantidadSegunParametro()                                                                                                                                                                                                                       " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Cantidad                                                                                                                                      " dominio="NUMERICODECIMALPARAMETRIZADO  " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="23" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="PRECIO                                  " tabla="COMPROBANTEVDET" campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="DESCUENTO                               " tabla="COMPROBANTEVDET" campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, % Descuento                                                                                                                                   " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="26" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTODESCUENTO                          " tabla="COMPROBANTEVDET" campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Monto descuento                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="27" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTO                                   " tabla="COMPROBANTEVDET" campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND COMPROBANTEV.FACTTIPO = 55                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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