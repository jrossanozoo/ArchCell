
define class Din_EntidadFACTURAAGRUPADAAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_FACTURAAGRUPADA'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( TipoComprobante, 2, 0) + Letra + str( PuntoDeVenta, 4, 0) + str( Numero, 8, 0) + Secuencia]
	cExpresionCCPorCampos = [str( #tabla#.FACTTIPO, 2, 0) + #tabla#.FLETRA + str( #tabla#.FPTOVEN, 4, 0) + str( #tabla#.FNUMCOMP, 8, 0) + #tabla#.FACTSEC]
	cTagClaveCandidata = '_FAGCC'
	cTagClavePk = '_FAGPK'
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
			local  lxComprobantevFecimpo, lxComprobantevFectrans, lxComprobantevFecexpo, lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFmodifw, lxComprobantevVtocai, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevTimestamp, lxComprobantevCai, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevFpodes2, lxComprobantevCondivalp, lxComprobantevSubtotcisi, lxComprobantevFsubtot, lxComprobantevSitfisccli, lxComprobantevFsubton, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevAnulado, lxComprobantevDesaut, lxComprobantevFcompfis, lxComprobantevHoraexpo, lxComprobantevEsttrans, lxComprobantevOpecomm, lxComprobantevBdmodifw, lxComprobantevBdaltafw, lxComprobantevSaltafw, lxComprobantevCbautoimp, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevUmodifw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevIdajuste, lxComprobantevDespachos, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevSimbmon, lxComprobantevFacttipo, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevFmtdes2, lxComprobantevIdsenia, lxComprobantevSenia, lxComprobantevCodigo, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevCodlista, lxComprobantevFptoven, lxComprobantevEmail, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevDirentr, lxComprobantevFfch, lxComprobantevFmtdes3, lxComprobantevDeuda, lxComprobantevCotiz, lxComprobantevFpago, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFvuelto, lxComprobantevEntregapos, lxComprobantevFfchvtopag, lxComprobantevOpctrasmis, lxComprobantevFdescu, lxComprobantevMerconsign, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevChequer, lxComprobantevCancelar, lxComprobantevIvasis
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevVtocai =  .Fechavtocai			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevCai =  .Cai			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevCbautoimp =  .Codigobarraautoimpresor			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevDespachos =  .Despachos			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevIdsenia =  .Idsenia			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevCodigo =  .Codigo			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevEmail =  .Email			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevDirentr =  .Direccionentrega			lxComprobantevFfch =  .Fecha			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevDeuda =  .Deuda			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFvuelto =  .Vuelto			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFfchvtopag =  .Fechavencimientomipyme			lxComprobantevOpctrasmis =  .Opciontransmisionmipyme			lxComprobantevFdescu =  .Descuento			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevChequer =  .Chequereintegro			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema
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
				insert into ZooLogic.COMPROBANTEV ( "Fecimpo","Fectrans","Fecexpo","Fd2","Informnube","Fmodifw","Vtocai","Fcuit","Idcaja","Fajxre","Mdcimpu","Timestamp","Cai","Factsec","Totalcant","Fpodes2","Condivalp","Subtotcisi","Fsubtot","Sitfisccli","Fsubton","Signomov","Subtotsisi","Recmntosi2","Desmntosi2","Desmntosi1","Desmntosi3","Desmntosi","Recmntosi1","Recmntosi","Anulado","Desaut","Fcompfis","Horaexpo","Esttrans","Opecomm","Bdmodifw","Bdaltafw","Saltafw","Cbautoimp","Descfw","Fhora","Zadsfw","Umodifw","Valtafw","Vmodifw","Hmodifw","Smodifw","Horaimpo","Ualtafw","Idajuste","Despachos","Faltafw","Haltafw","Simbmon","Facttipo","Idvuelto","Monsis","Motdescdev","Fobs","Fpodes1","Fperson","Fturno","Fmtdes2","Idsenia","Senia","Codigo","Md1","Fcliente","Fmtdes1","Receptor","Fven","Moneda","Fletra","Vtosenia","Totrecarsi","Trci","Codlista","Fptoven","Email","Fnumcomp","Ftotal","Totdescsi","Tdci","Direntr","Ffch","Fmtdes3","Deuda","Cotiz","Fpago","Fpodes","Recmnto2","Fvuelto","Entregapos","Ffchvtopag","Opctrasmis","Fdescu","Merconsign","Md3","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecarci","Totdesc","Totimpue","Chequer","Cancelar","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtocai ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevFajxre >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevTimestamp >>, <<lxComprobantevCai >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevFsubtot >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFsubton >>, <<lxComprobantevSignomov >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCbautoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDespachos ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<lxComprobantevFacttipo >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<lxComprobantevFptoven >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFtotal >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<"'" + this.FormatearTextoSql( lxComprobantevDirentr ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevDeuda >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'" >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevFvuelto >>, <<lxComprobantevEntregapos >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpctrasmis ) + "'" >>, <<lxComprobantevFdescu >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecarci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<"'" + this.FormatearTextoSql( lxComprobantevChequer ) + "'" >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >> )
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
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.COMPROBANTEVDET" )
this.xmlacursor( lcXml, 'c_COMPROBANTEVDETciditem' )
loItem.idItem = c_COMPROBANTEVDETciditem.ciditem
use in select( 'c_COMPROBANTEVDETciditem' )
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
			for each loItem in this.oEntidad.PromocionesDetalle
				if this.oEntidad.PromocionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPromociontipo = loItem.Promociontipo
					lxNroitem = lnContadorNroItem
					lxPromocion_PK = loItem.Promocion_PK
					lxPromociondetalle = loItem.Promociondetalle
					lxCantidad = loItem.Cantidad
					lxBeneficio = loItem.Beneficio
					lxIditempromocion = loItem.Iditempromocion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PromDet("Tipo","NROITEM","Codigo","Promo","descrip","Cantidad","Beneficio","IdItem" ) values ( <<lxPromociontipo>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromocion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromociondetalle ) + "'">>, <<lxCantidad>>, <<lxBeneficio>>, <<"'" + this.FormatearTextoSql( lxIditempromocion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PromoArticulosDetalle
				if this.oEntidad.PromoArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobeneficio = loItem.Montobeneficio
					lxNroitem = lnContadorNroItem
					lxIditemvalor = loItem.Iditemvalor
					lxAtributocabecera = loItem.Atributocabecera
					lxIditemarticulo = loItem.Iditemarticulo
					lxIditempromo = loItem.Iditempromo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ProArtDet("Monto","NROITEM","IdValor","AtrCabever","IdArti","IdPromo","CODIGO" ) values ( <<lxMontobeneficio>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxIditemvalor ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributocabecera ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditempromo ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajecfi = loItem.Porcentajecfi
					lxAfe_saldo = loItem.Afe_saldo
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNeto = loItem.Neto
					lxKit = loItem.Kit
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontoiva = loItem.Montoiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
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
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FX2","NroItem","FporCFI","AfeSaldo","FporDTO1","FNETO","FKIT","FmtoCFI","FmtoDTO1","fporIva","FmtoIVA","Prunsinimp","prunconimp","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","FAMate","Afe_cod","IDKIT","IdItem","CODIGO","GiftCard","MotDevol","FUnid","MotDescu","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajecfi>>, <<lxAfe_saldo>>, <<lxPorcentajedto1>>, <<lxNeto>>, <<lxKit>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxMontoiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.SeniaVDet" )
this.xmlacursor( lcXml, 'c_SeniaVDetciditem' )
loItem.idItem = c_SeniaVDetciditem.ciditem
use in select( 'c_SeniaVDetciditem' )
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
			local  lxComprobantevFecimpo, lxComprobantevFectrans, lxComprobantevFecexpo, lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFmodifw, lxComprobantevVtocai, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevTimestamp, lxComprobantevCai, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevFpodes2, lxComprobantevCondivalp, lxComprobantevSubtotcisi, lxComprobantevFsubtot, lxComprobantevSitfisccli, lxComprobantevFsubton, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevAnulado, lxComprobantevDesaut, lxComprobantevFcompfis, lxComprobantevHoraexpo, lxComprobantevEsttrans, lxComprobantevOpecomm, lxComprobantevBdmodifw, lxComprobantevBdaltafw, lxComprobantevSaltafw, lxComprobantevCbautoimp, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevUmodifw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevIdajuste, lxComprobantevDespachos, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevSimbmon, lxComprobantevFacttipo, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevFmtdes2, lxComprobantevIdsenia, lxComprobantevSenia, lxComprobantevCodigo, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevCodlista, lxComprobantevFptoven, lxComprobantevEmail, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevDirentr, lxComprobantevFfch, lxComprobantevFmtdes3, lxComprobantevDeuda, lxComprobantevCotiz, lxComprobantevFpago, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFvuelto, lxComprobantevEntregapos, lxComprobantevFfchvtopag, lxComprobantevOpctrasmis, lxComprobantevFdescu, lxComprobantevMerconsign, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevChequer, lxComprobantevCancelar, lxComprobantevIvasis
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevVtocai =  .Fechavtocai			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevCai =  .Cai			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevCbautoimp =  .Codigobarraautoimpresor			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevDespachos =  .Despachos			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevIdsenia =  .Idsenia			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevCodigo =  .Codigo			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevEmail =  .Email			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevDirentr =  .Direccionentrega			lxComprobantevFfch =  .Fecha			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevDeuda =  .Deuda			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFvuelto =  .Vuelto			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFfchvtopag =  .Fechavencimientomipyme			lxComprobantevOpctrasmis =  .Opciontransmisionmipyme			lxComprobantevFdescu =  .Descuento			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevChequer =  .Chequereintegro			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema
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
				update ZooLogic.COMPROBANTEV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>,"Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>,"Informnube" = <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>,"Vtocai" = <<"'" + this.ConvertirDateSql( lxComprobantevVtocai ) + "'">>,"Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>,"Idcaja" = <<lxComprobantevIdcaja>>,"Fajxre" = <<lxComprobantevFajxre>>,"Mdcimpu" = <<lxComprobantevMdcimpu>>,"Timestamp" = <<lxComprobantevTimestamp>>,"Cai" = <<lxComprobantevCai>>,"Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>,"Totalcant" = <<lxComprobantevTotalcant>>,"Fpodes2" = <<lxComprobantevFpodes2>>,"Condivalp" = <<lxComprobantevCondivalp>>,"Subtotcisi" = <<lxComprobantevSubtotcisi>>,"Fsubtot" = <<lxComprobantevFsubtot>>,"Sitfisccli" = <<lxComprobantevSitfisccli>>,"Fsubton" = <<lxComprobantevFsubton>>,"Signomov" = <<lxComprobantevSignomov>>,"Subtotsisi" = <<lxComprobantevSubtotsisi>>,"Recmntosi2" = <<lxComprobantevRecmntosi2>>,"Desmntosi2" = <<lxComprobantevDesmntosi2>>,"Desmntosi1" = <<lxComprobantevDesmntosi1>>,"Desmntosi3" = <<lxComprobantevDesmntosi3>>,"Desmntosi" = <<lxComprobantevDesmntosi>>,"Recmntosi1" = <<lxComprobantevRecmntosi1>>,"Recmntosi" = <<lxComprobantevRecmntosi>>,"Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>,"Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>,"Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>,"Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>,"Cbautoimp" = <<"'" + this.FormatearTextoSql( lxComprobantevCbautoimp ) + "'">>,"Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>,"Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>,"Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>,"Despachos" = <<"'" + this.FormatearTextoSql( lxComprobantevDespachos ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>,"Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>,"Facttipo" = <<lxComprobantevFacttipo>>,"Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>,"Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>,"Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>,"Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>,"Fpodes1" = <<lxComprobantevFpodes1>>,"Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>,"Fturno" = <<lxComprobantevFturno>>,"Fmtdes2" = <<lxComprobantevFmtdes2>>,"Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>,"Senia" = <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>,"Md1" = <<lxComprobantevMd1>>,"Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>,"Fmtdes1" = <<lxComprobantevFmtdes1>>,"Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>,"Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>,"Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>,"Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>,"Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>,"Totrecarsi" = <<lxComprobantevTotrecarsi>>,"Trci" = <<lxComprobantevTrci>>,"Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>,"Fptoven" = <<lxComprobantevFptoven>>,"Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>,"Fnumcomp" = <<lxComprobantevFnumcomp>>,"Ftotal" = <<lxComprobantevFtotal>>,"Totdescsi" = <<lxComprobantevTotdescsi>>,"Tdci" = <<lxComprobantevTdci>>,"Direntr" = <<"'" + this.FormatearTextoSql( lxComprobantevDirentr ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>,"Fmtdes3" = <<lxComprobantevFmtdes3>>,"Deuda" = <<lxComprobantevDeuda>>,"Cotiz" = <<lxComprobantevCotiz>>,"Fpago" = <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'">>,"Fpodes" = <<lxComprobantevFpodes>>,"Recmnto2" = <<lxComprobantevRecmnto2>>,"Fvuelto" = <<lxComprobantevFvuelto>>,"Entregapos" = <<lxComprobantevEntregapos>>,"Ffchvtopag" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'">>,"Opctrasmis" = <<"'" + this.FormatearTextoSql( lxComprobantevOpctrasmis ) + "'">>,"Fdescu" = <<lxComprobantevFdescu>>,"Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>,"Md3" = <<lxComprobantevMd3>>,"Percepcion" = <<lxComprobantevPercepcion>>,"Recmnto" = <<lxComprobantevRecmnto>>,"Recpor" = <<lxComprobantevRecpor>>,"Mr" = <<lxComprobantevMr>>,"Mr2" = <<lxComprobantevMr2>>,"Md2" = <<lxComprobantevMd2>>,"Mr1" = <<lxComprobantevMr1>>,"Recmnto1" = <<lxComprobantevRecmnto1>>,"Gravamen" = <<lxComprobantevGravamen>>,"Fimpuesto" = <<lxComprobantevFimpuesto>>,"Totrecarci" = <<lxComprobantevTotrecarci>>,"Totdesc" = <<lxComprobantevTotdesc>>,"Totimpue" = <<lxComprobantevTotimpue>>,"Chequer" = <<"'" + this.FormatearTextoSql( lxComprobantevChequer ) + "'">>,"Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>,"Ivasis" = <<lxComprobantevIvasis>> where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PromDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ProArtDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KITDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.IMPUESTOSV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

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
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.COMPROBANTEVDET" )
this.xmlacursor( lcXml, 'c_COMPROBANTEVDETciditem' )
loItem.idItem = c_COMPROBANTEVDETciditem.ciditem
use in select( 'c_COMPROBANTEVDETciditem' )
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
			for each loItem in this.oEntidad.PromocionesDetalle
				if this.oEntidad.PromocionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPromociontipo = loItem.Promociontipo
					lxNroitem = lnContadorNroItem
					lxPromocion_PK = loItem.Promocion_PK
					lxPromociondetalle = loItem.Promociondetalle
					lxCantidad = loItem.Cantidad
					lxBeneficio = loItem.Beneficio
					lxIditempromocion = loItem.Iditempromocion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PromDet("Tipo","NROITEM","Codigo","Promo","descrip","Cantidad","Beneficio","IdItem" ) values ( <<lxPromociontipo>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromocion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromociondetalle ) + "'">>, <<lxCantidad>>, <<lxBeneficio>>, <<"'" + this.FormatearTextoSql( lxIditempromocion ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PromoArticulosDetalle
				if this.oEntidad.PromoArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobeneficio = loItem.Montobeneficio
					lxNroitem = lnContadorNroItem
					lxIditemvalor = loItem.Iditemvalor
					lxAtributocabecera = loItem.Atributocabecera
					lxIditemarticulo = loItem.Iditemarticulo
					lxIditempromo = loItem.Iditempromo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ProArtDet("Monto","NROITEM","IdValor","AtrCabever","IdArti","IdPromo","CODIGO" ) values ( <<lxMontobeneficio>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxIditemvalor ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributocabecera ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditempromo ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">> ) 
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
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajecfi = loItem.Porcentajecfi
					lxAfe_saldo = loItem.Afe_saldo
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNeto = loItem.Neto
					lxKit = loItem.Kit
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontoiva = loItem.Montoiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
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
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FX2","NroItem","FporCFI","AfeSaldo","FporDTO1","FNETO","FKIT","FmtoCFI","FmtoDTO1","fporIva","FmtoIVA","Prunsinimp","prunconimp","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","FAMate","Afe_cod","IDKIT","IdItem","CODIGO","GiftCard","MotDevol","FUnid","MotDescu","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajecfi>>, <<lxAfe_saldo>>, <<lxPorcentajedto1>>, <<lxNeto>>, <<lxKit>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxMontoiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.SeniaVDet" )
this.xmlacursor( lcXml, 'c_SeniaVDetciditem' )
loItem.idItem = c_SeniaVDetciditem.ciditem
use in select( 'c_SeniaVDetciditem' )
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.COMPROBANTEV where " + this.ConvertirFuncionesSql( " COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)" ) )
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
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )

			if reccount( 'c_FACTURAAGRUPADA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				select "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) And FACTTIPO = <<lxCOMPROBANTEVFACTTIPO>> and FLETRA = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFLETRA ) + "'">> and FPTOVEN = <<lxCOMPROBANTEVFPTOVEN>> and FNUMCOMP = <<lxCOMPROBANTEVFNUMCOMP>> and FACTSEC = <<"'" + this.FormatearTextoSql( lxCOMPROBANTEVFACTSEC ) + "'">>
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )
			if reccount( 'c_FACTURAAGRUPADA' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				select count( * ) as CantidadDeRegistros from ZooLogic.COMPROBANTEV where "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">> and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) order by FAltaFW,HAltaFW,CODIGO
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  funciones.dtos( FAltaFW ) + funciones.padr( HAltaFW, 8, ' ' ) + funciones.padr( CODIGO, 38, ' ' ) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
				select top 1 "Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) order by FAltaFW desc,HAltaFW desc,CODIGO desc
			endtext
			use in select('c_FACTURAAGRUPADA')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FACTURAAGRUPADA', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fporcfi" as "Porcentajecfi", "Fx2" as "Oferta", "Fpordto1" as "Porcentajedto1", "Nroitem" as "Nroitem", "Fporiva" as "Porcentajeiva", "Afesaldo" as "Afe_saldo", "Fmtodto1" as "Montodto1", "Fmtoiva" as "Montoiva", "Prunconimp" as "Precioconimpuestos", "Fneto" as "Neto", "Prunsinimp" as "Preciosinimpuestos", "Fkit" as "Kit", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fmtocfi" as "Montocfi", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Iditem" as "Iditemarticulos", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Famate" as "Material", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdescu" as "Codigomotivodescuento", "Funid" as "Unidad", "Motdevol" as "Codigomotivodevolucion", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.COMPROBANTEVDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_FacturaDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_FacturaDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_FacturaDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Afetipocom" as "Tipocomprobante", "Afecomprob" as "Tipocompcaracter", "Afeletra" as "Letra", "Afeptoven" as "Puntodeventa", "Afenumcom" as "Numero", "Afefecha" as "Fecha", "Afetotal" as "Total", "Afevend" as "Vendedor", "Afetipo" as "Tipo", "Afecta" as "Afecta", "Descinter" as "Interviniente", "Nominter" as "Nombreentidad", "Codinter" as "Codigoentidad", "Origen" as "Origen" from ZooLogic.CompAfe where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_COMPAFEC')
			this.oConexion.EjecutarSql( lcSentencia, 'c_COMPAFEC', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_COMPAFEC
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion" from ZooLogic.PromDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromocionesDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromocionesDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromocionesDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo" from ZooLogic.ProArtDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_PromoArticulosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_PromoArticulosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_PromoArticulosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afenumcom" as "Afe_numero", "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntpper" as "Montoprorrateopercepciones", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntptot" as "Montoprorrateototal", "Conrestr" as "Tienerestriccion", "Afets" as "Afe_timestamp", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Fbruto" as "Bruto", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Preciosr" as "Preciosinredondear", "Tasaimpint" as "Tasaimpuestointerno", "Preciosisr" as "Preciosinimpuestossinredondear", "Preciocisr" as "Precioconimpuestossinredondear", "Comp" as "Comportamiento", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mndesci" as "Montodescuentoconimpuestos", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mndessi" as "Montodescuentosinimpuestos", "Afecant" as "Afe_cantidad", "Aporcivav" as "Articulo_porcentajeivaventas", "Fneto" as "Neto", "Fmtoiva" as "Montoiva", "Nroitem" as "Nroitem", "Fmtodto1" as "Montodto1", "Fx2" as "Oferta", "Fmtocfi" as "Montocfi", "Artpercep" as "Percepcionivarg5329", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Fporcfi" as "Porcentajecfi", "Fkit" as "Kit", "Fpordto1" as "Porcentajedto1", "Acondivav" as "Articulo_condicionivaventas", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Afetipocom" as "Afe_tipocomprobante", "Ciditem" as "Iditem", "Impinterno" as "Montoimpuestointerno", "Afe_sliq" as "Afe_saldoliquidacion", "Fporiva" as "Porcentajeiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fprun" as "Preciounitario", "Afesaldo" as "Afe_saldo", "Fn11" as "Tipolistadeprecio", "Artsindes" as "Restringirdescuentos", "Procstock" as "Noprocesarstock", "Usarplista" as "Usarpreciodelista", "Idkit" as "Idkit", "Famate" as "Material", "Iditem" as "Iditemarticulos", "Codautdjcp" as "Codigoautorizaciondjcp", "Afe_cod" as "Afe_codigo", "Funid" as "Unidad", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Equiv" as "Equivalencia", "Motdevol" as "Codigomotivodevolucion", "Motdescu" as "Codigomotivodescuento", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcoldet" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntdes" as "Montodescuento", "Mntpiva" as "Montoprorrateoiva", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Seniacance" as "Idseniacancelada", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.KITDET where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_KitsDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_KitsDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_KitsDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Intmonto" as "Montodeimpuestointerno", "Nroitem" as "Nroitem", "Intmonsd" as "Montodeimpuestointernosindescuento", "Ivamngsd" as "Montonogravadosindescuento", "Ivamonng" as "Montonogravado", "Ivaporcent" as "Porcentajedeiva", "Ivamonsd" as "Montodeivasindescuento", "Ivamonto" as "Montodeiva", "Codigo" as "Codigo" from ZooLogic.IMPUESTOSV where Codigo = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Montobase" as "Montobase", "Minimoper" as "Minimo", "Porcen" as "Porcentaje", "Sirecert" as "Certificadosire", "Minoimp" as "Minimonoimponible", "Monto" as "Monto", "Nroitem" as "Nroitem", "Sirecs" as "Codseguridadsire", "Base" as "Basedecalculo", "Regimenimp" as "Regimenimpositivo", "Tipoi" as "Tipoimpuesto", "Codint" as "Codigointerno", "Codimp" as "Codigoimpuesto", "Descri" as "Descripcion", "Jurid" as "Jurisdiccion", "Ccod" as "Codigo", "Artpercep" as "Rg5329porcentaje", "Artperce" as "Rg5329aplicaporarticulo" from ZooLogic.impVentas where cCod = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ImpuestosComprobante')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ImpuestosComprobante', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ImpuestosComprobante
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto" from ZooLogic.SeniaVDet where CODIGO = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ArticulosSeniadosDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ArticulosSeniadosDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ArticulosSeniadosDetalle
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Jjfecha" as "Fechacomp", "Fechcoti" as "Fechaultcotizacion", "Idcaja" as "Caja", "Descmonto" as "Descuentomonto", "Descporc" as "Descuentoporcentaje", "Cotiza" as "Ultimacotizacion", "Monrecpes" as "Recargomontoenpesos", "Monderepes" as "Montodesrecpesos", "Mondespes" as "Descuentomontoenpesos", "Descsinimp" as "Descuentomontosinimpuestos", "Signo" as "Signo", "Nroitem" as "Nroitem", "Numcompr" as "Numerodecomprobante", "Nrocupon" as "Numerocupon", "Pesos" as "Pesosalcambio", "Jjt" as "Tipo", "Ptoventa" as "Puntodeventa", "Jjcotiz" as "Cotiza", "Jjturno" as "Turno", "Esretiroef" as "Esretiroefectivo", "Esvuelto" as "Esvuelto", "Celectro" as "Chequeelectronico", "Visualcaja" as "Visualizarenestadodecaja", "Autorizado" as "Autorizacionpos", "Perscomp" as "Personalizarcomprobante", "Tipcomp" as "Tipodecomprobante", "Redondeo" as "Redondeo", "Nrodoc" as "Nrodocumento", "Tipodoc" as "Tipodocumento", "Iditem" as "Iditemvalores", "Idretiroef" as "Iditemretiroenefectivo", "Jjven" as "Vendedor", "Nrotarjeta" as "Numerotarjeta", "Letra" as "Letra", "Condpago" as "Condiciondepago", "Nrochprop" as "Numerochequepropio", "Nrocheque" as "Numerocheque", "Jjnum" as "Codigo", "Jjco" as "Valor", "Jjde" as "Valordetalle", "Jjfe" as "Fecha", "Nrointerno" as "Numerointerno", "Jjm" as "Monto", "Jrecporc" as "Recargoporcentaje", "Porcdesrec" as "Porcentajedesrec", "Jrecmnt" as "Recargomonto", "Mondesrec" as "Montodesrec", "Jjtotfac" as "Total", "Jjrecib" as "Recibido", "Jrecmntsi" as "Recargomontosinimpuestos", "Montosiste" as "Montoamonedasistema", "Recpesos" as "Recibidoalcambio", "Moncupon" as "Montocupon", "Jrrecsperc" as "Recargosinpercepciones", "Permvuelto" as "Permitevuelto", "Guidcomp" as "Iditemcomponente", "Guidcupon" as "Codigodecupon", "Cupon" as "Cupon", "Valecambio" as "Numerovaledecambio" from ZooLogic.VAL where JJNUM = <<"'" + this.FormatearTextoSql( c_FACTURAAGRUPADA.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_ValoresDetalle')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ValoresDetalle', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_ValoresDetalle
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
			lcXml = this.oConexion.EjecutarSql( "select Fecimpo,Fectrans,Fecexpo,Fd2,Informnube,Fmodifw,Vtocai,Fcuit,Idcaja,Fajxre,Mdcimpu,Timestamp" + ;
",Cai,Factsec,Totalcant,Fpodes2,Condivalp,Subtotcisi,Fsubtot,Sitfisccli,Fsubton,Signomov,Subtotsisi,R" + ;
"ecmntosi2,Desmntosi2,Desmntosi1,Desmntosi3,Desmntosi,Recmntosi1,Recmntosi,Anulado,Desaut,Fcompfis,Ho" + ;
"raexpo,Esttrans,Opecomm,Bdmodifw,Bdaltafw,Saltafw,Cbautoimp,Descfw,Fhora,Zadsfw,Umodifw,Valtafw,Vmod" + ;
"ifw,Hmodifw,Smodifw,Horaimpo,Ualtafw,Idajuste,Despachos,Faltafw,Haltafw,Simbmon,Facttipo,Idvuelto,Mo" + ;
"nsis,Motdescdev,Fobs,Fpodes1,Fperson,Fturno,Fmtdes2,Idsenia,Senia,Codigo,Md1,Fcliente,Fmtdes1,Recept" + ;
"or,Fven,Moneda,Fletra,Vtosenia,Totrecarsi,Trci,Codlista,Fptoven,Email,Fnumcomp,Ftotal,Totdescsi,Tdci" + ;
",Direntr,Ffch,Fmtdes3,Deuda,Cotiz,Fpago,Fpodes,Recmnto2,Fvuelto,Entregapos,Ffchvtopag,Opctrasmis,Fde" + ;
"scu,Merconsign,Md3,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1,Gravamen,Fimpuesto,Totrecarci,T" + ;
"otdesc,Totimpue,Chequer,Cancelar,Ivasis" + ;
" from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27) and " + lcFiltro )
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
			local  lxComprobantevFecimpo, lxComprobantevFectrans, lxComprobantevFecexpo, lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFmodifw, lxComprobantevVtocai, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevTimestamp, lxComprobantevCai, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevFpodes2, lxComprobantevCondivalp, lxComprobantevSubtotcisi, lxComprobantevFsubtot, lxComprobantevSitfisccli, lxComprobantevFsubton, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevAnulado, lxComprobantevDesaut, lxComprobantevFcompfis, lxComprobantevHoraexpo, lxComprobantevEsttrans, lxComprobantevOpecomm, lxComprobantevBdmodifw, lxComprobantevBdaltafw, lxComprobantevSaltafw, lxComprobantevCbautoimp, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevUmodifw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevIdajuste, lxComprobantevDespachos, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevSimbmon, lxComprobantevFacttipo, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevFmtdes2, lxComprobantevIdsenia, lxComprobantevSenia, lxComprobantevCodigo, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevCodlista, lxComprobantevFptoven, lxComprobantevEmail, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevDirentr, lxComprobantevFfch, lxComprobantevFmtdes3, lxComprobantevDeuda, lxComprobantevCotiz, lxComprobantevFpago, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFvuelto, lxComprobantevEntregapos, lxComprobantevFfchvtopag, lxComprobantevOpctrasmis, lxComprobantevFdescu, lxComprobantevMerconsign, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevChequer, lxComprobantevCancelar, lxComprobantevIvasis
				lxComprobantevFecimpo = ctod( '  /  /    ' )			lxComprobantevFectrans = ctod( '  /  /    ' )			lxComprobantevFecexpo = ctod( '  /  /    ' )			lxComprobantevFd2 = ctod( '  /  /    ' )			lxComprobantevInformnube = ctod( '  /  /    ' )			lxComprobantevFmodifw = ctod( '  /  /    ' )			lxComprobantevVtocai = ctod( '  /  /    ' )			lxComprobantevFcuit = []			lxComprobantevIdcaja = 0			lxComprobantevFajxre = 0			lxComprobantevMdcimpu = 0			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevCai = 0			lxComprobantevFactsec = []			lxComprobantevTotalcant = 0			lxComprobantevFpodes2 = 0			lxComprobantevCondivalp = 0			lxComprobantevSubtotcisi = 0			lxComprobantevFsubtot = 0			lxComprobantevSitfisccli = 0			lxComprobantevFsubton = 0			lxComprobantevSignomov = 0			lxComprobantevSubtotsisi = 0			lxComprobantevRecmntosi2 = 0			lxComprobantevDesmntosi2 = 0			lxComprobantevDesmntosi1 = 0			lxComprobantevDesmntosi3 = 0			lxComprobantevDesmntosi = 0			lxComprobantevRecmntosi1 = 0			lxComprobantevRecmntosi = 0			lxComprobantevAnulado = .F.			lxComprobantevDesaut = .F.			lxComprobantevFcompfis = .F.			lxComprobantevHoraexpo = []			lxComprobantevEsttrans = []			lxComprobantevOpecomm = []			lxComprobantevBdmodifw = []			lxComprobantevBdaltafw = []			lxComprobantevSaltafw = []			lxComprobantevCbautoimp = []			lxComprobantevDescfw = []			lxComprobantevFhora = []			lxComprobantevZadsfw = []			lxComprobantevUmodifw = []			lxComprobantevValtafw = []			lxComprobantevVmodifw = []			lxComprobantevHmodifw = []			lxComprobantevSmodifw = []			lxComprobantevHoraimpo = []			lxComprobantevUaltafw = []			lxComprobantevIdajuste = []			lxComprobantevDespachos = []			lxComprobantevFaltafw = ctod( '  /  /    ' )			lxComprobantevHaltafw = []			lxComprobantevSimbmon = []			lxComprobantevFacttipo = 0			lxComprobantevIdvuelto = []			lxComprobantevMonsis = []			lxComprobantevMotdescdev = []			lxComprobantevFobs = []			lxComprobantevFpodes1 = 0			lxComprobantevFperson = []			lxComprobantevFturno = 0			lxComprobantevFmtdes2 = 0			lxComprobantevIdsenia = []			lxComprobantevSenia = []			lxComprobantevCodigo = []			lxComprobantevMd1 = 0			lxComprobantevFcliente = []			lxComprobantevFmtdes1 = 0			lxComprobantevReceptor = []			lxComprobantevFven = []			lxComprobantevMoneda = []			lxComprobantevFletra = []			lxComprobantevVtosenia = ctod( '  /  /    ' )			lxComprobantevTotrecarsi = 0			lxComprobantevTrci = 0			lxComprobantevCodlista = []			lxComprobantevFptoven = 0			lxComprobantevEmail = []			lxComprobantevFnumcomp = 0			lxComprobantevFtotal = 0			lxComprobantevTotdescsi = 0			lxComprobantevTdci = 0			lxComprobantevDirentr = []			lxComprobantevFfch = ctod( '  /  /    ' )			lxComprobantevFmtdes3 = 0			lxComprobantevDeuda = 0			lxComprobantevCotiz = 0			lxComprobantevFpago = []			lxComprobantevFpodes = 0			lxComprobantevRecmnto2 = 0			lxComprobantevFvuelto = 0			lxComprobantevEntregapos = 0			lxComprobantevFfchvtopag = ctod( '  /  /    ' )			lxComprobantevOpctrasmis = []			lxComprobantevFdescu = 0			lxComprobantevMerconsign = .F.			lxComprobantevMd3 = 0			lxComprobantevPercepcion = 0			lxComprobantevRecmnto = 0			lxComprobantevRecpor = 0			lxComprobantevMr = 0			lxComprobantevMr2 = 0			lxComprobantevMd2 = 0			lxComprobantevMr1 = 0			lxComprobantevRecmnto1 = 0			lxComprobantevGravamen = 0			lxComprobantevFimpuesto = 0			lxComprobantevTotrecarci = 0			lxComprobantevTotdesc = 0			lxComprobantevTotimpue = 0			lxComprobantevChequer = []			lxComprobantevCancelar = .F.			lxComprobantevIvasis = 0
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.CompAfe where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.PromDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ProArtDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.KITDET where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.IMPUESTOSV where "Codigo" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.impVentas where "cCod" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.SeniaVDet where "CODIGO" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.VAL where "JJNUM" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
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
		lcWhere = " Where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema"
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
	Function ObtenerDatosDetallePromocionesDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PROMDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Tipo" as "Promociontipo", "Nroitem" as "Nroitem", "Codigo" as "Codigo", "Promo" as "Promocion", "Descrip" as "Promociondetalle", "Cantidad" as "Cantidad", "Beneficio" as "Beneficio", "Iditem" as "Iditempromocion"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePromocionesDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'PromDet', 'PromocionesDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePromocionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePromocionesDetalle( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetallePromoArticulosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  PROARTDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Monto" as "Montobeneficio", "Nroitem" as "Nroitem", "Idvalor" as "Iditemvalor", "Atrcabever" as "Atributocabecera", "Idarti" as "Iditemarticulo", "Idpromo" as "Iditempromo", "Codigo" as "Codigo"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetallePromoArticulosDetalle( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ProArtDet', 'PromoArticulosDetalle', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetallePromoArticulosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetallePromoArticulosDetalle( lcAtributo )
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
	Function ObtenerDatosDetalleArticulosSeniadosDetalle( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  SENIAVDET.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Afeptoven" as "Afe_puntodeventa", "Afeletra" as "Afe_letra", "Afenumcom" as "Afe_numero", "Codgtin" as "Codigogtin", "Fart" as "Articulo", "Mntprecsi" as "Montoprorrateorecargosinimpuestos", "Mntpdessi" as "Montoprorrateodescuentosinimpuestos", "Mntprecci" as "Montoprorrateorecargoconimpuestos", "Afets" as "Afe_timestamp", "Mntptot" as "Montoprorrateototal", "Mntpdesci" as "Montoprorrateodescuentoconimpuestos", "Mntpper" as "Montoprorrateopercepciones", "Preciosisr" as "Preciosinimpuestossinredondear", "Mnpdsi" as "Montoporcentajedescuentosinimpuesto", "Conrestr" as "Tienerestriccion", "Afe_sliq" as "Afe_saldoliquidacion", "Comp" as "Comportamiento", "Impinterno" as "Montoimpuestointerno", "Artpercep" as "Percepcionivarg5329", "Ajusimp" as "Ajusteporredondeosinimpuestos", "Tasaimpint" as "Tasaimpuestointerno", "Preciocisr" as "Precioconimpuestossinredondear", "Mndessi" as "Montodescuentosinimpuestos", "Fbruto" as "Bruto", "Preciosr" as "Preciosinredondear", "Mndesci" as "Montodescuentoconimpuestos", "Ajucimp" as "Ajusteporredondeoconimpuestos", "Aporcivav" as "Articulo_porcentajeivaventas", "Acondivav" as "Articulo_condicionivaventas", "Fx2" as "Oferta", "Nroitem" as "Nroitem", "Fporcfi" as "Porcentajecfi", "Afesaldo" as "Afe_saldo", "Fpordto1" as "Porcentajedto1", "Fneto" as "Neto", "Fkit" as "Kit", "Fmtocfi" as "Montocfi", "Fmtodto1" as "Montodto1", "Fporiva" as "Porcentajeiva", "Fmtoiva" as "Montoiva", "Prunsinimp" as "Preciosinimpuestos", "Prunconimp" as "Precioconimpuestos", "Fcfitot" as "Montoporcentajedescuentoconimpuesto", "Afetipocom" as "Afe_tipocomprobante", "Afecant" as "Afe_cantidad", "Afenroitem" as "Afe_nroitem", "Iditemorig" as "Idorigen", "Fn11" as "Tipolistadeprecio", "Ciditem" as "Iditem", "Fprun" as "Preciounitario", "Artsindes" as "Restringirdescuentos", "Usarplista" as "Usarpreciodelista", "Procstock" as "Noprocesarstock", "Codautdjcp" as "Codigoautorizaciondjcp", "Famate" as "Material", "Afe_cod" as "Afe_codigo", "Idkit" as "Idkit", "Iditem" as "Iditemarticulos", "Codigo" as "Codigo", "Giftcard" as "Numerogiftcard", "Motdevol" as "Codigomotivodevolucion", "Funid" as "Unidad", "Motdescu" as "Codigomotivodescuento", "Equiv" as "Equivalencia", "Ftxt" as "Articulodetalle", "Fcolo" as "Color", "Fcotxt" as "Colordetalle", "Ftall" as "Talle", "Fcfi" as "Descuento", "Mntpiva" as "Montoprorrateoiva", "Mntdes" as "Montodescuento", "Mntpint" as "Montoprorrateoimpuestointerno", "Fcant" as "Cantidad", "Fprecio" as "Precio", "Fmonto" as "Monto"
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
	Function ObtenerCamposSelectEntidad( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'FECHAMODIFICACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FD2 AS FECHAMODIFICACION'
				Case lcAtributo == 'FUEINFORMADOALANUBE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INFORMNUBE AS FUEINFORMADOALANUBE'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAVTOCAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VTOCAI AS FECHAVTOCAI'
				Case lcAtributo == 'CUIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCUIT AS CUIT'
				Case lcAtributo == 'CAJA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDCAJA AS CAJA'
				Case lcAtributo == 'AJUSTESPORREDONDEOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAJXRE AS AJUSTESPORREDONDEOS'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MDCIMPU AS MONTODESCUENTOCONIMPUESTOS'
				Case lcAtributo == 'TIMESTAMP'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIMESTAMP AS TIMESTAMP'
				Case lcAtributo == 'CAI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CAI AS CAI'
				Case lcAtributo == 'SECUENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTSEC AS SECUENCIA'
				Case lcAtributo == 'TOTALCANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTALCANT AS TOTALCANTIDAD'
				Case lcAtributo == 'PORCENTAJEDESCUENTO2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES2 AS PORCENTAJEDESCUENTO2'
				Case lcAtributo == 'CONDICIONIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CONDIVALP AS CONDICIONIVA'
				Case lcAtributo == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTCISI AS SUBTOTALCONIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'SUBTOTALBRUTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTOT AS SUBTOTALBRUTO'
				Case lcAtributo == 'SITUACIONFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SITFISCCLI AS SITUACIONFISCAL'
				Case lcAtributo == 'SUBTOTALNETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FSUBTON AS SUBTOTALNETO'
				Case lcAtributo == 'SIGNODEMOVIMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIGNOMOV AS SIGNODEMOVIMIENTO'
				Case lcAtributo == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SUBTOTSISI AS SUBTOTALSINIMPUESTOSSOBREITEMS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI2 AS RECARGOMONTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI2 AS MONTODESCUENTOSINIMPUESTOS2'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI1 AS MONTODESCUENTOSINIMPUESTOS1'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI3 AS MONTODESCUENTOSINIMPUESTOS3'
				Case lcAtributo == 'MONTODESCUENTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESMNTOSI AS MONTODESCUENTOSINIMPUESTOS'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI1 AS RECARGOMONTOSINIMPUESTOS1'
				Case lcAtributo == 'RECARGOMONTOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTOSI AS RECARGOMONTOSINIMPUESTOS'
				Case lcAtributo == 'ANULADO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ANULADO AS ANULADO'
				Case lcAtributo == 'DESCUENTOAUTOMATICO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESAUT AS DESCUENTOAUTOMATICO'
				Case lcAtributo == 'COMPROBANTEFISCAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOMPFIS AS COMPROBANTEFISCAL'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'NROOPECOMMERCE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPECOMM AS NROOPECOMMERCE'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'CODIGOBARRAAUTOIMPRESOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CBAUTOIMP AS CODIGOBARRAAUTOIMPRESOR'
				Case lcAtributo == 'DESCRIPCIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCFW AS DESCRIPCIONFW'
				Case lcAtributo == 'HORA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FHORA AS HORA'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'CODIGOAJUSTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDAJUSTE AS CODIGOAJUSTE'
				Case lcAtributo == 'DESPACHOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESPACHOS AS DESPACHOS'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'SIMBOLOMONETARIOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SIMBMON AS SIMBOLOMONETARIOCOMPROBANTE'
				Case lcAtributo == 'TIPOCOMPROBANTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FACTTIPO AS TIPOCOMPROBANTE'
				Case lcAtributo == 'IDVUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVUELTO AS IDVUELTO'
				Case lcAtributo == 'MONEDASISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONSIS AS MONEDASISTEMA'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCDEV AS CODIGOMOTIVODESCUENTOENSUBTOTAL'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FOBS AS OBS'
				Case lcAtributo == 'PORCENTAJEDESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES1 AS PORCENTAJEDESCUENTO1'
				Case lcAtributo == 'CLIENTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPERSON AS CLIENTE'
				Case lcAtributo == 'TURNO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTURNO AS TURNO'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES2 AS MONTODESCUENTOCONIMPUESTOS2'
				Case lcAtributo == 'IDSENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDSENIA AS IDSENIA'
				Case lcAtributo == 'SENIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SENIA AS SENIA'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'MONTODESCUENTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MD1 AS MONTODESCUENTO1'
				Case lcAtributo == 'CLIENTEDESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCLIENTE AS CLIENTEDESCRIPCION'
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
				Case lcAtributo == 'LISTADEPRECIOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODLISTA AS LISTADEPRECIOS'
				Case lcAtributo == 'PUNTODEVENTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPTOVEN AS PUNTODEVENTA'
				Case lcAtributo == 'EMAIL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'EMAIL AS EMAIL'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNUMCOMP AS NUMERO'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FTOTAL AS TOTAL'
				Case lcAtributo == 'TOTALDESCUENTOSSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESCSI AS TOTALDESCUENTOSSINIMPUESTOS'
				Case lcAtributo == 'TOTALDESCUENTOSCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TDCI AS TOTALDESCUENTOSCONIMPUESTOS'
				Case lcAtributo == 'DIRECCIONENTREGA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DIRENTR AS DIRECCIONENTREGA'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'MONTODESCUENTOCONIMPUESTOS3'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTDES3 AS MONTODESCUENTOCONIMPUESTOS3'
				Case lcAtributo == 'DEUDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DEUDA AS DEUDA'
				Case lcAtributo == 'COTIZACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COTIZ AS COTIZACION'
				Case lcAtributo == 'FORPAGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPAGO AS FORPAGO'
				Case lcAtributo == 'PORCENTAJEDESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPODES AS PORCENTAJEDESCUENTO'
				Case lcAtributo == 'RECARGOMONTOCONIMPUESTOS2'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'RECMNTO2 AS RECARGOMONTOCONIMPUESTOS2'
				Case lcAtributo == 'VUELTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FVUELTO AS VUELTO'
				Case lcAtributo == 'ENTREGAPOSTERIOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ENTREGAPOS AS ENTREGAPOSTERIOR'
				Case lcAtributo == 'FECHAVENCIMIENTOMIPYME'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCHVTOPAG AS FECHAVENCIMIENTOMIPYME'
				Case lcAtributo == 'OPCIONTRANSMISIONMIPYME'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OPCTRASMIS AS OPCIONTRANSMISIONMIPYME'
				Case lcAtributo == 'DESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FDESCU AS DESCUENTO'
				Case lcAtributo == 'MERCADERIACONSIGNACION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MERCONSIGN AS MERCADERIACONSIGNACION'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTRECARCI AS TOTALRECARGOS'
				Case lcAtributo == 'TOTALDESCUENTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTDESC AS TOTALDESCUENTOS'
				Case lcAtributo == 'TOTALIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TOTIMPUE AS TOTALIMPUESTOS'
				Case lcAtributo == 'CHEQUEREINTEGRO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CHEQUER AS CHEQUEREINTEGRO'
				Case lcAtributo == 'ACCIONCANCELATORIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANCELAR AS ACCIONCANCELATORIA'
				Case lcAtributo == 'IVADELSISTEMA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IVASIS AS IVADELSISTEMA'
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
	Function ObtenerCamposSelectDetallePromocionesDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'PROMOCIONTIPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPO AS PROMOCIONTIPO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'PROMOCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROMO AS PROMOCION'
				Case lcAtributo == 'PROMOCIONDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS PROMOCIONDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
				Case lcAtributo == 'BENEFICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BENEFICIO AS BENEFICIO'
				Case lcAtributo == 'IDITEMPROMOCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMPROMOCION'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetallePromoArticulosDetalle( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'MONTOBENEFICIO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MONTO AS MONTOBENEFICIO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'IDITEMVALOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDVALOR AS IDITEMVALOR'
				Case lcAtributo == 'ATRIBUTOCABECERA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ATRCABEVER AS ATRIBUTOCABECERA'
				Case lcAtributo == 'IDITEMARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDARTI AS IDITEMARTICULO'
				Case lcAtributo == 'IDITEMPROMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDPROMO AS IDITEMPROMO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleArticulosSeniadosDetalle( tcCampos As String ) As String
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
				Case lcAtributo == 'OFERTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FX2 AS OFERTA'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'PORCENTAJECFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORCFI AS PORCENTAJECFI'
				Case lcAtributo == 'AFE_SALDO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFESALDO AS AFE_SALDO'
				Case lcAtributo == 'PORCENTAJEDTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORDTO1 AS PORCENTAJEDTO1'
				Case lcAtributo == 'NETO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FNETO AS NETO'
				Case lcAtributo == 'KIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FKIT AS KIT'
				Case lcAtributo == 'MONTOCFI'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOCFI AS MONTOCFI'
				Case lcAtributo == 'MONTODTO1'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTODTO1 AS MONTODTO1'
				Case lcAtributo == 'PORCENTAJEIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FPORIVA AS PORCENTAJEIVA'
				Case lcAtributo == 'MONTOIVA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMTOIVA AS MONTOIVA'
				Case lcAtributo == 'PRECIOSINIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNSINIMP AS PRECIOSINIMPUESTOS'
				Case lcAtributo == 'PRECIOCONIMPUESTOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRUNCONIMP AS PRECIOCONIMPUESTOS'
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
				Case lcAtributo == 'MATERIAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMATE AS MATERIAL'
				Case lcAtributo == 'AFE_CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'AFE_COD AS AFE_CODIGO'
				Case lcAtributo == 'IDKIT'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDKIT AS IDKIT'
				Case lcAtributo == 'IDITEMARTICULOS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMARTICULOS'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'NUMEROGIFTCARD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GIFTCARD AS NUMEROGIFTCARD'
				Case lcAtributo == 'CODIGOMOTIVODEVOLUCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDEVOL AS CODIGOMOTIVODEVOLUCION'
				Case lcAtributo == 'UNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FUNID AS UNIDAD'
				Case lcAtributo == 'CODIGOMOTIVODESCUENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCU AS CODIGOMOTIVODESCUENTO'
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
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACION'
				lcCampo = 'FD2'
			Case upper( alltrim( tcAtributo ) ) == 'FUEINFORMADOALANUBE'
				lcCampo = 'INFORMNUBE'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVTOCAI'
				lcCampo = 'VTOCAI'
			Case upper( alltrim( tcAtributo ) ) == 'CUIT'
				lcCampo = 'FCUIT'
			Case upper( alltrim( tcAtributo ) ) == 'CAJA'
				lcCampo = 'IDCAJA'
			Case upper( alltrim( tcAtributo ) ) == 'AJUSTESPORREDONDEOS'
				lcCampo = 'FAJXRE'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS'
				lcCampo = 'MDCIMPU'
			Case upper( alltrim( tcAtributo ) ) == 'TIMESTAMP'
				lcCampo = 'TIMESTAMP'
			Case upper( alltrim( tcAtributo ) ) == 'CAI'
				lcCampo = 'CAI'
			Case upper( alltrim( tcAtributo ) ) == 'SECUENCIA'
				lcCampo = 'FACTSEC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALCANTIDAD'
				lcCampo = 'TOTALCANT'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO2'
				lcCampo = 'FPODES2'
			Case upper( alltrim( tcAtributo ) ) == 'CONDICIONIVA'
				lcCampo = 'CONDIVALP'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALCONIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTCISI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALBRUTO'
				lcCampo = 'FSUBTOT'
			Case upper( alltrim( tcAtributo ) ) == 'SITUACIONFISCAL'
				lcCampo = 'SITFISCCLI'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALNETO'
				lcCampo = 'FSUBTON'
			Case upper( alltrim( tcAtributo ) ) == 'SIGNODEMOVIMIENTO'
				lcCampo = 'SIGNOMOV'
			Case upper( alltrim( tcAtributo ) ) == 'SUBTOTALSINIMPUESTOSSOBREITEMS'
				lcCampo = 'SUBTOTSISI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS2'
				lcCampo = 'RECMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS2'
				lcCampo = 'DESMNTOSI2'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS1'
				lcCampo = 'DESMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS3'
				lcCampo = 'DESMNTOSI3'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOSINIMPUESTOS'
				lcCampo = 'DESMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS1'
				lcCampo = 'RECMNTOSI1'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOSINIMPUESTOS'
				lcCampo = 'RECMNTOSI'
			Case upper( alltrim( tcAtributo ) ) == 'ANULADO'
				lcCampo = 'ANULADO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTOAUTOMATICO'
				lcCampo = 'DESAUT'
			Case upper( alltrim( tcAtributo ) ) == 'COMPROBANTEFISCAL'
				lcCampo = 'FCOMPFIS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'NROOPECOMMERCE'
				lcCampo = 'OPECOMM'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOBARRAAUTOIMPRESOR'
				lcCampo = 'CBAUTOIMP'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCIONFW'
				lcCampo = 'DESCFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORA'
				lcCampo = 'FHORA'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOAJUSTE'
				lcCampo = 'IDAJUSTE'
			Case upper( alltrim( tcAtributo ) ) == 'DESPACHOS'
				lcCampo = 'DESPACHOS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SIMBOLOMONETARIOCOMPROBANTE'
				lcCampo = 'SIMBMON'
			Case upper( alltrim( tcAtributo ) ) == 'TIPOCOMPROBANTE'
				lcCampo = 'FACTTIPO'
			Case upper( alltrim( tcAtributo ) ) == 'IDVUELTO'
				lcCampo = 'IDVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'MONEDASISTEMA'
				lcCampo = 'MONSIS'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTOENSUBTOTAL'
				lcCampo = 'MOTDESCDEV'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'FOBS'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO1'
				lcCampo = 'FPODES1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTE'
				lcCampo = 'FPERSON'
			Case upper( alltrim( tcAtributo ) ) == 'TURNO'
				lcCampo = 'FTURNO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS2'
				lcCampo = 'FMTDES2'
			Case upper( alltrim( tcAtributo ) ) == 'IDSENIA'
				lcCampo = 'IDSENIA'
			Case upper( alltrim( tcAtributo ) ) == 'SENIA'
				lcCampo = 'SENIA'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTO1'
				lcCampo = 'MD1'
			Case upper( alltrim( tcAtributo ) ) == 'CLIENTEDESCRIPCION'
				lcCampo = 'FCLIENTE'
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
			Case upper( alltrim( tcAtributo ) ) == 'LISTADEPRECIOS'
				lcCampo = 'CODLISTA'
			Case upper( alltrim( tcAtributo ) ) == 'PUNTODEVENTA'
				lcCampo = 'FPTOVEN'
			Case upper( alltrim( tcAtributo ) ) == 'EMAIL'
				lcCampo = 'EMAIL'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'FNUMCOMP'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'FTOTAL'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSSINIMPUESTOS'
				lcCampo = 'TOTDESCSI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOSCONIMPUESTOS'
				lcCampo = 'TDCI'
			Case upper( alltrim( tcAtributo ) ) == 'DIRECCIONENTREGA'
				lcCampo = 'DIRENTR'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODESCUENTOCONIMPUESTOS3'
				lcCampo = 'FMTDES3'
			Case upper( alltrim( tcAtributo ) ) == 'DEUDA'
				lcCampo = 'DEUDA'
			Case upper( alltrim( tcAtributo ) ) == 'COTIZACION'
				lcCampo = 'COTIZ'
			Case upper( alltrim( tcAtributo ) ) == 'FORPAGO'
				lcCampo = 'FPAGO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDESCUENTO'
				lcCampo = 'FPODES'
			Case upper( alltrim( tcAtributo ) ) == 'RECARGOMONTOCONIMPUESTOS2'
				lcCampo = 'RECMNTO2'
			Case upper( alltrim( tcAtributo ) ) == 'VUELTO'
				lcCampo = 'FVUELTO'
			Case upper( alltrim( tcAtributo ) ) == 'ENTREGAPOSTERIOR'
				lcCampo = 'ENTREGAPOS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAVENCIMIENTOMIPYME'
				lcCampo = 'FFCHVTOPAG'
			Case upper( alltrim( tcAtributo ) ) == 'OPCIONTRANSMISIONMIPYME'
				lcCampo = 'OPCTRASMIS'
			Case upper( alltrim( tcAtributo ) ) == 'DESCUENTO'
				lcCampo = 'FDESCU'
			Case upper( alltrim( tcAtributo ) ) == 'MERCADERIACONSIGNACION'
				lcCampo = 'MERCONSIGN'
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
				lcCampo = 'TOTRECARCI'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALDESCUENTOS'
				lcCampo = 'TOTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'TOTALIMPUESTOS'
				lcCampo = 'TOTIMPUE'
			Case upper( alltrim( tcAtributo ) ) == 'CHEQUEREINTEGRO'
				lcCampo = 'CHEQUER'
			Case upper( alltrim( tcAtributo ) ) == 'ACCIONCANCELATORIA'
				lcCampo = 'CANCELAR'
			Case upper( alltrim( tcAtributo ) ) == 'IVADELSISTEMA'
				lcCampo = 'IVASIS'
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
	Function ObtenerCampoDetallePromocionesDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'PROMOCIONTIPO'
				lcCampo = 'TIPO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROMOCION'
				lcCampo = 'PROMO'
			Case upper( alltrim( tcAtributo ) ) == 'PROMOCIONDETALLE'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'BENEFICIO'
				lcCampo = 'BENEFICIO'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMPROMOCION'
				lcCampo = 'IDITEM'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetallePromoArticulosDetalle( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'MONTOBENEFICIO'
				lcCampo = 'MONTO'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMVALOR'
				lcCampo = 'IDVALOR'
			Case upper( alltrim( tcAtributo ) ) == 'ATRIBUTOCABECERA'
				lcCampo = 'ATRCABEVER'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULO'
				lcCampo = 'IDARTI'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMPROMO'
				lcCampo = 'IDPROMO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
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
	Function ObtenerCampoDetalleArticulosSeniadosDetalle( tcAtributo As String ) As String
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
			Case upper( alltrim( tcAtributo ) ) == 'OFERTA'
				lcCampo = 'FX2'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJECFI'
				lcCampo = 'FPORCFI'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_SALDO'
				lcCampo = 'AFESALDO'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEDTO1'
				lcCampo = 'FPORDTO1'
			Case upper( alltrim( tcAtributo ) ) == 'NETO'
				lcCampo = 'FNETO'
			Case upper( alltrim( tcAtributo ) ) == 'KIT'
				lcCampo = 'FKIT'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOCFI'
				lcCampo = 'FMTOCFI'
			Case upper( alltrim( tcAtributo ) ) == 'MONTODTO1'
				lcCampo = 'FMTODTO1'
			Case upper( alltrim( tcAtributo ) ) == 'PORCENTAJEIVA'
				lcCampo = 'FPORIVA'
			Case upper( alltrim( tcAtributo ) ) == 'MONTOIVA'
				lcCampo = 'FMTOIVA'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOSINIMPUESTOS'
				lcCampo = 'PRUNSINIMP'
			Case upper( alltrim( tcAtributo ) ) == 'PRECIOCONIMPUESTOS'
				lcCampo = 'PRUNCONIMP'
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
			Case upper( alltrim( tcAtributo ) ) == 'MATERIAL'
				lcCampo = 'FAMATE'
			Case upper( alltrim( tcAtributo ) ) == 'AFE_CODIGO'
				lcCampo = 'AFE_COD'
			Case upper( alltrim( tcAtributo ) ) == 'IDKIT'
				lcCampo = 'IDKIT'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMARTICULOS'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'NUMEROGIFTCARD'
				lcCampo = 'GIFTCARD'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODEVOLUCION'
				lcCampo = 'MOTDEVOL'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDAD'
				lcCampo = 'FUNID'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOMOTIVODESCUENTO'
				lcCampo = 'MOTDESCU'
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
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'FACTURADETALLE'
			lcRetorno = 'COMPROBANTEVDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'COMPAFEC'
			lcRetorno = 'COMPAFE'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PROMOCIONESDETALLE'
			lcRetorno = 'PROMDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'PROMOARTICULOSDETALLE'
			lcRetorno = 'PROARTDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'KITSDETALLE'
			lcRetorno = 'KITDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSDETALLE'
			lcRetorno = 'IMPUESTOSV'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'IMPUESTOSCOMPROBANTE'
			lcRetorno = 'IMPVENTAS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ARTICULOSSENIADOSDETALLE'
			lcRetorno = 'SENIAVDET'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'VALORESDETALLE'
			lcRetorno = 'VAL'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxComprobantevFecimpo, lxComprobantevFectrans, lxComprobantevFecexpo, lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFmodifw, lxComprobantevVtocai, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevTimestamp, lxComprobantevCai, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevFpodes2, lxComprobantevCondivalp, lxComprobantevSubtotcisi, lxComprobantevFsubtot, lxComprobantevSitfisccli, lxComprobantevFsubton, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevAnulado, lxComprobantevDesaut, lxComprobantevFcompfis, lxComprobantevHoraexpo, lxComprobantevEsttrans, lxComprobantevOpecomm, lxComprobantevBdmodifw, lxComprobantevBdaltafw, lxComprobantevSaltafw, lxComprobantevCbautoimp, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevUmodifw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevIdajuste, lxComprobantevDespachos, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevSimbmon, lxComprobantevFacttipo, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevFmtdes2, lxComprobantevIdsenia, lxComprobantevSenia, lxComprobantevCodigo, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevCodlista, lxComprobantevFptoven, lxComprobantevEmail, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevDirentr, lxComprobantevFfch, lxComprobantevFmtdes3, lxComprobantevDeuda, lxComprobantevCotiz, lxComprobantevFpago, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFvuelto, lxComprobantevEntregapos, lxComprobantevFfchvtopag, lxComprobantevOpctrasmis, lxComprobantevFdescu, lxComprobantevMerconsign, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevChequer, lxComprobantevCancelar, lxComprobantevIvasis
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevVtocai =  .Fechavtocai			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevCai =  .Cai			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevCbautoimp =  .Codigobarraautoimpresor			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevDespachos =  .Despachos			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevIdsenia =  .Idsenia			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevCodigo =  .Codigo			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevEmail =  .Email			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevDirentr =  .Direccionentrega			lxComprobantevFfch =  .Fecha			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevDeuda =  .Deuda			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFvuelto =  .Vuelto			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFfchvtopag =  .Fechavencimientomipyme			lxComprobantevOpctrasmis =  .Opciontransmisionmipyme			lxComprobantevFdescu =  .Descuento			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevChequer =  .Chequereintegro			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.COMPROBANTEV ( "Fecimpo","Fectrans","Fecexpo","Fd2","Informnube","Fmodifw","Vtocai","Fcuit","Idcaja","Fajxre","Mdcimpu","Timestamp","Cai","Factsec","Totalcant","Fpodes2","Condivalp","Subtotcisi","Fsubtot","Sitfisccli","Fsubton","Signomov","Subtotsisi","Recmntosi2","Desmntosi2","Desmntosi1","Desmntosi3","Desmntosi","Recmntosi1","Recmntosi","Anulado","Desaut","Fcompfis","Horaexpo","Esttrans","Opecomm","Bdmodifw","Bdaltafw","Saltafw","Cbautoimp","Descfw","Fhora","Zadsfw","Umodifw","Valtafw","Vmodifw","Hmodifw","Smodifw","Horaimpo","Ualtafw","Idajuste","Despachos","Faltafw","Haltafw","Simbmon","Facttipo","Idvuelto","Monsis","Motdescdev","Fobs","Fpodes1","Fperson","Fturno","Fmtdes2","Idsenia","Senia","Codigo","Md1","Fcliente","Fmtdes1","Receptor","Fven","Moneda","Fletra","Vtosenia","Totrecarsi","Trci","Codlista","Fptoven","Email","Fnumcomp","Ftotal","Totdescsi","Tdci","Direntr","Ffch","Fmtdes3","Deuda","Cotiz","Fpago","Fpodes","Recmnto2","Fvuelto","Entregapos","Ffchvtopag","Opctrasmis","Fdescu","Merconsign","Md3","Percepcion","Recmnto","Recpor","Mr","Mr2","Md2","Mr1","Recmnto1","Gravamen","Fimpuesto","Totrecarci","Totdesc","Totimpue","Chequer","Cancelar","Ivasis" ) values ( <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtocai ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'" >>, <<lxComprobantevIdcaja >>, <<lxComprobantevFajxre >>, <<lxComprobantevMdcimpu >>, <<lxComprobantevTimestamp >>, <<lxComprobantevCai >>, <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'" >>, <<lxComprobantevTotalcant >>, <<lxComprobantevFpodes2 >>, <<lxComprobantevCondivalp >>, <<lxComprobantevSubtotcisi >>, <<lxComprobantevFsubtot >>, <<lxComprobantevSitfisccli >>, <<lxComprobantevFsubton >>, <<lxComprobantevSignomov >>, <<lxComprobantevSubtotsisi >>, <<lxComprobantevRecmntosi2 >>, <<lxComprobantevDesmntosi2 >>, <<lxComprobantevDesmntosi1 >>, <<lxComprobantevDesmntosi3 >>, <<lxComprobantevDesmntosi >>, <<lxComprobantevRecmntosi1 >>, <<lxComprobantevRecmntosi >>, <<iif( lxComprobantevAnulado, 1, 0 ) >>, <<iif( lxComprobantevDesaut, 1, 0 ) >>, <<iif( lxComprobantevFcompfis, 1, 0 ) >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCbautoimp ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevDespachos ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'" >>, <<lxComprobantevFacttipo >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'" >>, <<lxComprobantevFpodes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'" >>, <<lxComprobantevFturno >>, <<lxComprobantevFmtdes2 >>, <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'" >>, <<lxComprobantevMd1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'" >>, <<lxComprobantevFmtdes1 >>, <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'" >>, <<lxComprobantevTotrecarsi >>, <<lxComprobantevTrci >>, <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'" >>, <<lxComprobantevFptoven >>, <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'" >>, <<lxComprobantevFnumcomp >>, <<lxComprobantevFtotal >>, <<lxComprobantevTotdescsi >>, <<lxComprobantevTdci >>, <<"'" + this.FormatearTextoSql( lxComprobantevDirentr ) + "'" >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'" >>, <<lxComprobantevFmtdes3 >>, <<lxComprobantevDeuda >>, <<lxComprobantevCotiz >>, <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'" >>, <<lxComprobantevFpodes >>, <<lxComprobantevRecmnto2 >>, <<lxComprobantevFvuelto >>, <<lxComprobantevEntregapos >>, <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'" >>, <<"'" + this.FormatearTextoSql( lxComprobantevOpctrasmis ) + "'" >>, <<lxComprobantevFdescu >>, <<iif( lxComprobantevMerconsign, 1, 0 ) >>, <<lxComprobantevMd3 >>, <<lxComprobantevPercepcion >>, <<lxComprobantevRecmnto >>, <<lxComprobantevRecpor >>, <<lxComprobantevMr >>, <<lxComprobantevMr2 >>, <<lxComprobantevMd2 >>, <<lxComprobantevMr1 >>, <<lxComprobantevRecmnto1 >>, <<lxComprobantevGravamen >>, <<lxComprobantevFimpuesto >>, <<lxComprobantevTotrecarci >>, <<lxComprobantevTotdesc >>, <<lxComprobantevTotimpue >>, <<"'" + this.FormatearTextoSql( lxComprobantevChequer ) + "'" >>, <<iif( lxComprobantevCancelar, 1, 0 ) >>, <<lxComprobantevIvasis >> )
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
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.COMPROBANTEVDET" )
this.xmlacursor( lcXml, 'c_COMPROBANTEVDETciditem' )
loItem.idItem = c_COMPROBANTEVDETciditem.ciditem
use in select( 'c_COMPROBANTEVDETciditem' )
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
			for each loItem in this.oEntidad.PromocionesDetalle
				if this.oEntidad.PromocionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPromociontipo = loItem.Promociontipo
					lxNroitem = lnContadorNroItem
					lxPromocion_PK = loItem.Promocion_PK
					lxPromociondetalle = loItem.Promociondetalle
					lxCantidad = loItem.Cantidad
					lxBeneficio = loItem.Beneficio
					lxIditempromocion = loItem.Iditempromocion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PromDet("Tipo","NROITEM","Codigo","Promo","descrip","Cantidad","Beneficio","IdItem" ) values ( <<lxPromociontipo>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxPromocion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromociondetalle ) + "'">>, <<lxCantidad>>, <<lxBeneficio>>, <<"'" + this.FormatearTextoSql( lxIditempromocion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PromoArticulosDetalle
				if this.oEntidad.PromoArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobeneficio = loItem.Montobeneficio
					lxNroitem = lnContadorNroItem
					lxIditemvalor = loItem.Iditemvalor
					lxAtributocabecera = loItem.Atributocabecera
					lxIditemarticulo = loItem.Iditemarticulo
					lxIditempromo = loItem.Iditempromo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ProArtDet("Monto","NROITEM","IdValor","AtrCabever","IdArti","IdPromo","CODIGO" ) values ( <<lxMontobeneficio>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxIditemvalor ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributocabecera ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditempromo ) + "'">>, << lcValorClavePrimariaString >> ) 
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
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajecfi = loItem.Porcentajecfi
					lxAfe_saldo = loItem.Afe_saldo
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNeto = loItem.Neto
					lxKit = loItem.Kit
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontoiva = loItem.Montoiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
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
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FX2","NroItem","FporCFI","AfeSaldo","FporDTO1","FNETO","FKIT","FmtoCFI","FmtoDTO1","fporIva","FmtoIVA","Prunsinimp","prunconimp","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","FAMate","Afe_cod","IDKIT","IdItem","CODIGO","GiftCard","MotDevol","FUnid","MotDescu","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajecfi>>, <<lxAfe_saldo>>, <<lxPorcentajedto1>>, <<lxNeto>>, <<lxKit>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxMontoiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.SeniaVDet" )
this.xmlacursor( lcXml, 'c_SeniaVDetciditem' )
loItem.idItem = c_SeniaVDetciditem.ciditem
use in select( 'c_SeniaVDetciditem' )
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
			local  lxComprobantevFecimpo, lxComprobantevFectrans, lxComprobantevFecexpo, lxComprobantevFd2, lxComprobantevInformnube, lxComprobantevFmodifw, lxComprobantevVtocai, lxComprobantevFcuit, lxComprobantevIdcaja, lxComprobantevFajxre, lxComprobantevMdcimpu, lxComprobantevTimestamp, lxComprobantevCai, lxComprobantevFactsec, lxComprobantevTotalcant, lxComprobantevFpodes2, lxComprobantevCondivalp, lxComprobantevSubtotcisi, lxComprobantevFsubtot, lxComprobantevSitfisccli, lxComprobantevFsubton, lxComprobantevSignomov, lxComprobantevSubtotsisi, lxComprobantevRecmntosi2, lxComprobantevDesmntosi2, lxComprobantevDesmntosi1, lxComprobantevDesmntosi3, lxComprobantevDesmntosi, lxComprobantevRecmntosi1, lxComprobantevRecmntosi, lxComprobantevAnulado, lxComprobantevDesaut, lxComprobantevFcompfis, lxComprobantevHoraexpo, lxComprobantevEsttrans, lxComprobantevOpecomm, lxComprobantevBdmodifw, lxComprobantevBdaltafw, lxComprobantevSaltafw, lxComprobantevCbautoimp, lxComprobantevDescfw, lxComprobantevFhora, lxComprobantevZadsfw, lxComprobantevUmodifw, lxComprobantevValtafw, lxComprobantevVmodifw, lxComprobantevHmodifw, lxComprobantevSmodifw, lxComprobantevHoraimpo, lxComprobantevUaltafw, lxComprobantevIdajuste, lxComprobantevDespachos, lxComprobantevFaltafw, lxComprobantevHaltafw, lxComprobantevSimbmon, lxComprobantevFacttipo, lxComprobantevIdvuelto, lxComprobantevMonsis, lxComprobantevMotdescdev, lxComprobantevFobs, lxComprobantevFpodes1, lxComprobantevFperson, lxComprobantevFturno, lxComprobantevFmtdes2, lxComprobantevIdsenia, lxComprobantevSenia, lxComprobantevCodigo, lxComprobantevMd1, lxComprobantevFcliente, lxComprobantevFmtdes1, lxComprobantevReceptor, lxComprobantevFven, lxComprobantevMoneda, lxComprobantevFletra, lxComprobantevVtosenia, lxComprobantevTotrecarsi, lxComprobantevTrci, lxComprobantevCodlista, lxComprobantevFptoven, lxComprobantevEmail, lxComprobantevFnumcomp, lxComprobantevFtotal, lxComprobantevTotdescsi, lxComprobantevTdci, lxComprobantevDirentr, lxComprobantevFfch, lxComprobantevFmtdes3, lxComprobantevDeuda, lxComprobantevCotiz, lxComprobantevFpago, lxComprobantevFpodes, lxComprobantevRecmnto2, lxComprobantevFvuelto, lxComprobantevEntregapos, lxComprobantevFfchvtopag, lxComprobantevOpctrasmis, lxComprobantevFdescu, lxComprobantevMerconsign, lxComprobantevMd3, lxComprobantevPercepcion, lxComprobantevRecmnto, lxComprobantevRecpor, lxComprobantevMr, lxComprobantevMr2, lxComprobantevMd2, lxComprobantevMr1, lxComprobantevRecmnto1, lxComprobantevGravamen, lxComprobantevFimpuesto, lxComprobantevTotrecarci, lxComprobantevTotdesc, lxComprobantevTotimpue, lxComprobantevChequer, lxComprobantevCancelar, lxComprobantevIvasis
				lxComprobantevFecimpo =  .Fechaimpo			lxComprobantevFectrans =  .Fechatransferencia			lxComprobantevFecexpo =  .Fechaexpo			lxComprobantevFd2 =  .Fechamodificacion			lxComprobantevInformnube =  .Fueinformadoalanube			lxComprobantevFmodifw =  .Fechamodificacionfw			lxComprobantevVtocai =  .Fechavtocai			lxComprobantevFcuit =  .Cuit			lxComprobantevIdcaja =  .Caja_PK 			lxComprobantevFajxre =  .Ajustesporredondeos			lxComprobantevMdcimpu =  .Montodescuentoconimpuestos			lxComprobantevTimestamp = goLibrerias.ObtenerTimestamp()			lxComprobantevCai =  .Cai			lxComprobantevFactsec =  .Secuencia			lxComprobantevTotalcant =  .Totalcantidad			lxComprobantevFpodes2 =  .Porcentajedescuento2			lxComprobantevCondivalp =  .Condicioniva			lxComprobantevSubtotcisi =  .Subtotalconimpuestossobreitems			lxComprobantevFsubtot =  .Subtotalbruto			lxComprobantevSitfisccli =  .Situacionfiscal_PK 			lxComprobantevFsubton =  .Subtotalneto			lxComprobantevSignomov =  .Signodemovimiento			lxComprobantevSubtotsisi =  .Subtotalsinimpuestossobreitems			lxComprobantevRecmntosi2 =  .Recargomontosinimpuestos2			lxComprobantevDesmntosi2 =  .Montodescuentosinimpuestos2			lxComprobantevDesmntosi1 =  .Montodescuentosinimpuestos1			lxComprobantevDesmntosi3 =  .Montodescuentosinimpuestos3			lxComprobantevDesmntosi =  .Montodescuentosinimpuestos			lxComprobantevRecmntosi1 =  .Recargomontosinimpuestos1			lxComprobantevRecmntosi =  .Recargomontosinimpuestos			lxComprobantevAnulado =  .Anulado			lxComprobantevDesaut =  .Descuentoautomatico			lxComprobantevFcompfis =  .Comprobantefiscal			lxComprobantevHoraexpo =  .Horaexpo			lxComprobantevEsttrans =  .Estadotransferencia			lxComprobantevOpecomm =  .Nroopecommerce			lxComprobantevBdmodifw =  .Basededatosmodificacionfw			lxComprobantevBdaltafw =  .Basededatosaltafw			lxComprobantevSaltafw =  .Seriealtafw			lxComprobantevCbautoimp =  .Codigobarraautoimpresor			lxComprobantevDescfw =  .Descripcionfw			lxComprobantevFhora =  .Hora			lxComprobantevZadsfw =  .Zadsfw			lxComprobantevUmodifw =  .Usuariomodificacionfw			lxComprobantevValtafw =  .Versionaltafw			lxComprobantevVmodifw =  .Versionmodificacionfw			lxComprobantevHmodifw =  .Horamodificacionfw			lxComprobantevSmodifw =  .Seriemodificacionfw			lxComprobantevHoraimpo =  .Horaimpo			lxComprobantevUaltafw =  .Usuarioaltafw			lxComprobantevIdajuste =  .Codigoajuste			lxComprobantevDespachos =  .Despachos			lxComprobantevFaltafw =  .Fechaaltafw			lxComprobantevHaltafw =  .Horaaltafw			lxComprobantevSimbmon =  .Simbolomonetariocomprobante			lxComprobantevFacttipo =  .Tipocomprobante			lxComprobantevIdvuelto =  upper( .IdVuelto_PK ) 			lxComprobantevMonsis =  upper( .MonedaSistema_PK ) 			lxComprobantevMotdescdev =  upper( .CodigoMotivoDescuentoEnSubtotal_PK ) 			lxComprobantevFobs =  .Obs			lxComprobantevFpodes1 =  .Porcentajedescuento1			lxComprobantevFperson =  upper( .Cliente_PK ) 			lxComprobantevFturno =  .Turno			lxComprobantevFmtdes2 =  .Montodescuentoconimpuestos2			lxComprobantevIdsenia =  .Idsenia			lxComprobantevSenia =  upper( .Senia_PK ) 			lxComprobantevCodigo =  .Codigo			lxComprobantevMd1 =  .Montodescuento1			lxComprobantevFcliente =  .Clientedescripcion			lxComprobantevFmtdes1 =  .Montodescuentoconimpuestos1			lxComprobantevReceptor =  upper( .Receptor_PK ) 			lxComprobantevFven =  upper( .Vendedor_PK ) 			lxComprobantevMoneda =  upper( .MonedaComprobante_PK ) 			lxComprobantevFletra =  .Letra			lxComprobantevVtosenia =  .Fechavtosenia			lxComprobantevTotrecarsi =  .Totalrecargossinimpuestos			lxComprobantevTrci =  .Totalrecargosconimpuestos			lxComprobantevCodlista =  upper( .ListaDePrecios_PK ) 			lxComprobantevFptoven =  .Puntodeventa			lxComprobantevEmail =  .Email			lxComprobantevFnumcomp =  .Numero			lxComprobantevFtotal =  .Total			lxComprobantevTotdescsi =  .Totaldescuentossinimpuestos			lxComprobantevTdci =  .Totaldescuentosconimpuestos			lxComprobantevDirentr =  .Direccionentrega			lxComprobantevFfch =  .Fecha			lxComprobantevFmtdes3 =  .Montodescuentoconimpuestos3			lxComprobantevDeuda =  .Deuda			lxComprobantevCotiz =  .Cotizacion			lxComprobantevFpago =  upper( .ForPago_PK ) 			lxComprobantevFpodes =  .Porcentajedescuento			lxComprobantevRecmnto2 =  .Recargomontoconimpuestos2			lxComprobantevFvuelto =  .Vuelto			lxComprobantevEntregapos =  .Entregaposterior			lxComprobantevFfchvtopag =  .Fechavencimientomipyme			lxComprobantevOpctrasmis =  .Opciontransmisionmipyme			lxComprobantevFdescu =  .Descuento			lxComprobantevMerconsign =  .Mercaderiaconsignacion			lxComprobantevMd3 =  .Montodescuento3			lxComprobantevPercepcion =  .Percepciones			lxComprobantevRecmnto =  .Recargomontoconimpuestos			lxComprobantevRecpor =  .Recargoporcentaje			lxComprobantevMr =  .Recargomonto			lxComprobantevMr2 =  .Recargomonto2			lxComprobantevMd2 =  .Montodescuento2			lxComprobantevMr1 =  .Recargomonto1			lxComprobantevRecmnto1 =  .Recargomontoconimpuestos1			lxComprobantevGravamen =  .Gravamenes			lxComprobantevFimpuesto =  .Impuestos			lxComprobantevTotrecarci =  .Totalrecargos			lxComprobantevTotdesc =  .Totaldescuentos			lxComprobantevTotimpue =  .Totalimpuestos			lxComprobantevChequer =  .Chequereintegro			lxComprobantevCancelar =  .Accioncancelatoria			lxComprobantevIvasis =  .Ivadelsistema
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)]
			text to lcSentencia noshow textmerge
				update ZooLogic.COMPROBANTEV set "Fecimpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecimpo ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxComprobantevFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxComprobantevFecexpo ) + "'">>, "Fd2" = <<"'" + this.ConvertirDateSql( lxComprobantevFd2 ) + "'">>, "Informnube" = <<"'" + this.ConvertirDateSql( lxComprobantevInformnube ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxComprobantevFmodifw ) + "'">>, "Vtocai" = <<"'" + this.ConvertirDateSql( lxComprobantevVtocai ) + "'">>, "Fcuit" = <<"'" + this.FormatearTextoSql( lxComprobantevFcuit ) + "'">>, "Idcaja" = <<lxComprobantevIdcaja>>, "Fajxre" = <<lxComprobantevFajxre>>, "Mdcimpu" = <<lxComprobantevMdcimpu>>, "Timestamp" = <<lxComprobantevTimestamp>>, "Cai" = <<lxComprobantevCai>>, "Factsec" = <<"'" + this.FormatearTextoSql( lxComprobantevFactsec ) + "'">>, "Totalcant" = <<lxComprobantevTotalcant>>, "Fpodes2" = <<lxComprobantevFpodes2>>, "Condivalp" = <<lxComprobantevCondivalp>>, "Subtotcisi" = <<lxComprobantevSubtotcisi>>, "Fsubtot" = <<lxComprobantevFsubtot>>, "Sitfisccli" = <<lxComprobantevSitfisccli>>, "Fsubton" = <<lxComprobantevFsubton>>, "Signomov" = <<lxComprobantevSignomov>>, "Subtotsisi" = <<lxComprobantevSubtotsisi>>, "Recmntosi2" = <<lxComprobantevRecmntosi2>>, "Desmntosi2" = <<lxComprobantevDesmntosi2>>, "Desmntosi1" = <<lxComprobantevDesmntosi1>>, "Desmntosi3" = <<lxComprobantevDesmntosi3>>, "Desmntosi" = <<lxComprobantevDesmntosi>>, "Recmntosi1" = <<lxComprobantevRecmntosi1>>, "Recmntosi" = <<lxComprobantevRecmntosi>>, "Anulado" = <<iif( lxComprobantevAnulado, 1, 0 )>>, "Desaut" = <<iif( lxComprobantevDesaut, 1, 0 )>>, "Fcompfis" = <<iif( lxComprobantevFcompfis, 1, 0 )>>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraexpo ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxComprobantevEsttrans ) + "'">>, "Opecomm" = <<"'" + this.FormatearTextoSql( lxComprobantevOpecomm ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdmodifw ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevBdaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevSaltafw ) + "'">>, "Cbautoimp" = <<"'" + this.FormatearTextoSql( lxComprobantevCbautoimp ) + "'">>, "Descfw" = <<"'" + this.FormatearTextoSql( lxComprobantevDescfw ) + "'">>, "Fhora" = <<"'" + this.FormatearTextoSql( lxComprobantevFhora ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxComprobantevZadsfw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevUmodifw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevValtafw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevVmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevHmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxComprobantevSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxComprobantevHoraimpo ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxComprobantevUaltafw ) + "'">>, "Idajuste" = <<"'" + this.FormatearTextoSql( lxComprobantevIdajuste ) + "'">>, "Despachos" = <<"'" + this.FormatearTextoSql( lxComprobantevDespachos ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxComprobantevFaltafw ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxComprobantevHaltafw ) + "'">>, "Simbmon" = <<"'" + this.FormatearTextoSql( lxComprobantevSimbmon ) + "'">>, "Facttipo" = <<lxComprobantevFacttipo>>, "Idvuelto" = <<"'" + this.FormatearTextoSql( lxComprobantevIdvuelto ) + "'">>, "Monsis" = <<"'" + this.FormatearTextoSql( lxComprobantevMonsis ) + "'">>, "Motdescdev" = <<"'" + this.FormatearTextoSql( lxComprobantevMotdescdev ) + "'">>, "Fobs" = <<"'" + this.FormatearTextoSql( lxComprobantevFobs ) + "'">>, "Fpodes1" = <<lxComprobantevFpodes1>>, "Fperson" = <<"'" + this.FormatearTextoSql( lxComprobantevFperson ) + "'">>, "Fturno" = <<lxComprobantevFturno>>, "Fmtdes2" = <<lxComprobantevFmtdes2>>, "Idsenia" = <<"'" + this.FormatearTextoSql( lxComprobantevIdsenia ) + "'">>, "Senia" = <<"'" + this.FormatearTextoSql( lxComprobantevSenia ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxComprobantevCodigo ) + "'">>, "Md1" = <<lxComprobantevMd1>>, "Fcliente" = <<"'" + this.FormatearTextoSql( lxComprobantevFcliente ) + "'">>, "Fmtdes1" = <<lxComprobantevFmtdes1>>, "Receptor" = <<"'" + this.FormatearTextoSql( lxComprobantevReceptor ) + "'">>, "Fven" = <<"'" + this.FormatearTextoSql( lxComprobantevFven ) + "'">>, "Moneda" = <<"'" + this.FormatearTextoSql( lxComprobantevMoneda ) + "'">>, "Fletra" = <<"'" + this.FormatearTextoSql( lxComprobantevFletra ) + "'">>, "Vtosenia" = <<"'" + this.ConvertirDateSql( lxComprobantevVtosenia ) + "'">>, "Totrecarsi" = <<lxComprobantevTotrecarsi>>, "Trci" = <<lxComprobantevTrci>>, "Codlista" = <<"'" + this.FormatearTextoSql( lxComprobantevCodlista ) + "'">>, "Fptoven" = <<lxComprobantevFptoven>>, "Email" = <<"'" + this.FormatearTextoSql( lxComprobantevEmail ) + "'">>, "Fnumcomp" = <<lxComprobantevFnumcomp>>, "Ftotal" = <<lxComprobantevFtotal>>, "Totdescsi" = <<lxComprobantevTotdescsi>>, "Tdci" = <<lxComprobantevTdci>>, "Direntr" = <<"'" + this.FormatearTextoSql( lxComprobantevDirentr ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxComprobantevFfch ) + "'">>, "Fmtdes3" = <<lxComprobantevFmtdes3>>, "Deuda" = <<lxComprobantevDeuda>>, "Cotiz" = <<lxComprobantevCotiz>>, "Fpago" = <<"'" + this.FormatearTextoSql( lxComprobantevFpago ) + "'">>, "Fpodes" = <<lxComprobantevFpodes>>, "Recmnto2" = <<lxComprobantevRecmnto2>>, "Fvuelto" = <<lxComprobantevFvuelto>>, "Entregapos" = <<lxComprobantevEntregapos>>, "Ffchvtopag" = <<"'" + this.ConvertirDateSql( lxComprobantevFfchvtopag ) + "'">>, "Opctrasmis" = <<"'" + this.FormatearTextoSql( lxComprobantevOpctrasmis ) + "'">>, "Fdescu" = <<lxComprobantevFdescu>>, "Merconsign" = <<iif( lxComprobantevMerconsign, 1, 0 )>>, "Md3" = <<lxComprobantevMd3>>, "Percepcion" = <<lxComprobantevPercepcion>>, "Recmnto" = <<lxComprobantevRecmnto>>, "Recpor" = <<lxComprobantevRecpor>>, "Mr" = <<lxComprobantevMr>>, "Mr2" = <<lxComprobantevMr2>>, "Md2" = <<lxComprobantevMd2>>, "Mr1" = <<lxComprobantevMr1>>, "Recmnto1" = <<lxComprobantevRecmnto1>>, "Gravamen" = <<lxComprobantevGravamen>>, "Fimpuesto" = <<lxComprobantevFimpuesto>>, "Totrecarci" = <<lxComprobantevTotrecarci>>, "Totdesc" = <<lxComprobantevTotdesc>>, "Totimpue" = <<lxComprobantevTotimpue>>, "Chequer" = <<"'" + this.FormatearTextoSql( lxComprobantevChequer ) + "'">>, "Cancelar" = <<iif( lxComprobantevCancelar, 1, 0 )>>, "Ivasis" = <<lxComprobantevIvasis>> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'COMPROBANTEV' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PromDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ProArtDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KITDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

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
						Insert into ZooLogic.COMPROBANTEVDET("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FporCFI","FX2","FporDTO1","NroItem","fporIva","AfeSaldo","FmtoDTO1","FmtoIVA","prunconimp","FNETO","Prunsinimp","FKIT","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FmtoCFI","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","IdItem","Afe_cod","IDKIT","FAMate","CODIGO","GiftCard","MotDescu","FUnid","MotDevol","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","seniacance","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxPorcentajecfi>>, <<lxOferta>>, <<lxPorcentajedto1>>, <<lxNroitem>>, <<lxPorcentajeiva>>, <<lxAfe_saldo>>, <<lxMontodto1>>, <<lxMontoiva>>, <<lxPrecioconimpuestos>>, <<lxNeto>>, <<lxPreciosinimpuestos>>, <<lxKit>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxMontocfi>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<"'" + this.FormatearTextoSql( lxIdseniacancelada ) + "'">>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.COMPROBANTEVDET" )
this.xmlacursor( lcXml, 'c_COMPROBANTEVDETciditem' )
loItem.idItem = c_COMPROBANTEVDETciditem.ciditem
use in select( 'c_COMPROBANTEVDETciditem' )
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
			for each loItem in this.oEntidad.PromocionesDetalle
				if this.oEntidad.PromocionesDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxPromociontipo = loItem.Promociontipo
					lxNroitem = lnContadorNroItem
					lxPromocion_PK = loItem.Promocion_PK
					lxPromociondetalle = loItem.Promociondetalle
					lxCantidad = loItem.Cantidad
					lxBeneficio = loItem.Beneficio
					lxIditempromocion = loItem.Iditempromocion
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.PromDet("Tipo","NROITEM","Codigo","Promo","descrip","Cantidad","Beneficio","IdItem" ) values ( <<lxPromociontipo>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxPromocion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxPromociondetalle ) + "'">>, <<lxCantidad>>, <<lxBeneficio>>, <<"'" + this.FormatearTextoSql( lxIditempromocion ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.PromoArticulosDetalle
				if this.oEntidad.PromoArticulosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxMontobeneficio = loItem.Montobeneficio
					lxNroitem = lnContadorNroItem
					lxIditemvalor = loItem.Iditemvalor
					lxAtributocabecera = loItem.Atributocabecera
					lxIditemarticulo = loItem.Iditemarticulo
					lxIditempromo = loItem.Iditempromo
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ProArtDet("Monto","NROITEM","IdValor","AtrCabever","IdArti","IdPromo","CODIGO" ) values ( <<lxMontobeneficio>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxIditemvalor ) + "'">>, <<"'" + this.FormatearTextoSql( lxAtributocabecera ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditempromo ) + "'">>, << lcValorClavePrimariaString >> ) 
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
			for each loItem in this.oEntidad.ArticulosSeniadosDetalle
				if this.oEntidad.ArticulosSeniadosDetalle.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
					lxOferta = loItem.Oferta
					lxNroitem = lnContadorNroItem
					lxPorcentajecfi = loItem.Porcentajecfi
					lxAfe_saldo = loItem.Afe_saldo
					lxPorcentajedto1 = loItem.Porcentajedto1
					lxNeto = loItem.Neto
					lxKit = loItem.Kit
					lxMontocfi = loItem.Montocfi
					lxMontodto1 = loItem.Montodto1
					lxPorcentajeiva = loItem.Porcentajeiva
					lxMontoiva = loItem.Montoiva
					lxPreciosinimpuestos = loItem.Preciosinimpuestos
					lxPrecioconimpuestos = loItem.Precioconimpuestos
					lxMontoporcentajedescuentoconimpuesto = loItem.Montoporcentajedescuentoconimpuesto
					lxAfe_tipocomprobante = loItem.Afe_tipocomprobante
					lxAfe_cantidad = loItem.Afe_cantidad
					lxAfe_nroitem = loItem.Afe_nroitem
					lxIdorigen = loItem.Idorigen
					lxTipolistadeprecio = loItem.Tipolistadeprecio
					lxPreciounitario = loItem.Preciounitario
					lxRestringirdescuentos = loItem.Restringirdescuentos
					lxUsarpreciodelista = loItem.Usarpreciodelista
					lxNoprocesarstock = loItem.Noprocesarstock
					lxCodigoautorizaciondjcp = loItem.Codigoautorizaciondjcp
					lxMaterial_PK = loItem.Material_PK
					lxAfe_codigo = loItem.Afe_codigo
					lxIdkit = loItem.Idkit
					lxIditemarticulos = loItem.Iditemarticulos
					lxNumerogiftcard_PK = loItem.Numerogiftcard_PK
					lxCodigomotivodevolucion_PK = loItem.Codigomotivodevolucion_PK
					lxUnidad_PK = loItem.Unidad_PK
					lxCodigomotivodescuento_PK = loItem.Codigomotivodescuento_PK
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
					lxPrecio = loItem.Precio
					lxMonto = loItem.Monto
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.SeniaVDet("AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FX2","NroItem","FporCFI","AfeSaldo","FporDTO1","FNETO","FKIT","FmtoCFI","FmtoDTO1","fporIva","FmtoIVA","Prunsinimp","prunconimp","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","FAMate","Afe_cod","IDKIT","IdItem","CODIGO","GiftCard","MotDevol","FUnid","MotDescu","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","FPRECIO","FMONTO" ) values ( <<lxAfe_puntodeventa>>, <<"'" + this.FormatearTextoSql( lxAfe_letra ) + "'">>, <<lxAfe_numero>>, <<"'" + this.FormatearTextoSql( lxCodigogtin ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<lxMontoprorrateorecargosinimpuestos>>, <<lxMontoprorrateodescuentosinimpuestos>>, <<lxMontoprorrateorecargoconimpuestos>>, <<lxAfe_timestamp>>, <<lxMontoprorrateototal>>, <<lxMontoprorrateodescuentoconimpuestos>>, <<lxMontoprorrateopercepciones>>, <<lxPreciosinimpuestossinredondear>>, <<lxMontoporcentajedescuentosinimpuesto>>, <<lxTienerestriccion>>, <<lxAfe_saldoliquidacion>>, <<lxComportamiento>>, <<lxMontoimpuestointerno>>, <<lxPercepcionivarg5329>>, <<lxAjusteporredondeosinimpuestos>>, <<lxTasaimpuestointerno>>, <<lxPrecioconimpuestossinredondear>>, <<lxMontodescuentosinimpuestos>>, <<lxBruto>>, <<lxPreciosinredondear>>, <<lxMontodescuentoconimpuestos>>, <<lxAjusteporredondeoconimpuestos>>, <<lxArticulo_porcentajeivaventas>>, <<lxArticulo_condicionivaventas>>, <<lxOferta>>, <<lxNroitem>>, <<lxPorcentajecfi>>, <<lxAfe_saldo>>, <<lxPorcentajedto1>>, <<lxNeto>>, <<lxKit>>, <<lxMontocfi>>, <<lxMontodto1>>, <<lxPorcentajeiva>>, <<lxMontoiva>>, <<lxPreciosinimpuestos>>, <<lxPrecioconimpuestos>>, <<lxMontoporcentajedescuentoconimpuesto>>, <<lxAfe_tipocomprobante>>, <<lxAfe_cantidad>>, <<lxAfe_nroitem>>, <<lxIdorigen>>, <<lxTipolistadeprecio>>, <<lxPreciounitario>>, <<iif( lxRestringirdescuentos, 1, 0 )>>, <<iif( lxUsarpreciodelista, 1, 0 )>>, <<iif( lxNoprocesarstock, 1, 0 )>>, <<"'" + this.FormatearTextoSql( lxCodigoautorizaciondjcp ) + "'">>, <<"'" + this.FormatearTextoSql( lxMaterial_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxAfe_codigo ) + "'">>, <<"'" + this.FormatearTextoSql( lxIdkit ) + "'">>, <<"'" + this.FormatearTextoSql( lxIditemarticulos ) + "'">>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxNumerogiftcard_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodevolucion_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidad_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxCodigomotivodescuento_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxEquivalencia_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle ) + "'">>, <<lxDescuento>>, <<lxMontoprorrateoiva>>, <<lxMontodescuento>>, <<lxMontoprorrateoimpuestointerno>>, <<lxCantidad>>, <<lxPrecio>>, <<lxMonto>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					local lcXml as string
lcXml = this.oConexion.EjecutarSql( "select max( ciditem ) as ciditem from ZooLogic.SeniaVDet" )
this.xmlacursor( lcXml, 'c_SeniaVDetciditem' )
loItem.idItem = c_SeniaVDetciditem.ciditem
use in select( 'c_SeniaVDetciditem' )
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)]
		loColeccion.Agregar( 'delete from ZooLogic.COMPROBANTEV where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.COMPROBANTEVDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.CompAfe where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.PromDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ProArtDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.KITDET where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.IMPUESTOSV where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.impVentas where "cCod" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.SeniaVDet where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.VAL where "JJNUM" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
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
			
			.oCompServiciosalcliente.lNuevo = .EsNuevo()
			.oCompServiciosalcliente.lEdicion = .EsEdicion()
			.oCompServiciosalcliente.lEliminar = .lEliminar
			.oCompServiciosalcliente.lAnular = .lAnular
			loColSentencias = .oCompServiciosalcliente.grabar()
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
			lcRetorno = [update ZooLogic.COMPROBANTEV set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.COMPROBANTEV where  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.COMPROBANTEV where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)" )
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

		Local loError as Exception
		dodefault()

		with this.oEntidad
			.lCargando = .t.
			Try
				If .VerificarContexto( 'C' )
				Else
					.NUMERO = .oNumeraciones.grabar( 'NUMERO' )
					Try
						.oNumeraciones.AsignarAtributosCAI( 'NUMERO', 'FECHA'  )
					Catch to loError
						this.ActualizarNumeraciones()
						goServicios.Errores.LevantarExcepcion( loError )
					EndTry
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA'
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
								this.oConexion.EjecutarSql( [UPDATE ZooLogic.COMPROBANTEV set  FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FD2 = ] + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'"+ [, InformNube = ] + "'" + this.ConvertirDateSql( &lcCursor..InformNube ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, VtoCAI = ] + "'" + this.ConvertirDateSql( &lcCursor..VtoCAI ) + "'"+ [, fCuit = ] + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'"+ [, IdCaja = ] + transform( &lcCursor..IdCaja )+ [, FAjXRe = ] + transform( &lcCursor..FAjXRe )+ [, MDCIMPU = ] + transform( &lcCursor..MDCIMPU )+ [, TIMESTAMP = ] + transform( &lcCursor..TIMESTAMP )+ [, CAI = ] + transform( &lcCursor..CAI )+ [, FACTSEC = ] + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'"+ [, TotalCant = ] + transform( &lcCursor..TotalCant )+ [, FPODES2 = ] + transform( &lcCursor..FPODES2 )+ [, CondivaLp = ] + transform( &lcCursor..CondivaLp )+ [, SubTotCISI = ] + transform( &lcCursor..SubTotCISI )+ [, FSubTOT = ] + transform( &lcCursor..FSubTOT )+ [, SitFiscCli = ] + transform( &lcCursor..SitFiscCli )+ [, fSubToN = ] + transform( &lcCursor..fSubToN )+ [, signomov = ] + transform( &lcCursor..signomov )+ [, SubTotSISI = ] + transform( &lcCursor..SubTotSISI )+ [, RecMntoSI2 = ] + transform( &lcCursor..RecMntoSI2 )+ [, DesMntoSI2 = ] + transform( &lcCursor..DesMntoSI2 )+ [, DesMntoSI1 = ] + transform( &lcCursor..DesMntoSI1 )+ [, DesMntoSI3 = ] + transform( &lcCursor..DesMntoSI3 )+ [, DesMntoSI = ] + transform( &lcCursor..DesMntoSI )+ [, RecMntoSI1 = ] + transform( &lcCursor..RecMntoSI1 )+ [, RecMntoSI = ] + transform( &lcCursor..RecMntoSI )+ [, Anulado = ] + Transform( iif( &lcCursor..Anulado, 1, 0 ))+ [, DESAUT = ] + Transform( iif( &lcCursor..DESAUT, 1, 0 ))+ [, FCOMPFIS = ] + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 ))+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, OPEcomm = ] + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, CBAutoImp = ] + "'" + this.FormatearTextoSql( &lcCursor..CBAutoImp ) + "'"+ [, DescFW = ] + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'"+ [, FHORA = ] + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, idAjuste = ] + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'"+ [, Despachos = ] + "'" + this.FormatearTextoSql( &lcCursor..Despachos ) + "'"+ [, SimbMon = ] + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'"+ [, FACTTIPO = ] + transform( &lcCursor..FACTTIPO )+ [, idVuelto = ] + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'"+ [, MonSis = ] + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'"+ [, MotDescDev = ] + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'"+ [, FObs = ] + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'"+ [, FPODES1 = ] + transform( &lcCursor..FPODES1 )+ [, FPerson = ] + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'"+ [, FTurno = ] + transform( &lcCursor..FTurno )+ [, FMTDES2 = ] + transform( &lcCursor..FMTDES2 )+ [, IDSenia = ] + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'"+ [, Senia = ] + "'" + this.FormatearTextoSql( &lcCursor..Senia ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, MD1 = ] + transform( &lcCursor..MD1 )+ [, FCLIENTE = ] + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'"+ [, FMTDES1 = ] + transform( &lcCursor..FMTDES1 )+ [, Receptor = ] + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'"+ [, FVEN = ] + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'"+ [, Moneda = ] + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'"+ [, FLETRA = ] + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'"+ [, vtosenia = ] + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'"+ [, totrecarSI = ] + transform( &lcCursor..totrecarSI )+ [, TRCI = ] + transform( &lcCursor..TRCI )+ [, CodLista = ] + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"+ [, FPTOVEN = ] + transform( &lcCursor..FPTOVEN )+ [, Email = ] + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'"+ [, FNUMCOMP = ] + transform( &lcCursor..FNUMCOMP )+ [, FTotal = ] + transform( &lcCursor..FTotal )+ [, totdescSI = ] + transform( &lcCursor..totdescSI )+ [, TDCI = ] + transform( &lcCursor..TDCI )+ [, DirEntr = ] + "'" + this.FormatearTextoSql( &lcCursor..DirEntr ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, FMTDES3 = ] + transform( &lcCursor..FMTDES3 )+ [, Deuda = ] + transform( &lcCursor..Deuda )+ [, Cotiz = ] + transform( &lcCursor..Cotiz )+ [, FPago = ] + "'" + this.FormatearTextoSql( &lcCursor..FPago ) + "'"+ [, FPODES = ] + transform( &lcCursor..FPODES )+ [, RecMnto2 = ] + transform( &lcCursor..RecMnto2 )+ [, FVuelto = ] + transform( &lcCursor..FVuelto )+ [, EntregaPos = ] + transform( &lcCursor..EntregaPos )+ [, FFCHVTOPAG = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCHVTOPAG ) + "'"+ [, OpcTrasmis = ] + "'" + this.FormatearTextoSql( &lcCursor..OpcTrasmis ) + "'"+ [, fDescu = ] + transform( &lcCursor..fDescu )+ [, MerConsign = ] + Transform( iif( &lcCursor..MerConsign, 1, 0 ))+ [, MD3 = ] + transform( &lcCursor..MD3 )+ [, percepcion = ] + transform( &lcCursor..percepcion )+ [, RecMnto = ] + transform( &lcCursor..RecMnto )+ [, RecPor = ] + transform( &lcCursor..RecPor )+ [, MR = ] + transform( &lcCursor..MR )+ [, MR2 = ] + transform( &lcCursor..MR2 )+ [, MD2 = ] + transform( &lcCursor..MD2 )+ [, MR1 = ] + transform( &lcCursor..MR1 )+ [, RecMnto1 = ] + transform( &lcCursor..RecMnto1 )+ [, gravamen = ] + transform( &lcCursor..gravamen )+ [, fImpuesto = ] + transform( &lcCursor..fImpuesto )+ [, totrecarCI = ] + transform( &lcCursor..totrecarCI )+ [, totdesc = ] + transform( &lcCursor..totdesc )+ [, totimpue = ] + transform( &lcCursor..totimpue )+ [, ChequeR = ] + "'" + this.FormatearTextoSql( &lcCursor..ChequeR ) + "'"+ [, Cancelar = ] + Transform( iif( &lcCursor..Cancelar, 1, 0 ))+ [, IvaSis = ] + transform( &lcCursor..IvaSis ) + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
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
						 FECIMPO, FECTRANS, FECEXPO, FD2, InformNube, FMODIFW, VtoCAI, fCuit, IdCaja, FAjXRe, MDCIMPU, TIMESTAMP, CAI, FACTSEC, TotalCant, FPODES2, CondivaLp, SubTotCISI, FSubTOT, SitFiscCli, fSubToN, signomov, SubTotSISI, RecMntoSI2, DesMntoSI2, DesMntoSI1, DesMntoSI3, DesMntoSI, RecMntoSI1, RecMntoSI, Anulado, DESAUT, FCOMPFIS, HORAEXPO, ESTTRANS, OPEcomm, BDMODIFW, BDALTAFW, SALTAFW, CBAutoImp, DescFW, FHORA, ZADSFW, UMODIFW, VALTAFW, VMODIFW, HMODIFW, SMODIFW, HORAIMPO, UALTAFW, idAjuste, Despachos, FAltaFW, HAltaFW, SimbMon, FACTTIPO, idVuelto, MonSis, MotDescDev, FObs, FPODES1, FPerson, FTurno, FMTDES2, IDSenia, Senia, CODIGO, MD1, FCLIENTE, FMTDES1, Receptor, FVEN, Moneda, FLETRA, vtosenia, totrecarSI, TRCI, CodLista, FPTOVEN, Email, FNUMCOMP, FTotal, totdescSI, TDCI, DirEntr, FFCH, FMTDES3, Deuda, Cotiz, FPago, FPODES, RecMnto2, FVuelto, EntregaPos, FFCHVTOPAG, OpcTrasmis, fDescu, MerConsign, MD3, percepcion, RecMnto, RecPor, MR, MR2, MD2, MR1, RecMnto1, gravamen, fImpuesto, totrecarCI, totdesc, totimpue, ChequeR, Cancelar, IvaSis
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FD2 ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..InformNube ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..VtoCAI ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..fCuit ) + "'" + ',' + transform( &lcCursor..IdCaja ) + ',' + transform( &lcCursor..FAjXRe ) + ',' + transform( &lcCursor..MDCIMPU ) + ',' + transform( &lcCursor..TIMESTAMP ) + ',' + transform( &lcCursor..CAI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FACTSEC ) + "'" + ',' + transform( &lcCursor..TotalCant ) + ',' + transform( &lcCursor..FPODES2 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..CondivaLp ) + ',' + transform( &lcCursor..SubTotCISI ) + ',' + transform( &lcCursor..FSubTOT ) + ',' + transform( &lcCursor..SitFiscCli ) + ',' + transform( &lcCursor..fSubToN ) + ',' + transform( &lcCursor..signomov ) + ',' + transform( &lcCursor..SubTotSISI ) + ',' + transform( &lcCursor..RecMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI2 ) + ',' + transform( &lcCursor..DesMntoSI1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..DesMntoSI3 ) + ',' + transform( &lcCursor..DesMntoSI ) + ',' + transform( &lcCursor..RecMntoSI1 ) + ',' + transform( &lcCursor..RecMntoSI ) + ',' + Transform( iif( &lcCursor..Anulado, 1, 0 )) + ',' + Transform( iif( &lcCursor..DESAUT, 1, 0 )) + ',' + Transform( iif( &lcCursor..FCOMPFIS, 1, 0 )) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..OPEcomm ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CBAutoImp ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..DescFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FHORA ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..idAjuste ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Despachos ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HAltaFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SimbMon ) + "'" + ',' + transform( &lcCursor..FACTTIPO )
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..idVuelto ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MonSis ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MotDescDev ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FObs ) + "'" + ',' + transform( &lcCursor..FPODES1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPerson ) + "'" + ',' + transform( &lcCursor..FTurno )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FMTDES2 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..IDSenia ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Senia ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'" + ',' + transform( &lcCursor..MD1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FCLIENTE ) + "'" + ',' + transform( &lcCursor..FMTDES1 ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Receptor ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FVEN ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Moneda ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FLETRA ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..vtosenia ) + "'" + ',' + transform( &lcCursor..totrecarSI ) + ',' + transform( &lcCursor..TRCI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..CodLista ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..FPTOVEN ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Email ) + "'" + ',' + transform( &lcCursor..FNUMCOMP ) + ',' + transform( &lcCursor..FTotal ) + ',' + transform( &lcCursor..totdescSI ) + ',' + transform( &lcCursor..TDCI ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..DirEntr ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + transform( &lcCursor..FMTDES3 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Deuda ) + ',' + transform( &lcCursor..Cotiz ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..FPago ) + "'" + ',' + transform( &lcCursor..FPODES ) + ',' + transform( &lcCursor..RecMnto2 ) + ',' + transform( &lcCursor..FVuelto ) + ',' + transform( &lcCursor..EntregaPos ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCHVTOPAG ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OpcTrasmis ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..fDescu ) + ',' + Transform( iif( &lcCursor..MerConsign, 1, 0 )) + ',' + transform( &lcCursor..MD3 ) + ',' + transform( &lcCursor..percepcion ) + ',' + transform( &lcCursor..RecMnto ) + ',' + transform( &lcCursor..RecPor ) + ',' + transform( &lcCursor..MR ) + ',' + transform( &lcCursor..MR2 ) + ',' + transform( &lcCursor..MD2 ) + ',' + transform( &lcCursor..MR1 ) + ',' + transform( &lcCursor..RecMnto1 )
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..gravamen ) + ',' + transform( &lcCursor..fImpuesto ) + ',' + transform( &lcCursor..totrecarCI ) + ',' + transform( &lcCursor..totdesc ) + ',' + transform( &lcCursor..totimpue ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..ChequeR ) + "'" + ',' + Transform( iif( &lcCursor..Cancelar, 1, 0 )) + ',' + transform( &lcCursor..IvaSis )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.CompAfe Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.PromDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ProArtDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.KITDET Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.IMPUESTOSV Where Codigo] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.impVentas Where cCod] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.SeniaVDet Where CODIGO] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.VAL Where JJNUM] + lcIn  )
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
		this.oConexion.EjecutarSql( [Insert into ZooLogic.COMPROBANTEVDET ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afe_cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.seniacance ) + "'" + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPROMOCIONES'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Tipo","NROITEM","Codigo","Promo","descrip","Cantidad","Beneficio","IdItem"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.PromDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Tipo       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Promo      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.descrip    ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ',' + transform( cDetallesExistentes.Beneficio  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMPROMOARTICULOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"Monto","NROITEM","IdValor","AtrCabever","IdArti","IdPromo","CODIGO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ProArtDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.Monto      ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdValor    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AtrCabever ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdArti     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdPromo    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ' )'  )
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
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSENIADOS'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CODIGO in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"AfePTOVEN","AfeLETRA","AfeNUMCOM","codgtin","FART","MNTPRECSI","MNTPDESSI","MNTPRECCI","AfeTS","MNTPTOT","MNTPDESCI","MNTPPER","PRECIOSISR","MNPDSI","ConRestr","Afe_SLiq","COMP","impinterno","ArtPercep","AjuSImp","tasaimpint","PRECIOCISR","MNDESSI","FBruto","PRECIOSR","MNDESCI","AjuCImp","APorcIvaV","ACondIvaV","FX2","NroItem","FporCFI","AfeSaldo","FporDTO1","FNETO","FKIT","FmtoCFI","FmtoDTO1","fporIva","FmtoIVA","Prunsinimp","prunconimp","FCFITot","AfeTipoCom","AfeCANT","AfeNroItem","iditemOrig","FN11","FPRUN","ArtSinDes","UsarPLista","ProcStock","CodAutDJCP","FAMate","Afe_cod","IDKIT","IdItem","CODIGO","GiftCard","MotDevol","FUnid","MotDescu","Equiv","FTXT","FCOLO","FCOTXT","FTALL","FCFI","MNTPIVA","MNTDES","MNTPINT","FCANT","FPRECIO","FMONTO"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.SeniaVDet ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.AfePTOVEN  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.AfeLETRA   ) + "'" + ',' + transform( cDetallesExistentes.AfeNUMCOM  ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.codgtin    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FART       ) + "'" + ',' + transform( cDetallesExistentes.MNTPRECSI  ) + ',' + transform( cDetallesExistentes.MNTPDESSI  ) + ',' + transform( cDetallesExistentes.MNTPRECCI  ) + ',' + transform( cDetallesExistentes.AfeTS      ) + ',' + transform( cDetallesExistentes.MNTPTOT    ) + ',' + transform( cDetallesExistentes.MNTPDESCI  ) + ',' + transform( cDetallesExistentes.MNTPPER    ) + ',' + transform( cDetallesExistentes.PRECIOSISR ) + ',' + transform( cDetallesExistentes.MNPDSI     ) + ',' + transform( cDetallesExistentes.ConRestr   ) + ',' + transform( cDetallesExistentes.Afe_SLiq   ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.impinterno ) + ',' + transform( cDetallesExistentes.ArtPercep  ) + ',' + transform( cDetallesExistentes.AjuSImp    ) + ',' + transform( cDetallesExistentes.tasaimpint ) + ',' + transform( cDetallesExistentes.PRECIOCISR ) + ',' + transform( cDetallesExistentes.MNDESSI    ) + ',' + transform( cDetallesExistentes.FBruto     ) + ',' + transform( cDetallesExistentes.PRECIOSR   ) + ',' + transform( cDetallesExistentes.MNDESCI    ) + ',' + transform( cDetallesExistentes.AjuCImp    ) + ',' + transform( cDetallesExistentes.APorcIvaV  ) + ',' + transform( cDetallesExistentes.ACondIvaV  ) + ',' + transform( cDetallesExistentes.FX2        ) + ',' + transform( cDetallesExistentes.NroItem    ) + ',' + transform( cDetallesExistentes.FporCFI    ) + ',' + transform( cDetallesExistentes.AfeSaldo   ) + ',' + transform( cDetallesExistentes.FporDTO1   ) + ',' + transform( cDetallesExistentes.FNETO      ) + ',' + transform( cDetallesExistentes.FKIT       ) + ',' + transform( cDetallesExistentes.FmtoCFI    ) + ',' + transform( cDetallesExistentes.FmtoDTO1   ) + ',' + transform( cDetallesExistentes.fporIva    ) + ',' + transform( cDetallesExistentes.FmtoIVA    ) + ',' + transform( cDetallesExistentes.Prunsinimp ) + ',' + transform( cDetallesExistentes.prunconimp ) + ',' + transform( cDetallesExistentes.FCFITot    ) + ',' + transform( cDetallesExistentes.AfeTipoCom ) + ',' + transform( cDetallesExistentes.AfeCANT    ) + ',' + transform( cDetallesExistentes.AfeNroItem ) + ',' + transform( cDetallesExistentes.iditemOrig ) + ',' + transform( cDetallesExistentes.FN11       ) + ',' + transform( cDetallesExistentes.FPRUN      ) + ',' + Transform( iif( cDetallesExistentes.ArtSinDes , 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.UsarPLista, 1, 0 )) + ',' + Transform( iif( cDetallesExistentes.ProcStock , 1, 0 )) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodAutDJCP ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FAMate     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Afe_cod    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IDKIT      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CODIGO     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GiftCard   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDevol   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FUnid      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescu   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Equiv      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTXT       ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLO      ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOTXT     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FTALL      ) + "'" + ',' + transform( cDetallesExistentes.FCFI       ) + ',' + transform( cDetallesExistentes.MNTPIVA    ) + ',' + transform( cDetallesExistentes.MNTDES     ) + ',' + transform( cDetallesExistentes.MNTPINT    ) + ',' + transform( cDetallesExistentes.FCANT      ) + ',' + transform( cDetallesExistentes.FPRECIO    ) + ',' + transform( cDetallesExistentes.FMONTO     ) + ' )'  )
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
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		this.oEntidad.FacturaDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.KitsDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.ArticulosSeniadosDetalle.oItem.oCompPrecios.Recibir( this.oEntidad, 'ArticulosSeniadosDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSSENIADOS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.KitsDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'KitsDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMKITS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.FacturaDetalle.oItem.oCompStock.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.ValoresDetalle.oItem.oCompCajero.Recibir( this.oEntidad, 'ValoresDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMVALORES',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.FacturaDetalle.oItem.oCompGiftcard.Recibir( this.oEntidad, 'FacturaDetalle',this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS',this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		this.oEntidad.oCompEnBaseA.Recibir( this.oEntidad, 'FacturaDetalle', this.oEntidad.cPrefijoRecibir + 'ITEMARTICULOSVENTAS', this.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA')
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcSecuencia = &tcCursor..FACTSEC
		if !empty( lcSecuencia )
			lcRetorno = lcRetorno + ' - Secuencia: ' + transform( lcSecuencia )
		endif
		lcRetorno = lcRetorno + ' - Tipo de comprobante: ' + transform( &tcCursor..FACTTIPO   )
		lcRetorno = lcRetorno + ' - Letra de comprobante: ' + transform( &tcCursor..FLETRA     )
		lcRetorno = lcRetorno + ' - Pto. venta: ' + transform( &tcCursor..FPTOVEN    )
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
			Case  lcAlias == lcPrefijo + 'FACTURAAGRUPADA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FACTURAAGRUPADA_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'FACTURAAGRUPADA_FOBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMCOMPROBANTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPROMOCIONES'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMPROMOARTICULOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMKITS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMIMPUESTOVENTAS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMARTICULOSSENIADOS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMVALORES'
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
		lcCursor = This.oEntidad.cPrefijoImportar + 'FACTURAAGRUPADA'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..FACTTIPO ) or isnull( &lcCursor..FLETRA ) or isnull( &lcCursor..FPTOVEN ) or isnull( &lcCursor..FNUMCOMP ) or isnull( &lcCursor..FACTSEC )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad FACTURAAGRUPADA. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA'
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FD2       
		* Validar ANTERIORES A 1/1/1753  InformNube
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  VtoCAI    
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  vtosenia  
		* Validar ANTERIORES A 1/1/1753  FFCH      
		* Validar ANTERIORES A 1/1/1753  FFCHVTOPAG
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_COMPROBANTEV') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_COMPROBANTEV
Create Table ZooLogic.TablaTrabajo_COMPROBANTEV ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fecimpo" datetime  null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fd2" datetime  null, 
"informnube" datetime  null, 
"fmodifw" datetime  null, 
"vtocai" datetime  null, 
"fcuit" char( 15 )  null, 
"idcaja" numeric( 2, 0 )  null, 
"fajxre" numeric( 8, 2 )  null, 
"mdcimpu" numeric( 15, 4 )  null, 
"timestamp" numeric( 20, 0 )  null, 
"cai" numeric( 14, 0 )  null, 
"factsec" char( 2 )  null, 
"totalcant" numeric( 15, 2 )  null, 
"fpodes2" numeric( 6, 2 )  null, 
"condivalp" numeric( 1, 0 )  null, 
"subtotcisi" numeric( 10, 2 )  null, 
"fsubtot" numeric( 15, 4 )  null, 
"sitfisccli" numeric( 2, 0 )  null, 
"fsubton" numeric( 15, 4 )  null, 
"signomov" numeric( 2, 0 )  null, 
"subtotsisi" numeric( 10, 2 )  null, 
"recmntosi2" numeric( 15, 4 )  null, 
"desmntosi2" numeric( 15, 4 )  null, 
"desmntosi1" numeric( 15, 4 )  null, 
"desmntosi3" numeric( 15, 4 )  null, 
"desmntosi" numeric( 15, 4 )  null, 
"recmntosi1" numeric( 15, 4 )  null, 
"recmntosi" numeric( 15, 4 )  null, 
"anulado" bit  null, 
"desaut" bit  null, 
"fcompfis" bit  null, 
"horaexpo" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"opecomm" char( 254 )  null, 
"bdmodifw" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"cbautoimp" char( 40 )  null, 
"descfw" char( 200 )  null, 
"fhora" char( 8 )  null, 
"zadsfw" varchar(max)  null, 
"umodifw" char( 100 )  null, 
"valtafw" char( 13 )  null, 
"vmodifw" char( 13 )  null, 
"hmodifw" char( 8 )  null, 
"smodifw" char( 7 )  null, 
"horaimpo" char( 8 )  null, 
"ualtafw" char( 100 )  null, 
"idajuste" char( 10 )  null, 
"despachos" char( 254 )  null, 
"faltafw" datetime  null, 
"haltafw" char( 8 )  null, 
"simbmon" char( 3 )  null, 
"facttipo" numeric( 2, 0 )  null, 
"idvuelto" char( 5 )  null, 
"monsis" char( 10 )  null, 
"motdescdev" char( 10 )  null, 
"fobs" varchar(max)  null, 
"fpodes1" numeric( 6, 2 )  null, 
"fperson" char( 5 )  null, 
"fturno" numeric( 1, 0 )  null, 
"fmtdes2" numeric( 15, 4 )  null, 
"idsenia" char( 38 )  null, 
"senia" char( 38 )  null, 
"codigo" char( 38 )  null, 
"md1" numeric( 15, 2 )  null, 
"fcliente" char( 30 )  null, 
"fmtdes1" numeric( 15, 4 )  null, 
"receptor" char( 5 )  null, 
"fven" char( 5 )  null, 
"moneda" char( 10 )  null, 
"fletra" char( 1 )  null, 
"vtosenia" datetime  null, 
"totrecarsi" numeric( 15, 4 )  null, 
"trci" numeric( 15, 4 )  null, 
"codlista" char( 6 )  null, 
"fptoven" numeric( 4, 0 )  null, 
"email" char( 250 )  null, 
"fnumcomp" numeric( 8, 0 )  null, 
"ftotal" numeric( 16, 2 )  null, 
"totdescsi" numeric( 15, 4 )  null, 
"tdci" numeric( 15, 4 )  null, 
"direntr" char( 250 )  null, 
"ffch" datetime  null, 
"fmtdes3" numeric( 15, 4 )  null, 
"deuda" numeric( 15, 2 )  null, 
"cotiz" numeric( 15, 5 )  null, 
"fpago" char( 5 )  null, 
"fpodes" numeric( 6, 2 )  null, 
"recmnto2" numeric( 15, 4 )  null, 
"fvuelto" numeric( 8, 2 )  null, 
"entregapos" numeric( 1, 0 )  null, 
"ffchvtopag" datetime  null, 
"opctrasmis" char( 5 )  null, 
"fdescu" numeric( 8, 2 )  null, 
"merconsign" bit  null, 
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
"fimpuesto" numeric( 8, 2 )  null, 
"totrecarci" numeric( 8, 2 )  null, 
"totdesc" numeric( 8, 2 )  null, 
"totimpue" numeric( 8, 2 )  null, 
"chequer" char( 20 )  null, 
"cancelar" bit  null, 
"ivasis" numeric( 10, 2 )  null )
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'FACTURAAGRUPADA'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fd2','fd2')
			.AgregarMapeo('informnube','informnube')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('vtocai','vtocai')
			.AgregarMapeo('fcuit','fcuit')
			.AgregarMapeo('idcaja','idcaja')
			.AgregarMapeo('fajxre','fajxre')
			.AgregarMapeo('mdcimpu','mdcimpu')
			.AgregarMapeo('timestamp','timestamp')
			.AgregarMapeo('cai','cai')
			.AgregarMapeo('factsec','factsec')
			.AgregarMapeo('totalcant','totalcant')
			.AgregarMapeo('fpodes2','fpodes2')
			.AgregarMapeo('condivalp','condivalp')
			.AgregarMapeo('subtotcisi','subtotcisi')
			.AgregarMapeo('fsubtot','fsubtot')
			.AgregarMapeo('sitfisccli','sitfisccli')
			.AgregarMapeo('fsubton','fsubton')
			.AgregarMapeo('signomov','signomov')
			.AgregarMapeo('subtotsisi','subtotsisi')
			.AgregarMapeo('recmntosi2','recmntosi2')
			.AgregarMapeo('desmntosi2','desmntosi2')
			.AgregarMapeo('desmntosi1','desmntosi1')
			.AgregarMapeo('desmntosi3','desmntosi3')
			.AgregarMapeo('desmntosi','desmntosi')
			.AgregarMapeo('recmntosi1','recmntosi1')
			.AgregarMapeo('recmntosi','recmntosi')
			.AgregarMapeo('anulado','anulado')
			.AgregarMapeo('desaut','desaut')
			.AgregarMapeo('fcompfis','fcompfis')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('opecomm','opecomm')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('cbautoimp','cbautoimp')
			.AgregarMapeo('descfw','descfw')
			.AgregarMapeo('fhora','fhora')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('idajuste','idajuste')
			.AgregarMapeo('despachos','despachos')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('simbmon','simbmon')
			.AgregarMapeo('facttipo','facttipo')
			.AgregarMapeo('idvuelto','idvuelto')
			.AgregarMapeo('monsis','monsis')
			.AgregarMapeo('motdescdev','motdescdev')
			.AgregarMapeo('fobs','fobs')
			.AgregarMapeo('fpodes1','fpodes1')
			.AgregarMapeo('fperson','fperson')
			.AgregarMapeo('fturno','fturno')
			.AgregarMapeo('fmtdes2','fmtdes2')
			.AgregarMapeo('idsenia','idsenia')
			.AgregarMapeo('senia','senia')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('md1','md1')
			.AgregarMapeo('fcliente','fcliente')
			.AgregarMapeo('fmtdes1','fmtdes1')
			.AgregarMapeo('receptor','receptor')
			.AgregarMapeo('fven','fven')
			.AgregarMapeo('moneda','moneda')
			.AgregarMapeo('fletra','fletra')
			.AgregarMapeo('vtosenia','vtosenia')
			.AgregarMapeo('totrecarsi','totrecarsi')
			.AgregarMapeo('trci','trci')
			.AgregarMapeo('codlista','codlista')
			.AgregarMapeo('fptoven','fptoven')
			.AgregarMapeo('email','email')
			.AgregarMapeo('fnumcomp','fnumcomp')
			.AgregarMapeo('ftotal','ftotal')
			.AgregarMapeo('totdescsi','totdescsi')
			.AgregarMapeo('tdci','tdci')
			.AgregarMapeo('direntr','direntr')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('fmtdes3','fmtdes3')
			.AgregarMapeo('deuda','deuda')
			.AgregarMapeo('cotiz','cotiz')
			.AgregarMapeo('fpago','fpago')
			.AgregarMapeo('fpodes','fpodes')
			.AgregarMapeo('recmnto2','recmnto2')
			.AgregarMapeo('fvuelto','fvuelto')
			.AgregarMapeo('entregapos','entregapos')
			.AgregarMapeo('ffchvtopag','ffchvtopag')
			.AgregarMapeo('opctrasmis','opctrasmis')
			.AgregarMapeo('fdescu','fdescu')
			.AgregarMapeo('merconsign','merconsign')
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
			.AgregarMapeo('totrecarci','totrecarci')
			.AgregarMapeo('totdesc','totdesc')
			.AgregarMapeo('totimpue','totimpue')
			.AgregarMapeo('chequer','chequer')
			.AgregarMapeo('cancelar','cancelar')
			.AgregarMapeo('ivasis','ivasis')
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
				Update t Set t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FD2 = isnull( d.FD2, t.FD2 ),t.INFORMNUBE = isnull( d.INFORMNUBE, t.INFORMNUBE ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.VTOCAI = isnull( d.VTOCAI, t.VTOCAI ),t.FCUIT = isnull( d.FCUIT, t.FCUIT ),t.IDCAJA = isnull( d.IDCAJA, t.IDCAJA ),t.FAJXRE = isnull( d.FAJXRE, t.FAJXRE ),t.MDCIMPU = isnull( d.MDCIMPU, t.MDCIMPU ),t.TIMESTAMP = isnull( d.TIMESTAMP, t.TIMESTAMP ),t.CAI = isnull( d.CAI, t.CAI ),t.FACTSEC = isnull( d.FACTSEC, t.FACTSEC ),t.TOTALCANT = isnull( d.TOTALCANT, t.TOTALCANT ),t.FPODES2 = isnull( d.FPODES2, t.FPODES2 ),t.CONDIVALP = isnull( d.CONDIVALP, t.CONDIVALP ),t.SUBTOTCISI = isnull( d.SUBTOTCISI, t.SUBTOTCISI ),t.FSUBTOT = isnull( d.FSUBTOT, t.FSUBTOT ),t.SITFISCCLI = isnull( d.SITFISCCLI, t.SITFISCCLI ),t.FSUBTON = isnull( d.FSUBTON, t.FSUBTON ),t.SIGNOMOV = isnull( d.SIGNOMOV, t.SIGNOMOV ),t.SUBTOTSISI = isnull( d.SUBTOTSISI, t.SUBTOTSISI ),t.RECMNTOSI2 = isnull( d.RECMNTOSI2, t.RECMNTOSI2 ),t.DESMNTOSI2 = isnull( d.DESMNTOSI2, t.DESMNTOSI2 ),t.DESMNTOSI1 = isnull( d.DESMNTOSI1, t.DESMNTOSI1 ),t.DESMNTOSI3 = isnull( d.DESMNTOSI3, t.DESMNTOSI3 ),t.DESMNTOSI = isnull( d.DESMNTOSI, t.DESMNTOSI ),t.RECMNTOSI1 = isnull( d.RECMNTOSI1, t.RECMNTOSI1 ),t.RECMNTOSI = isnull( d.RECMNTOSI, t.RECMNTOSI ),t.ANULADO = isnull( d.ANULADO, t.ANULADO ),t.DESAUT = isnull( d.DESAUT, t.DESAUT ),t.FCOMPFIS = isnull( d.FCOMPFIS, t.FCOMPFIS ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.OPECOMM = isnull( d.OPECOMM, t.OPECOMM ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.CBAUTOIMP = isnull( d.CBAUTOIMP, t.CBAUTOIMP ),t.DESCFW = isnull( d.DESCFW, t.DESCFW ),t.FHORA = isnull( d.FHORA, t.FHORA ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.IDAJUSTE = isnull( d.IDAJUSTE, t.IDAJUSTE ),t.DESPACHOS = isnull( d.DESPACHOS, t.DESPACHOS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.SIMBMON = isnull( d.SIMBMON, t.SIMBMON ),t.FACTTIPO = isnull( d.FACTTIPO, t.FACTTIPO ),t.IDVUELTO = isnull( d.IDVUELTO, t.IDVUELTO ),t.MONSIS = isnull( d.MONSIS, t.MONSIS ),t.MOTDESCDEV = isnull( d.MOTDESCDEV, t.MOTDESCDEV ),t.FOBS = isnull( d.FOBS, t.FOBS ),t.FPODES1 = isnull( d.FPODES1, t.FPODES1 ),t.FPERSON = isnull( d.FPERSON, t.FPERSON ),t.FTURNO = isnull( d.FTURNO, t.FTURNO ),t.FMTDES2 = isnull( d.FMTDES2, t.FMTDES2 ),t.IDSENIA = isnull( d.IDSENIA, t.IDSENIA ),t.SENIA = isnull( d.SENIA, t.SENIA ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.MD1 = isnull( d.MD1, t.MD1 ),t.FCLIENTE = isnull( d.FCLIENTE, t.FCLIENTE ),t.FMTDES1 = isnull( d.FMTDES1, t.FMTDES1 ),t.RECEPTOR = isnull( d.RECEPTOR, t.RECEPTOR ),t.FVEN = isnull( d.FVEN, t.FVEN ),t.MONEDA = isnull( d.MONEDA, t.MONEDA ),t.FLETRA = isnull( d.FLETRA, t.FLETRA ),t.VTOSENIA = isnull( d.VTOSENIA, t.VTOSENIA ),t.TOTRECARSI = isnull( d.TOTRECARSI, t.TOTRECARSI ),t.TRCI = isnull( d.TRCI, t.TRCI ),t.CODLISTA = isnull( d.CODLISTA, t.CODLISTA ),t.FPTOVEN = isnull( d.FPTOVEN, t.FPTOVEN ),t.EMAIL = isnull( d.EMAIL, t.EMAIL ),t.FNUMCOMP = isnull( d.FNUMCOMP, t.FNUMCOMP ),t.FTOTAL = isnull( d.FTOTAL, t.FTOTAL ),t.TOTDESCSI = isnull( d.TOTDESCSI, t.TOTDESCSI ),t.TDCI = isnull( d.TDCI, t.TDCI ),t.DIRENTR = isnull( d.DIRENTR, t.DIRENTR ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.FMTDES3 = isnull( d.FMTDES3, t.FMTDES3 ),t.DEUDA = isnull( d.DEUDA, t.DEUDA ),t.COTIZ = isnull( d.COTIZ, t.COTIZ ),t.FPAGO = isnull( d.FPAGO, t.FPAGO ),t.FPODES = isnull( d.FPODES, t.FPODES ),t.RECMNTO2 = isnull( d.RECMNTO2, t.RECMNTO2 ),t.FVUELTO = isnull( d.FVUELTO, t.FVUELTO ),t.ENTREGAPOS = isnull( d.ENTREGAPOS, t.ENTREGAPOS ),t.FFCHVTOPAG = isnull( d.FFCHVTOPAG, t.FFCHVTOPAG ),t.OPCTRASMIS = isnull( d.OPCTRASMIS, t.OPCTRASMIS ),t.FDESCU = isnull( d.FDESCU, t.FDESCU ),t.MERCONSIGN = isnull( d.MERCONSIGN, t.MERCONSIGN ),t.MD3 = isnull( d.MD3, t.MD3 ),t.PERCEPCION = isnull( d.PERCEPCION, t.PERCEPCION ),t.RECMNTO = isnull( d.RECMNTO, t.RECMNTO ),t.RECPOR = isnull( d.RECPOR, t.RECPOR ),t.MR = isnull( d.MR, t.MR ),t.MR2 = isnull( d.MR2, t.MR2 ),t.MD2 = isnull( d.MD2, t.MD2 ),t.MR1 = isnull( d.MR1, t.MR1 ),t.RECMNTO1 = isnull( d.RECMNTO1, t.RECMNTO1 ),t.GRAVAMEN = isnull( d.GRAVAMEN, t.GRAVAMEN ),t.FIMPUESTO = isnull( d.FIMPUESTO, t.FIMPUESTO ),t.TOTRECARCI = isnull( d.TOTRECARCI, t.TOTRECARCI ),t.TOTDESC = isnull( d.TOTDESC, t.TOTDESC ),t.TOTIMPUE = isnull( d.TOTIMPUE, t.TOTIMPUE ),t.CHEQUER = isnull( d.CHEQUER, t.CHEQUER ),t.CANCELAR = isnull( d.CANCELAR, t.CANCELAR ),t.IVASIS = isnull( d.IVASIS, t.IVASIS )
					from ZooLogic.COMPROBANTEV t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.FACTTIPO = d.FACTTIPO
							 and  t.FLETRA = d.FLETRA
							 and  t.FPTOVEN = d.FPTOVEN
							 and  t.FNUMCOMP = d.FNUMCOMP
							 and  t.FACTSEC = d.FACTSEC
				-- Fin Updates
				insert into ZooLogic.COMPROBANTEV(Fecimpo,Fectrans,Fecexpo,Fd2,Informnube,Fmodifw,Vtocai,Fcuit,Idcaja,Fajxre,Mdcimpu,Timestamp,Cai,Factsec,Totalcant,Fpodes2,Condivalp,Subtotcisi,Fsubtot,Sitfisccli,Fsubton,Signomov,Subtotsisi,Recmntosi2,Desmntosi2,Desmntosi1,Desmntosi3,Desmntosi,Recmntosi1,Recmntosi,Anulado,Desaut,Fcompfis,Horaexpo,Esttrans,Opecomm,Bdmodifw,Bdaltafw,Saltafw,Cbautoimp,Descfw,Fhora,Zadsfw,Umodifw,Valtafw,Vmodifw,Hmodifw,Smodifw,Horaimpo,Ualtafw,Idajuste,Despachos,Faltafw,Haltafw,Simbmon,Facttipo,Idvuelto,Monsis,Motdescdev,Fobs,Fpodes1,Fperson,Fturno,Fmtdes2,Idsenia,Senia,Codigo,Md1,Fcliente,Fmtdes1,Receptor,Fven,Moneda,Fletra,Vtosenia,Totrecarsi,Trci,Codlista,Fptoven,Email,Fnumcomp,Ftotal,Totdescsi,Tdci,Direntr,Ffch,Fmtdes3,Deuda,Cotiz,Fpago,Fpodes,Recmnto2,Fvuelto,Entregapos,Ffchvtopag,Opctrasmis,Fdescu,Merconsign,Md3,Percepcion,Recmnto,Recpor,Mr,Mr2,Md2,Mr1,Recmnto1,Gravamen,Fimpuesto,Totrecarci,Totdesc,Totimpue,Chequer,Cancelar,Ivasis)
					Select isnull( d.FECIMPO,''),isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FD2,''),isnull( d.INFORMNUBE,''),isnull( d.FMODIFW,''),isnull( d.VTOCAI,''),isnull( d.FCUIT,''),isnull( d.IDCAJA,0),isnull( d.FAJXRE,0),isnull( d.MDCIMPU,0),isnull( d.TIMESTAMP,0),isnull( d.CAI,0),isnull( d.FACTSEC,''),isnull( d.TOTALCANT,0),isnull( d.FPODES2,0),isnull( d.CONDIVALP,0),isnull( d.SUBTOTCISI,0),isnull( d.FSUBTOT,0),isnull( d.SITFISCCLI,0),isnull( d.FSUBTON,0),isnull( d.SIGNOMOV,0),isnull( d.SUBTOTSISI,0),isnull( d.RECMNTOSI2,0),isnull( d.DESMNTOSI2,0),isnull( d.DESMNTOSI1,0),isnull( d.DESMNTOSI3,0),isnull( d.DESMNTOSI,0),isnull( d.RECMNTOSI1,0),isnull( d.RECMNTOSI,0),isnull( d.ANULADO,0),isnull( d.DESAUT,0),isnull( d.FCOMPFIS,0),isnull( d.HORAEXPO,''),isnull( d.ESTTRANS,''),isnull( d.OPECOMM,''),isnull( d.BDMODIFW,''),isnull( d.BDALTAFW,''),isnull( d.SALTAFW,''),isnull( d.CBAUTOIMP,''),isnull( d.DESCFW,''),isnull( d.FHORA,''),isnull( d.ZADSFW,''),isnull( d.UMODIFW,''),isnull( d.VALTAFW,''),isnull( d.VMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.UALTAFW,''),isnull( d.IDAJUSTE,''),isnull( d.DESPACHOS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),convert( char(8), getdate(), 108 ),isnull( d.SIMBMON,''),isnull( d.FACTTIPO,0),isnull( d.IDVUELTO,''),isnull( d.MONSIS,''),isnull( d.MOTDESCDEV,''),isnull( d.FOBS,''),isnull( d.FPODES1,0),isnull( d.FPERSON,''),isnull( d.FTURNO,0),isnull( d.FMTDES2,0),isnull( d.IDSENIA,''),isnull( d.SENIA,''),isnull( d.CODIGO,''),isnull( d.MD1,0),isnull( d.FCLIENTE,''),isnull( d.FMTDES1,0),isnull( d.RECEPTOR,''),isnull( d.FVEN,''),isnull( d.MONEDA,''),isnull( d.FLETRA,''),isnull( d.VTOSENIA,''),isnull( d.TOTRECARSI,0),isnull( d.TRCI,0),isnull( d.CODLISTA,''),isnull( d.FPTOVEN,0),isnull( d.EMAIL,''),isnull( d.FNUMCOMP,0),isnull( d.FTOTAL,0),isnull( d.TOTDESCSI,0),isnull( d.TDCI,0),isnull( d.DIRENTR,''),isnull( d.FFCH,''),isnull( d.FMTDES3,0),isnull( d.DEUDA,0),isnull( d.COTIZ,0),isnull( d.FPAGO,''),isnull( d.FPODES,0),isnull( d.RECMNTO2,0),isnull( d.FVUELTO,0),isnull( d.ENTREGAPOS,0),isnull( d.FFCHVTOPAG,''),isnull( d.OPCTRASMIS,''),isnull( d.FDESCU,0),isnull( d.MERCONSIGN,0),isnull( d.MD3,0),isnull( d.PERCEPCION,0),isnull( d.RECMNTO,0),isnull( d.RECPOR,0),isnull( d.MR,0),isnull( d.MR2,0),isnull( d.MD2,0),isnull( d.MR1,0),isnull( d.RECMNTO1,0),isnull( d.GRAVAMEN,0),isnull( d.FIMPUESTO,0),isnull( d.TOTRECARCI,0),isnull( d.TOTDESC,0),isnull( d.TOTIMPUE,0),isnull( d.CHEQUER,''),isnull( d.CANCELAR,0),isnull( d.IVASIS,0)
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
from ZooLogic.COMPROBANTEVDET t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.COMPROBANTEVDET
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
From deleted d left join ZooLogic.COMPROBANTEVDET pk 
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
	function ObtenerTriggerDeleteImportacion_PromDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_PromDet
ON ZooLogic.TablaTrabajo_COMPROBANTEV_PromDet
AFTER DELETE
As
Begin
Update t Set 
t.TIPO = isnull( d.TIPO, t.TIPO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.PROMO = isnull( d.PROMO, t.PROMO ),
t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD ),
t.BENEFICIO = isnull( d.BENEFICIO, t.BENEFICIO ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM )
from ZooLogic.PromDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.PromDet
( 
"TIPO",
"NROITEM",
"CODIGO",
"PROMO",
"DESCRIP",
"CANTIDAD",
"BENEFICIO",
"IDITEM"
 )
Select 
d.TIPO,
d.NROITEM,
d.CODIGO,
d.PROMO,
d.DESCRIP,
d.CANTIDAD,
d.BENEFICIO,
d.IDITEM
From deleted d left join ZooLogic.PromDet pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ProArtDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_ProArtDet
ON ZooLogic.TablaTrabajo_COMPROBANTEV_ProArtDet
AFTER DELETE
As
Begin
Update t Set 
t.MONTO = isnull( d.MONTO, t.MONTO ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.IDVALOR = isnull( d.IDVALOR, t.IDVALOR ),
t.ATRCABEVER = isnull( d.ATRCABEVER, t.ATRCABEVER ),
t.IDARTI = isnull( d.IDARTI, t.IDARTI ),
t.IDPROMO = isnull( d.IDPROMO, t.IDPROMO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO )
from ZooLogic.ProArtDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ProArtDet
( 
"MONTO",
"NROITEM",
"IDVALOR",
"ATRCABEVER",
"IDARTI",
"IDPROMO",
"CODIGO"
 )
Select 
d.MONTO,
d.NROITEM,
d.IDVALOR,
d.ATRCABEVER,
d.IDARTI,
d.IDPROMO,
d.CODIGO
From deleted d left join ZooLogic.ProArtDet pk 
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
	function ObtenerTriggerDeleteImportacion_SeniaVDet( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_COMPROBANTEV_SeniaVDet
ON ZooLogic.TablaTrabajo_COMPROBANTEV_SeniaVDet
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
t.FX2 = isnull( d.FX2, t.FX2 ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.FPORCFI = isnull( d.FPORCFI, t.FPORCFI ),
t.AFESALDO = isnull( d.AFESALDO, t.AFESALDO ),
t.FPORDTO1 = isnull( d.FPORDTO1, t.FPORDTO1 ),
t.FNETO = isnull( d.FNETO, t.FNETO ),
t.FKIT = isnull( d.FKIT, t.FKIT ),
t.FMTOCFI = isnull( d.FMTOCFI, t.FMTOCFI ),
t.FMTODTO1 = isnull( d.FMTODTO1, t.FMTODTO1 ),
t.FPORIVA = isnull( d.FPORIVA, t.FPORIVA ),
t.FMTOIVA = isnull( d.FMTOIVA, t.FMTOIVA ),
t.PRUNSINIMP = isnull( d.PRUNSINIMP, t.PRUNSINIMP ),
t.PRUNCONIMP = isnull( d.PRUNCONIMP, t.PRUNCONIMP ),
t.FCFITOT = isnull( d.FCFITOT, t.FCFITOT ),
t.AFETIPOCOM = isnull( d.AFETIPOCOM, t.AFETIPOCOM ),
t.AFECANT = isnull( d.AFECANT, t.AFECANT ),
t.AFENROITEM = isnull( d.AFENROITEM, t.AFENROITEM ),
t.IDITEMORIG = isnull( d.IDITEMORIG, t.IDITEMORIG ),
t.FN11 = isnull( d.FN11, t.FN11 ),
t.CIDITEM = isnull( d.CIDITEM, t.CIDITEM ),
t.FPRUN = isnull( d.FPRUN, t.FPRUN ),
t.ARTSINDES = isnull( d.ARTSINDES, t.ARTSINDES ),
t.USARPLISTA = isnull( d.USARPLISTA, t.USARPLISTA ),
t.PROCSTOCK = isnull( d.PROCSTOCK, t.PROCSTOCK ),
t.CODAUTDJCP = isnull( d.CODAUTDJCP, t.CODAUTDJCP ),
t.FAMATE = isnull( d.FAMATE, t.FAMATE ),
t.AFE_COD = isnull( d.AFE_COD, t.AFE_COD ),
t.IDKIT = isnull( d.IDKIT, t.IDKIT ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.GIFTCARD = isnull( d.GIFTCARD, t.GIFTCARD ),
t.MOTDEVOL = isnull( d.MOTDEVOL, t.MOTDEVOL ),
t.FUNID = isnull( d.FUNID, t.FUNID ),
t.MOTDESCU = isnull( d.MOTDESCU, t.MOTDESCU ),
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
t.FPRECIO = isnull( d.FPRECIO, t.FPRECIO ),
t.FMONTO = isnull( d.FMONTO, t.FMONTO )
from ZooLogic.SeniaVDet t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.SeniaVDet
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
"FX2",
"NROITEM",
"FPORCFI",
"AFESALDO",
"FPORDTO1",
"FNETO",
"FKIT",
"FMTOCFI",
"FMTODTO1",
"FPORIVA",
"FMTOIVA",
"PRUNSINIMP",
"PRUNCONIMP",
"FCFITOT",
"AFETIPOCOM",
"AFECANT",
"AFENROITEM",
"IDITEMORIG",
"FN11",
"CIDITEM",
"FPRUN",
"ARTSINDES",
"USARPLISTA",
"PROCSTOCK",
"CODAUTDJCP",
"FAMATE",
"AFE_COD",
"IDKIT",
"IDITEM",
"CODIGO",
"GIFTCARD",
"MOTDEVOL",
"FUNID",
"MOTDESCU",
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
d.FX2,
d.NROITEM,
d.FPORCFI,
d.AFESALDO,
d.FPORDTO1,
d.FNETO,
d.FKIT,
d.FMTOCFI,
d.FMTODTO1,
d.FPORIVA,
d.FMTOIVA,
d.PRUNSINIMP,
d.PRUNCONIMP,
d.FCFITOT,
d.AFETIPOCOM,
d.AFECANT,
d.AFENROITEM,
d.IDITEMORIG,
d.FN11,
d.CIDITEM,
d.FPRUN,
d.ARTSINDES,
d.USARPLISTA,
d.PROCSTOCK,
d.CODAUTDJCP,
d.FAMATE,
d.AFE_COD,
d.IDKIT,
d.IDITEM,
d.CODIGO,
d.GIFTCARD,
d.MOTDEVOL,
d.FUNID,
d.MOTDESCU,
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
d.FPRECIO,
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
			if reccount( 'c_FACTURAAGRUPADA' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacion = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechamodificacion, ctod( '  /  /    ' ) ) )
					.Fueinformadoalanube = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fueinformadoalanube, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechavtocai = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechavtocai, ctod( '  /  /    ' ) ) )
					.Cuit = nvl( c_FACTURAAGRUPADA.Cuit, [] )
					.Facturadetalle.Limpiar()
					.Facturadetalle.SetearEsNavegacion( .lProcesando )
					.Facturadetalle.Cargar()
					.Caja_PK =  nvl( c_FACTURAAGRUPADA.Caja, 0 )
					.Compafec.Limpiar()
					.Compafec.SetearEsNavegacion( .lProcesando )
					.Compafec.Cargar()
					.Ajustesporredondeos = nvl( c_FACTURAAGRUPADA.Ajustesporredondeos, 0 )
					.Montodescuentoconimpuestos = nvl( c_FACTURAAGRUPADA.Montodescuentoconimpuestos, 0 )
					.Timestamp = nvl( c_FACTURAAGRUPADA.Timestamp, 0 )
					.Cai = nvl( c_FACTURAAGRUPADA.Cai, 0 )
					.Secuencia = nvl( c_FACTURAAGRUPADA.Secuencia, [] )
					.Totalcantidad = nvl( c_FACTURAAGRUPADA.Totalcantidad, 0 )
					.Porcentajedescuento2 = nvl( c_FACTURAAGRUPADA.Porcentajedescuento2, 0 )
					.Condicioniva = nvl( c_FACTURAAGRUPADA.Condicioniva, 0 )
					.Subtotalconimpuestossobreitems = nvl( c_FACTURAAGRUPADA.Subtotalconimpuestossobreitems, 0 )
					.Subtotalbruto = nvl( c_FACTURAAGRUPADA.Subtotalbruto, 0 )
					.Situacionfiscal_PK =  nvl( c_FACTURAAGRUPADA.Situacionfiscal, 0 )
					.Subtotalneto = nvl( c_FACTURAAGRUPADA.Subtotalneto, 0 )
					.Signodemovimiento = nvl( c_FACTURAAGRUPADA.Signodemovimiento, 0 )
					.Subtotalsinimpuestossobreitems = nvl( c_FACTURAAGRUPADA.Subtotalsinimpuestossobreitems, 0 )
					.Recargomontosinimpuestos2 = nvl( c_FACTURAAGRUPADA.Recargomontosinimpuestos2, 0 )
					.Montodescuentosinimpuestos2 = nvl( c_FACTURAAGRUPADA.Montodescuentosinimpuestos2, 0 )
					.Montodescuentosinimpuestos1 = nvl( c_FACTURAAGRUPADA.Montodescuentosinimpuestos1, 0 )
					.Montodescuentosinimpuestos3 = nvl( c_FACTURAAGRUPADA.Montodescuentosinimpuestos3, 0 )
					.Montodescuentosinimpuestos = nvl( c_FACTURAAGRUPADA.Montodescuentosinimpuestos, 0 )
					.Recargomontosinimpuestos1 = nvl( c_FACTURAAGRUPADA.Recargomontosinimpuestos1, 0 )
					.Recargomontosinimpuestos = nvl( c_FACTURAAGRUPADA.Recargomontosinimpuestos, 0 )
					.Anulado = nvl( c_FACTURAAGRUPADA.Anulado, .F. )
					.Descuentoautomatico = nvl( c_FACTURAAGRUPADA.Descuentoautomatico, .F. )
					.Comprobantefiscal = nvl( c_FACTURAAGRUPADA.Comprobantefiscal, .F. )
					.Horaexpo = nvl( c_FACTURAAGRUPADA.Horaexpo, [] )
					.Estadotransferencia = nvl( c_FACTURAAGRUPADA.Estadotransferencia, [] )
					.Nroopecommerce = nvl( c_FACTURAAGRUPADA.Nroopecommerce, [] )
					.Basededatosmodificacionfw = nvl( c_FACTURAAGRUPADA.Basededatosmodificacionfw, [] )
					.Basededatosaltafw = nvl( c_FACTURAAGRUPADA.Basededatosaltafw, [] )
					.Seriealtafw = nvl( c_FACTURAAGRUPADA.Seriealtafw, [] )
					.Codigobarraautoimpresor = nvl( c_FACTURAAGRUPADA.Codigobarraautoimpresor, [] )
					.Descripcionfw = nvl( c_FACTURAAGRUPADA.Descripcionfw, [] )
					.Hora = nvl( c_FACTURAAGRUPADA.Hora, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Usuariomodificacionfw = nvl( c_FACTURAAGRUPADA.Usuariomodificacionfw, [] )
					.Versionaltafw = nvl( c_FACTURAAGRUPADA.Versionaltafw, [] )
					.Versionmodificacionfw = nvl( c_FACTURAAGRUPADA.Versionmodificacionfw, [] )
					.Horamodificacionfw = nvl( c_FACTURAAGRUPADA.Horamodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_FACTURAAGRUPADA.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_FACTURAAGRUPADA.Horaimpo, [] )
					.Usuarioaltafw = nvl( c_FACTURAAGRUPADA.Usuarioaltafw, [] )
					.Codigoajuste = nvl( c_FACTURAAGRUPADA.Codigoajuste, [] )
					.Despachos = nvl( c_FACTURAAGRUPADA.Despachos, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_FACTURAAGRUPADA.Horaaltafw, [] )
					.Simbolomonetariocomprobante = nvl( c_FACTURAAGRUPADA.Simbolomonetariocomprobante, [] )
					.Tipocomprobante = nvl( c_FACTURAAGRUPADA.Tipocomprobante, 0 )
					.Promocionesdetalle.Limpiar()
					.Promocionesdetalle.SetearEsNavegacion( .lProcesando )
					.Promocionesdetalle.Cargar()
					.Promoarticulosdetalle.Limpiar()
					.Promoarticulosdetalle.SetearEsNavegacion( .lProcesando )
					.Promoarticulosdetalle.Cargar()
					.Idvuelto_PK =  nvl( c_FACTURAAGRUPADA.Idvuelto, [] )
					.Monedasistema_PK =  nvl( c_FACTURAAGRUPADA.Monedasistema, [] )
					.Codigomotivodescuentoensubtotal_PK =  nvl( c_FACTURAAGRUPADA.Codigomotivodescuentoensubtotal, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Kitsdetalle.Limpiar()
					.Kitsdetalle.SetearEsNavegacion( .lProcesando )
					.Kitsdetalle.Cargar()
					.Porcentajedescuento1 = nvl( c_FACTURAAGRUPADA.Porcentajedescuento1, 0 )
					.Cliente_PK =  nvl( c_FACTURAAGRUPADA.Cliente, [] )
					.Turno = nvl( c_FACTURAAGRUPADA.Turno, 0 )
					.Impuestosdetalle.Limpiar()
					.Impuestosdetalle.SetearEsNavegacion( .lProcesando )
					.Impuestosdetalle.Cargar()
					.Montodescuentoconimpuestos2 = nvl( c_FACTURAAGRUPADA.Montodescuentoconimpuestos2, 0 )
					.Idsenia = nvl( c_FACTURAAGRUPADA.Idsenia, [] )
					.Impuestoscomprobante.Limpiar()
					.Impuestoscomprobante.SetearEsNavegacion( .lProcesando )
					.Impuestoscomprobante.Cargar()
					.Senia_PK =  nvl( c_FACTURAAGRUPADA.Senia, [] )
					.Codigo = nvl( c_FACTURAAGRUPADA.Codigo, [] )
					.Montodescuento1 = nvl( c_FACTURAAGRUPADA.Montodescuento1, 0 )
					.Clientedescripcion = nvl( c_FACTURAAGRUPADA.Clientedescripcion, [] )
					.Montodescuentoconimpuestos1 = nvl( c_FACTURAAGRUPADA.Montodescuentoconimpuestos1, 0 )
					.Receptor_PK =  nvl( c_FACTURAAGRUPADA.Receptor, [] )
					.Articulosseniadosdetalle.Limpiar()
					.Articulosseniadosdetalle.SetearEsNavegacion( .lProcesando )
					.Articulosseniadosdetalle.Cargar()
					.Vendedor_PK =  nvl( c_FACTURAAGRUPADA.Vendedor, [] )
					.Monedacomprobante_PK =  nvl( c_FACTURAAGRUPADA.Monedacomprobante, [] )
					.Letra = nvl( c_FACTURAAGRUPADA.Letra, [] )
					.Fechavtosenia = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechavtosenia, ctod( '  /  /    ' ) ) )
					.Valoresdetalle.Limpiar()
					.Valoresdetalle.SetearEsNavegacion( .lProcesando )
					.Valoresdetalle.Cargar()
					.Totalrecargossinimpuestos = nvl( c_FACTURAAGRUPADA.Totalrecargossinimpuestos, 0 )
					.Totalrecargosconimpuestos = nvl( c_FACTURAAGRUPADA.Totalrecargosconimpuestos, 0 )
					.Listadeprecios_PK =  nvl( c_FACTURAAGRUPADA.Listadeprecios, [] )
					.Puntodeventa = nvl( c_FACTURAAGRUPADA.Puntodeventa, 0 )
					.Email = nvl( c_FACTURAAGRUPADA.Email, [] )
					.Numero = nvl( c_FACTURAAGRUPADA.Numero, 0 )
					.Total = nvl( c_FACTURAAGRUPADA.Total, 0 )
					.Totaldescuentossinimpuestos = nvl( c_FACTURAAGRUPADA.Totaldescuentossinimpuestos, 0 )
					.Totaldescuentosconimpuestos = nvl( c_FACTURAAGRUPADA.Totaldescuentosconimpuestos, 0 )
					.Direccionentrega = nvl( c_FACTURAAGRUPADA.Direccionentrega, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fecha, ctod( '  /  /    ' ) ) )
					.Montodescuentoconimpuestos3 = nvl( c_FACTURAAGRUPADA.Montodescuentoconimpuestos3, 0 )
					.Deuda = nvl( c_FACTURAAGRUPADA.Deuda, 0 )
					.Cotizacion = nvl( c_FACTURAAGRUPADA.Cotizacion, 0 )
					.Forpago_PK =  nvl( c_FACTURAAGRUPADA.Forpago, [] )
					.Porcentajedescuento = nvl( c_FACTURAAGRUPADA.Porcentajedescuento, 0 )
					.Recargomontoconimpuestos2 = nvl( c_FACTURAAGRUPADA.Recargomontoconimpuestos2, 0 )
					.Vuelto = nvl( c_FACTURAAGRUPADA.Vuelto, 0 )
					.Entregaposterior = nvl( c_FACTURAAGRUPADA.Entregaposterior, 0 )
					.Fechavencimientomipyme = GoLibrerias.ObtenerFechaFormateada( nvl( c_FACTURAAGRUPADA.Fechavencimientomipyme, ctod( '  /  /    ' ) ) )
					.Opciontransmisionmipyme = nvl( c_FACTURAAGRUPADA.Opciontransmisionmipyme, [] )
					.Descuento = nvl( c_FACTURAAGRUPADA.Descuento, 0 )
					.Mercaderiaconsignacion = nvl( c_FACTURAAGRUPADA.Mercaderiaconsignacion, .F. )
					.Montodescuento3 = nvl( c_FACTURAAGRUPADA.Montodescuento3, 0 )
					.Percepciones = nvl( c_FACTURAAGRUPADA.Percepciones, 0 )
					.Recargomontoconimpuestos = nvl( c_FACTURAAGRUPADA.Recargomontoconimpuestos, 0 )
					.Recargoporcentaje = nvl( c_FACTURAAGRUPADA.Recargoporcentaje, 0 )
					.Recargomonto = nvl( c_FACTURAAGRUPADA.Recargomonto, 0 )
					.Recargomonto2 = nvl( c_FACTURAAGRUPADA.Recargomonto2, 0 )
					.Montodescuento2 = nvl( c_FACTURAAGRUPADA.Montodescuento2, 0 )
					.Recargomonto1 = nvl( c_FACTURAAGRUPADA.Recargomonto1, 0 )
					.Recargomontoconimpuestos1 = nvl( c_FACTURAAGRUPADA.Recargomontoconimpuestos1, 0 )
					.Gravamenes = nvl( c_FACTURAAGRUPADA.Gravamenes, 0 )
					.Impuestos = nvl( c_FACTURAAGRUPADA.Impuestos, 0 )
					.Totalrecargos = nvl( c_FACTURAAGRUPADA.Totalrecargos, 0 )
					.Totaldescuentos = nvl( c_FACTURAAGRUPADA.Totaldescuentos, 0 )
					.Totalimpuestos = nvl( c_FACTURAAGRUPADA.Totalimpuestos, 0 )
					.Chequereintegro = nvl( c_FACTURAAGRUPADA.Chequereintegro, [] )
					.Accioncancelatoria = nvl( c_FACTURAAGRUPADA.Accioncancelatoria, .F. )
					.Ivadelsistema = nvl( c_FACTURAAGRUPADA.Ivadelsistema, 0 )
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
			lxRetorno = c_FACTURAAGRUPADA.CODIGO
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

		loDetalle = this.oEntidad.PromocionesDetalle
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

		loDetalle = this.oEntidad.PromoArticulosDetalle
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
		return c_FACTURAAGRUPADA.&lcAtributo
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
								Where   COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)
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
			"Fecimpo" as "Fechaimpo", "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fd2" as "Fechamodificacion", "Informnube" as "Fueinformadoalanube", "Fmodifw" as "Fechamodificacionfw", "Vtocai" as "Fechavtocai", "Fcuit" as "Cuit", "Idcaja" as "Caja", "Fajxre" as "Ajustesporredondeos", "Mdcimpu" as "Montodescuentoconimpuestos", "Timestamp" as "Timestamp", "Cai" as "Cai", "Factsec" as "Secuencia", "Totalcant" as "Totalcantidad", "Fpodes2" as "Porcentajedescuento2", "Condivalp" as "Condicioniva", "Subtotcisi" as "Subtotalconimpuestossobreitems", "Fsubtot" as "Subtotalbruto", "Sitfisccli" as "Situacionfiscal", "Fsubton" as "Subtotalneto", "Signomov" as "Signodemovimiento", "Subtotsisi" as "Subtotalsinimpuestossobreitems", "Recmntosi2" as "Recargomontosinimpuestos2", "Desmntosi2" as "Montodescuentosinimpuestos2", "Desmntosi1" as "Montodescuentosinimpuestos1", "Desmntosi3" as "Montodescuentosinimpuestos3", "Desmntosi" as "Montodescuentosinimpuestos", "Recmntosi1" as "Recargomontosinimpuestos1", "Recmntosi" as "Recargomontosinimpuestos", "Anulado" as "Anulado", "Desaut" as "Descuentoautomatico", "Fcompfis" as "Comprobantefiscal", "Horaexpo" as "Horaexpo", "Esttrans" as "Estadotransferencia", "Opecomm" as "Nroopecommerce", "Bdmodifw" as "Basededatosmodificacionfw", "Bdaltafw" as "Basededatosaltafw", "Saltafw" as "Seriealtafw", "Cbautoimp" as "Codigobarraautoimpresor", "Descfw" as "Descripcionfw", "Fhora" as "Hora", "Zadsfw" as "Zadsfw", "Umodifw" as "Usuariomodificacionfw", "Valtafw" as "Versionaltafw", "Vmodifw" as "Versionmodificacionfw", "Hmodifw" as "Horamodificacionfw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Ualtafw" as "Usuarioaltafw", "Idajuste" as "Codigoajuste", "Despachos" as "Despachos", "Faltafw" as "Fechaaltafw", "Haltafw" as "Horaaltafw", "Simbmon" as "Simbolomonetariocomprobante", "Facttipo" as "Tipocomprobante", "Idvuelto" as "Idvuelto", "Monsis" as "Monedasistema", "Motdescdev" as "Codigomotivodescuentoensubtotal", "Fobs" as "Obs", "Fpodes1" as "Porcentajedescuento1", "Fperson" as "Cliente", "Fturno" as "Turno", "Fmtdes2" as "Montodescuentoconimpuestos2", "Idsenia" as "Idsenia", "Senia" as "Senia", "Codigo" as "Codigo", "Md1" as "Montodescuento1", "Fcliente" as "Clientedescripcion", "Fmtdes1" as "Montodescuentoconimpuestos1", "Receptor" as "Receptor", "Fven" as "Vendedor", "Moneda" as "Monedacomprobante", "Fletra" as "Letra", "Vtosenia" as "Fechavtosenia", "Totrecarsi" as "Totalrecargossinimpuestos", "Trci" as "Totalrecargosconimpuestos", "Codlista" as "Listadeprecios", "Fptoven" as "Puntodeventa", "Email" as "Email", "Fnumcomp" as "Numero", "Ftotal" as "Total", "Totdescsi" as "Totaldescuentossinimpuestos", "Tdci" as "Totaldescuentosconimpuestos", "Direntr" as "Direccionentrega", "Ffch" as "Fecha", "Fmtdes3" as "Montodescuentoconimpuestos3", "Deuda" as "Deuda", "Cotiz" as "Cotizacion", "Fpago" as "Forpago", "Fpodes" as "Porcentajedescuento", "Recmnto2" as "Recargomontoconimpuestos2", "Fvuelto" as "Vuelto", "Entregapos" as "Entregaposterior", "Ffchvtopag" as "Fechavencimientomipyme", "Opctrasmis" as "Opciontransmisionmipyme", "Fdescu" as "Descuento", "Merconsign" as "Mercaderiaconsignacion", "Md3" as "Montodescuento3", "Percepcion" as "Percepciones", "Recmnto" as "Recargomontoconimpuestos", "Recpor" as "Recargoporcentaje", "Mr" as "Recargomonto", "Mr2" as "Recargomonto2", "Md2" as "Montodescuento2", "Mr1" as "Recargomonto1", "Recmnto1" as "Recargomontoconimpuestos1", "Gravamen" as "Gravamenes", "Fimpuesto" as "Impuestos", "Totrecarci" as "Totalrecargos", "Totdesc" as "Totaldescuentos", "Totimpue" as "Totalimpuestos", "Chequer" as "Chequereintegro", "Cancelar" as "Accioncancelatoria", "Ivasis" as "Ivadelsistema"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.COMPROBANTEV 
								Where   COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)
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

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaComprobanteRelacionado() as string

		lcRetorno = ''
		lcPtoVta = alltrim( str( this.oEntidad.PuntoDeVentaCpteRelacionado ) )
		lcTipoComp = alltrim( str( this.oEntidad.TipoCpteRelacionado ) )
		lcNumero = alltrim( str( this.oEntidad.NumeroCpteRelacionado))
		lcLetra = this.oEntidad.LetraCpteRelacionado
		lcWhere = " where facttipo = " + lcTipoComp + " and fptoven =" + lcPtoVta + " and fletra = '" + lcLetra + "' and fnumcomp = " + lcNumero
		lcXml = this.ObtenerDatos( 'Ffch as Fecha', '', '', '', lcWhere, 'COMPROBANTEV', '', 1 )
		xmltocursor(lcXml,'c_cursorFecha')
		IF RECCOUNT( 'c_cursorFecha') > 0
		lcRetorno = dtos(c_cursorFecha.Fecha)
		endif
		return lcRetorno
	endfunc

enddefine

define class ObjetoBusqueda as custom
	Tabla = 'COMPROBANTEV'
	Filtro = " COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)"
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
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAIMPO                               " tabla="COMPROBANTEV   " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHATRANSFERENCIA                      " tabla="COMPROBANTEV   " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                                                                                                                       " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAEXPO                               " tabla="COMPROBANTEV   " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAMODIFICACION                       " tabla="COMPROBANTEV   " campo="FD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FUEINFORMADOALANUBE                     " tabla="COMPROBANTEV   " campo="INFORMNUBE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAVTOCAI                             " tabla="COMPROBANTEV   " campo="VTOCAI    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CUIT                                    " tabla="COMPROBANTEV   " campo="FCUIT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="CUIT                                                                                                                                                                                                                                                      " dominio="CUIT                          " detalle="false" tipo="E" atributoforaneo="Cliente.cuit                                                                                                                                                                                                                                                  " clavecandidata="0" mascara="99-99999999-9            " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FACTURADETALLE                          " tabla="COMPROBANTEVDET" campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Artículos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMARTICULOSVENTAS    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CAJA                                    " tabla="COMPROBANTEV   " campo="IDCAJA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CAJAESTADO                              " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Caja                                                                                                                                                                                                                                                      " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="COMPAFEC                                " tabla="COMPAFE        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="DETALLEITEMCOMPROBANTE        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="AJUSTESPORREDONDEOS                     " tabla="COMPROBANTEV   " campo="FAJXRE    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Ajustes por redondeo                                                                                                                                                                                                                                      " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOCONIMPUESTOS              " tabla="COMPROBANTEV   " campo="MDCIMPU   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TIMESTAMP                               " tabla="COMPROBANTEV   " campo="TIMESTAMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CAI                                     " tabla="COMPROBANTEV   " campo="CAI       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="14" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SECUENCIA                               " tabla="COMPROBANTEV   " campo="FACTSEC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="18" etiqueta="Secuencia                                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="5" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALCANTIDAD                           " tabla="COMPROBANTEV   " campo="TOTALCANT " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="14" etiqueta="Total Cantidad                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PORCENTAJEDESCUENTO2                    " tabla="COMPROBANTEV   " campo="FPODES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 2                                                                                                                                                                                                                                 " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CONDICIONIVA                            " tabla="COMPROBANTEV   " campo="CONDIVALP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de IVA                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="ListaDePrecios.CondicionIva                                                                                                                                                                                                                                   " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALCONIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTCISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALBRUTO                           " tabla="COMPROBANTEV   " campo="FSUBTOT   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SITUACIONFISCAL                         " tabla="COMPROBANTEV   " campo="SITFISCCLI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SITUACIONFISCAL                         " tipodato="N         " longitud="2" decimales="0" valorsugerido="=3                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="Situación fiscal                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALNETO                            " tabla="COMPROBANTEV   " campo="FSUBTON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SIGNODEMOVIMIENTO                       " tabla="COMPROBANTEV   " campo="SIGNOMOV  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="1                                                                                                                                                                                                                                                             " obligatorio="true" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALSINIMPUESTOSSOBREITEMS          " tabla="COMPROBANTEV   " campo="SUBTOTSISI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOSINIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOSINIMPUESTOS2             " tabla="COMPROBANTEV   " campo="DESMNTOSI2" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOSINIMPUESTOS1             " tabla="COMPROBANTEV   " campo="DESMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOSINIMPUESTOS3             " tabla="COMPROBANTEV   " campo="DESMNTOSI3" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOSINIMPUESTOS              " tabla="COMPROBANTEV   " campo="DESMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOSINIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTOSI1" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOSINIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTOSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ANULADO                                 " tabla="COMPROBANTEV   " campo="ANULADO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Esta anulado                                                                                                                                                                                                                                              " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DESCUENTOAUTOMATICO                     " tabla="COMPROBANTEV   " campo="DESAUT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="COMPROBANTEFISCAL                       " tabla="COMPROBANTEV   " campo="FCOMPFIS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="HORAEXPO                                " tabla="COMPROBANTEV   " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ESTADOTRANSFERENCIA                     " tabla="COMPROBANTEV   " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="NROOPECOMMERCE                          " tabla="COMPROBANTEV   " campo="OPECOMM   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="COMPROBANTEV   " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="BASEDEDATOSALTAFW                       " tabla="COMPROBANTEV   " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SERIEALTAFW                             " tabla="COMPROBANTEV   " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CODIGOBARRAAUTOIMPRESOR                 " tabla="COMPROBANTEV   " campo="CBAUTOIMP " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DESCRIPCIONFW                           " tabla="COMPROBANTEV   " campo="DESCFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="200" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="HORA                                    " tabla="COMPROBANTEV   " campo="FHORA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ZADSFW                                  " tabla="COMPROBANTEV   " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="USUARIOMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VERSIONALTAFW                           " tabla="COMPROBANTEV   " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VERSIONMODIFICACIONFW                   " tabla="COMPROBANTEV   " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="HORAMODIFICACIONFW                      " tabla="COMPROBANTEV   " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SERIEMODIFICACIONFW                     " tabla="COMPROBANTEV   " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="HORAIMPO                                " tabla="COMPROBANTEV   " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="USUARIOALTAFW                           " tabla="COMPROBANTEV   " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CODIGOAJUSTE                            " tabla="COMPROBANTEV   " campo="IDAJUSTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Codigo de Ajuste                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DESPACHOS                               " tabla="COMPROBANTEV   " campo="DESPACHOS " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="254" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Despachos                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAALTAFW                             " tabla="COMPROBANTEV   " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="20" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="HORAALTAFW                              " tabla="COMPROBANTEV   " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerHora()                                                                                                                                                                                                                          " obligatorio="false" admitebusqueda="22" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SIMBOLOMONETARIOCOMPROBANTE             " tabla="COMPROBANTEV   " campo="SIMBMON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TIPOCOMPROBANTE                         " tabla="COMPROBANTEV   " campo="FACTTIPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="@ObtenerSugeridoTipoComprobante(&quot;FACTURA&quot;)                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="18" etiqueta="Tipo de comprobante                                                                                                                                                                                                                                       " dominio="COMBOXML                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PROMOCIONESDETALLE                      " tabla="PROMDET        " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Promociones                                                                                                                                                                                                                                               " dominio="DETALLEITEMPROMOCIONES        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PROMOARTICULOSDETALLE                   " tabla="PROARTDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="DETALLEITEMPROMOARTICULOS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUCURSAL                                " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SUCURSAL                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="=goParametros.Nucleo.Sucursal                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="0" etiqueta="Sucursal                                                                                                                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IDVUELTO                                " tabla="COMPROBANTEV   " campo="IDVUELTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VALOR                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="=goParametros.Felino.Sugerencias.CodigoDeValorSugeridoParaVuelto                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código vuelto                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONEDASISTEMA                           " tabla="COMPROBANTEV   " campo="MONSIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Moneda Sistema                                                                                                                                                                                                                                            " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CODIGOMOTIVODESCUENTOENSUBTOTAL         " tabla="COMPROBANTEV   " campo="MOTDESCDEV" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MOTIVODESCUENTOYDEVOLUCION              " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="OBS                                     " tabla="COMPROBANTEV   " campo="FOBS      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="KITSDETALLE                             " tabla="KITDET         " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Detalle de kits                                                                                                                                                                                                                                           " dominio="DETALLEITEMKITS               " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="0" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PORCENTAJEDESCUENTO1                    " tabla="COMPROBANTEV   " campo="FPODES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Porcentaje de descuento 1                                                                                                                                                                                                                                 " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CLIENTE                                 " tabla="COMPROBANTEV   " campo="FPERSON   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="8" etiqueta="Cliente                                                                                                                                                                                                                                                   " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TURNO                                   " tabla="COMPROBANTEV   " campo="FTURNO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="@ObtenerTurno()                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="0" etiqueta="Turno                                                                                                                                                                                                                                                     " dominio="TURNO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IMPUESTOSDETALLE                        " tabla="IMPUESTOSV     " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos                                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOS          " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOCONIMPUESTOS2             " tabla="COMPROBANTEV   " campo="FMTDES2   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 2                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="4" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IDSENIA                                 " tabla="COMPROBANTEV   " campo="IDSENIA   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código seña                                                                                                                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IMPUESTOSCOMPROBANTE                    " tabla="IMPVENTAS      " campo="CCOD      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuestos del comprobante                                                                                                                                                                                                                                 " dominio="DETALLEITEMIMPUESTOVENTAS     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SENIA                                   " tabla="COMPROBANTEV   " campo="SENIA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="SENIA                                   " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Id del comprobante seña                                                                                                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CODIGO                                  " tabla="COMPROBANTEV   " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="24" etiqueta="Código número                                                                                                                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTO1                         " tabla="COMPROBANTEV   " campo="MD1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento 1                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CLIENTEDESCRIPCION                      " tabla="COMPROBANTEV   " campo="FCLIENTE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="410" etiqueta="Cliente descripción                                                                                                                                                                                                                                       " dominio="CODIGOCLIENTECOMPROBANTE      " detalle="false" tipo="E" atributoforaneo="Cliente.Nombre                                                                                                                                                                                                                                                " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOCONIMPUESTOS1             " tabla="COMPROBANTEV   " campo="FMTDES1   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto cescuento con impuestos 1                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="3" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECEPTOR                                " tabla="COMPROBANTEV   " campo="RECEPTOR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLIENTE                                 " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Despachar a                                                                                                                                                                                                                                               " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ARTICULOSSENIADOSDETALLE                " tabla="SENIAVDET      " campo="CODIGO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Artículos señados                                                                                                                                                                                                                                         " dominio="DETALLEITEMARTICULOSSENIADOS  " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VENDEDOR                                " tabla="COMPROBANTEV   " campo="FVEN      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="VENDEDOR                                " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="414" etiqueta="Vendedor                                                                                                                                                                                                                                                  " dominio="CODIGOVENDEDOR                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CODIGOBARRACAE                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código de barra                                                                                                                                                                                                                                           " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONEDACOMPROBANTE                       " tabla="COMPROBANTEV   " campo="MONEDA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MONEDA                                  " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="416" etiqueta="Moneda                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="LETRA                                   " tabla="COMPROBANTEV   " campo="FLETRA    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Letra de comprobante                                                                                                                                                                                                                                      " dominio="NUMEROCOMPROBANTEAGRUPADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="2" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAVTOSENIA                           " tabla="COMPROBANTEV   " campo="VTOSENIA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vencimiento de la seña                                                                                                                                                                                                                                    " dominio="FECHACALENDARIO               " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VALORESDETALLE                          " tabla="VAL            " campo="JJNUM     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="418" etiqueta="Valores                                                                                                                                                                                                                                                   " dominio="DETALLEITEMVALORES            " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="5" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALRECARGOSSINIMPUESTOS               " tabla="COMPROBANTEV   " campo="TOTRECARSI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos Sin impuestos                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALRECARGOSCONIMPUESTOS               " tabla="COMPROBANTEV   " campo="TRCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total recargos con impuestos                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="LISTADEPRECIOS                          " tabla="COMPROBANTEV   " campo="CODLISTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LISTADEPRECIOS                          " tipodato="C         " longitud="6" decimales="0" valorsugerido="=goParametros.Felino.Precios.ListasDePrecios.ListaDePreciosPreferente                                                                                                                                                                                         " obligatorio="true" admitebusqueda="420" etiqueta="Lista de precio                                                                                                                                                                                                                                           " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PUNTODEVENTA                            " tabla="COMPROBANTEV   " campo="FPTOVEN   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Pto. venta                                                                                                                                                                                                                                                " dominio="NUMEROCOMPROBANTEAGRUPADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="3" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="EMAIL                                   " tabla="COMPROBANTEV   " campo="EMAIL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="422" etiqueta="Email                                                                                                                                                                                                                                                     " dominio="MAIL                          " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="NUMERO                                  " tabla="COMPROBANTEV   " campo="FNUMCOMP  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                                                                                                                    " dominio="NUMEROCOMPROBANTEAGRUPADO     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="4" mascara="99999999                 " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTAL                                   " tabla="COMPROBANTEV   " campo="FTOTAL    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="16" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="12" etiqueta="Total                                                                                                                                                                                                                                                     " dominio="TOTALMULTIMONEDA              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALDESCUENTOSSINIMPUESTOS             " tabla="COMPROBANTEV   " campo="TOTDESCSI " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos sin impuestos                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALDESCUENTOSCONIMPUESTOS             " tabla="COMPROBANTEV   " campo="TDCI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuentos con impuestos                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="25" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DIRECCIONENTREGA                        " tabla="COMPROBANTEV   " campo="DIRENTR   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Dirección de entrega                                                                                                                                                                                                                                      " dominio="COMBODIRECCIONESENTREGA       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHA                                   " tabla="COMPROBANTEV   " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTOCONIMPUESTOS3             " tabla="COMPROBANTEV   " campo="FMTDES3   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto descuento con impuestos 3                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="8" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DEUDA                                   " tabla="COMPROBANTEV   " campo="DEUDA     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Saldo de cta. cte.                                                                                                                                                                                                                                        " dominio="FECHASALDO                    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="COTIZACION                              " tabla="COMPROBANTEV   " campo="COTIZ     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="5" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="426" etiqueta="Cotización                                                                                                                                                                                                                                                " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FORPAGO                                 " tabla="COMPROBANTEV   " campo="FPAGO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CONDICIONDEPAGO                         " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Condición de pago                                                                                                                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PORCENTAJEDESCUENTO                     " tabla="COMPROBANTEV   " campo="FPODES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Porcentaje de descuento                                                                                                                                                                                                                                   " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOCONIMPUESTOS2               " tabla="COMPROBANTEV   " campo="RECMNTO2  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 2                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VUELTO                                  " tabla="COMPROBANTEV   " campo="FVUELTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Vuelto persistido                                                                                                                                                                                                                                         " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="10" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="VUELTOVIRTUAL                           " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="430" etiqueta="Vuelto                                                                                                                                                                                                                                                    " dominio="VUELTO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="7" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CAE                                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="C.A.E.                                                                                                                                                                                                                                                    " dominio="CAE                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAVENCIMIENTOCAE                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="434" etiqueta="Vto C.A.E.                                                                                                                                                                                                                                                " dominio="CAE                           " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ENTREGAPOSTERIOR                        " tabla="COMPROBANTEV   " campo="ENTREGAPOS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="436" etiqueta="Tipo de entrega                                                                                                                                                                                                                                           " dominio="COMBO                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHAVENCIMIENTOMIPYME                  " tabla="COMPROBANTEV   " campo="FFCHVTOPAG" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goservicios.librerias.obtenerFecha() + goparametros.felino.gestionDEVENTAS.facTURACIONELECTRONICA.fechaDEVENCIMIENTOSUGERIDAPARALOSCOMPROBANTESDECREDITOENDIAS                                                                                               " obligatorio="false" admitebusqueda="438" etiqueta="Vto pago                                                                                                                                                                                                                                                  " dominio="DATOSMIPYME                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="OPCIONTRANSMISIONMIPYME                 " tabla="COMPROBANTEV   " campo="OPCTRASMIS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="=iif(inlist(goparametros.felino.gestiondeventas.facturacionelectronica.opciondetransmisionparacomprobantesdecreditomipyme,2,4),&quot;SCA&quot;,&quot;ADC&quot;)                                                                                                                   " obligatorio="false" admitebusqueda="440" etiqueta="Opción de transmisión                                                                                                                                                                                                                                     " dominio="DATOSMIPYME                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="14" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="DESCUENTO                               " tabla="COMPROBANTEV   " campo="FDESCU    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="442" etiqueta="Monto % descuento                                                                                                                                                                                                                                         " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MERCADERIACONSIGNACION                  " tabla="COMPROBANTEV   " campo="MERCONSIGN" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Mercadería en consignación                                                                                                                                                                                                                                " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="20" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTO3                         " tabla="COMPROBANTEV   " campo="MD3       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Monto de descuento                                                                                                                                                                                                                                        " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="30" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PERCEPCIONES                            " tabla="COMPROBANTEV   " campo="PERCEPCION" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Percepciones                                                                                                                                                                                                                                              " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOCONIMPUESTOS                " tabla="COMPROBANTEV   " campo="RECMNTO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos                                                                                                                                                                                                                               " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="40" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOPORCENTAJE                       " tabla="COMPROBANTEV   " campo="RECPOR    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="6" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="446" etiqueta="Recargo porcentaje                                                                                                                                                                                                                                        " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTO                            " tabla="COMPROBANTEV   " campo="MR        " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Recargo % monto                                                                                                                                                                                                                                           " dominio="DESCUENTO                     " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="42" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTO2                           " tabla="COMPROBANTEV   " campo="MR2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="450" etiqueta="Recargo monto                                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="43" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTO2VISUAL                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Descuentos en valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="MONTODESCUENTO2                         " tabla="COMPROBANTEV   " campo="MD2       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Descuento valores                                                                                                                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="44" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTO1VISUAL                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="454" etiqueta="Monto de recargo valores                                                                                                                                                                                                                                  " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTO1                           " tabla="COMPROBANTEV   " campo="MR1       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="17" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Monto recargo valores                                                                                                                                                                                                                                     " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="RECARGOMONTOCONIMPUESTOS1               " tabla="COMPROBANTEV   " campo="RECMNTO1  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="4" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargo monto con impuestos 1                                                                                                                                                                                                                             " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="0" orden="45" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="GRAVAMENES                              " tabla="COMPROBANTEV   " campo="GRAVAMEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Impuesto Interno                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALSINIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal sin imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="50" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IMPUESTOS                               " tabla="COMPROBANTEV   " campo="FIMPUESTO " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="456" etiqueta="I.V.A.                                                                                                                                                                                                                                                    " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="50" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="SUBTOTALCONIMP                          " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="15" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Subtotal con imp                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="51" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALRECARGOS                           " tabla="COMPROBANTEV   " campo="TOTRECARCI" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Recargos total                                                                                                                                                                                                                                            " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="27" orden="52" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALDESCUENTOS                         " tabla="COMPROBANTEV   " campo="TOTDESC   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Total descuentos                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="28" orden="53" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TOTALIMPUESTOS                          " tabla="COMPROBANTEV   " campo="TOTIMPUE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="458" etiqueta="Total impuestos                                                                                                                                                                                                                                           " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="8" orden="60" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="CHEQUEREINTEGRO                         " tabla="COMPROBANTEV   " campo="CHEQUER   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Cheque reintegro                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="6" orden="60" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="ACCIONCANCELATORIA                      " tabla="COMPROBANTEV   " campo="CANCELAR  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="L         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="SINOBOOL                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="80" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="IVADELSISTEMA                           " tabla="COMPROBANTEV   " campo="IVASIS    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="10" decimales="2" valorsugerido="goparametros.felino.datoSIMPOSITIVOS.ivaINSCRIPTOS                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="81" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="TIPOCPTERELACIONADO                     " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="90" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="LETRACPTERELACIONADO                    " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Comprobante asociado                                                                                                                                                                                                                                      " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="91" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="PUNTODEVENTACPTERELACIONADO             " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="4" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="92" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="NUMEROCPTERELACIONADO                   " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="                                                                                                                                                                                                                                                          " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="93" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FACTURAAGRUPADA                         " atributo="FECHACPTERELACIONADO                    " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha comprobante asociado                                                                                                                                                                                                                                " dominio="COMPROBANTERELACIONADO        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="94" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="9" etiqueta="Detalle Cli.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.FPERSON = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLIENTE                                 " atributo="NOMBRE                                  " tabla="CLI            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="17" etiqueta="Detalle Des.                                                                                                                                                                                                                                              " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLI On COMPROBANTEV.RECEPTOR = CLI.CLCOD And  CLI.CLCOD != ''                                                                                                                                                                                      " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="VENDEDOR                                " atributo="NOMBRE                                  " tabla="VEN            " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Ven.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join VEN On COMPROBANTEV.FVEN = VEN.CLCOD And  VEN.CLCOD != ''                                                                                                                                                                                          " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MONEDA                                  " atributo="DESCRIPCION                             " tabla="MONEDA         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Mon.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MONEDA On COMPROBANTEV.MONEDA = MONEDA.Codigo And  MONEDA.CODIGO != ''                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LISTADEPRECIOS                          " atributo="NOMBRE                                  " tabla="LPRECIO        " campo="LPR_NOMBRE" claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="30" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Lis.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LPRECIO On COMPROBANTEV.CODLISTA = LPRECIO.LPR_NUMERO And  LPRECIO.LPR_NUMERO != ''                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULO                                " tabla="COMPROBANTEVDET" campo="FART      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="201" etiqueta="DetalleArtículos, Artículo                                                                                                                                      " dominio="CLAVECONLECTURACB             " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="ARTICULODETALLE                         " tabla="COMPROBANTEVDET" campo="FTXT      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="DetalleArtículos, Descripción                                                                                                                                   " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="Articulo.Descripcion                                                                                                                                                                                                                                          " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLOR                                   " tabla="COMPROBANTEVDET" campo="FCOLO     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="203" etiqueta="DetalleArtículos, Color                                                                                                                                         " dominio="CODIGO                        " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="COLORDETALLE                            " tabla="COMPROBANTEVDET" campo="FCOTXT    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="DetalleArtículos, Detalle                                                                                                                                       " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="TALLE                                   " tabla="COMPROBANTEVDET" campo="FTALL     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="205" etiqueta="DetalleArtículos, Tal                                                                                                                                           " dominio="DESCRIPCION                   " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="DESCUENTO                               " tabla="COMPROBANTEVDET" campo="FCFI      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="7" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="DetalleArtículos, Des%                                                                                                                                          " dominio="NUMERICOCONSIGNO              " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTODESCUENTO                          " tabla="COMPROBANTEVDET" campo="MNTDES    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="207" etiqueta="DetalleArtículos, Monto Desc.                                                                                                                                   " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="CANTIDAD                                " tabla="COMPROBANTEVDET" campo="FCANT     " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="this.CompletarCantidadSegunParametro()                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="208" etiqueta="DetalleArtículos, Cant                                                                                                                                          " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="PRECIO                                  " tabla="COMPROBANTEVDET" campo="FPRECIO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="209" etiqueta="DetalleArtículos, Precio                                                                                                                                        " dominio="PRECIONONEGATIVOPARAMETROFOCO " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ITEMARTICULOSVENTAS                     " atributo="MONTO                                   " tabla="COMPROBANTEVDET" campo="FMONTO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="2" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="DetalleArtículos, Monto                                                                                                                                         " dominio="NUMERICO                      " detalle="false" tipo="I" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COMPROBANTEVDET On COMPROBANTEV.CODIGO = COMPROBANTEVDET.CODIGO And  COMPROBANTEV.CODIGO != '' AND (COMPROBANTEV.FACTTIPO = 54 OR COMPROBANTEV.FACTTIPO = 1 OR COMPROBANTEV.FACTTIPO = 2 OR COMPROBANTEV.FACTTIPO = 27)                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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